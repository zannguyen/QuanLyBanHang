<%@ Page Title="Lịch sử mua hàng" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderHistory.aspx.cs" Inherits="QuanLyBanHang.OrderHistory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="utf-8" />
    <style>
        .page-title { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; color: #1A1208; margin-bottom: 30px; text-align: center; margin-top: 30px; font-size: 32px; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; position: relative; padding-bottom: 15px; }
        .page-title::after { content: ''; position: absolute; bottom: 0; left: 50%; transform: translateX(-50%); width: 80px; height: 3px; background-color: #C9973A; border-radius: 2px; }
        .table-container { background: #ffffff; border-radius: 12px; box-shadow: 0 8px 30px rgba(0,0,0,0.08); padding: 35px; margin: 40px auto; max-width: 1100px; font-family: 'Segoe UI', Tahoma, sans-serif; border: 1px solid #f0f0f0; transition: transform 0.3s ease, box-shadow 0.3s ease; }
        .table-container:hover { box-shadow: 0 12px 40px rgba(0,0,0,0.12); transform: translateY(-2px); }
        .table { width: 100%; border-collapse: separate; border-spacing: 0; margin-top: 25px; border-radius: 8px; overflow: hidden; box-shadow: 0 0 0 1px #e9ecef; }
        .table th, .table td { padding: 18px 20px; text-align: left; vertical-align: middle; }
        .table th { background-color: #f8f9fa; font-weight: 600; color: #495057; font-size: 15px; text-transform: capitalize; border-bottom: 2px solid #e9ecef; letter-spacing: 0.5px; }
        .table td { border-bottom: 1px solid #e9ecef; color: #555; font-size: 15px; transition: background-color 0.2s; }
        .table tr:last-child td { border-bottom: none; }
        .table-striped tr:nth-child(even) { background-color: #fdfdfd; }
        .table-striped tr:hover td { background-color: #fcf8ee; color: #333; }
        #lblMessage { display: block; text-align: center; margin-bottom: 20px; font-weight: 600; font-size: 16px; padding: 10px; border-radius: 6px; }
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
