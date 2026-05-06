<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductDetail.aspx.cs" Inherits="QuanLyBanHang.ProductDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div style="max-width:1100px; margin:40px auto; padding:0 32px;">

    <asp:Repeater ID="rptDetail" runat="server">
        <ItemTemplate>
            <div style="display:grid; grid-template-columns:420px 1fr; gap:40px;
                        background:white; padding:36px; border-radius:18px;
                        border:1px solid #E8DDD0;">

                <div style="height:400px; background:#F0EBE3; border-radius:16px;
                            display:flex; align-items:center; justify-content:center;">
                    <img src='Images/<%# Eval("Image") %>'
                         style="max-width:90%; max-height:350px; object-fit:contain;" />
                </div>

                <div>
                    <div style="font-size:13px; color:#8B7355; text-transform:uppercase;
                                letter-spacing:.08em; margin-bottom:10px;">
                        <%# Eval("CatName") %>
                    </div>

                    <h1 style="font-family:Georgia,serif; color:#1A1208;
                               font-size:34px; margin:0 0 16px;">
                        <%# Eval("Name") %>
                    </h1>

                    <div style="font-size:30px; color:#C9973A; font-weight:700;
                                margin-bottom:22px;">
                        <%# string.Format("{0:N0}₫", Eval("Price")) %>
                    </div>

                    <p style="font-size:15px; line-height:1.8; color:#6B4C2A;
                              margin-bottom:28px;">
                        <%# Eval("Description") %>
                    </p>

                    <asp:LinkButton ID="btnAddCart" runat="server"
                        CommandArgument='<%# Eval("Id") %>'
                        OnClick="btnAddCart_Click"
                        style="display:inline-block; background:#1A1208; color:white;
                               padding:14px 32px; border-radius:10px;
                               text-decoration:none; font-weight:600;">
                        🛒 Thêm vào giỏ hàng
                    </asp:LinkButton>

                    <a href="Default.aspx"
                       style="display:inline-block; margin-left:14px; color:#6B4C2A;
                              text-decoration:none; font-weight:600;">
                        ← Quay lại
                    </a>
                </div>

            </div>
        </ItemTemplate>
    </asp:Repeater>

    <!-- Reviews Section -->
    <div style="max-width:1100px; margin:40px auto; padding:0 32px;">
        <h2 style="font-family:Georgia,serif; color:#1A1208; font-size:28px;
                   border-bottom:2px solid #C9973A; padding-bottom:12px; margin-bottom:24px;">
            ⭐ Đánh giá sản phẩm
        </h2>

        <!-- Add Review Form -->
        <div style="background:#FFF8EE; padding:24px; border-radius:12px; margin-bottom:24px;
                    border:1px solid #E8DDD0;">
            <h3 style="color:#1A1208; margin-top:0;">Thêm đánh giá của bạn</h3>

            <div style="margin-bottom:14px;">
                <label style="display:block; margin-bottom:6px; font-weight:600;">Đánh giá (1-5 sao)</label>
                <asp:DropDownList ID="ddlRating" runat="server" style="padding:8px; border:1px solid #E8DDD0; border-radius:8px;">
                    <asp:ListItem Value="5">⭐⭐⭐⭐⭐ - Rất tốt</asp:ListItem>
                    <asp:ListItem Value="4">⭐⭐⭐⭐ - Tốt</asp:ListItem>
                    <asp:ListItem Value="3">⭐⭐⭐ - Bình thường</asp:ListItem>
                    <asp:ListItem Value="2">⭐⭐ - Kém</asp:ListItem>
                    <asp:ListItem Value="1">⭐ - Rất kém</asp:ListItem>
                </asp:DropDownList>
            </div>

            <div style="margin-bottom:14px;">
                <label style="display:block; margin-bottom:6px; font-weight:600;">Nhận xét</label>
                <asp:TextBox ID="txtReviewComment" runat="server" TextMode="MultiLine" Rows="4"
                    Placeholder="Chia sẻ trải nghiệm của bạn về sản phẩm..."
                    style="width:100%; padding:10px; border:1px solid #E8DDD0; border-radius:8px;
                           font-family:Arial; resize:vertical;" />
            </div>

            <asp:Button ID="btnSubmitReview" runat="server"
                Text="Gửi đánh giá"
                OnClick="btnSubmitReview_Click"
                style="background:#C9973A; color:white; border:none; padding:10px 20px;
                       border-radius:8px; font-weight:600; cursor:pointer;" />

            <asp:Label ID="lblReviewMsg" runat="server" style="display:block; margin-top:12px; font-weight:600;" />
        </div>

        <!-- Reviews List -->
        <asp:GridView ID="gvReviews" runat="server" AutoGenerateColumns="False" CssClass="reviews-table"
            style="width:100%; border-collapse:collapse;">
            <Columns>
                <asp:BoundField DataField="UserName" HeaderText="Người dùng" />
                <asp:BoundField DataField="Rating" HeaderText="Đánh giá" />
                <asp:BoundField DataField="Comment" HeaderText="Nhận xét" />
                <asp:BoundField DataField="CreatedDate" HeaderText="Ngày đánh giá" DataFormatString="{0:dd/MM/yyyy}" />
            </Columns>
            <HeaderStyle BackColor="#C9973A" ForeColor="White" Font-Bold="True" />
            <AlternatingRowStyle BackColor="#FFF8EE" />
            <RowStyle BackColor="White" />
        </asp:GridView>

        <div id="noReviews" runat="server" style="text-align:center; padding:24px; color:#999;">
            Chưa có đánh giá nào. Hãy là người đầu tiên đánh giá sản phẩm này!
        </div>
    </div>

</div>

</asp:Content>