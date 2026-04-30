<%@ Page Title="Quản Lý Đơn Hàng" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminOrders.aspx.cs" Inherits="QuanLyBanHang.AdminOrders" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="utf-8" />
    <style>
        .page-title { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; color: #1A1208; margin-bottom: 20px; padding-bottom: 10px; border-bottom: 2px solid #C9973A; }
        .wrapper-container { background: #fff; padding: 20px; font-family: 'Segoe UI', Tahoma, sans-serif; margin: 20px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        .table th, .table td { padding: 12px; border: 1px solid #e0e0e0; text-align: left; }
        .table th { background-color: #f4f4f4; color: #333; font-weight: bold; text-transform: uppercase; font-size: 14px; }
        .table tr:hover { background-color: #f9f9f9; }
        select { padding: 6px 12px; border-radius: 4px; border: 1px solid #ccc; font-family: inherit; }
        input[type="submit"], button, .btn { padding: 8px 16px; border: none; border-radius: 4px; cursor: pointer; background: #C9973A; color: #fff; font-weight: bold; }
        input[type="submit"]:hover, button:hover, .btn:hover { background: #b58530; }
        a { color: #C9973A; text-decoration: none; font-weight: bold; }
        a:hover { text-decoration: underline; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper-container">
        <h2 class="page-title">Quản Lý Đơn Hàng</h2>
        <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="False" DataKeyNames="Id"
            OnRowEditing="gvOrders_RowEditing" OnRowUpdating="gvOrders_RowUpdating" OnRowCancelingEdit="gvOrders_RowCancelingEdit"
            CssClass="table table-bordered">
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="Mã Đơn" ReadOnly="True" />
                <asp:BoundField DataField="Username" HeaderText="Khách hàng" ReadOnly="True" />
                <asp:BoundField DataField="OrderDate" HeaderText="Ngày đặt" ReadOnly="True" />
                <asp:BoundField DataField="TotalPrice" HeaderText="Tổng tiền" ReadOnly="True" DataFormatString="{0:N0} VNĐ" />
                <asp:TemplateField HeaderText="Trạng thái">
                    <ItemTemplate>
                        <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList ID="ddlStatus" runat="server" SelectedValue='<%# Eval("Status") %>'>
                            <asp:ListItem Text="Chờ xử lý" Value="Chờ xử lý" />
                            <asp:ListItem Text="Đã xác nhận" Value="Đã xác nhận" />
                            <asp:ListItem Text="Đang giao hàng" Value="Đang giao hàng" />
                            <asp:ListItem Text="Đã giao" Value="Đã giao" />
                            <asp:ListItem Text="Đã hủy" Value="Đã hủy" />
                        </asp:DropDownList>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:CommandField ShowEditButton="True" CancelText="Hủy" EditText="Sửa" UpdateText="Lưu" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
