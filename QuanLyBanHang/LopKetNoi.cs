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

        public int ThucThiLenh(string sql)
        {
            if (con.State == ConnectionState.Closed) con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            int kq = cmd.ExecuteNonQuery();
            if (con.State == ConnectionState.Open) con.Close();
            return kq;
        }
    }
}  