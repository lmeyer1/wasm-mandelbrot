<?php
header('content-type: text/javascript');
header('Cross-Origin-Embedder-Policy: require-corp');
readfile('worker.js');