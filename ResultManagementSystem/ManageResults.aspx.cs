using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace ResultManagementSystem
{
    public partial class ManageResults : System.Web.UI.Page
    {
        string connStr = @"Data Source=.;Initial Catalog=ResultManagementSystem;Integrated Security=True;TrustServerCertificate=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!User.Identity.IsAuthenticated)
                {
                    Response.Redirect("Login.aspx");
                }
                LoadAllResults();
                // Initialize a temporary table in Session to hold data before saving
                Session["TempResults"] = null;
            }
        }

        private void LoadAllResults()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                // SQL query to calculate Total Marks and count of subjects per student
                string query = @"
            SELECT 
                S.StudentID, 
                S.StudentName, 
                COUNT(R.CourseCode) as TotalSubjects, 
                SUM(R.MarksObtained) as AggregateMarks 
            FROM Students S
            INNER JOIN Results R ON S.StudentID = R.StudentID
            GROUP BY S.StudentID, S.StudentName
            ORDER BY S.StudentID ASC";

                SqlDataAdapter sda = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                sda.Fill(dt);

                gvAllResults.DataSource = dt;
                gvAllResults.DataBind();
            }
        }

        protected void btnToggleAdd_Click(object sender, EventArgs e)
        {
            //pnlViewAll.Visible = false;
            pnlAddResult.Visible = true;
        }

        // PART ONE: Verification
        protected void btnVerify_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT StudentName FROM Students WHERE StudentID=@id", con);
                cmd.Parameters.AddWithValue("@id", txtSearchSID.Text.Trim());
                con.Open();
                object result = cmd.ExecuteScalar();

                if (result != null)
                {
                    litStudentName.Text = result.ToString();
                    litStudentID.Text = txtSearchSID.Text;
                    phPart1.Visible = false;
                    phPart2.Visible = true;
                    LoadCourses();
                }
                else
                {
                    lblPart1Msg.Text = "No student found. Would you like to ";
                    lnkAddNewStudent.Visible = true;
                }
            }
        }

        private void LoadCourses()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlDataAdapter sda = new SqlDataAdapter("SELECT CourseCode, CourseName FROM Courses", con);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                ddlCourses.DataSource = dt;
                ddlCourses.DataTextField = "CourseName";
                ddlCourses.DataValueField = "CourseCode";
                ddlCourses.DataBind();
            }
        }

        // PART TWO: Add multiple to list
        protected void btnAddToList_Click(object sender, EventArgs e)
        {
            DataTable dt = (Session["TempResults"] as DataTable) ?? CreateTempTable();

            // Check if course already in list
            foreach (DataRow row in dt.Rows)
            {
                if (row["CourseCode"].ToString() == ddlCourses.SelectedValue)
                {
                    Response.Write("<script>alert('Course already added to this list!');</script>");
                    return;
                }
            }

            dt.Rows.Add(litStudentID.Text, ddlCourses.SelectedValue, txtNewMarks.Text);
            Session["TempResults"] = dt;
            gvTempResults.DataSource = dt;
            gvTempResults.DataBind();
            btnSaveFinal.Visible = true;
        }

        private DataTable CreateTempTable()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("StudentID");
            dt.Columns.Add("CourseCode");
            dt.Columns.Add("Marks");
            return dt;
        }

        // FINAL STEP: Save to DB
        protected void btnSaveFinal_Click(object sender, EventArgs e)
        {
            DataTable dt = Session["TempResults"] as DataTable;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                foreach (DataRow row in dt.Rows)
                {
                    SqlCommand cmd = new SqlCommand("INSERT INTO Results (StudentID, CourseCode, MarksObtained) VALUES (@sid, @cc, @m)", con);
                    cmd.Parameters.AddWithValue("@sid", row["StudentID"]);
                    cmd.Parameters.AddWithValue("@cc", row["CourseCode"]);
                    cmd.Parameters.AddWithValue("@m", row["Marks"]);
                    cmd.ExecuteNonQuery();
                }
            }
            Response.Redirect("ManageResults.aspx");
        }

        protected void btnCancel_Click(object sender, EventArgs e) { 
            Response.Redirect("ManageResults.aspx"); 
        }
    }
}