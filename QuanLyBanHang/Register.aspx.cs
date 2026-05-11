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
    public partial class Register : System.Web.UI.Page
    {
        LopKetNoi kn = new LopKetNoi();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] != null)
                Response.Redirect("Default.aspx");
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string fullname = txtFullName.Text.Trim();
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();
            string confirm = txtConfirmPassword.Text.Trim();

            if (string.IsNullOrEmpty(fullname) || string.IsNullOrEmpty(username) ||
                string.IsNullOrEmpty(password))
            {
                ShowError("⚠️ Vui lòng nhập đầy đủ tất cả các trường!");
                return;
            }

            if (password != confirm)
            {
                ShowError("⚠️ Mật khẩu nhập lại không khớp!");
                return;
            }

            string sqlCheckUsername = "SELECT Id FROM Users WHERE Username = @Username";
            SqlParameter[] paramsUsername = new SqlParameter[] { new SqlParameter("@Username", username) };
            DataTable dtUser = kn.LayDuLieu(sqlCheckUsername, paramsUsername);

            if (dtUser.Rows.Count > 0)
            {
                ShowError("❌ Tên đăng nhập đã tồn tại!");
                return;
            }

            string sql = "INSERT INTO Users (Username, Password, FullName, Role) " +
                         "VALUES (@Username, @Password, @FullName, 'User')";

            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@Username", username),
                new SqlParameter("@Password", password),
                new SqlParameter("@FullName", fullname)
            };

            int kq = kn.ThucThiLenh(sql, parameters);

            if (kq > 0)
            {
                lblSuccess.Text = "✅ Đăng ký thành công! Đang chuyển đến trang đăng nhập...";
                lblSuccess.Visible = true;
                lblError.Visible = false;
                Response.AddHeader("Refresh", "2;url=Login.aspx");
            }
            else
            {
                ShowError("❌ Đăng ký thất bại, vui lòng thử lại!");
            }
        }

        private void ShowError(string msg)
        {
            lblError.Text = msg;
            lblError.Visible = true;
            lblSuccess.Visible = false;
        }
    }
}