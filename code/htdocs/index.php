<?php
require_once __DIR__ . '/../vendor/autoload.php';
$kernel = new \Hoborg\Dashboard\Kernel(__DIR__ . '/../src', 'dev');
$kernel->handle(array_merge($_GET, $_POST));