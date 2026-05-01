using System;
using System.Data;

namespace QuanLyBanHang
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        LopKetNoi kn = new LopKetNoi();

        protected void Page_Load(object sender, EventArgs e)
        {
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

            string dateFrom = txtDateFrom.Text;
            string dateTo = txtDateTo.Text;

            // Load Total Orders in range
            string sqlOrders = $"SELECT COUNT(*) AS Total FROM Orders WHERE OrderDate >= '{dateFrom} 00:00:00' AND OrderDate <= '{dateTo} 23:59:59'";
            try
            {
                DataTable dtOrders = kn.LayDuLieu(sqlOrders);
                if (dtOrders.Rows.Count > 0)
                {
                    lblTotalOrders.Text = dtOrders.Rows[0]["Total"].ToString();
                }
            }
            catch { lblTotalOrders.Text = "0"; }

            // Load Products Stat
            string sqlProducts = $@"
                SELECT p.Name AS ProductName,
                       COALESCE((SELECT AVG(CAST(Rating AS FLOAT)) FROM Reviews r WHERE r.ProductId = p.Id), 0) AS AvgRating,
                       COALESCE((SELECT SUM(od.Quantity)
                                 FROM OrderDetails od 
                                 INNER JOIN Orders o ON od.OrderId = o.Id 
                                 WHERE od.ProductId = p.Id 
                                 AND o.OrderDate >= '{dateFrom} 00:00:00' 
                                 AND o.OrderDate <= '{dateTo} 23:59:59'), 0) AS TotalSold
                FROM Products p";
            try
            {
                DataTable dtProducts = kn.LayDuLieu(sqlProducts);
                gvProducts.DataSource = dtProducts;
                gvProducts.DataBind();
            }
            catch
            {
                // Fallback in case Reviews table doesn't exist
                string sqlProductsFallback = $@"
                SELECT p.Name AS ProductName,
                       0 AS AvgRating,
                       COALESCE((SELECT SUM(od.Quantity)
                                 FROM OrderDetails od 
                                 INNER JOIN Orders o ON od.OrderId = o.Id 
                                 WHERE od.ProductId = p.Id 
                                 AND o.OrderDate >= '{dateFrom} 00:00:00' 
                                 AND o.OrderDate <= '{dateTo} 23:59:59'), 0) AS TotalSold
                FROM Products p";
                try
                {
                    DataTable dtProductsFallback = kn.LayDuLieu(sqlProductsFallback);
                    gvProducts.DataSource = dtProductsFallback;
                    gvProducts.DataBind();
                }
                catch { }
            }
        }
    }
}