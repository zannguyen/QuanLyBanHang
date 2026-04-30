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
            string email = txtEmail.Text.Trim();
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();
            string confirm = txtConfirmPassword.Text.Trim();

            // Kiểm tra đầu vào
            if (string.IsNullOrEmpty(fullname) || string.IsNullOrEmpty(email) ||
                string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                ShowError("⚠️ Vui lòng nhập đầy đủ tất cả các trường!");
                return;
            }

            if (password.Length < 6)
            {
                ShowError("⚠️ Mật khẩu phải có ít nhất 6 ký tự!");
                return;
            }

            if (password != confirm)
            {
                ShowError("⚠️ Mật khẩu nhập lại không khớp!");
                return;
            }

            // Kiểm tra username đã tồn tại chưa
            DataTable dtUser = kn.LayDuLieu($"SELECT Id FROM Users WHERE Username = '{username}'");
            if (dtUser.Rows.Count > 0)
            {
                ShowError("❌ Tên đăng nhập đã tồn tại!");
                return;
            }

            // Kiểm tra email đã tồn tại chưa
            DataTable dtEmail = kn.LayDuLieu($"SELECT Id FROM Users WHERE Email = '{email}'");
            if (dtEmail.Rows.Count > 0)
            {
                ShowError("❌ Email này đã được sử dụng!");
                return;
            }

            // Thêm user mới
            string sql = $"INSERT INTO Users (Username, Password, FullName, Email, Role) " +
                         $"VALUES ('{username}', '{password}', N'{fullname}', '{email}', 'User')";
            int kq = kn.ThucThiLenh(sql);

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