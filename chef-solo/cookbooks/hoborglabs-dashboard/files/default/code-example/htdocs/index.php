<?php
require_once __DIR__ . '/../vendor/autoload.php';
$kernel = new \Hoborg\Dashboard\Kernel(__DIR__ . '/../src', 'dev');
$kernel->addExtensionPath(__DIR__ . '/../vendor/hoborglabs/dashboard');
$kernel->addPath('widgets', array(__DIR__ . '/../vendor/hoborglabs/widgets'));
$kernel->handle(array_merge($_GET, $_POST));
