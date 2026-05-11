using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace ResultManagementSystem
{
    public partial class Default : System.Web.UI.Page
    {
        string connStr = @"Data Source=.;Initial Catalog=ResultManagementSystem;Integrated Security=True;TrustServerCertificate=True";

        protected void Page_Load(object sender, EventArgs e) { }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string sid = txtSearchID.Text.Trim();
            string yr = ddlYear.SelectedValue;
            string sem = ddlSem.SelectedValue;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                // Strict Matching Query
                string query = @"
                    SELECT S.StudentName, S.RunningYear, S.RunningSemester, 
                           C.CourseName, R.MarksObtained 
                    FROM Students S
                    INNER JOIN Results R ON S.StudentID = R.StudentID
                    INNER JOIN Courses C ON R.CourseCode = C.CourseCode
                    WHERE S.StudentID = @sid 
                    AND S.RunningYear = @yr 
                    AND S.RunningSemester = @sem";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@sid", sid);
                cmd.Parameters.AddWithValue("@yr", yr);
                cmd.Parameters.AddWithValue("@sem", sem);

                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    // Switch to Result View
                    mvPublic.ActiveViewIndex = 1;

                    // Fill Header
                    litName.Text = dt.Rows[0]["StudentName"].ToString();
                    litID.Text = sid;
                    //litYear.Text = yr;

                    //// Suffix Logic for Semester
                    //string suffix = (sem == "1") ? "st" : (sem == "2") ? "nd" : (sem == "3") ? "rd" : "th";
                    //litSem.Text = sem + suffix;


                    string rawYear = yr;
                    string suffixYear = "th"; // Default suffix

                    switch (rawYear)
                    {
                        case "1": suffixYear = "st"; break;
                        case "2": suffixYear = "nd"; break;
                        case "3": suffixYear = "rd"; break;
                        default: suffixYear = "th"; break;
                    }

                    litYear.Text = rawYear + suffixYear + " year";

                    string rawSemester = sem;
                    string suffix = "th"; // Default suffix

                    switch (rawSemester)
                    {
                        case "1": suffix = "st"; break;
                        case "2": suffix = "nd"; break;
                        case "3": suffix = "rd"; break;
                        default: suffix = "th"; break;
                    }

                    litSem.Text = rawSemester + suffix + " semester";
                    // Bind Grid
                    gvPublicResult.DataSource = dt;
                    gvPublicResult.DataBind();

                    // Summary Logic
                    int total = 0;
                    bool failed = false;
                    foreach (DataRow row in dt.Rows)
                    {
                        int m = Convert.ToInt32(row["MarksObtained"]);
                        total += m;
                        if (m < 33) failed = true;
                    }

                    litTotal.Text = total.ToString();
                    lblStatus.Text = failed ? "FAILED" : "PASSED";
                    lblStatus.CssClass = failed ? "badge bg-danger" : "badge bg-success";
                }
                else
                {
                    lblError.Text = "No records found matching these criteria.";
                }
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            mvPublic.ActiveViewIndex = 0;
            txtSearchID.Text = "";
            lblError.Text = "";
        }

        public string GetGrade(int marks)
        {
            if (marks >= 80) return "A+";
            if (marks >= 70) return "A";
            if (marks >= 60) return "B";
            if (marks >= 50) return "C";
            if (marks >= 33) return "D";
            return "F";
        }
    }
}