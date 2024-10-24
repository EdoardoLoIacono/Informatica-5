using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace DotNetIntro.App_Code
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
        public string GetBaseSelectAllStudents()
        {
            return @"SELECT Cognome, Nome, Classe, AnnoNascita, Genere FROM Studenti, Classi
                                WHERE Studenti.id_Classe = Classi.Id";
        }
    }
}