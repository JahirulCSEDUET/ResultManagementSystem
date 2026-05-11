using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ResultManagementSystem
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated)
            {
                Response.Redirect("Admin.aspx");
            }
        }

        protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
        {

        }

        protected void LoginButton_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(@"Data Source=.;Initial Catalog=ResultManagementSystem;Integrated Security=True;TrustServerCertificate=True");
            SqlCommand cmd = new SqlCommand("select * from admin where UserName=@username and Password =@word", con);
            cmd.Parameters.AddWithValue("@UserName", Login1.UserName);
            cmd.Parameters.AddWithValue("@word", Login1.Password);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            con.Open();
            if (dt.Rows.Count > 0)
            {
                FormsAuthentication.SetAuthCookie(Login1.UserName, false);
                Session["UserName"] = Login1.UserName;
                Response.Redirect("Admin.aspx"); 
            }
            else
            {
                Response.Write("<script>alert('Invalid username or password')</script>");
            }

        }
    }
}