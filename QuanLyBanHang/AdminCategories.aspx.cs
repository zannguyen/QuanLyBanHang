using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace QuanLyBanHang
{
    public partial class AdminCategories : System.Web.UI.Page
    {
        LopKetNoi kn = new LopKetNoi();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] == null || Session["Role"].ToString() != "Admin")
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadCategories();
            }
        }

        private void LoadCategories()
        {
            string sql = "SELECT Id, Name FROM Categories ORDER BY Id DESC";
            DataTable dt = kn.LayDuLieu(sql);
            if (GridViewCategories != null)
            {
                GridViewCategories.DataSource = dt;
                GridViewCategories.DataBind();
            }
        }

        protected void btnAddCategory_Click(object sender, EventArgs e)
        {
            string newName = txtNewCategoryName.Text.Trim();
            if (string.IsNullOrEmpty(newName))
            {
                lblMessage.Text = "⚠️ Vui lòng nhập tên danh mục!";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            try
            {
                string sql = "INSERT INTO Categories (Name) VALUES (@Name)";
                SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@Name", newName) };
                kn.ThucThiLenh(sql, parameters);

                txtNewCategoryName.Text = "";
                lblMessage.Text = "✅ Thêm danh mục thành công!";
                lblMessage.ForeColor = System.Drawing.Color.Green;
                LoadCategories();
            }
            catch (Exception ex)
            {
                ErrorLogger.Log(ex, "AdminCategories - btnAddCategory_Click");
                lblMessage.Text = "❌ " + ErrorLogger.GetUserFriendlyMessage(ex.Message);
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void GridViewCategories_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int categoryId = Convert.ToInt32(GridViewCategories.DataKeys[e.RowIndex].Value);
                string sql = "DELETE FROM Categories WHERE Id = @Id";
                SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@Id", categoryId) };
                kn.ThucThiLenh(sql, parameters);
                lblMessage.Text = "✅ Xóa danh mục thành công!";
                lblMessage.ForeColor = System.Drawing.Color.Green;
                LoadCategories();
            }
            catch (Exception ex)
            {
                ErrorLogger.Log(ex, "AdminCategories - GridViewCategories_RowDeleting");
                lblMessage.Text = "❌ " + ErrorLogger.GetUserFriendlyMessage(ex.Message);
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}