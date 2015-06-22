<?php
require_once __DIR__ . '/../vendor/autoload.php';
$kernel = new \Hoborg\Dashboard\Kernel(__DIR__ . '/../src', 'dev');

$widgets = $kernel->getWidgetsPath();
$widgets[] = __DIR__ . '/../vendor/hoborglabs/widgets/';
$kernel->setWidgetsPath($widgets);

$kernel->handle(array_merge($_GET, $_POST));
