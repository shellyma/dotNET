using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;

public partial class _Default : System.Web.UI.Page
{
    DataView dv;
    protected void Page_Load(object sender, EventArgs e)
    {
        dv = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
    }


    public string MD5Hash(string input)
    {
        MD5 md5 = MD5.Create();
        byte[] inputBytes = System.Text.Encoding.ASCII.GetBytes(input);
        byte[] hash = md5.ComputeHash(inputBytes);

        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < hash.Length; i++)
        {
            sb.Append(hash[i].ToString("X2"));
        }
        return sb.ToString();
    }


    protected void Login_clicked(object sender, EventArgs e)
    {
        if (username.Text == "" || password.Text == "")
        {
            Reminder.Text = "Please input your username and password.";
        }
        else
        {
            authenticate();
        }
    }
    protected void Signup_Clicked(object sender, EventArgs e)
    {
        if (username.Text != "" && password.Text != "")
        {
            if (dv.Count < 1)  //username available
            {
                Session["username"] = username.Text;
                Session["hashedPassword"] = MD5Hash(password.Text);
                SqlDataSource1.Insert();
                SqlDataSource1.DataBind();
                DataView dv1 = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);

               
                if (dv1.Count == 1) //just inserted 
                {
                   
                    Session["id"] = dv1[0][0];
                    Response.Redirect("Signup.aspx");
                }
                else
                {
                    Console.Write("Error occurred during creating new account.");
                }

            }
            else
            {
                Reminder.Text = "username is not available, please try another one.";
            }
        }
        else
        {
            Reminder.Text = "Please input your username and password.";
        }
             

    }


    protected void authenticate()
    {
        
        if (dv.Count < 1)
        {
            Reminder.Text = "Username  " + "<b style= color:red;>" + username.Text + "</b>"+ "  does not exist!";

        }
        else if (dv.Count == 1)
        {
            
            if (dv[0]["Password"].Equals(MD5Hash(password.Text)))
            {
                Session["id"] = dv[0]["Id"];
                Session["username"] = username.Text;
                Session["hashedPassword"] = MD5Hash(password.Text);
                Response.Redirect("Profile.aspx");
            }
            else Reminder.Text = "Wrong password";
        }
        else
        {
            Console.Write("Database error, duplicate accounts");
        }
    }
}