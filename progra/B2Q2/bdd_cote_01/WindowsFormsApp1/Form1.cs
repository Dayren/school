using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Data;
using System.Text;
using System.Windows.Forms;

namespace WindowsFormsApp1
{
    public partial class Form1 : Form
    {
        Logement l = new Logement();
        public Form1() {
            InitializeComponent();

        }

        private void refresh(Logement l) {
            tb_identifiant.Text = l.NLogement.ToString();
            tb_type.Text = l.Type;
            tb_idQuartier.Text = l.IdQuartier.ToString();
            tb_numero.Text = l.Num.ToString();
            tb_rue.Text = l.Rue.ToString();
            tb_superficie.Text = l.Superficie.ToString();
            tb_loyer.Text = l.Loyer.ToString();
        }

        private void Form1_Load(object sender, EventArgs e) {
            this.cb_quartier.Items.Clear();
            List<string> ls=new List<string>();


            foreach (DataRow dr in Access_donnee.recupererQuartier().Tables["Quartier"].Rows) {
                this.cb_quartier.Items.Add(dr["Libellé"]);
            }
            //this.cb_quartier.Items.RemoveAt(0);
        }

        private void cb_quartier_SelectedIndexChanged(object sender, EventArgs e) {
            Debug.WriteLine(string.Format("[{0}]{1}", cb_quartier.SelectedIndex, cb_quartier.SelectedItem.ToString()));
            this.tb_idQuartier.Enabled = true;

            l.RecupererLogementParQuartier(cb_quartier.SelectedItem.ToString());
            l.Premier();
            refresh(l);
            
        }

        private void btn_first_Click(object sender, EventArgs e) {
            this.tb_idQuartier.Enabled = true;

            l.Premier();
            refresh(l);
        }

        private void btn_previous_Click(object sender, EventArgs e) {
            this.tb_idQuartier.Enabled = true;

            l.Precedent();
            refresh(l);
        }

        private void btn_next_Click(object sender, EventArgs e) {
            this.tb_idQuartier.Enabled = true;

            l.Suivant();
            refresh(l);
        }

        private void btn_last_Click(object sender, EventArgs e) {
            this.tb_idQuartier.Enabled = true;

            l.Dernier();
            refresh(l);
        }



        private void btn_new_Click(object sender, EventArgs e) {
            this.tb_idQuartier.Enabled = false;

            l.Dernier();
            tb_identifiant.Text = (l.NLogement+1).ToString();
            tb_type.Text = "";
            tb_numero.Text = "0";
            tb_rue.Text = "";
            tb_superficie.Text = "0";
            tb_loyer.Text = "0";

            

        }
        private void btn_save_Click(object sender, EventArgs e) {
            bool fail=false;
            bool SQLsuccess=false;
            if (this.tb_idQuartier.Enabled) {
                MessageBox.Show("ERREUR: Veuillez créer une nouvelle entrée d'abord.\n Appuyez sur le bouton nouveau.");
                return;
            }
            if (this.cb_quartier.SelectedIndex < 0) {
                MessageBox.Show("ERREUR: Veuillez choisir un Quartier valide.");
                return;
            }
                

            int nlogement, idquartier, numero;
            float superficie, loyer;
            string rue, type;

            // trypase : 
            if (!int.TryParse(this.tb_identifiant.Text, out nlogement))
                fail = true;
            if (!int.TryParse(this.tb_idQuartier.Text, out idquartier))
                fail = true;
            if (!int.TryParse(this.tb_numero.Text, out numero))
                fail = true;
            if (!float.TryParse(this.tb_superficie.Text, out superficie))
                fail = true;
            if (!float.TryParse(this.tb_loyer.Text, out loyer))
                fail = true;
            if (fail) {
                MessageBox.Show("ERREUR: failed parsing!");
                return;
            }
            rue = this.tb_rue.Text;
            type = this.tb_type.Text;
            
            if (nlogement <= 0) {
                MessageBox.Show("ERREUR: nlogement incorrect");
            }
                
            Logement log = new Logement(nlogement, type, idquartier, numero, rue, superficie, loyer);
            try {
                SQLsuccess = log.AjouterLogement();
            } catch (Exception ex) {
                if (ex.Message.Contains("Violation of PRIMARY KEY")) {
                    MessageBox.Show("ERREUR : Identifiant déjà utlisé. Veuillez entrer un autre identifiant");
                } else {
                    MessageBox.Show(ex.Message);
                }
            }
            if (SQLsuccess) {
                MessageBox.Show("\tSUCCÈS !");
            }
        }
    }
}
