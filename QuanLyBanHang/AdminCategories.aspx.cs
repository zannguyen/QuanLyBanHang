using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QuanLyBanHang
{
    public partial class AdminCategories : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnAddCategory_Click(object sender, EventArgs e)
        {
            string newName = txtNewCategoryName.Text.Trim();
            if (string.IsNullOrEmpty(newName))
            {
                lblMessage.Text = "Vui lòng nhập tên danh mục!";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            try
            {
                // Assign value to the Insert parameter and execute Insert
                SqlDataSourceCategories.InsertParameters["Name"].DefaultValue = newName;
                SqlDataSourceCategories.Insert();

                txtNewCategoryName.Text = "";
                lblMessage.Text = "Thêm danh mục thành công!";
                lblMessage.ForeColor = System.Drawing.Color.Green;

                // Refresh grid is handled automatically by SqlDataSource.Insert()
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Có lỗi xảy ra: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}