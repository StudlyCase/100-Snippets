function rateLimit(string $key, int $maxRequests, int $windowSeconds): bool {
    $file = sys_get_temp_dir() . '/rate_' . md5($key) . '.json';
    $now = time();
    
    $data = file_exists($file) ? json_decode(file_get_contents($file), true) : [];
    $data = array_filter($data, fn($ts) => $ts > $now - $windowSeconds);
    
    if (count($data) >= $maxRequests) return false;
    
    $data[] = $now;
    file_put_contents($file, json_encode(array_values($data)), LOCK_EX);
    return true;
}

// Usage
if (!rateLimit('user_123', 10, 60)) {
    http_response_code(429);
    die('Too many requests');
}
