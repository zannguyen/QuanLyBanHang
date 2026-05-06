<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="QuanLyBanHang.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div style="min-height:600px; display:flex; align-items:center; justify-content:center; padding:40px;">

  <div style="background:#fff; border-radius:16px; border:1px solid #E8DDD0;
              padding:48px; width:100%; max-width:480px;
              box-shadow: 0 8px 32px rgba(26,18,8,0.08);">

    <!-- TIÊU ĐỀ -->
    <div style="text-align:center; margin-bottom:32px;">
      <div style="font-family:'Georgia',serif; font-size:28px; font-weight:700; color:#1A1208;">
        Shop<span style="color:#C9973A;">VN</span>
      </div>
      <h2 style="font-family:'Georgia',serif; font-size:22px; color:#1A1208; margin-top:8px;">
        Đăng ký tài khoản
      </h2>
      <p style="color:#8B7355; font-size:13px; margin-top:6px;">
        Tạo tài khoản để mua sắm dễ dàng hơn!
      </p>
    </div>

    <!-- THÔNG BÁO LỖI -->
    <asp:Label ID="lblError" runat="server" Visible="false"
      style="display:block; background:#FADBD8; color:#C0392B;
             border-left:4px solid #C0392B; border-radius:6px;
             padding:10px 14px; font-size:13px; margin-bottom:20px;">
    </asp:Label>

    <!-- THÔNG BÁO THÀNH CÔNG -->
    <asp:Label ID="lblSuccess" runat="server" Visible="false"
      style="display:block; background:#D5F5E3; color:#27AE60;
             border-left:4px solid #27AE60; border-radius:6px;
             padding:10px 14px; font-size:13px; margin-bottom:20px;">
    </asp:Label>

    <!-- HỌ TÊN -->
    <div style="margin-bottom:16px;">
      <label style="display:block; font-size:13px; font-weight:600;
                    color:#1A1208; margin-bottom:6px;">
        Họ và tên
      </label>
      <asp:TextBox ID="txtFullName" runat="server"
        placeholder="Nhập họ và tên"
        style="width:100%; padding:11px 14px; border:1.5px solid #E8DDD0;
               border-radius:8px; font-size:14px; outline:none;
               font-family:'DM Sans',sans-serif; background:#FAF7F2;
               box-sizing:border-box;">
      </asp:TextBox>
    </div>

    <!-- USERNAME -->
    <div style="margin-bottom:16px;">
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
    <div style="margin-bottom:16px;">
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

    <!-- NHẬP LẠI PASSWORD -->
    <div style="margin-bottom:28px;">
      <label style="display:block; font-size:13px; font-weight:600;
                    color:#1A1208; margin-bottom:6px;">
        Nhập lại mật khẩu
      </label>
      <asp:TextBox ID="txtConfirmPassword" runat="server"
        TextMode="Password"
        placeholder="Nhập lại mật khẩu"
        style="width:100%; padding:11px 14px; border:1.5px solid #E8DDD0;
               border-radius:8px; font-size:14px; outline:none;
               font-family:'DM Sans',sans-serif; background:#FAF7F2;
               box-sizing:border-box;">
      </asp:TextBox>
    </div>

    <!-- NÚT ĐĂNG KÝ -->
    <asp:Button ID="btnRegister" runat="server" Text="Đăng ký"
      OnClick="btnRegister_Click"
      style="width:100%; background:#C9973A; color:#fff; border:none;
             padding:13px; border-radius:8px; font-size:15px; font-weight:600;
             cursor:pointer; font-family:'DM Sans',sans-serif; margin-bottom:16px;" />

    <!-- ĐĂNG NHẬP -->
    <div style="text-align:center; font-size:13px; color:#8B7355;">
      Đã có tài khoản?
      <a href="Login.aspx" style="color:#C9973A; font-weight:600; text-decoration:none;">
        Đăng nhập ngay
      </a>
    </div>

  </div>
</div>

</asp:Content>