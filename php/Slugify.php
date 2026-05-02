function slugify(string $text, string $separator = '-'): string {
    $text = transliterator_transliterate('Any-Latin; Latin-ASCII', $text);
    $text = strtolower($text);
    $text = preg_replace('/[^a-z0-9]+/', $separator, $text);
    return trim($text, $separator);
}

// Usage
slugify('Héllo Wörld!');          // hello-world
slugify('Ärger über Straße');     // arger-uber-strase
slugify('foo  bar', '_');         // foo_bar
