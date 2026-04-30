<%@ Page Title="L?ch s? mua hàng" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderHistory.aspx.cs" Inherits="QuanLyBanHang.OrderHistory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="utf-8" />
    <style>
        .page-title { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; color: #333; margin-bottom: 20px; text-align: center; margin-top:20px; }
        .table-container { background: #fff; border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); padding: 20px; margin: 20px auto; max-width: 100%; font-family: 'Segoe UI', Tahoma, sans-serif; }
        .table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        .table th, .table td { padding: 12px 15px; border: 1px solid #ddd; text-align: left; }
        .table th { background-color: #f8f9fa; font-weight: bold; color: #333; }
        .table-striped tr:nth-child(even) { background-color: #fafafa; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="table-container">
        <h2 class="page-title">Lịch sử mua hàng</h2>
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
        <asp:GridView ID="gvHistory" runat="server" AutoGenerateColumns="False" CssClass="table table-striped" DataKeyNames="Id">
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="Mã đơn" />
                <asp:BoundField DataField="OrderDate" HeaderText="Ngày đặt" />
                <asp:BoundField DataField="TotalPrice" HeaderText="Tổng tiền (VNĐ)" DataFormatString="{0:N0}" />
                <asp:BoundField DataField="Status" HeaderText="Trạng thái" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
