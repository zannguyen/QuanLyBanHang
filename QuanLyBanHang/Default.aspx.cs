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
            if (!IsPostBack)
            {
                FilterProducts();
            }
        }

        private void FilterProducts()
        {
            string categoryId = Request.QueryString["cat"];
            string searchKeyword = Request.QueryString["search"];

            string sql = @"
                SELECT p.Id, p.Name, p.Price, p.Image, c.Name AS CatName
                FROM Products p
                JOIN Categories c ON p.CategoryId = c.Id
                WHERE 1=1";

            string title = "Sản phẩm nổi bật";

            if (!string.IsNullOrEmpty(categoryId))
            {
                int catId = int.Parse(categoryId);
                sql += " AND p.CategoryId = " + catId;

                // Get category name for title
                LopKetNoi kn = new LopKetNoi();
                System.Data.DataTable dt = kn.LayDuLieu("SELECT Name FROM Categories WHERE Id = " + catId);
                if (dt.Rows.Count > 0)
                {
                    title = "Danh mục: " + dt.Rows[0]["Name"].ToString();
                }
            }

            if (!string.IsNullOrEmpty(searchKeyword))
            {
                searchKeyword = searchKeyword.Replace("'", "''");
                sql += " AND (p.Name LIKE '%" + searchKeyword + "%' OR p.Description LIKE '%" + searchKeyword + "%')";
                title = "Tìm kiếm: " + searchKeyword;
            }

            sql += " ORDER BY p.Id DESC";

            SqlDataSource2.SelectCommand = sql;
            lblTitle.Text = title;
            DataList2.DataBind();
        }

        protected void btnAddCart_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int productId = int.Parse(btn.CommandArgument);

            Dictionary<int, int> cart = Session["Cart"] as Dictionary<int, int>;
            if (cart == null)
                cart = new Dictionary<int, int>();

            if (cart.ContainsKey(productId))
                cart[productId]++;
            else
                cart[productId] = 1;

            Session["Cart"] = cart;

            // Save cart to database if user is logged in
            if (Session["UserId"] != null)
            {
                int userId = Convert.ToInt32(Session["UserId"]);
                CartManager cartMgr = new CartManager();
                cartMgr.SaveCartToDatabase(userId, cart);
            }

            Response.Redirect("Cart.aspx");
        }
    }
}