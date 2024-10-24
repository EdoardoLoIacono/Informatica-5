using DotNetIntro.App_Code;
using System;
using System.Data;
using System.Web.UI;

namespace DotNetIntro
{
    public partial class Dettagli : System.Web.UI.Page
    {
        int index = 0;
        DataTable table;
        protected void Page_Load(object sender, EventArgs e)
        {
            string dbPath = Server.MapPath("App_Data/Registro.mdf");
            string connStr = $"Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename={dbPath};Integrated Security=True;Connect Timeout=30";
            DbTools dbTools = new DbTools(connStr);

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
                string cogn = Request.QueryString["Cognome"];
                string sql = dbTools.GetBaseSelectAllStudents();
                sql += $" AND Cognome = '{cogn}'";
                table = dbTools.GetDataTable(sql);
                if (table.Rows.Count > 0)
                {
                    assignData();
                    if(table.Rows.Count > 1)
                    {
                        pnlPrevNext.Visible = true;
                    }
                }
                else
                {
                    pnlDatiStudente.Visible = false;
                    pnlNonTrovato.Visible = true;
                }
                ViewState["studentTable"] = table;
            }
            else
            {
                if (ViewState["studentTable"] != null) table = (DataTable)ViewState["studentTable"];
                if (ViewState["index"]!= null) index = (int)ViewState["index"];
            }
        }

        protected void btnHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }

        protected void btnPrev_Click(object sender, EventArgs e)
        {
            index--;
            assignData();
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            index++;
            assignData();
        }

        private void assignData()
        {
            DataRow row = table.Rows[index];
            lblNome.Text = row["Nome"].ToString();
            lblCognome.Text = row["Cognome"].ToString();
            lblClasse.Text = row["Classe"].ToString();
            lblGenere.Text = row["Genere"].ToString();
            lblAnnonascita.Text = row["AnnoNascita"].ToString();
            ViewState["index"] = index;
            btnPrev.Enabled = (index > 0);
            btnNext.Enabled = (index < table.Rows.Count - 1);
        }
    }
}