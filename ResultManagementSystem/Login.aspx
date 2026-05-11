<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ResultManagementSystem.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login | Result Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background: #f4f7f6;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .login-card {
            background: #ffffff;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            overflow: hidden;
            display: flex;
            max-width: 900px;
            width: 100%;
        }
        .login-branding {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px;
            width: 40%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            text-align: center;
        }
        .login-form-area {
            padding: 50px;
            width: 60%;
        }
        .btn-login {
            background: #764ba2;
            border: none;
            color: white;
            padding: 10px 20px;
            width: 100%;
            border-radius: 5px;
            transition: 0.3s;
        }
        .btn-login:hover {
            background: #5a3782;
            color: white;
        }
        .error-text { font-size: 0.85rem; color: #dc3545; margin-bottom: 10px; display: block; }
        
        /* Mobile Responsiveness */
        @media (max-width: 768px) {
            .login-card { flex-direction: column; margin: 20px; }
            .login-branding, .login-form-area { width: 100%; }
            .login-branding { padding: 20px; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container d-flex justify-content-center">
            <div class="login-card">
                
                <div class="login-branding">
                    <h2 class="fw-bold">RMS</h2>
                    <p class="mt-3">Welcome to the Result Management System. Please log in to manage student academic records.</p>
                    <div class="mt-4">
                        <small>Need student access?</small><br />
                        <asp:HyperLink ID="userClickHere" runat="server" CssClass="text-white fw-bold" NavigateUrl="~/Defaylt.aspx">Click Here</asp:HyperLink>
                    </div>
                </div>

                <div class="login-form-area">
                    <h3 class="mb-4 text-dark fw-bold">Admin Login</h3>
                    
                    <asp:Login ID="Login1" runat="server" OnAuthenticate="Login1_Authenticate" RenderOuterTable="false">
                        <LayoutTemplate>
                            <div class="mb-3">
                                <label class="form-label">Username</label>
                                <asp:TextBox ID="UserName" runat="server" CssClass="form-control" placeholder="Enter your username"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" 
                                    ErrorMessage="Username is required." Display="Dynamic" CssClass="text-danger small" ValidationGroup="Login1"></asp:RequiredFieldValidator>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Password</label>
                                <asp:TextBox ID="Password" runat="server" CssClass="form-control" TextMode="Password" placeholder="••••••••"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" 
                                    ErrorMessage="Password is required." Display="Dynamic" CssClass="text-danger small" ValidationGroup="Login1"></asp:RequiredFieldValidator>
                            </div>

                            <div class="mb-3 form-check">
                                <asp:CheckBox ID="RememberMe" runat="server" CssClass="form-check-input" />
                                <label class="form-check-label" for="RememberMe">Remember me</label>
                            </div>

                            <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>

                            <div class="d-grid gap-2">
                                <asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="Login to Dashboard" 
                                    CssClass="btn btn-login" ValidationGroup="Login1" OnClick="LoginButton_Click" />
                            </div>
                        </LayoutTemplate>
                    </asp:Login>
                </div>

            </div>
        </div>
    </form>
</body>
</html>