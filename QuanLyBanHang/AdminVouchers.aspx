<%@ Page Title="Quản Lý Mã Giảm Giá" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminVouchers.aspx.cs" Inherits="QuanLyBanHang.AdminVouchers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="utf-8" />
    <style>
        .page-title { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; color: #1A1208; margin-bottom: 25px; padding-bottom: 15px; border-bottom: 3px solid #C9973A; font-size: 28px; text-transform: uppercase; letter-spacing: 1px; }
        .wrapper-container { background: #ffffff; padding: 30px; font-family: 'Segoe UI', Tahoma, sans-serif; margin: 30px auto; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); max-width: 1200px; }
        .card { background: #ffffff; padding: 25px; border-radius: 10px; border: 1px solid #eef2f5; margin-bottom: 35px; box-shadow: 0 2px 10px rgba(0,0,0,0.03); }
        .card h4 { margin-top: 0; margin-bottom: 20px; color: #1A1208; font-size: 20px; font-weight: 600; border-bottom: 2px solid #f0f0f0; padding-bottom: 10px; }
        .form-control { width: 100%; padding: 12px 15px; margin-bottom: 20px; border: 1px solid #ced4da; border-radius: 6px; box-sizing: border-box; font-family: inherit; font-size: 15px; color: #495057; transition: border-color 0.2s; }
        .form-control:focus { border-color: #C9973A; outline: none; box-shadow: 0 0 0 0.2rem rgba(201, 151, 58, 0.25); }
        .form-label { display: block; margin-bottom: 8px; font-weight: 600; color: #495057; font-size: 14px; }
        .btn-primary { background: #C9973A; color: #fff; padding: 12px 25px; border: none; border-radius: 6px; font-weight: 600; cursor: pointer; font-size: 15px; display: inline-block; transition: all 0.2s; text-transform: uppercase; letter-spacing: 0.5px; }
        .btn-primary:hover { background: #a87e31; transform: translateY(-1px); box-shadow: 0 4px 8px rgba(0,0,0,0.15); }
        .table { width: 100%; border-collapse: separate; border-spacing: 0; margin-top: 20px; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 8px rgba(0,0,0,0.05); }
        .table th, .table td { padding: 15px; text-align: left; }
        .table th { background-color: #f8f9fa; color: #495057; font-weight: 600; text-transform: capitalize; font-size: 15px; border-bottom: 2px solid #e9ecef; }
        .table td { border-bottom: 1px solid #e9ecef; color: #333; font-size: 14px; }
        .table tr:last-child td { border-bottom: none; }
        .table tr:hover { background-color: #fdfbf7; transition: background-color 0.2s; }
        a { color: #C9973A; text-decoration: none; font-weight: 600; margin-right: 12px; transition: color 0.2s; }
        a:hover { color: #a87e31; text-decoration: underline; }
        input[type="submit"]:not(.btn-primary) { padding: 6px 12px; border: none; border-radius: 4px; cursor: pointer; background: #C9973A; color: #fff; font-weight: 600; transition: all 0.2s; font-size: 13px; }
        input[type="submit"]:not(.btn-primary):hover { background: #a87e31; }
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
