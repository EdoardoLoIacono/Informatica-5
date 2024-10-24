using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eseAuto
{
    public partial class Dettagli : System.Web.UI.Page
    {
        DbTools tools;
        DataTable table;
        protected void Page_Load(object sender, EventArgs e)
        {
            string dbPath = Server.MapPath("App_Data/Biblioteca.mdf");
            string connStr = $"Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename={dbPath};Integrated Security=True;Connect Timeout=30";
            tools = new DbTools(connStr);


            if(!Page.IsPostBack)
            {
                string titolo = Request.QueryString["Titolo"];
                string sql = $"SELECT titolo, anno_pubblicazione, nome_completo, libro_id, nazione FROM libri JOIN autori ON libri.autore_id = autori.autore_id WHERE libri.titolo = '{titolo}'";
                table = tools.GetDataTable(sql) ;
                if(table.Rows.Count > 0 )
                {
                    DataRow row = table.Rows[0];
                    lblTitolo.Text = row["titolo"].ToString();
                    lblAnno.Text = row["anno_pubblicazione"].ToString();
                    lblAutore.Text = row["nome_completo"].ToString();
                    lblId.Text = row["libro_id"].ToString();
                    lblNazionalita.Text = row["nazione"].ToString();

                }
                else
                {
                    pnlDatiLibro.Visible = false ;
                    pnlNonTrovato.Visible = true ;
                }
            }
        }

        protected void btnHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }
    }
}