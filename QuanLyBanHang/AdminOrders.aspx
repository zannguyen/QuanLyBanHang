<%@ Page Title="Quản Lý Đơn Hàng" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminOrders.aspx.cs" Inherits="QuanLyBanHang.AdminOrders" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="utf-8" />
    <style>
        .page-title { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; color: #2c3e50; margin-bottom: 25px; padding-bottom: 15px; border-bottom: 3px solid #e74c3c; font-size: 28px; text-transform: uppercase; letter-spacing: 1px; text-align: center;}
        .wrapper-container { background: linear-gradient(to right bottom, #ffffff, #fdfbf7); padding: 30px; font-family: 'Segoe UI', Tahoma, sans-serif; margin: 30px auto; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); max-width: 1200px; }
        .table { width: 100%; border-collapse: separate; border-spacing: 0; margin-top: 20px; border-radius: 8px; overflow: hidden; box-shadow: 0 5px 15px rgba(0,0,0,0.08); }
        .table th, .table td { padding: 15px; text-align: left; }
        .table th { background: linear-gradient(135deg, #3498db, #2980b9); color: #ffffff; font-weight: 600; text-transform: capitalize; font-size: 15px; border-bottom: none; }
        .table td { border-bottom: 1px solid #e9ecef; color: #444; font-size: 14px; background-color: #fff; }
        .table tr:last-child td { border-bottom: none; }
        .table tr:nth-child(even) td { background-color: #f8fbfe; }
        .table tr:hover td { background-color: #eaf2f8; transition: background-color 0.3s ease; }
        select { padding: 8px 12px; border-radius: 6px; border: 1px solid #bdc3c7; font-family: inherit; font-size: 14px; color: #34495e; background-color: #f9fbfd; transition: border-color 0.2s; }
        select:focus { border-color: #3498db; outline: none; box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25); }
        input[type="submit"], button, .btn { padding: 8px 18px; border: none; border-radius: 6px; cursor: pointer; background: linear-gradient(135deg, #e74c3c, #c0392b); color: #fff; font-weight: 600; transition: all 0.3s ease; font-size: 14px; box-shadow: 0 2px 5px rgba(231, 76, 60, 0.3); }
        input[type="submit"]:hover, button:hover, .btn:hover { background: linear-gradient(135deg, #c0392b, #a53125); transform: translateY(-2px); box-shadow: 0 4px 8px rgba(231, 76, 60, 0.4); }
        a { color: #2980b9; text-decoration: none; font-weight: 600; transition: color 0.2s; background-color: transparent; }
        a:hover { color: #1abc9c; text-decoration: underline; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper-container">
        <h2 class="page-title">Quản Lý Đơn Hàng</h2>
        <asp:Label ID="lblMessage" runat="server" Font-Bold="true" ForeColor="Red"></asp:Label>
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
                            <asp:ListItem Text="Đang xử lý" Value="Đang xử lý" />
                            <asp:ListItem Text="Đang giao" Value="Đang giao" />
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
