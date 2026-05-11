<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ResultManagementSystem.Default" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Public Result Portal | DUET</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" />
    <style>
        body { background-color: #f1f5f9; padding: 40px 0; }
        .card { border: none; border-radius: 15px; }
        .search-header { background: linear-gradient(135deg, #1e293b 0%, #334155 100%); color: white; border-radius: 15px 15px 0 0 !important; }
        
        /* Marksheet Styling */
        .transcript-container { background: white; padding: 50px; max-width: 850px; margin: auto; border: 1px solid #e2e8f0; }
        .school-logo-area { text-align: center; border-bottom: 2px solid #1e293b; margin-bottom: 30px; }
        
        @media print {
            .no-print { display: none; }
            body { background: white; padding: 0; }
            .transcript-container { border: none; box-shadow: none; width: 100%; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <asp:MultiView ID="mvPublic" runat="server" ActiveViewIndex="0">
                
                <asp:View ID="vwSearch" runat="server">
                    <div class="row justify-content-center">
                        <div class="col-md-6">
                            <div class="card shadow-lg">
                                <div class="card-header search-header py-3 text-center">
                                    <h4 class="mb-0"><i class="bi bi-search me-2"></i>Find Your Result</h4>
                                </div>
                                <div class="card-body p-4">
                                    <div class="mb-3">
                                        <label class="form-label fw-bold">Student ID</label>
                                        <asp:TextBox ID="txtSearchID" runat="server" CssClass="form-control" placeholder="Enter ID (e.g. 202601)"></asp:TextBox>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-6">
                                            <label class="form-label fw-bold">Academic Year</label>
                                            <asp:DropDownList ID="ddlYear" runat="server" CssClass="form-select">
                                                <asp:ListItem Value="1">1st year</asp:ListItem>
                                                <asp:ListItem Value="2">2nd year</asp:ListItem>
                                                <asp:ListItem Value="3">3rd year</asp:ListItem>
                                                <asp:ListItem Value="4">4th year</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-6">
                                            <label class="form-label fw-bold">Semester</label>
                                            <asp:DropDownList ID="ddlSem" runat="server" CssClass="form-select">
                                                <asp:ListItem Value="1">1st Semester</asp:ListItem>
                                                <asp:ListItem Value="2">2nd Semester</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <asp:Button ID="btnSearch" runat="server" Text="Search Result" CssClass="btn btn-primary w-100 py-2 shadow-sm" OnClick="btnSearch_Click" />
                                    <div class="mt-3 text-center">
                                        <asp:Label ID="lblError" runat="server" CssClass="text-danger small fw-bold"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </asp:View>

                <asp:View ID="vwResult" runat="server">
                    <div class="transcript-container shadow-lg rounded">
                        <div class="school-logo-area">
                            <h6 class="fw-bold mb-1">DHAKA UNIVERSITY OF ENGINEERING & TECHNOLOGY, GAZIPUR</h6>
                            <p class="mb-1">Department of Computer Science and Engineering</p>
                            <p class="text-uppercase tracking-widest small">Gazipur, Bangladesh</p>
                            <h5 class="my-3 text-decoration-underline">ACADEMIC TRANSCRIPT</h5>
                        </div>

                        <div class="row mb-4">
                            <div class="col-7">
                                <p class="mb-1"><strong>Name:</strong> <asp:Literal ID="litName" runat="server"></asp:Literal></p>
                                <p class="mb-1"><strong>Student ID:</strong> <asp:Literal ID="litID" runat="server"></asp:Literal></p>
                            </div>
                            <div class="col-5 text-end">
                                <p class="mb-1"><asp:Literal ID="litYear" runat="server"></asp:Literal>/<asp:Literal ID="litSem" runat="server"></asp:Literal></p>
                            </div>
                        </div>

                        <asp:GridView ID="gvPublicResult" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered border-dark text-center">
                            <HeaderStyle CssClass="table-dark" />
                            <Columns>
                                <asp:BoundField DataField="CourseName" HeaderText="Course Title" ItemStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="MarksObtained" HeaderText="Marks" />
                                <asp:TemplateField HeaderText="Grade">
                                    <ItemTemplate>
                                        <span class="fw-bold"><%# GetGrade(Convert.ToInt32(Eval("MarksObtained"))) %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>

                        <div class="mt-4 d-flex justify-content-between align-items-center">
                            <h5>Result Status: <asp:Label ID="lblStatus" runat="server" CssClass="badge"></asp:Label></h5>
                            <p class="mb-0 fw-bold">Total Marks: <asp:Literal ID="litTotal" runat="server"></asp:Literal></p>
                        </div>
                        
                        <div class="text-center mt-5 pt-5 no-print">
                            <button type="button" class="btn btn-dark px-4" onclick="window.print()"><i class="bi bi-printer me-2"></i>Print Transcript</button>
                            <asp:Button ID="btnBack" runat="server" Text="New Search" CssClass="btn btn-outline-secondary px-4 ms-2" OnClick="btnBack_Click" />
                        </div>
                    </div>
                </asp:View>

            </asp:MultiView>
        </div>
    </form>
</body>
</html>