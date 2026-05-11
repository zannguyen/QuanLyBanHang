using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QuanLyBanHang
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] != null)
            {
                pnlLoginBtn.Visible = false;
                pnlLogoutBtn.Visible = true;
                lblUserName.Text = Session["FullName"]?.ToString() ?? "User";

                if (Session["Role"]?.ToString() == "Admin")
                {
                    userProfileLink.HRef = "AdminDashboard.aspx";
                }
                else
                {
                    userProfileLink.HRef = "#";
                }
            }
            else
            {
                pnlLoginBtn.Visible = true;
                pnlLogoutBtn.Visible = false;
            }
        }

        void BindCartCount()
        {
            var cart = Session["Cart"] as Dictionary<int, int>;

            int count = 0;
            if (cart != null)
                count = cart.Values.Sum();

            if (lblCartCount == null)
                return;

            if (count > 0)
            {
                lblCartCount.Visible = true;
                lblCartCount.Text = count.ToString();
            }
            else
            {
                lblCartCount.Visible = false;
                lblCartCount.Text = string.Empty;
            }
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            BindCartCount();
        }
    }
}