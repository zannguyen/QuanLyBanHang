<%@ Page Title="Quản Lý Mã Giảm Giá" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminVouchers.aspx.cs" Inherits="QuanLyBanHang.AdminVouchers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="utf-8" />
    <style>
        .page-title { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; color: #1A1208; margin-bottom: 20px; padding-bottom: 10px; border-bottom: 2px solid #C9973A; }
        .wrapper-container { background: #fff; padding: 20px; font-family: 'Segoe UI', Tahoma, sans-serif; margin: 20px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .card { background: #fafafa; padding: 20px; border-radius: 8px; border: 1px solid #eaeaea; margin-bottom: 30px; }
        .card h4 { margin-top: 0; margin-bottom: 15px; color: #333; }
        .form-control { width: 100%; padding: 10px 12px; margin-bottom: 15px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; font-family: inherit; font-size: 14px; }
        .form-label { display: block; margin-bottom: 5px; font-weight: bold; color: #555; }
        .btn-primary { background: #C9973A; color: #fff; padding: 10px 20px; border: none; border-radius: 4px; font-weight: bold; cursor: pointer; font-size: 15px; display: inline-block; }
        .btn-primary:hover { background: #b58530; }
        .table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        .table th, .table td { padding: 12px; border: 1px solid #e0e0e0; text-align: left; }
        .table th { background-color: #f4f4f4; color: #333; font-weight: bold; font-size: 14px; }
        .table tr:hover { background-color: #f9f9f9; }
        a { color: #C9973A; text-decoration: none; font-weight: bold; margin-right: 10px; }
        a:hover { text-decoration: underline; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper-container">
        <h2 class="page-title">Quản Lý Mã Giảm Giá (Vouchers)</h2>
        <div class="card">
            <h4>Thêm Voucher Mới</h4>
            <span class="form-label">Tên Mã (Code):</span>
            <asp:TextBox ID="txtCode" runat="server" CssClass="form-control"></asp:TextBox>

            <span class="form-label">Giảm giá (%):</span>
            <asp:TextBox ID="txtDiscountPercent" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>

            <span class="form-label">Giảm tối đa (VNĐ):</span>
            <asp:TextBox ID="txtMaxDiscount" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>

            <span class="form-label">Ngày hết hạn:</span>
            <asp:TextBox ID="txtExpiryDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>

            <span class="form-label">Số lượng:</span>
            <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control"></asp:TextBox>

            <asp:Button ID="btnAdd" runat="server" Text="Thêm Voucher" CssClass="btn-primary" OnClick="btnAdd_Click" />
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red" CssClass="mt-2" style="display:block; margin-top:10px; font-weight:bold;"></asp:Label>
        </div>

        <asp:GridView ID="gvVouchers" runat="server" AutoGenerateColumns="False" DataKeyNames="Id"
            OnRowEditing="gvVouchers_RowEditing" OnRowUpdating="gvVouchers_RowUpdating" 
            OnRowCancelingEdit="gvVouchers_RowCancelingEdit" OnRowDeleting="gvVouchers_RowDeleting"
            CssClass="table table-bordered">
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="ID" ReadOnly="True" />
                <asp:BoundField DataField="Code" HeaderText="Mã" />
                <asp:BoundField DataField="DiscountPercent" HeaderText="Giảm %" />
                <asp:BoundField DataField="MaxDiscount" HeaderText="Giảm Max" />
                <asp:TemplateField HeaderText="Ngày hết hạn">
                    <ItemTemplate>
                        <asp:Label ID="lblDate" runat="server" Text='<%# Eval("ExpiryDate", "{0:dd/MM/yyyy}") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtEditDate" runat="server" TextMode="Date" Text='<%# Eval("ExpiryDate", "{0:yyyy-MM-dd}") %>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Quantity" HeaderText="Số lượng" />
                <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" CancelText="Hủy" EditText="Sửa" UpdateText="Lưu" DeleteText="Xóa" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
