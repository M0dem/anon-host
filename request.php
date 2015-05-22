<?php
	// do stuff with $_POST["address"] and $_POST["file"]
	function pushQueue ($file, $queue) {
		$lines = file($file);
		array_push($lines, $queue);
		file_put_contents($file, $lines);
	}
?>
