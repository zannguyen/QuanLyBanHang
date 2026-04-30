using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;

namespace QuanLyBanHang
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                BindPendingOrders();
        }

        void BindPendingOrders()
        {
            int pending = 0;

            // Ưu tiên lấy từ Application nếu đã được cập nhật khi đặt hàng
            if (Application["PendingOrders"] != null)
                int.TryParse(Application["PendingOrders"].ToString(), out pending);

            // Nếu chưa có thì tự tính từ DB
            if (pending == 0)
            {
                string connect = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connect))
                {
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Orders WHERE Status = N'Chờ xác nhận'", con))
                    {
                        pending = Convert.ToInt32(cmd.ExecuteScalar());
                    }
                }
            }

            if (lblPendingOrders == null)
                return;

            if (pending > 0)
            {
                lblPendingOrders.Visible = true;
                lblPendingOrders.Text = pending.ToString();
            }
            else
            {
                lblPendingOrders.Visible = false;
                lblPendingOrders.Text = string.Empty;
            }
        }
    }
}