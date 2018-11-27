
public class Prime
{
	public static void main(String[] args)
	{
		int limit = 10000;
		if(args.length == 1) limit = Integer.parseInt(args[0]);

		long start = System.currentTimeMillis();
		int count = 0;
		for(int number = 2; ; number++)
		{
			if(!isPrime(number)) continue;
			count++;
			if(count == limit)
			{
				System.out.println(limit + "th prime number is " + number);
				break;
			}
		}
		System.out.println("[java] duration is " + (System.currentTimeMillis() - start) + " ms");
	}

	private static boolean isPrime(int number)
	{
		for(int n = 2; n <= number/2; n++)
			if(number % n == 0) return false;
		return true;
	}
}
