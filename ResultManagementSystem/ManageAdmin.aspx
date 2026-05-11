<%@ Page Title="Manage Admins" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageAdmin.aspx.cs" Inherits="ResultManagementSystem.ManageAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-4">
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-dark text-white">
                        <h5 class="mb-0">Add New Admin</h5>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <label class="form-label">Full Name</label>
                            <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="Enter Full Name"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Username</label>
                            <asp:TextBox ID="txtNewUser" runat="server" CssClass="form-control" placeholder="Choose Username"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Password</label>
                            <asp:TextBox ID="txtNewPass" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                        </div>
                        <asp:Button ID="btnAddAdmin" runat="server" Text="Add Admin" CssClass="btn btn-primary w-100" OnClick="btnAddAdmin_Click" />
                        <div class="mt-2 text-center">
                            <asp:Label ID="lblMsg" runat="server" CssClass="small fw-bold"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-8">
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-white">
                        <h5 class="mb-0">Existing Administrators</h5>
                    </div>
                    <div class="card-body p-0">
                        <asp:GridView ID="gvAdmins" runat="server" AutoGenerateColumns="False" 
                            CssClass="table table-hover mb-0" DataKeyNames="ID" OnRowDeleting="gvAdmins_RowDeleting">
                            <Columns>
                                <asp:BoundField DataField="FullName" HeaderText="Name" />
                                <asp:BoundField DataField="UserName" HeaderText="Username" />
                                <asp:TemplateField HeaderText="Actions" ItemStyle-Width="100px">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" 
                                            CssClass="text-danger" OnClientClick="return confirm('Delete this admin?');">
                                            <i class="bi bi-trash"></i> Delete
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataTemplate>
                                <div class="p-3 text-center text-muted">No other admins found.</div>
                            </EmptyDataTemplate>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
