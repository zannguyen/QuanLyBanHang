using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace QuanLyBanHang
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Role"] == null || !Session["Role"].ToString().Contains("Admin"))
                {
                    Response.Redirect("Login.aspx");
                    return;
                }

                BindPendingOrders();
            }
        }

        void BindPendingOrders()
        {
            int pending = 0;

            if (Application["PendingOrders"] != null)
            {
                int.TryParse(Application["PendingOrders"].ToString(), out pending);
            }

            if (pending == 0)
            {
                string connect = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

                using (SqlConnection con = new SqlConnection(connect))
                {
                    con.Open();

                    using (SqlCommand cmd = new SqlCommand(
                        "SELECT COUNT(*) FROM Orders WHERE Status = N'Chờ xác nhận'", con))
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