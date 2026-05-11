using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace ResultManagementSystem
{
    public partial class Result : System.Web.UI.Page
    {
        string connStr = @"Data Source=.;Initial Catalog=ResultManagementSystem;Integrated Security=True;TrustServerCertificate=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string studentId = Request.QueryString["sid"];
                if (!string.IsNullOrEmpty(studentId))
                {
                    LoadMarksheet(studentId);
                }
                else
                {
                    Response.Redirect("ManageResults.aspx");
                }
            }
        }

        private void LoadMarksheet(string sid)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                // Query to get Student Info and Marks in one go
                string query = @"
                    SELECT S.StudentName, S.RunningYear, S.RunningSemester, 
                           R.CourseCode, C.CourseName, R.MarksObtained 
                    FROM Students S
                    INNER JOIN Results R ON S.StudentID = R.StudentID
                    INNER JOIN Courses C ON R.CourseCode = C.CourseCode
                    WHERE S.StudentID = @sid";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@sid", sid);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    // Fill Student Header Info (using first row)
                    litStudentName.Text = dt.Rows[0]["StudentName"].ToString();
                    litRollNo.Text = sid;

                    string rawYear = dt.Rows[0]["RunningYear"].ToString();
                    string suffixYear = "th"; // Default suffix

                    switch (rawYear)
                    {
                        case "1": suffixYear = "st"; break;
                        case "2": suffixYear = "nd"; break;
                        case "3": suffixYear = "rd"; break;
                        default: suffixYear = "th"; break;
                    }

                    litYear.Text = rawYear + suffixYear + " year";

                    string rawSemester = dt.Rows[0]["RunningSemester"].ToString();
                    string suffix = "th"; // Default suffix

                    switch (rawSemester)
                    {
                        case "1": suffix = "st"; break;
                        case "2": suffix = "nd"; break;
                        case "3": suffix = "rd"; break;
                        default: suffix = "th"; break;
                    }

                    litSemester.Text = rawSemester + suffix + " semester";

                    // Bind GridView
                    gvResults.DataSource = dt;
                    gvResults.DataBind();

                    // Calculations
                    int totalMarks = 0;
                    bool isFailed = false;

                    foreach (DataRow row in dt.Rows)
                    {
                        int marks = Convert.ToInt32(row["MarksObtained"]);
                        totalMarks += marks;
                        if (marks < 33) isFailed = true; // DUET passing criteria check
                    }

                    double percentage = (double)totalMarks / dt.Rows.Count;
                    litTotalMarks.Text = totalMarks.ToString();
                    litPercentage.Text = percentage.ToString("F2");

                    if (isFailed)
                    {
                        lblStatus.Text = "FAILED";
                        lblStatus.CssClass = "badge bg-danger";
                    }
                    else
                    {
                        lblStatus.Text = "PASSED";
                        lblStatus.CssClass = "badge bg-success";
                    }
                }
            }
        }

        public string CalculateGrade(int marks)
        {
            if (marks >= 80) return "A+";
            if (marks >= 75) return "A";
            if (marks >= 70) return "A-";
            if (marks >= 65) return "B+";
            if (marks >= 60) return "B";
            if (marks >= 55) return "B-";
            if (marks >= 50) return "C+";
            if (marks >= 45) return "C";
            if (marks >= 40) return "D";
            return "F";
        }
    }
}