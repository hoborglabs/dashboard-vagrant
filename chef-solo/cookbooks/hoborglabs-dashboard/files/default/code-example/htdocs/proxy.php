<?php
require_once __DIR__ . '/../vendor/autoload.php';
$kernel = new \Hoborg\Dashboard\Kernel(__DIR__ . '/../src', 'dev');

$filePath = $kernel->findFileOnPath($_GET['file'], $kernel->getWidgetsPath());
$fileInfo = pathinfo($filePath);
$contentType = 'text/text';
switch ($fileInfo['extension']) {
    case 'js':
        $contentType = 'text/javascript';
        break;

    case 'css':
        $contentType = 'text/css';
        break;
}
header("Content-type: {$contentType}");

readfile($filePath);
