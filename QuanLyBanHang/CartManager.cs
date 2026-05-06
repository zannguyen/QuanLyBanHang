using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace QuanLyBanHang
{
    public class CartManager
    {
        private LopKetNoi kn = new LopKetNoi();

        public void LoadCartFromDatabase(int userId)
        {
            try
            {
                string sql = "SELECT ProductId, Quantity FROM CartItems WHERE UserId = @UserId";
                SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@UserId", userId) };
                DataTable dt = kn.LayDuLieu(sql, parameters);

                Dictionary<int, int> dbCart = new Dictionary<int, int>();
                foreach (DataRow row in dt.Rows)
                {
                    int productId = Convert.ToInt32(row["ProductId"]);
                    int quantity = Convert.ToInt32(row["Quantity"]);
                    dbCart[productId] = quantity;
                }

                // Merge with existing session cart (session cart items take priority)
                Dictionary<int, int> sessionCart = System.Web.HttpContext.Current.Session["Cart"] as Dictionary<int, int>;
                if (sessionCart != null && sessionCart.Count > 0)
                {
                    // Add/update session cart items to database cart
                    foreach (var item in sessionCart)
                    {
                        dbCart[item.Key] = item.Value;
                    }
                }

                System.Web.HttpContext.Current.Session["Cart"] = dbCart;
            }
            catch (Exception ex)
            {
                ErrorLogger.Log(ex, "CartManager - LoadCartFromDatabase");
            }
        }

        public void SaveCartToDatabase(int userId, Dictionary<int, int> cart)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\QuanLyBanHang.mdf;Integrated Security=True"))
                {
                    con.Open();

                    // Clear existing cart items
                    using (SqlCommand cmd = new SqlCommand("DELETE FROM CartItems WHERE UserId = @UserId", con))
                    {
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        cmd.ExecuteNonQuery();
                    }

                    // Insert new cart items
                    if (cart != null && cart.Count > 0)
                    {
                        foreach (var item in cart)
                        {
                            string sql = "INSERT INTO CartItems (UserId, ProductId, Quantity) VALUES (@UserId, @ProductId, @Quantity)";
                            using (SqlCommand cmd = new SqlCommand(sql, con))
                            {
                                cmd.Parameters.AddWithValue("@UserId", userId);
                                cmd.Parameters.AddWithValue("@ProductId", item.Key);
                                cmd.Parameters.AddWithValue("@Quantity", item.Value);
                                cmd.ExecuteNonQuery();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Log(ex, "CartManager - SaveCartToDatabase");
            }
        }

        public void ClearCart(int userId)
        {
            try
            {
                string sql = "DELETE FROM CartItems WHERE UserId = @UserId";
                SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@UserId", userId) };
                kn.ThucThiLenh(sql, parameters);
            }
            catch (Exception ex)
            {
                ErrorLogger.Log(ex, "CartManager - ClearCart");
            }
        }

        public void UpdateCartItem(int userId, int productId, int quantity)
        {
            try
            {
                if (quantity <= 0)
                {
                    RemoveCartItem(userId, productId);
                    return;
                }

                string sql = @"
                    IF EXISTS (SELECT 1 FROM CartItems WHERE UserId = @UserId AND ProductId = @ProductId)
                        UPDATE CartItems SET Quantity = @Quantity WHERE UserId = @UserId AND ProductId = @ProductId
                    ELSE
                        INSERT INTO CartItems (UserId, ProductId, Quantity) VALUES (@UserId, @ProductId, @Quantity)";

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@UserId", userId),
                    new SqlParameter("@ProductId", productId),
                    new SqlParameter("@Quantity", quantity)
                };
                kn.ThucThiLenh(sql, parameters);
            }
            catch (Exception ex)
            {
                ErrorLogger.Log(ex, "CartManager - UpdateCartItem");
            }
        }

        public void RemoveCartItem(int userId, int productId)
        {
            try
            {
                string sql = "DELETE FROM CartItems WHERE UserId = @UserId AND ProductId = @ProductId";
                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@UserId", userId),
                    new SqlParameter("@ProductId", productId)
                };
                kn.ThucThiLenh(sql, parameters);
            }
            catch (Exception ex)
            {
                ErrorLogger.Log(ex, "CartManager - RemoveCartItem");
            }
        }
    }
}
