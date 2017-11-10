using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using FizzBuzz;

namespace FizzBuzzTest
{
    [TestClass]
    public class FizzBuzzUT
    {
        [TestMethod]
        public void TestDividesBy3() {
            string expectedResult = "Fizz";
            for (int i = 1; i < 100; i++)
                if (i % 3 == 0 && i % 5 != 0)
                    Assert.AreEqual(expectedResult, FizzBuzzc.GetFizzBuzz(i));
        }
        [TestMethod]
        public void FizzBuzz1() {

            Assert.AreEqual("1", FizzBuzzc.GetFizzBuzz(1));
        }
        [TestMethod]
        public void FizzBuzz3() {

            Assert.AreEqual("Fizz", FizzBuzzc.GetFizzBuzz(3));
        }
        [TestMethod]
        public void FizzBuzz5() {

            Assert.AreEqual("Buzz", FizzBuzzc.GetFizzBuzz(5));
        }
        [TestMethod]
        public void FizzBuzz15() {

            Assert.AreEqual("FizzBuzz", FizzBuzzc.GetFizzBuzz(15));
        }
        [TestMethod]
        public void FizzBuzz16() {

            Assert.AreEqual("16", FizzBuzzc.GetFizzBuzz(16));
        }
    }
}
