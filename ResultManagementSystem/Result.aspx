<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Result.aspx.cs" Inherits="ResultManagementSystem.Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .marksheet-container {
            background: #fff;
            padding: 40px;
            border: 1px solid #dee2e6;
            box-shadow: 0 0 20px rgba(0,0,0,0.05);
            max-width: 850px;
            margin: 20px auto;
        }
        .school-header { text-align: center; margin-bottom: 25px; border-bottom: 3px double #333; padding-bottom: 10px; }
        .student-info p { margin-bottom: 5px; font-size: 0.95rem; }
        .student-info label { font-weight: bold; width: 140px; color: #495057; }
        
        @media print {
            .no-print, #sidebar, .top-navbar { display: none !important; }
            .marksheet-container { box-shadow: none; border: none; width: 100%; max-width: 100%; margin: 0; }
            body { background: white; }
        }
    </style>

    <div class="container mb-5">
        <div class="marksheet-container">
            <div class="school-header">
                <h5 class="fw-bold">Dhaka University of Engineering & Technology, Gazipur</h5>
                <p class="mb-1 text-muted">Department of Computer Science and Engineering</p>
                <h5 class="text-uppercase mt-3 text-decoration-underline fw-bold">Grade Sheet</h5>
            </div>

            <div class="row student-info mt-4">
                <div class="col-7">
                    <p><label>Student Name:</label> <asp:Literal ID="litStudentName" runat="server" /></p>
                    <p><label>Student ID:</label> <asp:Literal ID="litRollNo" runat="server" /></p>
                </div>
                <div class="col-5 text-end">
                    <p class="fw-bold text-primary">
                        <asp:Literal ID="litSemester" runat="server" /> / <asp:Literal ID="litYear" runat="server" />
                    </p>
                </div>
            </div>

            <div class="mt-4">
                <asp:GridView ID="gvResults" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered text-center">
                    <HeaderStyle CssClass="table-dark" />
                    <Columns>
                        <asp:BoundField DataField="CourseCode" HeaderText="Course Code" />
                        <asp:BoundField DataField="CourseName" HeaderText="Course Title" ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="MarksObtained" HeaderText="Marks" />
                        <asp:TemplateField HeaderText="Grade">
                            <ItemTemplate>
                                <span class="fw-bold"><%# CalculateGrade(Convert.ToInt32(Eval("MarksObtained"))) %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>

            <div class="row mt-4">
                <div class="col-6">
                    <p><strong>Result Status: </strong>  
                        <asp:Label ID="lblStatus" runat="server" CssClass="badge p-2"></asp:Label>
                    </p>
                </div>
                <div class="col-6 text-end">
                    <p><strong>Total Marks: </strong> <asp:Literal ID="litTotalMarks" runat="server" /></p>
                    <p><strong>Percentage: </strong> <asp:Literal ID="litPercentage" runat="server" />%</p>
                </div>
            </div>

            <div class="row mt-5 pt-4 text-center">
                <div class="col-4"><div style="border-top: 1px solid #000; padding-top: 5px;">Prepared By</div></div>
                <div class="col-4"></div>
                <div class="col-4"><div style="border-top: 1px solid #000; padding-top: 5px;">Controller of Exams</div></div>
            </div>
        </div>

        <div class="text-center mt-4 no-print">
            <button type="button" class="btn btn-dark px-4" onclick="window.print();">
                <i class="bi bi-printer"></i> Print Transcript
            </button>
            <a href="ManageResults.aspx" class="btn btn-outline-secondary px-4">Back to Dashboard</a>
        </div>
    </div>
</asp:Content>