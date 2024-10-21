using System;
using System.Net.NetworkInformation;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetIntro.App_Code;

namespace DotNetIntro
{
    public partial class Default : System.Web.UI.Page
    {
        DbTools dbTools;
        protected void Page_Load(object sender, EventArgs e)
        {
            string dbPath = Server.MapPath("App_Data/Registro.mdf");
            string connStr = $"Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename={dbPath};Integrated Security=True;Connect Timeout=30";
            dbTools = new DbTools(connStr);

            //Visualizzo lo User agent
            lblUserAgent.Text = Request.ServerVariables["HTTP_USER_AGENT"];

            //Gestisco il contatore visite
            int count = Application["Contatore"] == null ? 0 : (int)Application["Contatore"];
            if (Session["oraConnessione"] == null) //Evito di incrementare quanto torno da altre pagine
            {
                count++; 
                Application.Lock();
                Application["Contatore"] = count;
                Application.UnLock();
            }
            lblCounter.Text = count.ToString();

            //Gestisco la data e ora di connessione
            if (Session["oraConnessione"] == null) //1^a volta che inizializzo la variabile di sessione
            {
                string oraConnessione = DateTime.Now.ToLongTimeString();
                lblConnectionTime.Text = oraConnessione;
                Session["oraConnessione"] = oraConnessione;
            }
            else
            {
                lblConnectionTime.Text = Session["oraConnessione"].ToString();
            }


            if (!Page.IsPostBack) 
            {
                //Se è la prima volta che apro la pagina 
                //lblMessaggio.Text = "Introduci il tuo Username e Password";

                //Riempio la combo
                cmbClasse.DataTextField = "Classe";
                cmbClasse.DataValueField = "Id";
                cmbClasse.DataSource = dbTools.GetDataTable("SELECT * FROM Classi ORDER BY Classe");
                cmbClasse.DataBind();
                cmbClasse.Items.Insert(0, "- TUTTE -");

                //Cerco e leggo il cookie filteredClass
                HttpCookie filteredClassCookie = Request.Cookies["filteredClass"];

                //Riempio la griglia
                if(filteredClassCookie == null || filteredClassCookie.Value == "0")//Se il cookie non c'è, oppure se c'è ma vale 0
                {
                    string sql = dbTools.GetBaseSelectAllStudents();
                    gridStudenti.DataSource = dbTools.GetDataTable(sql);
                    gridStudenti.DataBind();
                    
                }
                else 
                {
                    showFilteredStudents(int.Parse(filteredClassCookie.Value),"ALL");
                }
            }
            else //Questa parte viene eseguita le volte successive
            {
                //lblMessaggio.Text = $"Benvenuto {txtUsername.Text}";
            }
        }

        private void setFilteredClassCookie(int cmbClasseIndex)
        {
            Response.Cookies["filteredClass"].Value = cmbClasseIndex.ToString();
            Response.Cookies["filteredClass"].Expires = DateTime.Today.AddDays(30);

        }

        private void showFilteredStudents(int cmbClasseIndex, string gender)
        {
            string sql = dbTools.GetBaseSelectAllStudents();
            if (cmbClasseIndex > 0)
            {
                cmbClasse.SelectedIndex = cmbClasseIndex;
                sql += " AND Classi.Id = " + cmbClasse.Items[cmbClasseIndex].Value;
            }
            if (gender != "ALL")
            {
                sql += $" AND Genere ='{gender}'";
            }
            gridStudenti.DataSource = dbTools.GetDataTable(sql);
            gridStudenti.DataBind();
            setFilteredClassCookie(cmbClasseIndex);
        }

        protected void cmbClasse_SelectedIndexChanged(object sender, EventArgs e)
        {
            string gender = rbFemale.Checked ? "F" : rbMale.Checked ? "M" : "ALL";
            showFilteredStudents(cmbClasse.SelectedIndex, gender);
        }

        protected void rbGender_CheckedChanged(object sender, EventArgs e)
        {
           RadioButton rb = (RadioButton)sender;
           showFilteredStudents(cmbClasse.SelectedIndex, rb.Text);
        }

        protected void btnCerca_Click(object sender, EventArgs e)
        {
            if(txtCognome.Text.Length > 0)
            {
                Response.Redirect($"Dettagli.aspx?cognome={txtCognome.Text}");
            }
        }
    }
}