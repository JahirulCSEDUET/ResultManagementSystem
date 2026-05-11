using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ResultManagementSystem
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            // 1. Tell ASP.NET to delete the Authentication Cookie
            FormsAuthentication.SignOut();

            // 2. Clear all Session variables (like UserName)
            Session.Abandon();
            Session.Clear();

            // 3. Redirect to the Public Search or Login page
            // We use 'true' to end the current response immediately
            Response.Redirect("Login.aspx", true);
        }
    }
}