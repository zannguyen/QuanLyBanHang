<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="QuanLyBanHang.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div style="padding: 32px;">

  <!-- ===== HERO BANNER ===== -->
  <div style="background: linear-gradient(135deg, #1A1208 0%, #6B4C2A 100%);
              border-radius: 16px; padding: 52px 48px;
              display: flex; align-items: center; justify-content: space-between;
              margin-bottom: 40px; position: relative; overflow: hidden;">

    <div>
      <h1 style="font-family:'Georgia',serif; font-size:38px; font-weight:700;
                 color:#fff; line-height:1.2; margin-bottom:12px;">
        Công nghệ đỉnh cao,<br/>Giá ưu đãi
      </h1>
      <p style="color:#BCA888; font-size:15px; margin-bottom:24px;">
        Hàng chính hãng 100% · Giao hàng toàn quốc · Bảo hành chính hãng
      </p>
      <a href="Default.aspx" style="display:inline-block; background:#C9973A;
         color:#fff; padding:12px 28px; border-radius:8px; text-decoration:none;
         font-size:14px; font-weight:600;">
        ⚡ Mua ngay
      </a>
    </div>

    <div style="background:rgba(255,255,255,0.08); border:1px solid rgba(201,151,58,0.3);
                border-radius:12px; padding:32px 40px; text-align:center;">
      <span style="font-family:'Georgia',serif; font-size:56px; font-weight:700;
                   color:#C9973A; display:block;">50%</span>
      <span style="font-size:13px; color:#BCA888;">Giảm giá hôm nay</span>
    </div>

  </div>

  <!-- ===== TIÊU ĐỀ ===== -->
  <h2 style="font-family:'Georgia',serif; font-size:28px; font-weight:600;
             color:#1A1208; border-bottom:2px solid #C9973A;
             padding-bottom:12px; margin-bottom:28px;">
    <asp:Label ID="lblTitle" runat="server" Text="Sản phẩm nổi bật"></asp:Label>
  </h2>

  <!-- ===== DATASOURCE ===== -->
  <asp:SqlDataSource ID="SqlDataSource2" runat="server"
    ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
    SelectCommand="
      SELECT p.Id, p.Name, p.Price, p.Image, c.Name AS CatName
      FROM Products p
      JOIN Categories c ON p.CategoryId = c.Id">
  </asp:SqlDataSource>

  <!-- ===== DATALIST SẢN PHẨM ===== -->
  <asp:DataList ID="DataList2" runat="server"
    DataSourceID="SqlDataSource2"
    DataKeyField="Id"
    RepeatColumns="4"
    RepeatDirection="Horizontal"
    Width="100%">

    <ItemStyle VerticalAlign="Top" />

    <ItemTemplate>
      <div style="background:#fff; border-radius:12px; overflow:hidden;
                  border:1px solid #E8DDD0; margin:8px;">

        <!-- ẢNH -->
        <div style="height:180px; background:#F0EBE3;
                    display:flex; align-items:center; justify-content:center; padding:20px;">
          <asp:Image ID="imgProduct" runat="server"
            ImageUrl='<%# "~/Images/" + Eval("Image") %>'
            AlternateText='<%# Eval("Name") %>'
            style="max-height:140px; max-width:100%; object-fit:contain;" />
        </div>

        <!-- THÔNG TIN -->
        <div style="padding:16px;">
          <div style="font-size:11px; color:#8B7355; text-transform:uppercase;
                      letter-spacing:.06em; margin-bottom:4px;">
            <%# Eval("CatName") %>
          </div>
          <div style="font-size:15px; font-weight:600; color:#1A1208;
                      margin-bottom:6px; white-space:nowrap;
                      overflow:hidden; text-overflow:ellipsis;">
            <%# Eval("Name") %>
          </div>
          <div style="font-size:17px; font-weight:700; color:#C9973A;">
            <%# string.Format("{0:N0}₫", Eval("Price")) %>
          </div>
        </div>

        <!-- NÚT THÊM GIỎ HÀNG -->
      <div style="display:flex;">
    <a href='ProductDetail.aspx?id=<%# Eval("Id") %>'
       style="flex:1; text-align:center; background:#C9973A; color:#fff;
              padding:11px; font-size:13px; font-weight:500;
              text-decoration:none;">
        Chi tiết
    </a>

    <asp:LinkButton ID="btnAddCart" runat="server"
        CommandArgument='<%# Eval("Id") %>'
        OnClick="btnAddCart_Click"
        style="flex:1; text-align:center; background:#1A1208; color:#fff;
               padding:11px; font-size:13px; font-weight:500;
               text-decoration:none;">
        🛒 Thêm
    </asp:LinkButton>
</div>

      </div>
    </ItemTemplate>

  </asp:DataList>

</div>

</asp:Content>