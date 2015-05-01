using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class signup : System.Web.UI.Page
{
    private DataView dv,dv1;

    protected void Page_Load(object sender, EventArgs e)
    {  
        if (Session["id"] == null || Session["username"] == null || Session["hashedPassword"] == null)
        {
            Response.Redirect("Default.aspx");
        }

       
        if(!IsPostBack)
        { 
            if (Request.QueryString["who"] == null)
            {
                username.Text = Session["username"].ToString();
                
            }
            else if (Request.QueryString["who"].Equals(Session["username"].ToString()))
            {
                username.Text = Session["username"].ToString();
                delete_accnt.Visible = true;
                delete_profile.Visible = true;
                update_btn.Visible = true;
            }else
            {
                username.Text = Request.QueryString["who"];
                update_btn.Visible = false;
                delete_accnt.Visible = false;
                delete_profile.Visible = false;
            }
            dv = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
            
            if (dv.Count == 1)
            {
                first.Text = dv[0]["First"].ToString();
                last.Text = dv[0]["Last"].ToString();
                age.Text = dv[0]["Age"].ToString();
                address.Text = dv[0]["Address"].ToString();
                phone.Text = dv[0]["Phone"].ToString();
                if (dv[0]["Gender"].ToString().Equals("Male"))
                {
                    gender.SelectedIndex = 0;
                }
                else if (dv[0]["Gender"].ToString().Equals("Female"))
                {
                    gender.SelectedIndex = 1;
                }
                email.Text = dv[0]["Email"].ToString();

                Reminder1.Text = "Welcome   " + Session["username"].ToString() + "  !";
            
            }
           
      
        }
        
    }
        

    protected void update_clicked(object sender, EventArgs e)
    {
        if (username.Text == ""  || first.Text == "" || last.Text == "" || email.Text =="")
        {
            Reminder1.Text = "All fields with * must be filled.";
        }
        else
        {
           dv =  (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
            if(dv.Count == 1)
            {
                if(first.Text != "" && last.Text != "" && email.Text != "") 
                {
                    if (age.Text != "")
                    {
                        if(!Regex.IsMatch(age.Text, "^[0-9]*$"))
                        Reminder1.Text = "Please input a numeric value for age.";
                      
                    }else if(phone.Text != ""){
                        if(!Regex.IsMatch(phone.Text, "^[0-9]*$"))
                            Reminder1.Text = "Please enter numbers only for phone.";
                    }
                    if (!Regex.IsMatch(address.Text, "^[a-zA-Z0-9]*$"))
                        Reminder1.Text = "Please enter a vlid email address.";

                    try
                    {
                        SqlDataSource1.Update();
                        SqlDataSource1.DataBind();
                        
                    }
                    catch
                    {
                        Console.Write("Database update error");
                    }
                         
                }
                else
                {
                    Reminder1.Text = "Please fill in required fields.";
                }
            }
            else
            {
                clear_session();
                Response.Redirect("Default.aspx");
            }
           
            
        }
       
    }

    protected void delete_account_clicked(object sender, EventArgs e)
    {
        SqlDataSource1.Delete();
        clear_session();
        Response.Redirect("Default.aspx");

    }

    protected void delete_profile_clicked(object sender, EventArgs e)
    {
        //only delete profile
        first.Text = "";
        last.Text = "";
        age.Text = "";
        address.Text = "";
        phone.Text = "";
        gender.SelectedIndex = -1;
        email.Text = "";

        SqlDataSource1.Update();
        SqlDataSource1.DataBind();
      
    }

    protected void logout_clicked(Object sender, EventArgs e)
    {
        clear_session();
        Response.Redirect("Default.aspx");
    }

    protected void home_clicked(Object sender, EventArgs e)
    {
        Response.Redirect("Profile.aspx");
    }

    protected void clear_session()
    {
        Session["id"] = null;
        Session["username"] = null;
        Session["password"] = null;
    }

    
    protected void visit_triggered(object sender, EventArgs e)
    {
        if (DropDownList1.SelectedIndex < 0)
        {
            Reminder1.Text = "Please select a user to visit.";
        }
        else
        {
            Response.Redirect("Profile.aspx?who="+ DropDownList1.SelectedValue );
        }
    }
}