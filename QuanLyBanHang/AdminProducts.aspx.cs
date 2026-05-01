using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QuanLyBanHang
{
    public partial class AdminProducts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

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
                lblMessage.Text = "Vui lòng nhập tên và giá sản phẩm!";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            try
            {
                decimal price = decimal.Parse(priceStr);
                int categoryId = int.Parse(categoryIdStr);

                SqlDataSourceProducts.InsertParameters["Name"].DefaultValue = name;
                SqlDataSourceProducts.InsertParameters["Price"].DefaultValue = price.ToString();
                SqlDataSourceProducts.InsertParameters["Image"].DefaultValue = image;
                SqlDataSourceProducts.InsertParameters["Description"].DefaultValue = desc;
                SqlDataSourceProducts.InsertParameters["CategoryId"].DefaultValue = categoryId.ToString();

                SqlDataSourceProducts.Insert();

                // Clear form
                txtProductName.Text = "";
                txtProductPrice.Text = "";
                txtProductImage.Text = "";
                txtProductDesc.Text = "";

                lblMessage.Text = "Thêm sản phẩm thành công!";
                lblMessage.ForeColor = System.Drawing.Color.Green;
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Có lỗi xảy ra: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}