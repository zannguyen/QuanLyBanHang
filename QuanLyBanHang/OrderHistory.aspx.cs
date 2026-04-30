using System;
using System.Web.UI.WebControls;

namespace QuanLyBanHang
{
    public partial class OrderHistory : System.Web.UI.Page
    {
        LopKetNoi kn = new LopKetNoi();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadData();
            }
        }

        private void LoadData()
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            string sql = $"SELECT Id, OrderDate, TotalPrice, Status FROM Orders WHERE UserId = {userId} ORDER BY OrderDate DESC";
            var dt = kn.LayDuLieu(sql);
            if (dt.Rows.Count > 0)
            {
                gvHistory.DataSource = dt;
                gvHistory.DataBind();
            }
            else
            {
                lblMessage.Text = "Bạn chưa có đơn hàng nào!";
            }
        }
    }
}
