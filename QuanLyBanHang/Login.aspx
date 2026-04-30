<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="QuanLyBanHang.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div style="min-height:600px; display:flex; align-items:center; justify-content:center; padding:40px;">

  <div style="background:#fff; border-radius:16px; border:1px solid #E8DDD0;
              padding:48px; width:100%; max-width:440px;
              box-shadow: 0 8px 32px rgba(26,18,8,0.08);">

    <!-- TIÊU ĐỀ -->
    <div style="text-align:center; margin-bottom:32px;">
      <div style="font-family:'Georgia',serif; font-size:28px; font-weight:700; color:#1A1208;">
        Shop<span style="color:#C9973A;">VN</span>
      </div>
      <h2 style="font-family:'Georgia',serif; font-size:22px; color:#1A1208; margin-top:8px;">
        Đăng nhập
      </h2>
      <p style="color:#8B7355; font-size:13px; margin-top:6px;">
        Chào mừng bạn trở lại!
      </p>
    </div>

    <!-- THÔNG BÁO LỖI -->
    <asp:Label ID="lblError" runat="server" Visible="false"
      style="display:block; background:#FADBD8; color:#C0392B;
             border-left:4px solid #C0392B; border-radius:6px;
             padding:10px 14px; font-size:13px; margin-bottom:20px;">
    </asp:Label>

    <!-- USERNAME -->
    <div style="margin-bottom:18px;">
      <label style="display:block; font-size:13px; font-weight:600;
                    color:#1A1208; margin-bottom:6px;">
        Tên đăng nhập
      </label>
      <asp:TextBox ID="txtUsername" runat="server"
        placeholder="Nhập tên đăng nhập"
        style="width:100%; padding:11px 14px; border:1.5px solid #E8DDD0;
               border-radius:8px; font-size:14px; outline:none;
               font-family:'DM Sans',sans-serif; background:#FAF7F2;
               box-sizing:border-box;">
      </asp:TextBox>
    </div>

    <!-- PASSWORD -->
    <div style="margin-bottom:24px;">
      <label style="display:block; font-size:13px; font-weight:600;
                    color:#1A1208; margin-bottom:6px;">
        Mật khẩu
      </label>
      <asp:TextBox ID="txtPassword" runat="server"
        TextMode="Password"
        placeholder="Nhập mật khẩu"
        style="width:100%; padding:11px 14px; border:1.5px solid #E8DDD0;
               border-radius:8px; font-size:14px; outline:none;
               font-family:'DM Sans',sans-serif; background:#FAF7F2;
               box-sizing:border-box;">
      </asp:TextBox>
    </div>

    <!-- NÚT ĐĂNG NHẬP -->
    <asp:Button ID="btnLogin" runat="server" Text="Đăng nhập"
      OnClick="btnLogin_Click"
      style="width:100%; background:#C9973A; color:#fff; border:none;
             padding:13px; border-radius:8px; font-size:15px; font-weight:600;
             cursor:pointer; font-family:'DM Sans',sans-serif; margin-bottom:16px;" />

    <!-- ĐĂNG KÝ -->
    <div style="text-align:center; font-size:13px; color:#8B7355;">
      Chưa có tài khoản?
      <a href="Register.aspx" style="color:#C9973A; font-weight:600; text-decoration:none;">
        Đăng ký ngay
      </a>
    </div>

  </div>
</div>

</asp:Content>