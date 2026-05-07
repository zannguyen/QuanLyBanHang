using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI.WebControls;

namespace QuanLyBanHang
{
    public partial class Cart : System.Web.UI.Page
    {
        LopKetNoi kn = new LopKetNoi();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCart();
            }
        }

        void LoadCart()
        {
            Dictionary<int, int> cart = Session["Cart"] as Dictionary<int, int>;

            if (cart == null || cart.Count == 0)
            {
                gvCart.Visible = false;
                lblEmpty.Visible = true;
                lblTotal.Text = "0₫";
                return;
            }

            string ids = string.Join(",", cart.Keys);

            string sql = "SELECT Id, Name, Price FROM Products WHERE Id IN (" + ids + ")";
            DataTable products = kn.LayDuLieu(sql);

            DataTable dt = new DataTable();
            dt.Columns.Add("Id", typeof(int));
            dt.Columns.Add("Name", typeof(string));
            dt.Columns.Add("Price", typeof(decimal));
            dt.Columns.Add("Quantity", typeof(int));
            dt.Columns.Add("Total", typeof(decimal));

            decimal grandTotal = 0;

            foreach (DataRow p in products.Rows)
            {
                int id = Convert.ToInt32(p["Id"]);
                int quantity = cart[id];
                decimal price = Convert.ToDecimal(p["Price"]);
                decimal total = price * quantity;

                dt.Rows.Add(id, p["Name"].ToString(), price, quantity, total);
                grandTotal += total;
            }

            gvCart.Visible = true;
            lblEmpty.Visible = false;

            gvCart.DataSource = dt;
            gvCart.DataBind();

            lblTotal.Text = string.Format("{0:N0}₫", grandTotal);
        }

        protected void gvCart_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            Dictionary<int, int> cart = Session["Cart"] as Dictionary<int, int>;

            if (cart == null) return;

            int productId = int.Parse(e.CommandArgument.ToString());
            CartManager cartMgr = new CartManager();

            if (e.CommandName == "Plus")
            {
                cart[productId]++;
            }
            else if (e.CommandName == "Minus")
            {
                cart[productId]--;

                if (cart[productId] <= 0)
                    cart.Remove(productId);
            }
            else if (e.CommandName == "Remove")
            {
                cart.Remove(productId);
            }

            Session["Cart"] = cart;

            // Save cart to database if user is logged in
            if (Session["UserId"] != null)
            {
                int userId = Convert.ToInt32(Session["UserId"]);
                cartMgr.SaveCartToDatabase(userId, cart);
            }

            LoadCart();
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx?returnUrl=" + Server.UrlEncode("Cart.aspx"));
            }
            else
            {
                Response.Redirect("Checkout.aspx");
            }
        }
    }
}