<%@ Page Language="C#" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="QuanLyBanHang" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.ContentType = "text/plain";

        if (int.TryParse(Request.QueryString["id"], out int productId))
        {
            Dictionary<int, int> cart = Session["Cart"] as Dictionary<int, int>;
            if (cart == null)
                cart = new Dictionary<int, int>();

            if (cart.ContainsKey(productId))
                cart[productId]++;
            else
                cart[productId] = 1;

            Session["Cart"] = cart;

            // Save to database if logged in
            if (Session["UserId"] != null)
            {
                int userId = Convert.ToInt32(Session["UserId"]);
                CartManager cartMgr = new CartManager();
                cartMgr.SaveCartToDatabase(userId, cart);
            }

            Response.Write("OK");
        }
        else
        {
            Response.Write("ERROR");
        }

        Response.End();
    }
</script>
