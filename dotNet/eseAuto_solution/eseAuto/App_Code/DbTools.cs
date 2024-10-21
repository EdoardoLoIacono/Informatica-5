using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;

namespace eseAuto.App_Code
{
    public class DbTools
    {
        private string connStr;
        public DbTools(string cs)
        {
            this.connStr = cs;
        }

        public DataTable GetDataTable(string sql)
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
        public string GetBaseSelectAllMachines()
        {
            return @"SELECT a.Marca, a.Modello, a.Alimentazione, a.Prezzo
                     FROM Auto a";
        }
    }
}