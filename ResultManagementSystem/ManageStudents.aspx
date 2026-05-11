<%@ Page Title="Manage Students" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageStudents.aspx.cs" Inherits="ResultManagementSystem.ManageStudents" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-4">
                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-header bg-white py-3">
                        <h6 class="m-0 fw-bold text-primary"><i class="bi bi-person-plus me-2"></i>Register Student</h6>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <label class="form-label">Student ID</label>
                            <asp:TextBox ID="txtID" runat="server" CssClass="form-control" placeholder="e.g. 2026001"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Full Name</label>
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter name"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Running Year</label>
                            <asp:DropDownList ID="ddlYear" runat="server" CssClass="form-select">
                                <asp:ListItem Value="0">Select Year</asp:ListItem>
                                <asp:ListItem Value="1">1st Year</asp:ListItem>
                                <asp:ListItem Value="2">2nd Year</asp:ListItem>
                                <asp:ListItem Value="3">3rd Year</asp:ListItem>
                                <asp:ListItem Value="4">4th Year</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Running Semester</label>
                            <asp:DropDownList ID="ddlSemester" runat="server" CssClass="form-select">
                                <asp:ListItem Value="0">Select Semester</asp:ListItem>
                                <asp:ListItem Value="1">1st Semester</asp:ListItem>
                                <asp:ListItem Value="2">2nd Semester</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <asp:Button ID="btnSave" runat="server" Text="Create Student" CssClass="btn btn-primary w-100 py-2" OnClick="btnSave_Click" />
                        <div class="mt-2 text-center">
                            <asp:Label ID="lblMsg" runat="server" CssClass="small"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-8">
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                        <h6 class="m-0 fw-bold text-dark"><i class="bi bi-people me-2"></i>Student List</h6>
                    </div>
                    <div class="card-body">
                        <asp:GridView ID="gvStudents" runat="server" AutoGenerateColumns="False" 
                            CssClass="table table-hover align-middle border-0" GridLines="None">
                            <Columns>
                                <asp:BoundField DataField="StudentID" HeaderText="Student ID" ItemStyle-CssClass="fw-bold text-secondary" />
                                <asp:BoundField DataField="StudentName" HeaderText="Name" />
                                <asp:TemplateField HeaderText="Current Status">
                                    <ItemTemplate>
                                        <span class="badge bg-light text-dark border">
                                            Year: <%# Eval("RunningYear") %> | Sem: <%# Eval("RunningSemester") %>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Action">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnEdit" runat="server" CssClass="text-primary me-2"><i class="bi bi-pencil"></i></asp:LinkButton>
                                        <asp:LinkButton ID="btnDel" runat="server" CssClass="text-danger"><i class="bi bi-trash"></i></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="bg-light" />
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>