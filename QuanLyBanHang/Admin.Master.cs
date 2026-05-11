using System;
using System;
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
                LopKetNoi ketnoi = new LopKetNoi();
                System.Data.DataTable dt = ketnoi.LayDuLieu("SELECT COUNT(*) FROM Orders WHERE Status = N'Chờ xác nhận'");
                if (dt != null && dt.Rows.Count > 0)
                {
                    pending = Convert.ToInt32(dt.Rows[0][0]);
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