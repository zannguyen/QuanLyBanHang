using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QuanLyBanHang
{
    public partial class Login : System.Web.UI.Page
    {

        LopKetNoi kn = new LopKetNoi();
        protected void Page_Load(object sender, EventArgs e)
        {
            // Nếu đã đăng nhập rồi thì về trang chủ
            if (Session["UserId"] != null)
                Response.Redirect("Default.aspx");
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                lblError.Text = "⚠️ Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu!";
                lblError.Visible = true;
                return;
            }

            // Dùng LopKetNoi.LayDuLieu thay vì SqlCommand
            string sql = $"SELECT Id, FullName, Role FROM Users WHERE Username = '{username}' AND Password = '{password}'";
            DataTable dt = kn.LayDuLieu(sql);

            if (dt.Rows.Count > 0)
            {
                Session["UserId"] = dt.Rows[0]["Id"];
                Session["FullName"] = dt.Rows[0]["FullName"].ToString();
                Session["Role"] = dt.Rows[0]["Role"].ToString();

                if (dt.Rows[0]["Role"].ToString() == "Admin")
                    Response.Redirect("AdminDashboard.aspx");
                else
                    Response.Redirect("Default.aspx");
            }
            else
            {
                lblError.Text = "❌ Tên đăng nhập hoặc mật khẩu không đúng!";
                lblError.Visible = true;
            }
        }
    }
}