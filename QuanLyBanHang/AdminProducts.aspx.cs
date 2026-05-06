using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QuanLyBanHang
{
    public partial class AdminProducts : System.Web.UI.Page
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
                LoadProducts();
            }
        }

        private void LoadCategories()
        {
            string sql = "SELECT Id, Name FROM Categories ORDER BY Name";
            DataTable dt = kn.LayDuLieu(sql);
            if (ddlCategory != null && dt.Rows.Count > 0)
            {
                ddlCategory.DataSource = dt;
                ddlCategory.DataTextField = "Name";
                ddlCategory.DataValueField = "Id";
                ddlCategory.DataBind();
            }
        }

        private void LoadProducts()
        {
            string sql = @"
                SELECT p.Id, p.Name, p.Price, p.Image, p.Description, c.Name AS CategoryName
                FROM Products p
                INNER JOIN Categories c ON p.CategoryId = c.Id
                ORDER BY p.Id DESC";

            DataTable dt = kn.LayDuLieu(sql);
            if (GridViewProducts != null)
            {
                GridViewProducts.DataSource = dt;
                GridViewProducts.DataBind();
            }
        }

        protected void btnAddProduct_Click(object sender, EventArgs e)
        {
            string name = txtProductName.Text.Trim();
            string priceStr = txtProductPrice.Text.Trim();
            string image = txtProductImage.Text.Trim();
            string desc = txtProductDesc.Text.Trim();
            string categoryIdStr = ddlCategory.SelectedValue;

            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(priceStr))
            {
                lblMessage.Text = "⚠️ Vui lòng nhập tên và giá sản phẩm!";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            try
            {
                decimal price = decimal.Parse(priceStr);
                int categoryId = int.Parse(categoryIdStr);

                string sql = "INSERT INTO Products (Name, Price, Image, Description, CategoryId) VALUES (@Name, @Price, @Image, @Description, @CategoryId)";
                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@Name", name),
                    new SqlParameter("@Price", price),
                    new SqlParameter("@Image", image),
                    new SqlParameter("@Description", desc),
                    new SqlParameter("@CategoryId", categoryId)
                };

                kn.ThucThiLenh(sql, parameters);

                txtProductName.Text = "";
                txtProductPrice.Text = "";
                txtProductImage.Text = "";
                txtProductDesc.Text = "";

                lblMessage.Text = "✅ Thêm sản phẩm thành công!";
                lblMessage.ForeColor = System.Drawing.Color.Green;
                LoadProducts();
            }
            catch (Exception ex)
            {
                ErrorLogger.Log(ex, "AdminProducts - btnAddProduct_Click");
                lblMessage.Text = "❌ " + ErrorLogger.GetUserFriendlyMessage(ex.Message);
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void GridViewProducts_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int productId = Convert.ToInt32(GridViewProducts.DataKeys[e.RowIndex].Value);
                string sql = "DELETE FROM Products WHERE Id = @Id";
                SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@Id", productId) };
                kn.ThucThiLenh(sql, parameters);
                lblMessage.Text = "✅ Xóa sản phẩm thành công!";
                lblMessage.ForeColor = System.Drawing.Color.Green;
                LoadProducts();
            }
            catch (Exception ex)
            {
                ErrorLogger.Log(ex, "AdminProducts - GridViewProducts_RowDeleting");
                lblMessage.Text = "❌ " + ErrorLogger.GetUserFriendlyMessage(ex.Message);
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void GridViewProducts_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow && e.Row.RowState == DataControlRowState.Edit)
            {
                DropDownList ddlGridCategory = (DropDownList)e.Row.FindControl("ddlGridCategory");
                if (ddlGridCategory != null)
                {
                    string sql = "SELECT Id, Name FROM Categories ORDER BY Name";
                    DataTable dt = kn.LayDuLieu(sql);
                    ddlGridCategory.DataSource = dt;
                    ddlGridCategory.DataTextField = "Name";
                    ddlGridCategory.DataValueField = "Id";
                    ddlGridCategory.DataBind();
                }
            }
        }
    }
}