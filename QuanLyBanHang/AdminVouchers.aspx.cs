using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QuanLyBanHang
{
    public partial class AdminVouchers : System.Web.UI.Page
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
            gvVouchers.DataSource = kn.LayDuLieu("SELECT * FROM Vouchers ORDER BY Id DESC");
            gvVouchers.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                string code = txtCode.Text.Trim();
                string percent = txtDiscountPercent.Text;
                string max = txtMaxDiscount.Text;
                string date = txtExpiryDate.Text;
                string qty = txtQuantity.Text;

                if (string.IsNullOrEmpty(code) || string.IsNullOrEmpty(percent))
                {
                     lblMessage.Text = "Mã và phần trăm không được để trống!";
                     lblMessage.ForeColor = System.Drawing.Color.Red;
                     return;
                }

                decimal pctVal = Convert.ToDecimal(percent);
                decimal maxVal = string.IsNullOrEmpty(max) ? 0 : Convert.ToDecimal(max);
                int qtyVal = string.IsNullOrEmpty(qty) ? 0 : Convert.ToInt32(qty);

                string sql = $"INSERT INTO Vouchers (Code, DiscountPercent, MaxDiscount, ExpiryDate, Quantity) VALUES (N'{code}', {pctVal.ToString(System.Globalization.CultureInfo.InvariantCulture)}, {maxVal.ToString(System.Globalization.CultureInfo.InvariantCulture)}, '{date}', {qtyVal})";
                kn.ThucThiLenh(sql);

                lblMessage.Text = "Thêm voucher thành công!";
                lblMessage.ForeColor = System.Drawing.Color.Green;
                LoadData();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi khi thêm: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void gvVouchers_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvVouchers.EditIndex = e.NewEditIndex;
            LoadData();
        }

        protected void gvVouchers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvVouchers.EditIndex = -1;
            LoadData();
        }

        protected void gvVouchers_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int id = Convert.ToInt32(gvVouchers.DataKeys[e.RowIndex].Value);
                GridViewRow row = gvVouchers.Rows[e.RowIndex];

                string code = ((TextBox)row.Cells[1].Controls[0]).Text;
                string percent = ((TextBox)row.Cells[2].Controls[0]).Text;
                string max = ((TextBox)row.Cells[3].Controls[0]).Text;
                string date = ((TextBox)row.FindControl("txtEditDate")).Text;
                string qty = ((TextBox)row.Cells[5].Controls[0]).Text;

                decimal pctVal = Convert.ToDecimal(percent);
                decimal maxVal = Convert.ToDecimal(max);
                int qtyVal = Convert.ToInt32(qty);

                string sql = $"UPDATE Vouchers SET Code = N'{code}', DiscountPercent = {pctVal.ToString(System.Globalization.CultureInfo.InvariantCulture)}, MaxDiscount = {maxVal.ToString(System.Globalization.CultureInfo.InvariantCulture)}, ExpiryDate = '{date}', Quantity = {qtyVal} WHERE Id = {id}";
                kn.ThucThiLenh(sql);

                gvVouchers.EditIndex = -1;
                LoadData();
                lblMessage.Text = "Cập nhật thành công!";
                lblMessage.ForeColor = System.Drawing.Color.Green;
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi khi cập nhật: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void gvVouchers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvVouchers.DataKeys[e.RowIndex].Value);
            kn.ThucThiLenh($"DELETE FROM Vouchers WHERE Id = {id}");
            LoadData();
        }
    }
}
