<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Web.Script.Serialization" %>
<%@ Import Namespace="QuanLyBanHang" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.ContentType = "application/json";

        string keyword = Request.QueryString["q"];

        if (string.IsNullOrEmpty(keyword) || keyword.Length < 2)
        {
            Response.Write("[]");
            Response.End();
            return;
        }

        try
        {
            LopKetNoi kn = new LopKetNoi();
            keyword = keyword.Replace("'", "''");

            string sql = @"
                SELECT TOP 10 p.Id, p.Name, p.Price, p.Image, c.Name AS CategoryName
                FROM Products p
                JOIN Categories c ON p.CategoryId = c.Id
                WHERE p.Name LIKE '%" + keyword + @"%'
                ORDER BY p.Name ASC";

            DataTable dt = kn.LayDuLieu(sql);

            JavaScriptSerializer serializer = new JavaScriptSerializer();

            if (dt.Rows.Count > 0)
            {
                var products = new System.Collections.Generic.List<dynamic>();

                foreach (DataRow row in dt.Rows)
                {
                    products.Add(new
                    {
                        id = row["Id"].ToString(),
                        name = row["Name"].ToString(),
                        price = row["Price"].ToString(),
                        image = row["Image"].ToString(),
                        category = row["CategoryName"].ToString()
                    });
                }

                Response.Write(serializer.Serialize(products));
            }
            else
            {
                Response.Write("[]");
            }
        }
        catch (Exception ex)
        {
            Response.Write("[]");
        }

        Response.End();
    }
</script>
