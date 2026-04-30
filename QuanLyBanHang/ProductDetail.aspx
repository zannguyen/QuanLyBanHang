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

</div>

</asp:Content>