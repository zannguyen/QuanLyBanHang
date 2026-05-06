using System;
using System.Data;
using System.Data.SqlClient;

namespace QuanLyBanHang
{
    public partial class AdminDashboard : System.Web.UI.Page
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
                LoadTotalUsers();
                txtDateFrom.Text = DateTime.Now.AddDays(-30).ToString("yyyy-MM-dd");
                txtDateTo.Text = DateTime.Now.ToString("yyyy-MM-dd");
                LoadDashboard();
            }
        }

        private void LoadTotalUsers()
        {
            try
            {
                DataTable dt = kn.LayDuLieu("SELECT COUNT(*) AS Total FROM Users");
                if (dt.Rows.Count > 0)
                {
                    lblTotalUsers.Text = dt.Rows[0]["Total"].ToString();
                }
            }
            catch { }
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            LoadDashboard();
        }

        private void LoadDashboard()
        {
            if (string.IsNullOrEmpty(txtDateFrom.Text) || string.IsNullOrEmpty(txtDateTo.Text))
                return;

            DateTime dateFrom = DateTime.Parse(txtDateFrom.Text);
            DateTime dateTo = DateTime.Parse(txtDateTo.Text);

            string sqlOrders = @"
                SELECT COUNT(*) AS Total FROM Orders
                WHERE OrderDate >= @DateFrom AND OrderDate <= @DateTo";

            try
            {
                SqlParameter[] paramsOrders = new SqlParameter[]
                {
                    new SqlParameter("@DateFrom", dateFrom),
                    new SqlParameter("@DateTo", dateTo.AddDays(1))
                };
                DataTable dtOrders = kn.LayDuLieu(sqlOrders, paramsOrders);
                if (dtOrders.Rows.Count > 0)
                {
                    lblTotalOrders.Text = dtOrders.Rows[0]["Total"].ToString();
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Log(ex, "AdminDashboard - LoadDashboard (Orders)");
                lblTotalOrders.Text = "0";
            }

            string sqlProducts = @"
                SELECT p.Name AS ProductName,
                       COALESCE((SELECT AVG(CAST(Rating AS FLOAT)) FROM Reviews r WHERE r.ProductId = p.Id), 0) AS AvgRating,
                       COALESCE((SELECT SUM(od.Quantity)
                                 FROM OrderDetails od
                                 INNER JOIN Orders o ON od.OrderId = o.Id
                                 WHERE od.ProductId = p.Id
                                 AND o.OrderDate >= @DateFrom
                                 AND o.OrderDate <= @DateTo), 0) AS TotalSold
                FROM Products p";

            try
            {
                SqlParameter[] paramsProducts = new SqlParameter[]
                {
                    new SqlParameter("@DateFrom", dateFrom),
                    new SqlParameter("@DateTo", dateTo.AddDays(1))
                };
                DataTable dtProducts = kn.LayDuLieu(sqlProducts, paramsProducts);
                gvProducts.DataSource = dtProducts;
                gvProducts.DataBind();
            }
            catch (Exception ex1)
            {
                ErrorLogger.Log(ex1, "AdminDashboard - LoadDashboard (Products with Reviews)");
                string sqlProductsFallback = @"
                SELECT p.Name AS ProductName,
                       0 AS AvgRating,
                       COALESCE((SELECT SUM(od.Quantity)
                                 FROM OrderDetails od
                                 INNER JOIN Orders o ON od.OrderId = o.Id
                                 WHERE od.ProductId = p.Id
                                 AND o.OrderDate >= @DateFrom
                                 AND o.OrderDate <= @DateTo), 0) AS TotalSold
                FROM Products p";
                try
                {
                    SqlParameter[] paramsFallback = new SqlParameter[]
                    {
                        new SqlParameter("@DateFrom", dateFrom),
                        new SqlParameter("@DateTo", dateTo.AddDays(1))
                    };
                    DataTable dtProductsFallback = kn.LayDuLieu(sqlProductsFallback, paramsFallback);
                    gvProducts.DataSource = dtProductsFallback;
                    gvProducts.DataBind();
                }
                catch (Exception ex2)
                {
                    ErrorLogger.Log(ex2, "AdminDashboard - LoadDashboard (Products fallback)");
                }
            }
        }
    }
}