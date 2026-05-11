<%@ Page Title="Quản Lý Sản Phẩm" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminProducts.aspx.cs" Inherits="QuanLyBanHang.AdminProducts" %>
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
        input[type="text"], input[type="number"], textarea, select, .form-control { padding: 8px 12px; border-radius: 6px; border: 1px solid #bdc3c7; font-family: inherit; font-size: 14px; color: #34495e; background-color: #f9fbfd; transition: border-color 0.2s; width: 100%; box-sizing: border-box; }
        input[type="text"]:focus, input[type="number"]:focus, textarea:focus, select:focus, .form-control:focus { border-color: #3498db; outline: none; box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25); }
        .form-group { margin-bottom: 15px; }
        label { font-weight: 600; display: block; margin-bottom: 5px; color: #2c3e50; }
        input[type="submit"], button, .btn { padding: 8px 18px; border: none; border-radius: 6px; cursor: pointer; background: linear-gradient(135deg, #e74c3c, #c0392b); color: #fff; font-weight: 600; transition: all 0.3s ease; font-size: 14px; box-shadow: 0 2px 5px rgba(231, 76, 60, 0.3); margin-top: 10px; }
        input[type="submit"]:hover, button:hover, .btn:hover { background: linear-gradient(135deg, #c0392b, #a53125); transform: translateY(-2px); box-shadow: 0 4px 8px rgba(231, 76, 60, 0.4); }
        a { color: #2980b9; text-decoration: none; font-weight: 600; transition: color 0.2s; background-color: transparent; }
        a:hover { color: #1abc9c; text-decoration: underline; }
        .form-container { background: #f8fbfe; padding: 20px; border-radius: 8px; border: 1px solid #e9ecef; margin-bottom: 25px; box-shadow: 0 2px 8px rgba(0,0,0,0.05); max-width: 600px; }
        .section-title { margin-bottom: 15px; font-size: 20px; color: #2980b9; font-weight: 600; border-bottom: 2px solid #3498db; display: inline-block; padding-bottom: 5px;}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper-container">
        <h2 class="page-title">Quản Lý Sản Phẩm</h2>

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

        <div class="form-container">
            <h3 class="section-title">Thêm sản phẩm mới</h3>

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
                    DataTextField="Name" DataValueField="Id">
                </asp:DropDownList>
            </div>

            <asp:Button ID="btnAddProduct" runat="server" Text="Thêm mới" CssClass="btn" OnClick="btnAddProduct_Click" />
            <asp:Label ID="lblMessage" runat="server" ForeColor="#e74c3c" style="display:block; margin-top:10px; font-weight:600;"></asp:Label>
        </div>

        <asp:GridView ID="GridViewProducts" runat="server" AutoGenerateColumns="False" DataKeyNames="Id"
            CssClass="table" OnRowDeleting="GridViewProducts_RowDeleting" OnRowDataBound="GridViewProducts_RowDataBound" AllowSorting="true" OnSorting="GridViewProducts_Sorting"
            EmptyDataText="Hiện chưa có sản phẩm nào.">
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="Mã" InsertVisible="False" ReadOnly="True" SortExpression="Id" ItemStyle-Width="50px" />
                <asp:BoundField DataField="Name" HeaderText="Tên SP" SortExpression="Name" />
                <asp:BoundField DataField="Price" HeaderText="Giá" SortExpression="Price" DataFormatString="{0:N0}" />
                <asp:TemplateField HeaderText="Ảnh" SortExpression="Image">
                    <ItemTemplate>
                        <asp:Image ID="imgThumbnail" runat="server" 
                            ImageUrl='<%# "~/Images/" + (Eval("Image") != DBNull.Value ? Eval("Image") : "no-image.png") %>' 
                            Width="50px" Height="50px" style="object-fit: contain; border-radius: 4px;" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtGridImage" runat="server" CssClass="form-control" Text='<%# Bind("Image") %>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Danh mục" SortExpression="CategoryName">
                    <ItemTemplate>
                        <%# Eval("CategoryName") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList ID="ddlGridCategory" runat="server"
                            DataTextField="Name"
                            DataValueField="Id"
                            SelectedValue='<%# Bind("CategoryId") %>'>
                        </asp:DropDownList>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" CancelText="Hủy" EditText="Sửa" UpdateText="Lưu" DeleteText="Xóa" HeaderText="Thao tác" ItemStyle-Width="150px" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
