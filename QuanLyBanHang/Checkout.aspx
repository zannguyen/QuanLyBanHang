<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="QuanLyBanHang.Checkout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div style="max-width:900px; margin:40px auto; padding:0 32px;">

    <h2 style="font-family:Georgia,serif; color:#1A1208; font-size:30px;
               border-bottom:2px solid #C9973A; padding-bottom:12px;">
        Thanh toán đơn hàng
    </h2>

    <div style="background:white; padding:30px; border-radius:16px; margin-top:24px;
                border:1px solid #E8DDD0;">

        <label>Họ và tên</label>
        <asp:TextBox ID="txtFullName" runat="server"
            style="width:100%; padding:12px; margin:8px 0 16px;
                   border:1px solid #E8DDD0; border-radius:8px;" />

        <label>Email</label>
        <asp:TextBox ID="txtEmail" runat="server"
            style="width:100%; padding:12px; margin:8px 0 16px;
                   border:1px solid #E8DDD0; border-radius:8px;" />

        <label>Địa chỉ nhận hàng</label>
        <asp:TextBox ID="txtShippingAddress" runat="server" TextMode="MultiLine" Rows="3"
            style="width:100%; padding:12px; margin:8px 0 16px;
                   border:1px solid #E8DDD0; border-radius:8px;" />

        <label>Phương thức thanh toán</label>
        <asp:RadioButtonList ID="rblPaymentMethod" runat="server" RepeatDirection="Horizontal"
            AutoPostBack="true" OnSelectedIndexChanged="rblPaymentMethod_SelectedIndexChanged"
            style="margin:8px 0 16px;">
            <asp:ListItem Value="Bank">Ngân hàng</asp:ListItem>
            <asp:ListItem Value="Momo">MoMo</asp:ListItem>
        </asp:RadioButtonList>

        <asp:Panel ID="pnlBank" runat="server" Visible="false"
            style="background:#FFF8EE; border:1px solid #E8DDD0; border-radius:12px; padding:14px; margin:-6px 0 16px;">
            <div style="display:flex; gap:16px; align-items:flex-start; justify-content:space-between; flex-wrap:wrap;">
                <div style="min-width:240px;">
                    <div style="font-weight:700; margin-bottom:6px;">Thông tin chuyển khoản</div>
                    <div>Ngân hàng: <b>MB</b></div>
                    <div>Số tài khoản: <b>0961099359</b></div>
                    <div>Chủ tài khoản: <b>ShopDienThoai</b></div>
                    <div style="margin-top:8px; color:#6B4C2A; font-size:12px; font-weight:600;">Quét mã QR để chuyển khoản</div>
                </div>

                <div style="width:180px; height:180px; background:#fff; border:1px solid #E8DDD0; border-radius:12px; padding:10px;">
                    <img alt="QR chuyển khoản" src="Images/qr-bank.png"
                        style="width:160px; height:160px; display:block; margin:0 auto;" />
                </div>
            </div>
        </asp:Panel>

        <asp:Panel ID="pnlMomo" runat="server" Visible="false"
            style="background:#FFF8EE; border:1px solid #E8DDD0; border-radius:12px; padding:14px; margin:-6px 0 16px;">
            <div style="display:flex; gap:16px; align-items:flex-start; justify-content:space-between; flex-wrap:wrap;">
                <div style="min-width:240px;">
                    <div style="font-weight:700; margin-bottom:6px;">Thông tin thanh toán MoMo</div>
                    <div>SĐT MoMo: <b>0961099359</b></div>
                    <div>Nội dung chuyển tiền: <b>DH</b> + mã đơn hàng</div>
                    <div style="margin-top:8px; color:#6B4C2A; font-size:12px; font-weight:600;">Quét mã QR để thanh toán</div>
                </div>

                <div style="width:180px; height:180px; background:#fff; border:1px solid #E8DDD0; border-radius:12px; padding:10px;">
                    <img alt="QR MoMo" src="Images/qr-momo.png"
                        style="width:160px; height:160px; display:block; margin:0 auto;" />
                </div>
            </div>
        </asp:Panel>

        <!-- Voucher Section -->
        <div style="background:#F5F5F5; padding:16px; border-radius:8px; margin:16px 0;">
            <label style="font-weight:600;">Mã giảm giá (nếu có)</label>
            <div style="display:flex; gap:8px; margin-top:8px;">
                <asp:TextBox ID="txtVoucherCode" runat="server"
                    Placeholder="Nhập mã voucher..."
                    style="flex:1; padding:10px; border:1px solid #E8DDD0; border-radius:8px;" />
                <asp:Button ID="btnApplyVoucher" runat="server"
                    Text="Áp dụng"
                    OnClick="btnApplyVoucher_Click"
                    style="background:#C9973A; color:white; border:none; padding:10px 20px;
                           border-radius:8px; font-weight:600; cursor:pointer;" />
            </div>
            <asp:Label ID="lblVoucherMsg" runat="server" style="display:block; margin-top:8px; font-size:13px;" />
        </div>

        <div style="font-size:16px; margin-bottom:8px; padding:8px; background:#FFF8EE; border-radius:8px;">
            Tổng tiền hàng: <span style="color:#C9973A; font-weight:700;"><asp:Label ID="lblSubTotal" runat="server" /></span>
        </div>

        <div style="font-size:16px; margin-bottom:8px; padding:8px; background:#FFF8EE; border-radius:8px;">
            Giảm giá: <span style="color:#27AE60; font-weight:700;"><asp:Label ID="lblDiscount" runat="server" Text="0₫" /></span>
        </div>

        <div style="font-size:22px; font-weight:700; margin-bottom:20px; padding:12px; background:#FFF3E0; border-radius:8px; border:2px solid #C9973A;">
            Tổng thanh toán: <span style="color:#C9973A;"><asp:Label ID="lblTotal" runat="server" /></span>
        </div>

        <asp:Button ID="btnCheckout" runat="server"
            Text="Xác nhận đặt hàng"
            OnClick="btnCheckout_Click"
            style="background:#1A1208; color:white; border:none; padding:13px 30px;
                   border-radius:8px; font-weight:600; cursor:pointer;" />

        <asp:Label ID="lblMsg" runat="server"
            style="display:block; margin-top:18px; font-weight:600;" />

    </div>

</div>

</asp:Content>