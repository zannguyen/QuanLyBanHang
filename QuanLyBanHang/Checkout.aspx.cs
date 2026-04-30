using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace QuanLyBanHang
{
    public partial class Checkout : System.Web.UI.Page
    {
        string connect = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        LopKetNoi kn = new LopKetNoi();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDefaultPaymentUI();
                LoadTotal();
            }
        }

        void BindDefaultPaymentUI()
        {
            if (rblPaymentMethod != null)
            {
                if (string.IsNullOrEmpty(rblPaymentMethod.SelectedValue) && rblPaymentMethod.Items.Count > 0)
                    rblPaymentMethod.SelectedIndex = 0;
            }

            UpdatePaymentPanels();
        }

        void UpdatePaymentPanels()
        {
            string method = (rblPaymentMethod == null) ? string.Empty : rblPaymentMethod.SelectedValue;

            if (pnlBank != null) pnlBank.Visible = method == "Bank";
            if (pnlMomo != null) pnlMomo.Visible = method == "Momo";
        }

        protected void rblPaymentMethod_SelectedIndexChanged(object sender, EventArgs e)
        {
            UpdatePaymentPanels();
        }

        decimal GetTotal()
        {
            Dictionary<int, int> cart = Session["Cart"] as Dictionary<int, int>;

            if (cart == null || cart.Count == 0)
                return 0;

            string ids = string.Join(",", cart.Keys);
            DataTable products = kn.LayDuLieu("SELECT Id, Price FROM Products WHERE Id IN (" + ids + ")");

            decimal total = 0;

            foreach (DataRow p in products.Rows)
            {
                int id = Convert.ToInt32(p["Id"]);
                decimal price = Convert.ToDecimal(p["Price"]);
                int quantity = cart[id];

                total += price * quantity;
            }

            return total;
        }

        void LoadTotal()
        {
            decimal total = GetTotal();
            lblTotal.Text = string.Format("{0:N0}₫", total);
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            Dictionary<int, int> cart = Session["Cart"] as Dictionary<int, int>;

            if (cart == null || cart.Count == 0)
            {
                lblMsg.Text = "Giỏ hàng đang trống!";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            if (txtFullName.Text.Trim() == "" || txtEmail.Text.Trim() == "")
            {
                lblMsg.Text = "Vui lòng nhập đầy đủ họ tên và email!";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            if (txtShippingAddress.Text.Trim() == "")
            {
                lblMsg.Text = "Vui lòng nhập địa chỉ nhận hàng!";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            if (string.IsNullOrEmpty(rblPaymentMethod.SelectedValue))
            {
                lblMsg.Text = "Vui lòng chọn phương thức thanh toán!";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            decimal totalMoney = GetTotal();

            using (SqlConnection con = new SqlConnection(connect))
            {
                con.Open();
                SqlTransaction tran = con.BeginTransaction();

                try
                {
                    int userId = 1;

                    string shippingAddress = txtShippingAddress.Text.Trim();
                    string paymentMethodText = rblPaymentMethod.SelectedValue;

                    bool hasShippingAddress = false;
                    bool hasPaymentMethod = false;

                    using (SqlCommand schemaCmd = new SqlCommand(@"
                        SELECT
                            COALESCE(SUM(CASE WHEN COLUMN_NAME = 'ShippingAddress' THEN 1 ELSE 0 END), 0) AS HasShippingAddress,
                            COALESCE(SUM(CASE WHEN COLUMN_NAME = 'PaymentMethod' THEN 1 ELSE 0 END), 0) AS HasPaymentMethod
                        FROM INFORMATION_SCHEMA.COLUMNS
                        WHERE TABLE_NAME = 'Orders'
                          AND COLUMN_NAME IN ('ShippingAddress', 'PaymentMethod')", con, tran))
                    {
                        using (SqlDataReader r = schemaCmd.ExecuteReader())
                        {
                            if (r.Read())
                            {
                                hasShippingAddress = r["HasShippingAddress"] != DBNull.Value && Convert.ToInt32(r["HasShippingAddress"]) > 0;
                                hasPaymentMethod = r["HasPaymentMethod"] != DBNull.Value && Convert.ToInt32(r["HasPaymentMethod"]) > 0;
                            }
                        }
                    }

                    string orderSql;
                    SqlCommand orderCmd;

                    if (hasShippingAddress && hasPaymentMethod)
                    {
                        orderSql = @"
                            INSERT INTO Orders(UserId, TotalPrice, Status, ShippingAddress, PaymentMethod)
                            OUTPUT INSERTED.Id
                            VALUES(@UserId, @TotalPrice, N'Chờ xác nhận', @ShippingAddress, @PaymentMethod)";

                        orderCmd = new SqlCommand(orderSql, con, tran);
                        orderCmd.Parameters.AddWithValue("@UserId", userId);
                        orderCmd.Parameters.AddWithValue("@TotalPrice", totalMoney);
                        orderCmd.Parameters.AddWithValue("@ShippingAddress", shippingAddress);
                        orderCmd.Parameters.AddWithValue("@PaymentMethod", paymentMethodText);
                    }
                    else
                    {
                        // Database cũ chưa có 2 cột mới
                        orderSql = @"
                            INSERT INTO Orders(UserId, TotalPrice, Status)
                            OUTPUT INSERTED.Id
                            VALUES(@UserId, @TotalPrice, N'Chờ xác nhận')";

                        orderCmd = new SqlCommand(orderSql, con, tran);
                        orderCmd.Parameters.AddWithValue("@UserId", userId);
                        orderCmd.Parameters.AddWithValue("@TotalPrice", totalMoney);
                    }

                    int orderId = Convert.ToInt32(orderCmd.ExecuteScalar());

                    string ids = string.Join(",", cart.Keys);
                    DataTable products = new DataTable();
                    using (SqlCommand productsCmd = new SqlCommand("SELECT Id, Price FROM Products WHERE Id IN (" + ids + ")", con, tran))
                    using (SqlDataAdapter da = new SqlDataAdapter(productsCmd))
                    {
                        da.Fill(products);
                    }

                    foreach (DataRow p in products.Rows)
                    {
                        int productId = Convert.ToInt32(p["Id"]);
                        decimal price = Convert.ToDecimal(p["Price"]);
                        int quantity = cart[productId];

                        string detailSql = @"
                            INSERT INTO OrderDetails(OrderId, ProductId, Quantity, Price)
                            VALUES(@OrderId, @ProductId, @Quantity, @Price)";

                        SqlCommand detailCmd = new SqlCommand(detailSql, con, tran);
                        detailCmd.Parameters.AddWithValue("@OrderId", orderId);
                        detailCmd.Parameters.AddWithValue("@ProductId", productId);
                        detailCmd.Parameters.AddWithValue("@Quantity", quantity);
                        detailCmd.Parameters.AddWithValue("@Price", price);

                        detailCmd.ExecuteNonQuery();
                    }

                    tran.Commit();

                    Session["Cart"] = null;

                    lblMsg.Text = "Đặt hàng thành công!";
                    lblMsg.ForeColor = System.Drawing.Color.Green;
                    lblTotal.Text = "0₫";
                }
                catch (Exception ex)
                {
                    tran.Rollback();

                    lblMsg.Text = "Lỗi đặt hàng: " + ex.Message;
                    lblMsg.ForeColor = System.Drawing.Color.Red;
                }
            }
        }
    }
}