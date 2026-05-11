<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageResults.aspx.cs" Inherits="ResultManagementSystem.ManageResults" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3>Result Management</h3>
            <asp:Button ID="btnToggleAdd" runat="server" Text="Add New Result" CssClass="btn btn-primary" OnClick="btnToggleAdd_Click" />
        </div>

        <asp:GridView ID="gvAllResults" runat="server" AutoGenerateColumns="False" CssClass="table table-hover shadow-sm">
            <Columns>
                <asp:BoundField DataField="StudentID" HeaderText="ID" />
                <asp:BoundField DataField="StudentName" HeaderText="Student Name" />
                <asp:BoundField DataField="TotalSubjects" HeaderText="Subjects" ItemStyle-HorizontalAlign="Center" />

                <asp:TemplateField HeaderText="Total Marks">
                    <ItemTemplate>
                        <span class="fw-bold text-primary"><%# Eval("AggregateMarks") %></span>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <a href='Result.aspx?sid=<%# Eval("StudentID") %>' class="btn btn-sm btn-outline-info">
                            <i class="bi bi-eye"></i>View Detail
                        </a>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <asp:Panel ID="pnlAddResult" runat="server" Visible="false">
            <div class="card shadow-sm border-0">
                <div class="card-body">

                    <asp:PlaceHolder ID="phPart1" runat="server">
                        <h5>Step 1: Verify Student</h5>
                        <div class="input-group mb-3 w-50">
                            <asp:TextBox ID="txtSearchSID" runat="server" CssClass="form-control" placeholder="Enter Student ID"></asp:TextBox>
                            <asp:Button ID="btnVerify" runat="server" Text="Next" CssClass="btn btn-dark" OnClick="btnVerify_Click" />
                        </div>
                        <asp:Label ID="lblPart1Msg" runat="server" CssClass="text-danger"></asp:Label>
                        <asp:HyperLink ID="lnkAddNewStudent" runat="server" NavigateUrl="ManageStudents.aspx" Visible="false" CssClass="btn btn-link">Add New Student</asp:HyperLink>
                    </asp:PlaceHolder>

                    <asp:PlaceHolder ID="phPart2" runat="server" Visible="false">
                        <h5>Step 2: Marks Entry</h5>
                        <div class="alert alert-info py-2">
                            Student: <strong>
                                <asp:Literal ID="litStudentName" runat="server"></asp:Literal></strong> (<asp:Literal ID="litStudentID" runat="server"></asp:Literal>)
                        </div>

                        <div class="row g-3 border-bottom pb-4 mb-4">
                            <div class="col-md-5">
                                <label class="form-label">Select Course</label>
                                <asp:DropDownList ID="ddlCourses" runat="server" CssClass="form-select"></asp:DropDownList>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Marks</label>
                                <asp:TextBox ID="txtNewMarks" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                            </div>
                            <div class="col-md-3 d-flex align-items-end">
                                <asp:Button ID="btnAddToList" runat="server" Text="Add to List" CssClass="btn btn-outline-success w-100" OnClick="btnAddToList_Click" />
                            </div>
                        </div>

                        <asp:GridView ID="gvTempResults" runat="server" CssClass="table table-sm text-center" AutoGenerateColumns="true"></asp:GridView>

                        <div class="mt-4">
                            <asp:Button ID="btnSaveFinal" runat="server" Text="Save All Results to Database" CssClass="btn btn-success" OnClick="btnSaveFinal_Click" Visible="false" />
                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-light" OnClick="btnCancel_Click" />
                        </div>
                    </asp:PlaceHolder>
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>

