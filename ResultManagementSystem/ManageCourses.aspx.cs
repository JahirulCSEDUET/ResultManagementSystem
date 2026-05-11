using System;
using System.Data;
using System.Data.SqlClient;

namespace ResultManagementSystem
{
    public partial class ManageCourses : System.Web.UI.Page
    {
        string connStr = @"Data Source=.;Initial Catalog=ResultManagementSystem;Integrated Security=True;TrustServerCertificate=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect("Login.aspx");
            }
            if (!IsPostBack) LoadCourses();
        }

        private void LoadCourses()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlDataAdapter sda = new SqlDataAdapter("SELECT * FROM Courses", con);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                gvCourses.DataSource = dt;
                gvCourses.DataBind();
            }
        }

        protected void btnAddCourse_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO Courses (CourseCode, CourseName) VALUES (@code, @name)", con);
                cmd.Parameters.AddWithValue("@code", txtCourseCode.Text);
                cmd.Parameters.AddWithValue("@name", txtCourseName.Text);
                con.Open();
                cmd.ExecuteNonQuery();
            }
            txtCourseCode.Text = ""; txtCourseName.Text = "";
            LoadCourses();
        }

        protected void gvCourses_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvCourses.DataKeys[e.RowIndex].Value);
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM Courses WHERE CourseID=@id", con);
                cmd.Parameters.AddWithValue("@id", id);
                con.Open();
                cmd.ExecuteNonQuery();
            }
            LoadCourses();
        }
    }
}