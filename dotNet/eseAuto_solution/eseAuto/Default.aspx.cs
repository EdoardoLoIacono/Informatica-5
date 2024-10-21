using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using eseAuto.App_code;
namespace eseAuto
{
    public partial class Default : System.Web.UI.Page
    {
        private DbTools dbTools;

        protected void Page_Load(object sender, EventArgs e)
        {
            string dbPath = Server.MapPath("App_Data/dbAuto.mdf");
            string connStr = $"Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename={dbPath};Integrated Security=True;Connect Timeout=30";
            dbTools = new DbTools(connStr);
        }
    }
}