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

        private decimal GetAppliedDiscount()
        {
            if (Session["VoucherId"] != null)
            {
                int voucherId = Convert.ToInt32(Session["VoucherId"]);
                string sql = "SELECT DiscountPercent, MaxDiscount FROM Vouchers WHERE Id = @VoucherId";
                SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@VoucherId", voucherId) };
                DataTable dt = kn.LayDuLieu(sql, parameters);

                if (dt.Rows.Count > 0)
                {
                    decimal discountPercent = Convert.ToDecimal(dt.Rows[0]["DiscountPercent"]);
                    decimal maxDiscount = Convert.ToDecimal(dt.Rows[0]["MaxDiscount"]);
                    decimal subtotal = GetTotal();
                    decimal discount = (subtotal * discountPercent) / 100;
                    return maxDiscount > 0 ? Math.Min(discount, maxDiscount) : discount;
                }
            }
            return 0;
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
            decimal subtotal = GetTotal();
            decimal discount = GetAppliedDiscount();
            decimal finalTotal = subtotal - discount;

            lblSubTotal.Text = string.Format("{0:N0}₫", subtotal);
            lblDiscount.Text = string.Format("{0:N0}₫", discount);
            lblTotal.Text = string.Format("{0:N0}₫", finalTotal);
        }

        protected void btnApplyVoucher_Click(object sender, EventArgs e)
        {
            string voucherCode = txtVoucherCode.Text.Trim().ToUpper();

            if (string.IsNullOrEmpty(voucherCode))
            {
                lblVoucherMsg.Text = "⚠️ Vui lòng nhập mã voucher!";
                lblVoucherMsg.ForeColor = System.Drawing.Color.Orange;
                return;
            }

            string sql = "SELECT Id, DiscountPercent, MaxDiscount, Quantity, ExpiryDate FROM Vouchers WHERE Code = @Code";
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@Code", voucherCode) };
            DataTable dt = kn.LayDuLieu(sql, parameters);

            if (dt.Rows.Count == 0)
            {
                lblVoucherMsg.Text = "❌ Mã voucher không tồn tại!";
                lblVoucherMsg.ForeColor = System.Drawing.Color.Red;
                Session["VoucherId"] = null;
                LoadTotal();
                return;
            }

            int quantity = Convert.ToInt32(dt.Rows[0]["Quantity"]);
            if (quantity <= 0)
            {
                lblVoucherMsg.Text = "❌ Mã voucher đã hết lượt sử dụng!";
                lblVoucherMsg.ForeColor = System.Drawing.Color.Red;
                Session["VoucherId"] = null;
                LoadTotal();
                return;
            }

            DateTime expiryDate = Convert.ToDateTime(dt.Rows[0]["ExpiryDate"]);
            if (expiryDate < DateTime.Now)
            {
                lblVoucherMsg.Text = "❌ Mã voucher đã hết hạn!";
                lblVoucherMsg.ForeColor = System.Drawing.Color.Red;
                Session["VoucherId"] = null;
                LoadTotal();
                return;
            }

            int voucherId = Convert.ToInt32(dt.Rows[0]["Id"]);
            decimal discountPercent = Convert.ToDecimal(dt.Rows[0]["DiscountPercent"]);
            decimal maxDiscount = Convert.ToDecimal(dt.Rows[0]["MaxDiscount"]);

            Session["VoucherId"] = voucherId;
            decimal discount = (GetTotal() * discountPercent) / 100;
            discount = maxDiscount > 0 ? Math.Min(discount, maxDiscount) : discount;

            lblVoucherMsg.Text = $"✅ Áp dụng giảm giá {discountPercent}% thành công! Tiết kiệm {discount:N0}₫";
            lblVoucherMsg.ForeColor = System.Drawing.Color.Green;
            LoadTotal();
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

            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            decimal subtotal = GetTotal();
            decimal discount = GetAppliedDiscount();
            decimal totalMoney = subtotal - discount;

            using (SqlConnection con = new SqlConnection(connect))
            {
                con.Open();
                SqlTransaction tran = con.BeginTransaction();

                try
                {
                    int userId = Convert.ToInt32(Session["UserId"]);

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

                        using (SqlCommand detailCmd = new SqlCommand(detailSql, con, tran))
                        {
                            detailCmd.Parameters.AddWithValue("@OrderId", orderId);
                            detailCmd.Parameters.AddWithValue("@ProductId", productId);
                            detailCmd.Parameters.AddWithValue("@Quantity", quantity);
                            detailCmd.Parameters.AddWithValue("@Price", price);
                            detailCmd.ExecuteNonQuery();
                        }
                    }

                    if (Session["VoucherId"] != null)
                    {
                        int voucherId = Convert.ToInt32(Session["VoucherId"]);
                        string updateVoucherSql = "UPDATE Vouchers SET Quantity = Quantity - 1 WHERE Id = @VoucherId";
                        using (SqlCommand voucherCmd = new SqlCommand(updateVoucherSql, con, tran))
                        {
                            voucherCmd.Parameters.AddWithValue("@VoucherId", voucherId);
                            voucherCmd.ExecuteNonQuery();
                        }
                    }

                    tran.Commit();

                    // Clear cart from database and session
                    CartManager cartMgr = new CartManager();
                    cartMgr.ClearCart(userId);

                    Session["Cart"] = null;
                    Session["VoucherId"] = null;

                    lblMsg.Text = "✅ Đặt hàng thành công!";
                    lblMsg.ForeColor = System.Drawing.Color.Green;
                    lblTotal.Text = "0₫";
                    lblSubTotal.Text = "0₫";
                    lblDiscount.Text = "0₫";
                    txtVoucherCode.Text = "";
                    lblVoucherMsg.Text = "";
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