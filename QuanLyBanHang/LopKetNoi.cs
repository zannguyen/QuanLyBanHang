using System.Data;
using System.Data.SqlClient;

namespace QuanLyBanHang
{
    public class LopKetNoi
    {
        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\QuanLyBanHang.mdf;Integrated Security=True");

        public DataTable LayDuLieu(string sql)
        {
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(sql, con);
            da.Fill(dt);
            return dt;
        }

        public DataTable LayDuLieu(string sql, SqlParameter[] parameters)
        {
            DataTable dt = new DataTable();
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                if (parameters != null)
                    cmd.Parameters.AddRange(parameters);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }
            return dt;
        }

        public int ThucThiLenh(string sql)
        {
            if (con.State == ConnectionState.Closed) con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            int kq = cmd.ExecuteNonQuery();
            if (con.State == ConnectionState.Open) con.Close();
            return kq;
        }

        public int ThucThiLenh(string sql, SqlParameter[] parameters)
        {
            if (con.State == ConnectionState.Closed) con.Open();
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                if (parameters != null)
                    cmd.Parameters.AddRange(parameters);
                int kq = cmd.ExecuteNonQuery();
                return kq;
            }
        }

        public object ThucThiLenhScalar(string sql, SqlParameter[] parameters)
        {
            if (con.State == ConnectionState.Closed) con.Open();
            try
            {
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    if (parameters != null)
                        cmd.Parameters.AddRange(parameters);
                    return cmd.ExecuteScalar();
                }
            }
            finally
            {
                if (con.State == ConnectionState.Open) con.Close();
            }
        }
    }
}