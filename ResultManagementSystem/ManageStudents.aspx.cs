using System;
using System.Data;
using System.Data.SqlClient;

namespace ResultManagementSystem
{
    public partial class ManageStudents : System.Web.UI.Page
    {
        // Connection string
        string connStr = @"Data Source=.;Initial Catalog=ResultManagementSystem;Integrated Security=True;TrustServerCertificate=True";

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect("Login.aspx");
            }
            if (!IsPostBack)
            {
                LoadStudents();
            }
        }

        private void LoadStudents()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlDataAdapter sda = new SqlDataAdapter("SELECT * FROM Students ORDER BY CreatedAt DESC", con);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                gvStudents.DataSource = dt;
                gvStudents.DataBind();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string query = "INSERT INTO Students (StudentID, StudentName, RunningYear, RunningSemester) " +
                                   "VALUES (@id, @name, @year, @sem)";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@id", txtID.Text.Trim());
                    cmd.Parameters.AddWithValue("@name", txtName.Text.Trim());
                    cmd.Parameters.AddWithValue("@year", ddlYear.SelectedValue);
                    cmd.Parameters.AddWithValue("@sem", ddlSemester.SelectedValue);

                    con.Open();
                    cmd.ExecuteNonQuery();

                    lblMsg.Text = "Student created successfully!";
                    lblMsg.CssClass = "text-success";

                    // Clear inputs
                    txtID.Text = ""; txtName.Text = ""; ddlSemester.ClearSelection(); ddlYear.ClearSelection();
                    LoadStudents();
                }
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Error: " + ex.Message;
                lblMsg.CssClass = "text-danger";
            }
        }
    }
}