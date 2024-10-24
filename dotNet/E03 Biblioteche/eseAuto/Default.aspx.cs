using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace eseAuto
{

    public partial class Default : System.Web.UI.Page
    {
        private string connStr;
        DbTools tools; 

        protected void Page_Load(object sender, EventArgs e)
        {
            string dbPath = Server.MapPath("App_Data/Biblioteca.mdf");
            string connStr = $"Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename={dbPath};Integrated Security=True;Connect Timeout=30";
            tools = new DbTools(connStr);

            //Visualizzo lo User agent
            lblUserAgent.Text = Request.ServerVariables["HTTP_USER_AGENT"];

            //Gestisco il contatore visite
            int count = Application["Contatore"] == null ? 0 : (int)Application["Contatore"]; //Se application["contatore"] è vuoto, va a 0, altrimenti prende il valore di application["contatore"]
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



            if (!IsPostBack)
            {
                cmbAutore.DataTextField = "nome_completo";
                cmbAutore.DataValueField = "nome_completo";
                cmbAutore.DataSource = tools.GetDataTable("SELECT a.nome_completo FROM autori a");
                cmbAutore.DataBind();
                cmbAutore.Items.Insert(0, "All");


                HttpCookie filteredAuthorCookie = Request.Cookies["filteredAuthor"];
                HttpCookie filteredID = Request.Cookies["filteredAuthorID"];
                if(filteredAuthorCookie == null || filteredID == null)
                {
                    showBooks(tools.GetBaseSelectAllBooks());
                    cmbAutore.SelectedIndex = 0;
                }
                else
                {
                    showBooks(tools.GetBaseSelectAllBooks()+$" WHERE a.nome_completo = '{filteredAuthorCookie.Value}'");
                    cmbAutore.SelectedIndex = int.Parse(filteredID.Value);
                }

            }
        }

        private void showBooks(string sql)
        {
            gdBooks.DataSource = tools.GetDataTable(sql);
            gdBooks.DataBind();
        }

        protected void cmbAutore_SelectedIndexChanged(object sender, EventArgs e)
        {
            string autore = cmbAutore.Text;
            if(autore != "All")
            {
                showBooks(tools.GetBaseSelectAllBooks() + $" WHERE a.nome_completo = '{autore}'");
                setFilteredAuthorCookie(autore);
            }
            else
            {
                showBooks(tools.GetBaseSelectAllBooks());
            }
        }

        private void setFilteredAuthorCookie(string autore)
        {
            HttpCookie cookie = new HttpCookie("filteredAuthor");
            cookie.Value = autore;
            cookie.Expires = DateTime.Now.AddMinutes(50);
            cookie.Path = "/";  // Rende il cookie accessibile in tutto il sito
            Response.Cookies.Add(cookie);
            HttpCookie cookieId = new HttpCookie("filteredAuthorID");
            cookieId.Value = cmbAutore.SelectedIndex.ToString();
            cookieId.Expires = DateTime.Now.AddMinutes(50);
            cookieId.Path = "/";  // Rende il cookie accessibile in tutto il sito
            Response.Cookies.Add(cookieId);
        }

        protected void btnDetails_Click(object sender, EventArgs e)
        {
            if (txtNome.Text.Length > 0)
            {
                Response.Redirect($"Dettagli.aspx?Titolo={txtNome.Text}");
            }
        }
    }
}