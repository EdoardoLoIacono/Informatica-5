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

        protected void Page_Load(object sender, EventArgs e)
        {
            string dbPath = Server.MapPath("App_Data/dbAuto.mdf");
            connStr = $"Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename={dbPath};Integrated Security=True;Connect Timeout=30";

            if (!Page.IsPostBack)
            {
                showTable(connStr, GetBaseSelectAllMachines());
                cmbMarche.DataTextField = "Marca";
                cmbMarche.DataValueField = "Marca";
                cmbMarche.DataSource = getData(connStr, "SELECT DISTINCT a.Marca FROM Auto a");
                cmbMarche.DataBind();
                cmbMarche.Items.Insert(0, "All");


            }
        }

        private void showTable(string connStr, string sql)
        {
            gridAuto.DataSource = getData(connStr, sql);
            gridAuto.DataBind();
        }

        private object getData(string connStr, string sql)
        {
            using (SqlConnection sqlConnection = new SqlConnection(connStr))
            {
                using (SqlCommand sqlCommand = new SqlCommand(sql, sqlConnection))
                {
                    sqlCommand.CommandType = System.Data.CommandType.Text;
                    using (SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sqlCommand))
                    {
                        DataTable dataTable = new DataTable();
                        sqlDataAdapter.Fill(dataTable);
                        return dataTable;
                    }
                }
            }
        }

        private string GetBaseSelectAllMachines()
        {
            return "SELECT a.Marca, a.Modello, a.Alimentazione, a.Prezzo FROM Auto a";
        }

        protected void cmbMarche_SelectedIndexChanged(object sender, EventArgs e)
        {
            string alimentazione = rbBenzina.Checked ? "Benzina" : rbElettrica.Checked ? "Elettrica" : "All";
            changeTable(cmbMarche.Text, alimentazione);
        }

        protected void rbAlimentazione_CheckedChanged(object sender, EventArgs e)
        {
            RadioButton rdb = (RadioButton)sender;
            string alimentazione = rdb.Text;
            changeTable(cmbMarche.Text, alimentazione);
        }

        private void changeTable(string marca, string alimentazione)
        {
            string sql = GetBaseSelectAllMachines();
            if(marca != "All" && alimentazione != "All")
            {
                sql += $" WHERE a.Marca = '{marca}' AND a.Alimentazione = '{alimentazione}'";
            }
            else if(marca != "All")
            {
                sql += $" WHERE a.Marca = '{marca}'";
            }
            else if(alimentazione != "All")
            {
                sql += $" WHERE a.Alimentazione = '{alimentazione}'";
            }
            showTable(connStr, sql);
        }
    }
}