<?php

$rules = [
    '@PSR2' => true,
    'array_indentation' => true,
    'array_syntax' => ['syntax' => 'short'],
    'trim_array_spaces' => true,
    'new_with_braces' => true,
    'ordered_imports' => ['sort_algorithm' => 'alpha', 'imports_order' => ['const', 'class', 'function']],
];

$config = new PhpCsFixer\Config();

return $config->setRules($rules);
