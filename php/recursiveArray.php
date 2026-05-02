function array_flatten(array $array, int $depth = PHP_INT_MAX): array {
    $result = [];
    foreach ($array as $item) {
        if (is_array($item) && $depth > 0) {
            $result = array_merge($result, array_flatten($item, $depth - 1));
        } else {
            $result[] = $item;
        }
    }
    return $result;
}

// Usage
$nested = [1, [2, 3], [4, [5, [6]]]];
array_flatten($nested);       // [1, 2, 3, 4, 5, 6]
array_flatten($nested, 1);    // [1, 2, 3, 4, [5, [6]]]
