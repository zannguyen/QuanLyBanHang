<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="QuanLyBanHang.Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div style="max-width:1100px; margin:40px auto; padding:0 32px;">

    <h2 style="font-family:Georgia,serif; color:#1A1208; font-size:30px;
               border-bottom:2px solid #C9973A; padding-bottom:12px;">
        Giỏ hàng của bạn
    </h2>

    <asp:Label ID="lblEmpty" runat="server" Visible="false"
        Text="Giỏ hàng đang trống."
        style="display:block; background:white; padding:24px; border-radius:12px;
               color:#6B4C2A; margin-top:24px;" />

    <asp:GridView ID="gvCart" runat="server" AutoGenerateColumns="False"
        OnRowCommand="gvCart_RowCommand"
        style="width:100%; background:white; border-collapse:collapse; margin-top:24px;"
        HeaderStyle-BackColor="#1A1208"
        HeaderStyle-ForeColor="White"
        HeaderStyle-Height="46px"
        RowStyle-Height="58px">

        <Columns>
            <asp:BoundField DataField="Name" HeaderText="Sản phẩm" />
            <asp:BoundField DataField="Price" HeaderText="Đơn giá" DataFormatString="{0:N0}₫" />
            <asp:BoundField DataField="Quantity" HeaderText="Số lượng" />
            <asp:BoundField DataField="Total" HeaderText="Thành tiền" DataFormatString="{0:N0}₫" />

            <asp:TemplateField HeaderText="Thao tác">
                <ItemTemplate>
                    <asp:LinkButton ID="btnMinus" runat="server"
                        CommandName="Minus"
                        CommandArgument='<%# Eval("Id") %>'
                        style="padding:6px 10px; background:#E8DDD0; color:#1A1208;
                               text-decoration:none; border-radius:6px;">-</asp:LinkButton>

                    <asp:LinkButton ID="btnPlus" runat="server"
                        CommandName="Plus"
                        CommandArgument='<%# Eval("Id") %>'
                        style="padding:6px 10px; background:#C9973A; color:white;
                               text-decoration:none; border-radius:6px;">+</asp:LinkButton>

                    <asp:LinkButton ID="btnRemove" runat="server"
                        CommandName="Remove"
                        CommandArgument='<%# Eval("Id") %>'
                        style="padding:6px 10px; background:#b23b3b; color:white;
                               text-decoration:none; border-radius:6px;">Xóa</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <div style="margin-top:24px; background:white; padding:24px; border-radius:12px;
                display:flex; justify-content:space-between; align-items:center;">
        <div style="font-size:22px; font-weight:700; color:#1A1208;">
            Tổng tiền:
            <asp:Label ID="lblTotal" runat="server" style="color:#C9973A;" />
        </div>

        <div>
            <a href="Default.aspx"
               style="padding:12px 22px; background:#E8DDD0; color:#1A1208;
                      border-radius:8px; text-decoration:none; margin-right:8px;">
                Tiếp tục mua
            </a>

            <asp:LinkButton ID="btnCheckout" runat="server" OnClick="btnCheckout_Click"
               style="padding:12px 22px; background:#1A1208; color:white;
                      border-radius:8px; text-decoration:none; display:inline-block; cursor:pointer;">
                Thanh toán
            </asp:LinkButton>
        </div>
    </div>

</div>

</asp:Content>