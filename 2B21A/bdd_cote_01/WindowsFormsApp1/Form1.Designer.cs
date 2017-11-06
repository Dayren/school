namespace WindowsFormsApp1
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing) {
            if (disposing && (components != null)) {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent() {
            this.l_quartier = new System.Windows.Forms.Label();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.btn_save = new System.Windows.Forms.Button();
            this.btn_new = new System.Windows.Forms.Button();
            this.tb_loyer = new System.Windows.Forms.TextBox();
            this.l_loyer = new System.Windows.Forms.Label();
            this.btn_last = new System.Windows.Forms.Button();
            this.btn_next = new System.Windows.Forms.Button();
            this.btn_previous = new System.Windows.Forms.Button();
            this.btn_first = new System.Windows.Forms.Button();
            this.l_superficie = new System.Windows.Forms.Label();
            this.l_rue = new System.Windows.Forms.Label();
            this.l_numero = new System.Windows.Forms.Label();
            this.l_idQuartier = new System.Windows.Forms.Label();
            this.l_type = new System.Windows.Forms.Label();
            this.l_identifiant = new System.Windows.Forms.Label();
            this.tb_superficie = new System.Windows.Forms.TextBox();
            this.tb_rue = new System.Windows.Forms.TextBox();
            this.tb_numero = new System.Windows.Forms.TextBox();
            this.tb_idQuartier = new System.Windows.Forms.TextBox();
            this.tb_type = new System.Windows.Forms.TextBox();
            this.tb_identifiant = new System.Windows.Forms.TextBox();
            this.cb_quartier = new System.Windows.Forms.ComboBox();
            this.groupBox1.SuspendLayout();
            this.SuspendLayout();
            // 
            // l_quartier
            // 
            this.l_quartier.AutoSize = true;
            this.l_quartier.Location = new System.Drawing.Point(21, 15);
            this.l_quartier.Name = "l_quartier";
            this.l_quartier.Size = new System.Drawing.Size(44, 13);
            this.l_quartier.TabIndex = 0;
            this.l_quartier.Text = "Quartier";
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.btn_save);
            this.groupBox1.Controls.Add(this.btn_new);
            this.groupBox1.Controls.Add(this.tb_loyer);
            this.groupBox1.Controls.Add(this.l_loyer);
            this.groupBox1.Controls.Add(this.btn_last);
            this.groupBox1.Controls.Add(this.btn_next);
            this.groupBox1.Controls.Add(this.btn_previous);
            this.groupBox1.Controls.Add(this.btn_first);
            this.groupBox1.Controls.Add(this.l_superficie);
            this.groupBox1.Controls.Add(this.l_rue);
            this.groupBox1.Controls.Add(this.l_numero);
            this.groupBox1.Controls.Add(this.l_idQuartier);
            this.groupBox1.Controls.Add(this.l_type);
            this.groupBox1.Controls.Add(this.l_identifiant);
            this.groupBox1.Controls.Add(this.tb_superficie);
            this.groupBox1.Controls.Add(this.tb_rue);
            this.groupBox1.Controls.Add(this.tb_numero);
            this.groupBox1.Controls.Add(this.tb_idQuartier);
            this.groupBox1.Controls.Add(this.tb_type);
            this.groupBox1.Controls.Add(this.tb_identifiant);
            this.groupBox1.Location = new System.Drawing.Point(12, 42);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(260, 305);
            this.groupBox1.TabIndex = 1;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Logement";
            // 
            // btn_save
            // 
            this.btn_save.Location = new System.Drawing.Point(145, 268);
            this.btn_save.Name = "btn_save";
            this.btn_save.Size = new System.Drawing.Size(75, 23);
            this.btn_save.TabIndex = 22;
            this.btn_save.Text = "Enregistrer";
            this.btn_save.UseVisualStyleBackColor = true;
            this.btn_save.Click += new System.EventHandler(this.btn_save_Click);
            // 
            // btn_new
            // 
            this.btn_new.Location = new System.Drawing.Point(40, 268);
            this.btn_new.Name = "btn_new";
            this.btn_new.Size = new System.Drawing.Size(75, 23);
            this.btn_new.TabIndex = 21;
            this.btn_new.Text = "Nouveau";
            this.btn_new.UseVisualStyleBackColor = true;
            this.btn_new.Click += new System.EventHandler(this.btn_new_Click);
            // 
            // tb_loyer
            // 
            this.tb_loyer.Location = new System.Drawing.Point(154, 179);
            this.tb_loyer.Name = "tb_loyer";
            this.tb_loyer.Size = new System.Drawing.Size(100, 20);
            this.tb_loyer.TabIndex = 20;
            // 
            // l_loyer
            // 
            this.l_loyer.AutoSize = true;
            this.l_loyer.Location = new System.Drawing.Point(9, 182);
            this.l_loyer.Name = "l_loyer";
            this.l_loyer.Size = new System.Drawing.Size(39, 13);
            this.l_loyer.TabIndex = 19;
            this.l_loyer.Text = "Loyer :";
            // 
            // btn_last
            // 
            this.btn_last.Location = new System.Drawing.Point(193, 221);
            this.btn_last.Name = "btn_last";
            this.btn_last.Size = new System.Drawing.Size(27, 27);
            this.btn_last.TabIndex = 18;
            this.btn_last.Text = ">|";
            this.btn_last.UseVisualStyleBackColor = true;
            this.btn_last.Click += new System.EventHandler(this.btn_last_Click);
            // 
            // btn_next
            // 
            this.btn_next.Location = new System.Drawing.Point(145, 221);
            this.btn_next.Name = "btn_next";
            this.btn_next.Size = new System.Drawing.Size(27, 27);
            this.btn_next.TabIndex = 17;
            this.btn_next.Text = ">";
            this.btn_next.UseVisualStyleBackColor = true;
            this.btn_next.Click += new System.EventHandler(this.btn_next_Click);
            // 
            // btn_previous
            // 
            this.btn_previous.Location = new System.Drawing.Point(88, 221);
            this.btn_previous.Name = "btn_previous";
            this.btn_previous.Size = new System.Drawing.Size(27, 27);
            this.btn_previous.TabIndex = 16;
            this.btn_previous.Text = "<";
            this.btn_previous.UseVisualStyleBackColor = true;
            this.btn_previous.Click += new System.EventHandler(this.btn_previous_Click);
            // 
            // btn_first
            // 
            this.btn_first.Location = new System.Drawing.Point(40, 221);
            this.btn_first.Name = "btn_first";
            this.btn_first.Size = new System.Drawing.Size(27, 27);
            this.btn_first.TabIndex = 15;
            this.btn_first.Text = "|<";
            this.btn_first.UseVisualStyleBackColor = true;
            this.btn_first.Click += new System.EventHandler(this.btn_first_Click);
            // 
            // l_superficie
            // 
            this.l_superficie.AutoSize = true;
            this.l_superficie.Location = new System.Drawing.Point(9, 156);
            this.l_superficie.Name = "l_superficie";
            this.l_superficie.Size = new System.Drawing.Size(60, 13);
            this.l_superficie.TabIndex = 14;
            this.l_superficie.Text = "Superficie :";
            // 
            // l_rue
            // 
            this.l_rue.AutoSize = true;
            this.l_rue.Location = new System.Drawing.Point(9, 130);
            this.l_rue.Name = "l_rue";
            this.l_rue.Size = new System.Drawing.Size(33, 13);
            this.l_rue.TabIndex = 13;
            this.l_rue.Text = "Rue :";
            // 
            // l_numero
            // 
            this.l_numero.AutoSize = true;
            this.l_numero.Location = new System.Drawing.Point(9, 104);
            this.l_numero.Name = "l_numero";
            this.l_numero.Size = new System.Drawing.Size(50, 13);
            this.l_numero.TabIndex = 12;
            this.l_numero.Text = "Numéro :";
            // 
            // l_idQuartier
            // 
            this.l_idQuartier.AutoSize = true;
            this.l_idQuartier.Location = new System.Drawing.Point(9, 78);
            this.l_idQuartier.Name = "l_idQuartier";
            this.l_idQuartier.Size = new System.Drawing.Size(62, 13);
            this.l_idQuartier.TabIndex = 11;
            this.l_idQuartier.Text = "Id Quartier :";
            // 
            // l_type
            // 
            this.l_type.AutoSize = true;
            this.l_type.Location = new System.Drawing.Point(9, 52);
            this.l_type.Name = "l_type";
            this.l_type.Size = new System.Drawing.Size(37, 13);
            this.l_type.TabIndex = 10;
            this.l_type.Text = "Type :";
            // 
            // l_identifiant
            // 
            this.l_identifiant.AutoSize = true;
            this.l_identifiant.Location = new System.Drawing.Point(9, 26);
            this.l_identifiant.Name = "l_identifiant";
            this.l_identifiant.Size = new System.Drawing.Size(59, 13);
            this.l_identifiant.TabIndex = 3;
            this.l_identifiant.Text = "Identifiant :";
            // 
            // tb_superficie
            // 
            this.tb_superficie.Location = new System.Drawing.Point(154, 153);
            this.tb_superficie.Name = "tb_superficie";
            this.tb_superficie.Size = new System.Drawing.Size(100, 20);
            this.tb_superficie.TabIndex = 8;
            // 
            // tb_rue
            // 
            this.tb_rue.Location = new System.Drawing.Point(154, 127);
            this.tb_rue.Name = "tb_rue";
            this.tb_rue.Size = new System.Drawing.Size(100, 20);
            this.tb_rue.TabIndex = 7;
            // 
            // tb_numero
            // 
            this.tb_numero.Location = new System.Drawing.Point(154, 101);
            this.tb_numero.Name = "tb_numero";
            this.tb_numero.Size = new System.Drawing.Size(100, 20);
            this.tb_numero.TabIndex = 6;
            // 
            // tb_idQuartier
            // 
            this.tb_idQuartier.Location = new System.Drawing.Point(154, 75);
            this.tb_idQuartier.Name = "tb_idQuartier";
            this.tb_idQuartier.Size = new System.Drawing.Size(100, 20);
            this.tb_idQuartier.TabIndex = 5;
            // 
            // tb_type
            // 
            this.tb_type.Location = new System.Drawing.Point(154, 49);
            this.tb_type.Name = "tb_type";
            this.tb_type.Size = new System.Drawing.Size(100, 20);
            this.tb_type.TabIndex = 4;
            // 
            // tb_identifiant
            // 
            this.tb_identifiant.Location = new System.Drawing.Point(154, 23);
            this.tb_identifiant.Name = "tb_identifiant";
            this.tb_identifiant.Size = new System.Drawing.Size(100, 20);
            this.tb_identifiant.TabIndex = 3;
            // 
            // cb_quartier
            // 
            this.cb_quartier.FormattingEnabled = true;
            this.cb_quartier.Location = new System.Drawing.Point(81, 12);
            this.cb_quartier.Name = "cb_quartier";
            this.cb_quartier.Size = new System.Drawing.Size(191, 21);
            this.cb_quartier.TabIndex = 2;
            this.cb_quartier.SelectedIndexChanged += new System.EventHandler(this.cb_quartier_SelectedIndexChanged);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(284, 354);
            this.Controls.Add(this.cb_quartier);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.l_quartier);
            this.Name = "Form1";
            this.Text = "Form1";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label l_quartier;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.ComboBox cb_quartier;
        private System.Windows.Forms.TextBox tb_identifiant;
        private System.Windows.Forms.Label l_superficie;
        private System.Windows.Forms.Label l_rue;
        private System.Windows.Forms.Label l_numero;
        private System.Windows.Forms.Label l_idQuartier;
        private System.Windows.Forms.Label l_type;
        private System.Windows.Forms.Label l_identifiant;
        private System.Windows.Forms.TextBox tb_superficie;
        private System.Windows.Forms.TextBox tb_rue;
        private System.Windows.Forms.TextBox tb_numero;
        private System.Windows.Forms.TextBox tb_idQuartier;
        private System.Windows.Forms.TextBox tb_type;
        private System.Windows.Forms.Button btn_last;
        private System.Windows.Forms.Button btn_next;
        private System.Windows.Forms.Button btn_previous;
        private System.Windows.Forms.Button btn_first;
        private System.Windows.Forms.Button btn_save;
        private System.Windows.Forms.Button btn_new;
        private System.Windows.Forms.TextBox tb_loyer;
        private System.Windows.Forms.Label l_loyer;
    }
}

