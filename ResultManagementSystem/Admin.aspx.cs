using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace ResultManagementSystem
{
    public partial class Admin : System.Web.UI.Page
    {
        // Your Connection String
        string connStr = @"Data Source=.;Initial Catalog=ResultManagementSystem;Integrated Security=True;TrustServerCertificate=True";
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                GetDashboardStats();
            }
        }

        private void GetDashboardStats()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                try
                {
                    con.Open();

                    // Query 1: Total Courses
                    SqlCommand cmd1 = new SqlCommand("SELECT COUNT(*) FROM Courses", con);
                    litTotalCourses.Text = cmd1.ExecuteScalar().ToString();

                    // Query 2: Total Students
                    SqlCommand cmd2 = new SqlCommand("SELECT COUNT(*) FROM Students", con);
                    litTotalStudents.Text = cmd2.ExecuteScalar().ToString();

                    // Query 3: Total Result Entries
                    SqlCommand cmd3 = new SqlCommand("SELECT COUNT(*) FROM Results", con);
                    litTotalResults.Text = cmd3.ExecuteScalar().ToString();
                }
                catch (Exception ex)
                {
                    // If table doesn't exist yet, it will show 0 instead of crashing
                    litTotalCourses.Text = "0";
                    litTotalStudents.Text = "0";
                    litTotalResults.Text = "0";
                }
            }
        }
    }
}