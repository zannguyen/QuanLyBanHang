<%@ Page Title="Quản Lý Mã Giảm Giá" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminVouchers.aspx.cs" Inherits="QuanLyBanHang.AdminVouchers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="utf-8" />
    <style>
        .page-title { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; color: #2c3e50; margin-bottom: 25px; padding-bottom: 15px; border-bottom: 3px solid #9b59b6; font-size: 28px; text-transform: uppercase; letter-spacing: 1px; text-align: center;}
        .wrapper-container { background: linear-gradient(to right bottom, #ffffff, #fdfbf7); padding: 30px; font-family: 'Segoe UI', Tahoma, sans-serif; margin: 30px auto; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); max-width: 1200px; }
        .card { background: linear-gradient(to right bottom, #ffffff, #f5f7fa); padding: 25px; border-radius: 10px; border: 1px solid #e1e8ed; margin-bottom: 35px; box-shadow: 0 8px 20px rgba(0,0,0,0.06); }
        .card h4 { margin-top: 0; margin-bottom: 20px; color: #8e44ad; font-size: 20px; font-weight: 600; border-bottom: 2px dashed #dcdde1; padding-bottom: 10px; }
        .form-control { width: 100%; padding: 12px 15px; margin-bottom: 20px; border: 1px solid #ced4da; border-radius: 6px; box-sizing: border-box; font-family: inherit; font-size: 15px; color: #2f3640; transition: border-color 0.3s, box-shadow 0.3s; background-color: #fafbfc; }
        .form-control:focus { border-color: #9b59b6; outline: none; box-shadow: 0 0 0 0.25rem rgba(155, 89, 182, 0.25); background-color: #fff; }
        .form-label { display: block; margin-bottom: 8px; font-weight: 600; color: #353b48; font-size: 14px; }
        .btn-primary { background: linear-gradient(135deg, #8e44ad, #9b59b6); color: #fff; padding: 12px 25px; border: none; border-radius: 6px; font-weight: 700; cursor: pointer; font-size: 15px; display: inline-block; transition: all 0.3s; text-transform: uppercase; letter-spacing: 1px; box-shadow: 0 4px 10px rgba(142, 68, 173, 0.3); }
        .btn-primary:hover { background: linear-gradient(135deg, #9b59b6, #8e44ad); transform: translateY(-2px); box-shadow: 0 6px 15px rgba(142, 68, 173, 0.4); }
        .table { width: 100%; border-collapse: separate; border-spacing: 0; margin-top: 20px; border-radius: 8px; overflow: hidden; box-shadow: 0 5px 15px rgba(0,0,0,0.08); }
        .table th, .table td { padding: 15px; text-align: left; }
        .table th { background: linear-gradient(135deg, #1abc9c, #16a085); color: #ffffff; font-weight: 600; text-transform: capitalize; font-size: 15px; border-bottom: none; }
        .table td { border-bottom: 1px solid #e9ecef; color: #333; font-size: 14px; background-color: #fff; }
        .table tr:last-child td { border-bottom: none; }
        .table tr:nth-child(even) td { background-color: #f4fcf9; }
        .table tr:hover td { background-color: #e8f8f5; transition: background-color 0.3s ease; }
        a { color: #f39c12; text-decoration: none; font-weight: 700; margin-right: 12px; transition: color 0.3s; }
        a:hover { color: #d35400; text-decoration: underline; }
        input[type="submit"]:not(.btn-primary) { padding: 6px 15px; border: none; border-radius: 6px; cursor: pointer; background: linear-gradient(135deg, #f39c12, #e67e22); color: #fff; font-weight: 600; transition: all 0.3s; font-size: 13px; box-shadow: 0 2px 5px rgba(243, 156, 18, 0.3); }
        input[type="submit"]:not(.btn-primary):hover { background: linear-gradient(135deg, #e67e22, #d35400); transform: translateY(-1px); box-shadow: 0 4px 8px rgba(243, 156, 18, 0.4); }
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
