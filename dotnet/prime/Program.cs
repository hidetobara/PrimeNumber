using System;
using System.Collections.Generic;
using System.Diagnostics;

namespace prime
{
	class Program
	{
		static void Main(string[] args)
		{
			int limit = 10000;
			if(args.Length == 1) int.TryParse(args[0], out limit);

			Stopwatch watch = new Stopwatch();
			watch.Start();
			List<int> list = new List<int>();
			int count = 0;
			for(int number = 2; ; number++)
			{
				if (!IsPrime(number)) continue;
				count++;
				if(count == limit)
				{
					Console.WriteLine(limit + "th prime is " + number);
					break;
				}
			}
			watch.Stop();
			Console.WriteLine("[dotnet] duration is " + (watch.ElapsedMilliseconds / 1000f).ToString("F1") + " sec");
		}

		static bool IsPrime(int number)
		{
			for (int n = 2; n <= number / 2; n++)
				if (number % n == 0) return false;
			return true;
		}
	}
}
