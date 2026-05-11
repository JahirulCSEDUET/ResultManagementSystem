<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="ResultManagementSystem.Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3 class="fw-bold text-dark">Dashboard Overview</h3>
        <span class="text-muted">Welcome back, <strong><%= Session["UserName"] %></strong></span>
    </div>

    <div class="row g-4">
        <div class="col-md-4">
            <div class="card border-0 shadow-sm p-3 border-start border-primary border-4">
                <div class="d-flex align-items-center">
                    <div class="flex-shrink-0 bg-primary bg-opacity-10 p-3 rounded">
                        <i class="bi bi-book text-primary fs-3"></i>
                    </div>
                    <div class="flex-grow-1 ms-3">
                        <h6 class="text-muted mb-0">Total Courses</h6>
                        <h3 class="fw-bold mb-0">
                            <asp:Literal ID="litTotalCourses" runat="server">0</asp:Literal>
                        </h3>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card border-0 shadow-sm p-3 border-start border-info border-4">
                <div class="d-flex align-items-center">
                    <div class="flex-shrink-0 bg-info bg-opacity-10 p-3 rounded">
                        <i class="bi bi-people text-info fs-3"></i>
                    </div>
                    <div class="flex-grow-1 ms-3">
                        <h6 class="text-muted mb-0">Total Students</h6>
                        <h3 class="fw-bold mb-0">
                            <asp:Literal ID="litTotalStudents" runat="server">0</asp:Literal>
                        </h3>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card border-0 shadow-sm p-3 border-start border-success border-4">
                <div class="d-flex align-items-center">
                    <div class="flex-shrink-0 bg-success bg-opacity-10 p-3 rounded">
                        <i class="bi bi-check-circle text-success fs-3"></i>
                    </div>
                    <div class="flex-grow-1 ms-3">
                        <h6 class="text-muted mb-0">Results Entries</h6>
                        <h3 class="fw-bold mb-0">
                            <asp:Literal ID="litTotalResults" runat="server">0</asp:Literal>
                        </h3>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="alert alert-light mt-5 border-0 shadow-sm">
        <i class="bi bi-info-circle me-2"></i> 
        Use the sidebar on the left to add courses, manage students, or publish new examination results.
    </div>
</asp:Content>