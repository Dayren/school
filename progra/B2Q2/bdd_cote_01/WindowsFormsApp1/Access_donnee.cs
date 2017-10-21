using System;
using System.Xml;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;

namespace WindowsFormsApp1
{
    class Access_donnee
    {
        //private static string sqlconnstr = "Server=TOUKO-KUSA\\SQLEXPRESS;Database=AgenceImmobiliereSQL;User Id=sa;Password=MSSQL;";
        private static string sqlconnstr = Properties.Settings.Default.SqlConnectionString;
        private static SqlCommand cmd;
        private static SqlConnection conn;
        private static SqlDataAdapter dtad;

        public static DataSet recupererQuartier() {
            SqlDataAdapter dtad;
            DataSet ds = new DataSet();
            conn = new SqlConnection();
            string cmdstr;

            conn.ConnectionString = sqlconnstr;
            conn.Open();
            cmdstr = "SELECT Libellé FROM Quartier";
            SqlCommand cmd = new SqlCommand(cmdstr, conn);

            dtad = new SqlDataAdapter(cmd);
            dtad.Fill(ds, "Quartier");

            Debug.WriteLine(ds.GetXml());
            conn.Close();
            return ds;
        }
        public static int recupererIdQuartier(string nomQuartier) {
            DataSet ds = new DataSet();
            conn = new SqlConnection();
            string cmdstr;
            int id=-1;

            // connection
            conn.ConnectionString = sqlconnstr;
            try {
                conn.Open();
            } catch (Exception ex) {
                Debug.WriteLine(ex.Message);
            }

            // requête
            cmdstr = "SELECT IdQuartier FROM Quartier WHERE libellé like @nom"; // no single quotes !
            cmd = new SqlCommand(cmdstr, conn);
            cmd.Parameters.AddWithValue("@nom", "%" + "St Brice" + "%");

            DataTable dt = new DataTable();
            dtad = new SqlDataAdapter(cmd);
            dtad.Fill(dt);

            // si un résultat
            if (dt.Rows.Count > 0 ) {
                try {
                    // try le cast, car on sait jamais
                    id = (int)dt.Rows[0]["IdQuartier"];
                } catch (Exception ex) {
                    Debug.WriteLine(ex.Message);
                }
            }

            conn.Close();
            return id;
        }

        public static DataSet recupererLogementParQuartier(string nomQuartier) {
            DataSet ds = new DataSet();
            conn = new SqlConnection();
            string cmdstr;

            conn.ConnectionString = sqlconnstr;
            try {
                conn.Open();
            } catch (Exception ex) {
                Debug.WriteLine(ex.Message);
            }

            cmdstr = "SELECT Logement.* FROM Logement, Quartier WHERE Libellé like @nom and Logement.IdQuartier = Quartier.IdQuartier";
            cmd = new SqlCommand(cmdstr, conn);
            cmd.Parameters.AddWithValue("@nom", "%"+nomQuartier+"%");

            dtad = new SqlDataAdapter(cmd);
            dtad.Fill(ds, "Logement");

            conn.Close();
            return ds;
        }

        public static bool AjouterLogement(int nLogement, string type, int idQuartier, int numero, string rue, float superficie, float loyer) {
            conn = new SqlConnection();
            string cmdstr;
            bool success;

            conn.ConnectionString = sqlconnstr;
            conn.Open();

            cmdstr = "INSERT [dbo].[Logement] (NLogement, TypeLogement, IdQuartier, Numero, Rue, Superficie, Loyer)" +
                "VALUES (@nl, @type, @idq, @num, @ru, @sf, @ly)";
            cmd = new SqlCommand(cmdstr, conn);
            cmd.Parameters.AddWithValue("@nl", nLogement);
            cmd.Parameters.AddWithValue("@type", type);
            cmd.Parameters.AddWithValue("@idq", idQuartier);
            cmd.Parameters.AddWithValue("@num", numero);
            cmd.Parameters.AddWithValue("@ru", rue);
            cmd.Parameters.AddWithValue("@sf", superficie);
            cmd.Parameters.AddWithValue("@ly", loyer);

            try {
                cmd.ExecuteNonQuery();
                success = true;
            } catch (SqlException se) {
                success = false;
                Debug.WriteLine(se.Message.ToString());
                foreach (SqlError ser in se.Errors) {
                    Debug.WriteLine(string.Format("{0}: l{1}- {2}", ser.Number, ser.LineNumber, ser.Message.ToString()));
                }
                throw se;
            }

            conn.Close();
            return success;
        }
    }
}
