<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="QuanLyBanHang.AdminDashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="utf-8" />
    <style>
        .page-title { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; color: #2c3e50; margin-bottom: 25px; padding-bottom: 15px; border-bottom: 3px solid #e74c3c; font-size: 28px; text-transform: uppercase; letter-spacing: 1px; text-align: center;}
        .wrapper-container { background: linear-gradient(to right bottom, #ffffff, #fdfbf7); padding: 30px; font-family: 'Segoe UI', Tahoma, sans-serif; margin: 30px auto; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); max-width: 1200px; }
        .table { width: 100%; border-collapse: separate; border-spacing: 0; margin-top: 20px; border-radius: 8px; overflow: hidden; box-shadow: 0 5px 15px rgba(0,0,0,0.08); }
        .table th, .table td { padding: 15px; text-align: left; }
        .table th { background: linear-gradient(135deg, #3498db, #2980b9); color: #F5F7FA; font-weight: 600; text-transform: capitalize; font-size: 15px; border-bottom: none; }
        .table th a { color: #F5F7FA; text-decoration: none; }
        .table td { border-bottom: 1px solid #e9ecef; color: #444; font-size: 14px; background-color: #fff; }
        .table tr:last-child td { border-bottom: none; }
        .table tr:nth-child(even) td { background-color: #f8fbfe; }
        .table tr:hover td { background-color: #eaf2f8; transition: background-color 0.3s ease; }
        input[type="submit"], button, .btn { padding: 8px 18px; border: none; border-radius: 6px; cursor: pointer; background: linear-gradient(135deg, #e74c3c, #c0392b); color: #fff; font-weight: 600; transition: all 0.3s ease; font-size: 14px; box-shadow: 0 2px 5px rgba(231, 76, 60, 0.3); }
        input[type="submit"]:hover, button:hover, .btn:hover { background: linear-gradient(135deg, #c0392b, #a53125); transform: translateY(-2px); box-shadow: 0 4px 8px rgba(231, 76, 60, 0.4); }
        .dashboard-container { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .dashboard-card { background: #f8fbfe; padding: 20px; border-radius: 8px; border: 1px solid #e9ecef; margin-bottom: 25px; box-shadow: 0 2px 8px rgba(0,0,0,0.05); text-align: center; }
        .dashboard-card h3 { margin-top: 0; color: #2c3e50; font-size: 18px; font-weight: 600; }
        .dashboard-card .value { font-size: 32px; font-weight: bold; color: #3498db; margin-top: 10px; }
        .filter-section { display: flex; gap: 15px; align-items: center; justify-content: center; margin-bottom: 20px; }
        .filter-section input[type="date"] { padding: 8px 12px; border-radius: 6px; border: 1px solid #bdc3c7; font-family: inherit; font-size: 14px; color: #34495e; background-color: #f9fbfd; transition: border-color 0.2s; }
        .filter-section input[type="date"]:focus { border-color: #3498db; outline: none; box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25); }
        .section-title { margin-top: 10px; font-size: 20px; color: #2980b9; font-weight: 600; border-bottom: 2px solid #3498db; display: inline-block; padding-bottom: 5px; margin-bottom: 15px; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper-container dashboard-container">
        <h2 class="page-title">Dashboard</h2>

        <div class="dashboard-card" style="padding: 25px;">
            <h3 style="border-bottom: 2px solid #3498db; display: inline-block; padding-bottom: 5px; margin-bottom: 20px;">Bộ lọc thời gian</h3>
            <div class="filter-section">
                <label style="font-weight: 600; color: #2c3e50;">Từ ngày:</label>
                <asp:TextBox ID="txtDateFrom" runat="server" TextMode="Date"></asp:TextBox>
                <label style="font-weight: 600; color: #2c3e50;">Đến ngày:</label>
                <asp:TextBox ID="txtDateTo" runat="server" TextMode="Date"></asp:TextBox>
                <asp:Button ID="btnFilter" runat="server" Text="Lọc Dữ Liệu" OnClick="btnFilter_Click" CssClass="btn" />
            </div>
        </div>
        
        <div style="display: flex; gap: 20px;">
            <div class="dashboard-card" style="flex: 1;">
                <h3>Tổng số Users</h3>
                <div class="value">
                    <asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label>
                </div>
            </div>
            <div class="dashboard-card" style="flex: 1;">
                <h3>Số lượng đơn hàng (theo bộ lọc)</h3>
                <div class="value">
                    <asp:Label ID="lblTotalOrders" runat="server" Text="0"></asp:Label>
                </div>
            </div>
        </div>

        <div>
            <h3 class="section-title">Thống kê sản phẩm</h3>
            <asp:GridView ID="gvProducts" runat="server" AutoGenerateColumns="False" CssClass="table" AllowSorting="true" OnSorting="gvProducts_Sorting">
                <Columns>
                    <asp:BoundField DataField="ProductName" HeaderText="Tên sản phẩm" SortExpression="ProductName" />
                    <asp:BoundField DataField="AvgRating" HeaderText="Rating trung bình" DataFormatString="{0:0.0}" SortExpression="AvgRating" />
                    <asp:BoundField DataField="TotalSold" HeaderText="Số lượng bán ra" SortExpression="TotalSold" />
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
