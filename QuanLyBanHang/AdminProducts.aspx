<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminProducts.aspx.cs" Inherits="QuanLyBanHang.AdminProducts" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .product-table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        .product-table th, .product-table td { padding: 10px; border: 1px solid #ddd; text-align: left; }
        .product-table th { background-color: #f4f4f4; color: #333; }
        .form-control { padding: 8px; border: 1px solid #ccc; border-radius: 4px; width: 100%; box-sizing: border-box; margin-bottom: 10px; }
        .btn { padding: 8px 16px; border: none; border-radius: 4px; cursor: pointer; color: #fff; background-color: #007bff; margin-top: 10px; }
        .btn:hover { background-color: #0056b3; }
        .form-group { margin-bottom: 10px; }
        label { font-weight: bold; display: block; margin-bottom: 5px; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2 style="font-family:'Georgia',serif; font-size:28px; font-weight:600; color:#1A1208; border-bottom:2px solid #C9973A; padding-bottom:12px; margin-bottom:20px;">
        Quản lý Sản phẩm
    </h2>

    <asp:SqlDataSource ID="SqlDataSourceCategories" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        SelectCommand="SELECT [Id], [Name] FROM [Categories] ORDER BY [Name]">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceProducts" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        SelectCommand="SELECT p.[Id], p.[Name], p.[Price], p.[Image], p.[Description], p.[CategoryId], c.[Name] AS CategoryName FROM [Products] p LEFT JOIN [Categories] c ON p.[CategoryId] = c.[Id] ORDER BY p.[Id] DESC" 
        DeleteCommand="DELETE FROM [Products] WHERE [Id] = @Id" 
        InsertCommand="INSERT INTO [Products] ([Name], [Price], [Image], [Description], [CategoryId]) VALUES (@Name, @Price, @Image, @Description, @CategoryId)" 
        UpdateCommand="UPDATE [Products] SET [Name] = @Name, [Price] = @Price, [Image] = @Image, [Description] = @Description, [CategoryId] = @CategoryId WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Price" Type="Decimal" />
            <asp:Parameter Name="Image" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="CategoryId" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Price" Type="Decimal" />
            <asp:Parameter Name="Image" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="CategoryId" Type="Int32" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <div style="margin-bottom: 20px; background: #f9f9f9; padding: 15px; border-radius: 8px; border: 1px solid #ddd; max-width: 600px;">
        <h3 style="margin-bottom: 15px; font-size: 18px;">Thêm sản phẩm mới</h3>

        <div class="form-group">
            <label>Tên sản phẩm:</label>
            <asp:TextBox ID="txtProductName" runat="server" CssClass="form-control" Placeholder="Nhập tên sản phẩm"></asp:TextBox>
        </div>

        <div class="form-group">
            <label>Giá (VNĐ):</label>
            <asp:TextBox ID="txtProductPrice" runat="server" CssClass="form-control" TextMode="Number" Placeholder="Nhập giá bán"></asp:TextBox>
        </div>

        <div class="form-group">
            <label>Tên file ảnh (vd: product1.jpg):</label>
            <asp:TextBox ID="txtProductImage" runat="server" CssClass="form-control" Placeholder="Tên file ảnh"></asp:TextBox>
        </div>

        <div class="form-group">
            <label>Mô tả:</label>
            <asp:TextBox ID="txtProductDesc" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" Placeholder="Mô tả sản phẩm"></asp:TextBox>
        </div>

        <div class="form-group">
            <label>Danh mục:</label>
            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control" 
                DataSourceID="SqlDataSourceCategories" DataTextField="Name" DataValueField="Id">
            </asp:DropDownList>
        </div>

        <asp:Button ID="btnAddProduct" runat="server" Text="Thêm mới" CssClass="btn" OnClick="btnAddProduct_Click" />
        <br />
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red" style="display:block; margin-top:10px;"></asp:Label>
    </div>

    <asp:GridView ID="GridViewProducts" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" AllowSorting="true" AllowPaging="true"
        DataSourceID="SqlDataSourceProducts" CssClass="product-table" 
        EmptyDataText="Hiện chưa có sản phẩm nào.">
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="Mã" InsertVisible="False" ReadOnly="True" SortExpression="Id" ItemStyle-Width="50px" />
            <asp:BoundField DataField="Name" HeaderText="Tên SP" SortExpression="Name" />
            <asp:BoundField DataField="Price" HeaderText="Giá" SortExpression="Price" DataFormatString="{0:N0}" />
            <asp:BoundField DataField="Image" HeaderText="Ảnh" SortExpression="Image" />
            <asp:TemplateField HeaderText="Danh mục" SortExpression="CategoryName">
                <ItemTemplate>
                    <%# Eval("CategoryName") %>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlGridCategory" runat="server" 
                        DataSourceID="SqlDataSourceCategories" 
                        DataTextField="Name" 
                        DataValueField="Id" 
                        SelectedValue='<%# Bind("CategoryId") %>'>
                    </asp:DropDownList>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" HeaderText="Thao tác" ItemStyle-Width="150px" />
        </Columns>
    </asp:GridView>
</asp:Content>
