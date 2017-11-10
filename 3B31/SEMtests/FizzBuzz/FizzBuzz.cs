using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FizzBuzz
{
    public static class FizzBuzzc
    {
        public static string GetFizzBuzz(int i) {
            string str = "";

            if ((i % 3) == 0) str = "Fizz";
            if (i % 5 == 0) str += "Buzz";
            if (str == "") str = i.ToString();

            return str;
        }
    }
}
