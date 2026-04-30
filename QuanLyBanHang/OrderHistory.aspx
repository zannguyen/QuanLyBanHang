<%@ Page Title="Lịch sử mua hàng" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderHistory.aspx.cs" Inherits="QuanLyBanHang.OrderHistory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="utf-8" />
    <style>
        .page-title { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; color: #2c3e50; margin-bottom: 30px; text-align: center; margin-top: 30px; font-size: 32px; font-weight: 800; text-transform: uppercase; letter-spacing: 1.5px; position: relative; padding-bottom: 15px; text-shadow: 1px 1px 2px rgba(0,0,0,0.1); }
        .page-title::after { content: ''; position: absolute; bottom: 0; left: 50%; transform: translateX(-50%); width: 100px; height: 4px; background: linear-gradient(90deg, #ff7e5f, #feb47b); border-radius: 2px; }
        .table-container { background: #ffffff; border-radius: 15px; box-shadow: 0 10px 40px rgba(0,0,0,0.1); padding: 35px; margin: 40px auto; max-width: 1100px; font-family: 'Segoe UI', Tahoma, sans-serif; border: 1px solid #f0f0f0; transition: transform 0.4s ease, box-shadow 0.4s ease; background: linear-gradient(to right bottom, #ffffff, #fffdfa); }
        .table-container:hover { box-shadow: 0 15px 50px rgba(0,0,0,0.15); transform: translateY(-3px); }
        .table { width: 100%; border-collapse: separate; border-spacing: 0; margin-top: 25px; border-radius: 10px; overflow: hidden; box-shadow: 0 5px 20px rgba(0,0,0,0.06); }
        .table th, .table td { padding: 18px 20px; text-align: left; vertical-align: middle; }
        .table th { background: linear-gradient(135deg, #ff7e5f, #feb47b); font-weight: 700; color: #fff; font-size: 16px; text-transform: uppercase; border-bottom: none; letter-spacing: 1px; }
        .table td { border-bottom: 1px solid #f2f2f2; color: #444; font-size: 15px; transition: background-color 0.3s; background-color: #fff; }
        .table tr:last-child td { border-bottom: none; }
        .table-striped tr:nth-child(even) td { background-color: #fffaf6; }
        .table-striped tr:hover td { background-color: #ffe8d6; color: #2c3e50; transform: scale(1.001); }
        #lblMessage { display: block; text-align: center; margin-bottom: 20px; font-weight: 700; font-size: 16px; padding: 12px; border-radius: 8px; background-color: #fdeceb; color: #e74c3c; box-shadow: 0 2px 10px rgba(231,76,60,0.1); }
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
