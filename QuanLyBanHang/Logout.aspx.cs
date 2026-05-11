using System;

namespace QuanLyBanHang
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Save cart to database before logout
            if (Session["UserId"] != null)
            {
                int userId = Convert.ToInt32(Session["UserId"]);
                var cart = Session["Cart"] as System.Collections.Generic.Dictionary<int, int>;

                CartManager cartMgr = new CartManager();
                if (cart != null && cart.Count > 0)
                {
                    cartMgr.SaveCartToDatabase(userId, cart);
                }
            }

            // Clear session
            Session.Clear();
            Session.Abandon();

            // Redirect to home
            Response.Redirect("Default.aspx");
        }
    }
}
