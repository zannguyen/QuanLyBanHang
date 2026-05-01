<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="QuanLyBanHang.AdminDashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .dashboard-container { padding: 20px; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .dashboard-card { margin: 0 auto 20px auto; text-align: center; width: 97.7%; background: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
        .dashboard-card h3 { margin-top: 0; color: #2c3e50; font-size: 18px; }
        .dashboard-card .value { font-size: 32px; font-weight: bold; color: #3498db; }
        .filter-section { display: flex; gap: 15px; align-items: center; justify-content: center; margin-bottom: 20px; }
        .filter-section input[type="date"] { padding: 8px; border: 1px solid #ddd; border-radius: 4px; }
        .btn { padding: 8px 16px; border: none; border-radius: 4px; cursor: pointer; color: #fff; background-color: #007bff; }
        .btn:hover { background-color: #0056b3; }
        .table-responsive { background: #fff; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
        .product-table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        .product-table th, .product-table td { padding: 10px; border: 1px solid #ddd; text-align: left; }
        .product-table th { background-color: #f4f4f4; color: #333; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="dashboard-card">
        <h3>Bộ lọc thời gian</h3>
            <div class="filter-section">
                <label>Từ ngày:</label>
                <asp:TextBox ID="txtDateFrom" runat="server" TextMode="Date"></asp:TextBox>
                <label>Đến ngày:</label>
                <asp:TextBox ID="txtDateTo" runat="server" TextMode="Date"></asp:TextBox>
                <asp:Button ID="btnFilter" runat="server" Text="Lọc Dữ Liệu" OnClick="btnFilter_Click" CssClass="btn" />
            </div>
    </div>
    
    <div class="dashboard-container">
        <h2>Dashboard</h2>

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

        <div class="table-responsive">
            <asp:GridView ID="gvProducts" runat="server" AutoGenerateColumns="False" CssClass="product-table" AllowPaging="true" AllowSorting="true">
                <Columns>
                    <asp:BoundField DataField="ProductName" HeaderText="Tên sản phẩm" />
                    <asp:BoundField DataField="AvgRating" HeaderText="Rating trung bình" DataFormatString="{0:0.0}" />
                    <asp:BoundField DataField="TotalSold" HeaderText="Số lượng bán ra" />
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
