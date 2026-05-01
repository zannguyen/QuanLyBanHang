<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminCategories.aspx.cs" Inherits="QuanLyBanHang.AdminCategories" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .category-table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        .category-table th, .category-table td { padding: 10px; border: 1px solid #ddd; text-align: left; }
        .category-table th { background-color: #f4f4f4; color: #333; }
        .form-control { padding: 8px; border: 1px solid #ccc; border-radius: 4px; width: 300px; }
        .btn { padding: 8px 16px; border: none; border-radius: 4px; cursor: pointer; color: #fff; background-color: #007bff; }
        .btn:hover { background-color: #0056b3; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2 style="font-family:'Georgia',serif; font-size:28px; font-weight:600; color:#1A1208; border-bottom:2px solid #C9973A; padding-bottom:12px; margin-bottom:20px;">
        Quản lý Danh mục
    </h2>

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

    <div style="margin-bottom: 20px; background: #f9f9f9; padding: 15px; border-radius: 8px; border: 1px solid #ddd;">
        <h3 style="margin-bottom: 10px; font-size: 18px;">Thêm danh mục mới</h3>
        <asp:TextBox ID="txtNewCategoryName" runat="server" CssClass="form-control" Placeholder="Nhập tên danh mục mới..."></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="btnAddCategory" runat="server" Text="Thêm mới" CssClass="btn" OnClick="btnAddCategory_Click" />
        <br />
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red" style="display:block; margin-top:10px;"></asp:Label>
    </div>

    <asp:GridView ID="GridViewCategories" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" AllowSorting="true" AllowPaging="true"
        DataSourceID="SqlDataSourceCategories" CssClass="category-table" 
        EmptyDataText="Hiện chưa có danh mục nào.">
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="Mã DM" InsertVisible="False" ReadOnly="True" SortExpression="Id" ItemStyle-Width="100px" />
            <asp:BoundField DataField="Name" HeaderText="Tên danh mục" SortExpression="Name" />
            <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" HeaderText="Thao tác" ItemStyle-Width="150px" />
        </Columns>
    </asp:GridView>
</asp:Content>
