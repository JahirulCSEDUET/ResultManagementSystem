using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace ResultManagementSystem
{
    public partial class ManageAdmin : System.Web.UI.Page
    {
        string connStr = @"Data Source=.;Initial Catalog=ResultManagementSystem;Integrated Security=True;TrustServerCertificate=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            // Security Check
            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadAdminList();
            }
        }

        private void LoadAdminList()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                // We show all admins EXCEPT the one currently logged in to prevent accidental self-deletion
                string query = "SELECT ID, UserName, FullName FROM admin WHERE UserName <> @currentUser";
                SqlCommand cmd = new SqlCommand(query, con);
                string currentUser = Session["UserName"] != null ? Session["UserName"].ToString() : "";
                cmd.Parameters.AddWithValue("@currentUser", currentUser);

                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                gvAdmins.DataSource = dt;
                gvAdmins.DataBind();
            }
        }

        protected void btnAddAdmin_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtNewUser.Text) || string.IsNullOrWhiteSpace(txtNewPass.Text))
            {
                lblMsg.Text = "Please fill all fields.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            using (SqlConnection con = new SqlConnection(connStr))
            {
                try
                {
                    string query = "INSERT INTO admin (UserName, Password, FullName) VALUES (@user, @pass, @name)";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@user", txtNewUser.Text.Trim());
                    cmd.Parameters.AddWithValue("@pass", txtNewPass.Text); // In production, hash this!
                    cmd.Parameters.AddWithValue("@name", txtFullName.Text.Trim());

                    con.Open();
                    cmd.ExecuteNonQuery();
                    
                    lblMsg.Text = "Admin added successfully!";
                    lblMsg.ForeColor = System.Drawing.Color.Green;
                    
                    // Clear fields and refresh grid
                    txtNewUser.Text = txtNewPass.Text = txtFullName.Text = "";
                    LoadAdminList();
                }
                catch (SqlException ex)
                {
                    lblMsg.Text = "Error: Username might already exist.";
                    lblMsg.ForeColor = System.Drawing.Color.Red;
                }
            }
        }

        protected void gvAdmins_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int adminId = Convert.ToInt32(gvAdmins.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM admin WHERE ID = @id", con);
                cmd.Parameters.AddWithValue("@id", adminId);
                con.Open();
                cmd.ExecuteNonQuery();
            }
            LoadAdminList();
        }
    }
}