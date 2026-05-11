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

                string sql = "INSERT INTO Vouchers (Code, DiscountPercent, MaxDiscount, ExpiryDate, Quantity) VALUES (@Code, @Percent, @MaxDiscount, @ExpiryDate, @Quantity)";
                using (System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\QuanLyBanHang.mdf;Integrated Security=True"))
                {
                    using (System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@Code", code);
                        cmd.Parameters.AddWithValue("@Percent", pctVal);
                        cmd.Parameters.AddWithValue("@MaxDiscount", maxVal);
                        cmd.Parameters.AddWithValue("@ExpiryDate", date);
                        cmd.Parameters.AddWithValue("@Quantity", qtyVal);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                lblMessage.Text = "Thêm voucher thành công!";
                lblMessage.ForeColor = System.Drawing.Color.Green;
                LoadData();
            }
            catch (Exception ex)
            {
                ErrorLogger.Log(ex, "AdminVouchers - btnAdd_Click");
                lblMessage.Text = "❌ " + ErrorLogger.GetUserFriendlyMessage(ex.Message);
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

                string sql = "UPDATE Vouchers SET Code = @Code, DiscountPercent = @Percent, MaxDiscount = @MaxDiscount, ExpiryDate = @ExpiryDate, Quantity = @Quantity WHERE Id = @Id";
                using (System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\QuanLyBanHang.mdf;Integrated Security=True"))
                {
                    using (System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@Code", code);
                        cmd.Parameters.AddWithValue("@Percent", pctVal);
                        cmd.Parameters.AddWithValue("@MaxDiscount", maxVal);
                        cmd.Parameters.AddWithValue("@ExpiryDate", date);
                        cmd.Parameters.AddWithValue("@Quantity", qtyVal);
                        cmd.Parameters.AddWithValue("@Id", id);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                gvVouchers.EditIndex = -1;
                LoadData();
                lblMessage.Text = "Cập nhật thành công!";
                lblMessage.ForeColor = System.Drawing.Color.Green;
            }
            catch (Exception ex)
            {
                ErrorLogger.Log(ex, "AdminVouchers - gvVouchers_RowUpdating");
                lblMessage.Text = "❌ " + ErrorLogger.GetUserFriendlyMessage(ex.Message);
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void gvVouchers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvVouchers.DataKeys[e.RowIndex].Value);
            string sql = "DELETE FROM Vouchers WHERE Id = @Id";
            System.Data.SqlClient.SqlParameter[] parameters = new System.Data.SqlClient.SqlParameter[]
            {
                new System.Data.SqlClient.SqlParameter("@Id", id)
            };
            kn.ThucThiLenh(sql, parameters);
            LoadData();
        }
    }
}
