using System;
using System.Diagnostics;
using System.Data;

namespace WindowsFormsApp1
{
    class Quartier
    {
        public int IdQuartier { get; set; }
        public int IdCommune { get; set; }
        public string Libel { get; set; }


        // CONSTRUCTEUR
        public Quartier(int iq=0, int ic=0, string lb="") {
            IdQuartier = iq;
            IdCommune = ic;
            Libel = lb;
        }

        // FONCTIONS
        public DataSet RecupererQuartier() {
            return Access_donnee.recupererQuartier();
        }
        public int RecupererIdQuartier(string nomQuartier) {
            return Access_donnee.recupererIdQuartier(nomQuartier);
        }
    }

    class Logement
    {
        DataSet DsLogements { get; set; }
        int Count { get; set; }

        public int NLogement { get; set; }
        public string Type { get; set; }
        public int IdQuartier { get; set; }
        public int Num { get; set; }
        public string Rue { get; set; }
        public float Superficie { get; set; }
        public float Loyer { get; set; }

        // CONSTRUCTEUR
        public Logement(int nLogement=0, string type="", int idquartier=0, int num=0, string rue="", float superficie=0, float loyer=0) {
            NLogement = nLogement;
            Type = type;
            IdQuartier = idquartier;
            Num = num;
            Rue = rue;
            Superficie = superficie;
            Loyer = loyer;
            DsLogements = new DataSet();
        }
        
        // FONCTIONS
        public DataSet RecupererLogementParQuartier(string nomQuartier) {
            DsLogements = Access_donnee.recupererLogementParQuartier(nomQuartier);
            return DsLogements;
        }


        public bool AjouterLogement() { 
            return Access_donnee.AjouterLogement(NLogement, Type, IdQuartier, Num, Rue, Superficie, Loyer);
        }
        public bool AjouterLogement(int nLogement, string type, int idQuartier, int numero, string rue, float superficie, float loyer) {
            return Access_donnee.AjouterLogement(nLogement, type, idQuartier, numero, rue, superficie, loyer);
        }

        public void Premier() {
            DataRow dr = null;
            if (DsLogements.Tables.Contains("Logement")) {
                if (DsLogements.Tables["Logement"].Rows.Count > 0) {
                    dr = DsLogements.Tables["Logement"].Rows[0];
                    Count = 0;
                }
            }

            init();
            Update(dr);
            //return dr;
        }

        public void Dernier() {
            DataRow dr = null;
            if (DsLogements.Tables.Contains("Logement")) {
                int c = DsLogements.Tables["Logement"].Rows.Count;
                if (c > 0) {
                    dr = DsLogements.Tables["Logement"].Rows[c-1];
                    Count = c - 1;
                }
            }
            Update(dr);

            //return dr;
        }

        public void Suivant() {
            DataRow dr = null;
            if (DsLogements.Tables.Contains("Logement")) {
                int c = DsLogements.Tables["Logement"].Rows.Count;
                if (c > 0) {
                    if (Count + 1 < c)
                        dr = DsLogements.Tables["Logement"].Rows[++Count];
                    else
                        dr = DsLogements.Tables["Logement"].Rows[Count];
                }
            }
            Update(dr);

            //return dr;
        }
        public void Precedent() {
            DataRow dr = null;
            if (DsLogements.Tables.Contains("Logement")) {
                int c = DsLogements.Tables["Logement"].Rows.Count;
                if (c > 0) {
                    if (Count - 1 >= 0)
                        dr = DsLogements.Tables["Logement"].Rows[--Count];
                    else
                        dr = DsLogements.Tables["Logement"].Rows[Count];
                }
            }
            //return dr;
            Update(dr);
        }

        public void Update(DataRow dr) {
            Debug.WriteLine(DsLogements.GetXml());
            if (dr == null) {
                Debug.WriteLine("cannot update null DataRow!");
                return;
            }
            else {
                this.NLogement = (int)dr["NLogement"];
                this.Type = dr["TypeLogement"].ToString();
                this.IdQuartier = (int)dr["IdQuartier"];
                this.Num = (int)dr["Numero"];
                this.Rue = dr["Rue"].ToString();

                float spf=0,lyr=0;
                float.TryParse(dr["Superficie"].ToString(),out spf);
                float.TryParse(dr["Loyer"].ToString(), out lyr);
                Superficie = spf;
                Loyer = lyr;
                //this.Superficie = (float)dr["Superficie"];
                //this.Loyer = (float)dr["Loyer"];
                this.ToDebug();
            }
        }
        private void init() {
            Debug.Write("init()... ");
            this.NLogement = 0;
            this.Type = "";
            this.IdQuartier = 0;
            this.Num = 0;
            this.Rue = "";
            this.Superficie = 0;
            this.Loyer = 0;
           
            this.ToDebug();
        }



        private void ToDebug() {
            Debug.WriteLine(string.Format("Logement:NL={0}; T={1}; IQ={2}; N={3}; R={4}; S={5}; L={6}",
                NLogement, Type, IdQuartier, Num, Rue, Superficie, Loyer));
        }
    }
}
