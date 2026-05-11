<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageCourses.aspx.cs" Inherits="ResultManagementSystem.ManageCourses" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="card p-4 mb-4 shadow-sm">
            <h3>Add New Course</h3>
            <div class="row g-3 mt-2">
                <div class="col-md-4">
                    <asp:TextBox ID="txtCourseCode" runat="server" CssClass="form-control" placeholder="Code (e.g. CSE-101)"></asp:TextBox>
                </div>
                <div class="col-md-5">
                    <asp:TextBox ID="txtCourseName" runat="server" CssClass="form-control" placeholder="Course Name"></asp:TextBox>
                </div>
                <div class="col-md-3">
                    <asp:Button ID="btnAddCourse" runat="server" Text="Save Course" CssClass="btn btn-primary w-100" OnClick="btnAddCourse_Click" />
                </div>
            </div>
        </div>

        <div class="card p-4 shadow-sm">
            <h3>Course List</h3>
            <asp:GridView ID="gvCourses" runat="server" AutoGenerateColumns="False" DataKeyNames="CourseID"
                CssClass="table table-bordered table-striped mt-3" OnRowDeleting="gvCourses_RowDeleting">
                <Columns>
                    <asp:BoundField DataField="CourseCode" HeaderText="Course Code" />
                    <asp:BoundField DataField="CourseName" HeaderText="Course Name" />
                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <asp:Button ID="btnDelete" runat="server" CommandName="Delete" Text="Delete" CssClass="btn btn-danger btn-sm" OnClientClick="return confirm('Delete this course?');" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
