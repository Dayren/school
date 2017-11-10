using System;
using SEMtests;
using CompteBancaireFramework;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;

namespace testSEMtests
{
    [TestClass]
    public class UTCB
    {
        IDAL fausseDAL;

        [TestInitialize]
        public void InitializeCB() {
            fausseDAL = Mock.Of<IDAL>();
            CompteBancaire cb = new CompteBancaire("MAERTE", 20);
            Mock.Get(fausseDAL).Setup(dal => dal.RetournerCompteBancaire("MAERTE")).Returns(cb);
        }

        [TestMethod]
        public void Bloquer_true() {
            CompteBancaire cb = fausseDAL.RetournerCompteBancaire("MAERTE");

            cb.BloquerCompte();

            Assert.IsTrue(cb.Bloque);
        }
        [TestMethod]
        public void Debloquer_false() {
            CompteBancaire cb = fausseDAL.RetournerCompteBancaire("MAERTE");

            cb.DebloquerCompte();

            Assert.IsFalse(cb.Bloque);
        }
        [TestMethod]
        public void Credit_15Solde20_35() {
            CompteBancaire cb = fausseDAL.RetournerCompteBancaire("MAERTE");

            cb.Crediter(15);

            Assert.AreEqual(35, cb.Solde);

        }
        [TestMethod]
        [ExpectedException(typeof(Exception), "Compte bloqué")]
        public void Credit_compteBloque_Exc() {
            CompteBancaire cb = fausseDAL.RetournerCompteBancaire("MAERTE");

            cb.Bloque = true;

            cb.Crediter(15);            
        }
        [TestMethod]
        public void Debit_15Solde20_5() {
            CompteBancaire cb = fausseDAL.RetournerCompteBancaire("MAERTE");

            cb.Debiter(15);

            Assert.AreEqual(5, cb.Solde);
        }
        [TestMethod]
        [ExpectedException(typeof(ArgumentOutOfRangeException), "montant plus petit que zéro")]
        public void Debit_15Solde5_Exc() {
            CompteBancaire cb = fausseDAL.RetournerCompteBancaire("MAERTE");
            cb.Solde = 5;

            cb.Debiter(15);
        }

    }

    [TestClass]
    public class UnitTest1
    {
        [TestMethod]
        public void addition_ints_7() {
            // ACT
            int a =4;
            int b =3;

            // ARRANGE
            int c = Calculatrice.Addition(a,b);

            // ASSERT
            Assert.AreEqual(7, c);
        }

    }


}
