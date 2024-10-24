using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace eseAuto
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
        public string GetBaseSelectAllBooks()
        {
            return @"SELECT l.libro_id, l.titolo, l.anno_pubblicazione, a.nome_completo FROM libri l JOIN autori a ON a.autore_id = l.autore_id";
        }
    }
}