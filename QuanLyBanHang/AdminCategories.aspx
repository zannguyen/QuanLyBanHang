<%@ Page Title="Quản Lý Danh Mục" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminCategories.aspx.cs" Inherits="QuanLyBanHang.AdminCategories" %>
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
        input[type="text"], .form-control { padding: 8px 12px; border-radius: 6px; border: 1px solid #bdc3c7; font-family: inherit; font-size: 14px; color: #34495e; background-color: #f9fbfd; transition: border-color 0.2s; box-sizing: border-box;}
        input[type="text"]:focus, .form-control:focus { border-color: #3498db; outline: none; box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25); }
        input[type="submit"], button, .btn { padding: 8px 18px; border: none; border-radius: 6px; cursor: pointer; background: linear-gradient(135deg, #e74c3c, #c0392b); color: #fff; font-weight: 600; transition: all 0.3s ease; font-size: 14px; box-shadow: 0 2px 5px rgba(231, 76, 60, 0.3); }
        input[type="submit"]:hover, button:hover, .btn:hover { background: linear-gradient(135deg, #c0392b, #a53125); transform: translateY(-2px); box-shadow: 0 4px 8px rgba(231, 76, 60, 0.4); }
        a { color: #2980b9; text-decoration: none; font-weight: 600; transition: color 0.2s; background-color: transparent; }
        a:hover { color: #1abc9c; text-decoration: underline; }
        .form-container { background: #f8fbfe; padding: 20px; border-radius: 8px; border: 1px solid #e9ecef; margin-bottom: 25px; box-shadow: 0 2px 8px rgba(0,0,0,0.05); }
        .section-title { margin-bottom: 15px; font-size: 20px; color: #2980b9; font-weight: 600; border-bottom: 2px solid #3498db; display: inline-block; padding-bottom: 5px;}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper-container">
        <h2 class="page-title">Quản Lý Danh Mục</h2>

        <asp:SqlDataSource ID="SqlDataSourceCategories" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            SelectCommand="SELECT * FROM [Categories] ORDER BY [Id] DESC" 
            DeleteCommand="DELETE FROM [Categories] WHERE [Id] = @Id" 
            InsertCommand="INSERT INTO [Categories] ([Name]) VALUES (@Name)" 
            UpdateCommand="UPDATE [Categories] SET [Name] = @Name WHERE [Id] = @Id">
            <DeleteParameters>
                <asp:Parameter Name="Id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Name" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="Name" Type="String" />
                <asp:Parameter Name="Id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <div class="form-container">
            <h3 class="section-title">Thêm danh mục mới</h3>
            <div style="display: flex; gap: 10px; align-items: center; margin-top: 10px;">
                <asp:TextBox ID="txtNewCategoryName" runat="server" CssClass="form-control" style="width: 300px;" Placeholder="Nhập tên danh mục mới..."></asp:TextBox>
                <asp:Button ID="btnAddCategory" runat="server" Text="Thêm mới" CssClass="btn" OnClick="btnAddCategory_Click" />
            </div>
            <asp:Label ID="lblMessage" runat="server" ForeColor="#e74c3c" style="display:block; margin-top:10px; font-weight: 600;"></asp:Label>
        </div>

        <asp:GridView ID="GridViewCategories" runat="server" AutoGenerateColumns="False" DataKeyNames="Id"
            CssClass="table" OnRowDeleting="GridViewCategories_RowDeleting" AllowSorting="true" OnSorting="GridViewCategories_Sorting"
            EmptyDataText="Hiện chưa có danh mục nào.">
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="Mã DM" InsertVisible="False" ReadOnly="True" SortExpression="Id" ItemStyle-Width="100px" />
                <asp:BoundField DataField="Name" HeaderText="Tên danh mục" SortExpression="Name" />
                <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" CancelText="Hủy" EditText="Sửa" UpdateText="Lưu" DeleteText="Xóa" HeaderText="Thao tác" ItemStyle-Width="150px" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
