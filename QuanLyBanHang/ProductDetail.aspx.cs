using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI.WebControls;

namespace QuanLyBanHang
{
    public partial class ProductDetail : System.Web.UI.Page
    {
        LopKetNoi kn = new LopKetNoi();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDetail();
            }
        }

        void LoadDetail()
        {
            string id = Request.QueryString["id"];

            if (string.IsNullOrEmpty(id))
            {
                Response.Redirect("Default.aspx");
                return;
            }

            string sql = @"
                SELECT p.Id, p.Name, p.Price, p.Image, p.Description, c.Name AS CatName
                FROM Products p
                INNER JOIN Categories c ON p.CategoryId = c.Id
                WHERE p.Id = " + id;

            DataTable dt = kn.LayDuLieu(sql);

            if (dt.Rows.Count == 0)
            {
                Response.Redirect("Default.aspx");
                return;
            }

            rptDetail.DataSource = dt;
            rptDetail.DataBind();
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

            Response.Redirect("Cart.aspx");
        }
    }
}