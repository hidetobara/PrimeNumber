<?php
function isPrime($number)
{
	for($n = 2; $n <= (int)$number/2; $n++)
	{
		if($number % $n == 0) return false;
	}
	return true;
}

function main($items)
{
	$limit = 10000;
	if(count($items) == 2) $limit = intval($items[1]);

	$start = microtime(true);
	$list = array();
	for($number = 2; ; $number++)
	{
		if(!isPrime($number)) continue;
		$list[] = $number;
		if(count($list) == $limit)
		{
			print($limit . "th prime is " . $number . "\n");
			break;
		}
	}
	$time = microtime(true) - $start;
	printf("[php] duration is %2.2f sec\n", $time);
}

main($argv);
?>
