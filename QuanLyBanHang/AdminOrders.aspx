<%@ Page Title="Quản Lý Đơn Hàng" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminOrders.aspx.cs" Inherits="QuanLyBanHang.AdminOrders" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="utf-8" />
    <style>
        .page-title { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; color: #1A1208; margin-bottom: 25px; padding-bottom: 15px; border-bottom: 3px solid #C9973A; font-size: 28px; text-transform: uppercase; letter-spacing: 1px; }
        .wrapper-container { background: #ffffff; padding: 30px; font-family: 'Segoe UI', Tahoma, sans-serif; margin: 30px auto; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); max-width: 1200px; }
        .table { width: 100%; border-collapse: separate; border-spacing: 0; margin-top: 20px; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 8px rgba(0,0,0,0.05); }
        .table th, .table td { padding: 15px; text-align: left; }
        .table th { background-color: #f8f9fa; color: #495057; font-weight: 600; text-transform: capitalize; font-size: 15px; border-bottom: 2px solid #e9ecef; }
        .table td { border-bottom: 1px solid #e9ecef; color: #333; font-size: 14px; }
        .table tr:last-child td { border-bottom: none; }
        .table tr:hover { background-color: #fdfbf7; transition: background-color 0.2s; }
        select { padding: 8px 12px; border-radius: 6px; border: 1px solid #ced4da; font-family: inherit; font-size: 14px; color: #495057; background-color: #fff; transition: border-color 0.2s; }
        select:focus { border-color: #C9973A; outline: none; box-shadow: 0 0 0 0.2rem rgba(201, 151, 58, 0.25); }
        input[type="submit"], button, .btn { padding: 8px 16px; border: none; border-radius: 6px; cursor: pointer; background: #C9973A; color: #fff; font-weight: 600; transition: all 0.2s; font-size: 14px; }
        input[type="submit"]:hover, button:hover, .btn:hover { background: #a87e31; transform: translateY(-1px); box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        a { color: #C9973A; text-decoration: none; font-weight: 600; transition: color 0.2s; }
        a:hover { color: #a87e31; text-decoration: underline; }
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
                        <asp:DropDownList ID="ddlStatus" runat="server" SelectedValue='<%# Bind("Status") %>'>
                            <asp:ListItem Text="Chờ xác nhận" Value="Chờ xác nhận" />
                            <asp:ListItem Text="Chờ xử lý" Value="Chờ xử lý" />
                            <asp:ListItem Text="Đã xác nhận" Value="Đã xác nhận" />
                            <asp:ListItem Text="Đang giao hàng" Value="Đang giao hàng" />
                            <asp:ListItem Text="Đang giao" Value="Đang giao" />
                            <asp:ListItem Text="Đã giao" Value="Đã giao" />
                            <asp:ListItem Text="Hoàn thành" Value="Hoàn thành" />
                            <asp:ListItem Text="Đã hủy" Value="Đã hủy" />
                        </asp:DropDownList>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:CommandField ShowEditButton="True" CancelText="Hủy" EditText="Sửa" UpdateText="Lưu" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
