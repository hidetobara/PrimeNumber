using System;
using System.Collections.Generic;
using System.Diagnostics;

namespace prime
{
    class Program
    {
        static void Main(string[] args)
        {
			Stopwatch watch = new Stopwatch();
			watch.Start();
			List<int> list = new List<int>();
			int number = 1;
			while(true)
			{
				number++;
				if (!IsPrime(number)) continue;
				list.Add(number);
				if(list.Count == 10000)
				{
					Console.WriteLine("10000th prime is " + number);
					break;
				}
			}
			watch.Stop();
			Console.WriteLine("[dotnet] duration is " + (watch.ElapsedMilliseconds / 1000f).ToString("F1") + " sec");
        }

		static bool IsPrime(int number)
		{
			for (int n = 2; n < number / 2; n++)
				if (number % n == 0) return false;
			return true;
		}
    }
}
