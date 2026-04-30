using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QuanLyBanHang
{
    public partial class AdminOrders : System.Web.UI.Page
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
                LoadData();
            }
        }

        private void LoadData()
        {
            string sql = @"
                SELECT o.Id, u.Username, o.OrderDate, o.TotalPrice, o.Status 
                FROM Orders o 
                JOIN Users u ON o.UserId = u.Id 
                ORDER BY o.OrderDate DESC";
            gvOrders.DataSource = kn.LayDuLieu(sql);
            gvOrders.DataBind();
        }

        protected void gvOrders_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvOrders.EditIndex = e.NewEditIndex;
            LoadData();
        }

        protected void gvOrders_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvOrders.EditIndex = -1;
            LoadData();
        }

        protected void gvOrders_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int orderId = Convert.ToInt32(gvOrders.DataKeys[e.RowIndex].Value);
            DropDownList ddlStatus = (DropDownList)gvOrders.Rows[e.RowIndex].FindControl("ddlStatus");
            string newStatus = ddlStatus.SelectedValue;

            string sql = $"UPDATE Orders SET Status = N'{newStatus}' WHERE Id = {orderId}";
            kn.ThucThiLenh(sql);

            gvOrders.EditIndex = -1;
            LoadData();
        }
    }
}