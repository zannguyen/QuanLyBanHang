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

            string sql = "SELECT Id, FullName, Role, Password FROM Users WHERE Username = @Username";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@Username", username)
            };

            DataTable dt = kn.LayDuLieu(sql, parameters);

            if (dt.Rows.Count > 0)
            {
                string storedPassword = dt.Rows[0]["Password"].ToString();

                if (password == storedPassword)
                {
                    int userId = Convert.ToInt32(dt.Rows[0]["Id"]);
                    Session["UserId"] = userId;
                    Session["FullName"] = dt.Rows[0]["FullName"].ToString();
                    Session["Role"] = dt.Rows[0]["Role"].ToString();

                    CartManager cartMgr = new CartManager();
                    cartMgr.LoadCartFromDatabase(userId);

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
            else
            {
                lblError.Text = "❌ Tên đăng nhập hoặc mật khẩu không đúng!";
                lblError.Visible = true;
            }
        }
    }
}