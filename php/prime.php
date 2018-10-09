<?php
function isPrime($number)
{
	for($n = 2; $n < (int)$number/2; $n++)
	{
		if($number % $n == 0) return false;
	}
	return true;
}

function main()
{
	$start = microtime(true);
	$list = array();
	for($number = 2; ; $number++)
	{
		if(!isPrime($number)) continue;
		$list[] = $number;
		if(count($list) == 10000)
		{
			print("10000th prime is " . $number . "\n");
			break;
		}
	}
	$time = microtime(true) - $start;
	printf("[php] duration is %2.2f sec\n", $time);
}

main();
?>
