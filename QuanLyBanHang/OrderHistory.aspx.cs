using System;
using System.Data;
using System.Data.SqlClient;
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
            string sql = "SELECT Id, OrderDate, TotalPrice, Status FROM Orders WHERE UserId = @UserId ORDER BY OrderDate DESC";

            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@UserId", userId)
            };

            DataTable dt = kn.LayDuLieu(sql, parameters);

            if (dt.Rows.Count > 0)
            {
                gvHistory.DataSource = dt;
                gvHistory.DataBind();
                lblMessage.Text = "";
            }
            else
            {
                gvHistory.DataSource = null;
                gvHistory.DataBind();
                lblMessage.Text = "🛒 Bạn chưa có đơn hàng nào. Vui lòng <a href='Default.aspx'>tiếp tục mua sắm</a>!";
                lblMessage.ForeColor = System.Drawing.Color.Gray;
            }
        }

        protected void gvHistory_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string status = e.Row.Cells[3].Text;
                System.Drawing.Color statusColor = System.Drawing.Color.Black;

                switch (status)
                {
                    case "Chờ xác nhận":
                        statusColor = System.Drawing.Color.Orange;
                        break;
                    case "Đang giao":
                        statusColor = System.Drawing.Color.Blue;
                        break;
                    case "Đã giao":
                        statusColor = System.Drawing.Color.Green;
                        break;
                    case "Đã hủy":
                        statusColor = System.Drawing.Color.Red;
                        break;
                }

                e.Row.Cells[3].ForeColor = statusColor;
                e.Row.Cells[3].Font.Bold = true;
            }
        }
    }
}
