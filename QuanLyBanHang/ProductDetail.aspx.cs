using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
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

        private int GetProductId()
        {
            string id = Request.QueryString["id"];
            if (string.IsNullOrEmpty(id) || !int.TryParse(id, out int productId))
                return 0;
            return productId;
        }

        void LoadDetail()
        {
            int productId = GetProductId();

            if (productId == 0)
            {
                Response.Redirect("Default.aspx");
                return;
            }

            string sql = @"
                SELECT p.Id, p.Name, p.Price, p.Image, p.Description, c.Name AS CatName
                FROM Products p
                INNER JOIN Categories c ON p.CategoryId = c.Id
                WHERE p.Id = @ProductId";

            using (SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\QuanLyBanHang.mdf;Integrated Security=True"))
            {
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@ProductId", productId);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count == 0)
                    {
                        Response.Redirect("Default.aspx");
                        return;
                    }

                    rptDetail.DataSource = dt;
                    rptDetail.DataBind();
                }
            }

            LoadReviews(productId);
        }

        void LoadReviews(int productId)
        {
            string sql = @"
                SELECT r.Rating, r.Comment, r.CreatedDate, u.Username AS UserName
                FROM Reviews r
                INNER JOIN Users u ON r.UserId = u.Id
                WHERE r.ProductId = @ProductId
                ORDER BY r.CreatedDate DESC";

            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ProductId", productId) };
            DataTable dt = kn.LayDuLieu(sql, parameters);

            if (dt.Rows.Count > 0)
            {
                gvReviews.DataSource = dt;
                gvReviews.DataBind();
                noReviews.Visible = false;
            }
            else
            {
                noReviews.Visible = true;
                gvReviews.DataSource = null;
                gvReviews.DataBind();
            }
        }

        protected void btnSubmitReview_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                lblReviewMsg.Text = "⚠️ Vui lòng đăng nhập để đánh giá sản phẩm!";
                lblReviewMsg.ForeColor = System.Drawing.Color.Orange;
                return;
            }

            int productId = GetProductId();
            if (productId == 0)
                return;

            int rating = Convert.ToInt32(ddlRating.SelectedValue);
            string comment = txtReviewComment.Text.Trim();
            int userId = Convert.ToInt32(Session["UserId"]);

            if (string.IsNullOrEmpty(comment))
            {
                lblReviewMsg.Text = "⚠️ Vui lòng nhập nhận xét!";
                lblReviewMsg.ForeColor = System.Drawing.Color.Orange;
                return;
            }

            try
            {
                string sql = @"
                    INSERT INTO Reviews (ProductId, UserId, Rating, Comment, CreatedDate)
                    VALUES (@ProductId, @UserId, @Rating, @Comment, @CreatedDate)";

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@ProductId", productId),
                    new SqlParameter("@UserId", userId),
                    new SqlParameter("@Rating", rating),
                    new SqlParameter("@Comment", comment),
                    new SqlParameter("@CreatedDate", DateTime.Now)
                };

                kn.ThucThiLenh(sql, parameters);

                lblReviewMsg.Text = "✅ Cảm ơn bạn đã đánh giá sản phẩm!";
                lblReviewMsg.ForeColor = System.Drawing.Color.Green;
                ddlRating.SelectedIndex = 0;
                txtReviewComment.Text = "";
                LoadReviews(productId);
            }
            catch (Exception ex)
            {
                lblReviewMsg.Text = "❌ Lỗi: " + ex.Message;
                lblReviewMsg.ForeColor = System.Drawing.Color.Red;
            }
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