using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QuanLyBanHang
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnAddCart_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int productId = int.Parse(btn.CommandArgument);

            // Lấy giỏ hàng từ Session
            Dictionary<int, int> cart = Session["Cart"] as Dictionary<int, int>;
            if (cart == null)
                cart = new Dictionary<int, int>();

            // Thêm sản phẩm vào giỏ
            if (cart.ContainsKey(productId))
                cart[productId]++;
            else
                cart[productId] = 1;

            Session["Cart"] = cart;

            // Chuyển sang giỏ hàng
            Response.Redirect("Cart.aspx");
        }
    }
}