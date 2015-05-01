<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Profile.aspx.cs" Inherits="signup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sign Up</title>
      <link rel="stylesheet" type="text/css" href="style.css"/>
</head>
<body>
    <form id="form1" class="box signup" runat="server">
   	    <fieldset class="boxBody_full">
            <asp:Button class="btnDelete" ID="logout" runat="server" Text="Lougout" OnClick="logout_clicked" Width="145px" />
            <asp:Button class="btnDelete" ID="delete_profile" runat="server" Text="Delete Profile" OnClick="delete_profile_clicked" Width="145px" />
                <asp:Button class="btnDelete" ID="delete_accnt" runat="server" Text="Delete Account" OnClick="delete_account_clicked" Width="145px" />
            <asp:Button class="btnDelete" ID="home" runat="server" Text="My Account" OnClick="home_clicked" Width="145px" />
            
        </fieldset>
   	<fieldset class="boxBody">
	  <label>Username</label>
	  <asp:Textbox ID="username"  runat="server" ReadOnly="True"/>
      <label>First Name<b style="color:red;">*</b></label>
	  <asp:Textbox class="txtField" ID="first"  runat="server" AutoPostBack="True"/>
      <label>Last Name<b style="color:red;">*</b></label>
	  <asp:Textbox class="txtField" ID="last"  runat="server" AutoPostBack="True"/>
      <label>Age</label>
	  <asp:Textbox class="txtField" ID="age"  runat="server" AutoPostBack="True"/>
      <label>Address</label>
	  <asp:Textbox  class="txtField" ID="address"  runat="server" AutoPostBack="True"/>
      <label>Phone Number</label>
	  <asp:Textbox class="txtField" ID="phone"  runat="server" AutoPostBack="True"/>
      <label>Gender</label>
      <asp:RadioButtonList runat="server" ID="gender" RepeatDirection="Horizontal"  RepeatLayout="Table" Width="277px" AutoPostBack="True">
        <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
        <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
      </asp:RadioButtonList>
      <label>Email Address<b style="color:red;">*</b></label>
	  <asp:Textbox class="txtField" ID="email"  runat="server" AutoPostBack="True"/>
	</fieldset>
       <fieldset>
           <label><b style="font-size:25px;">Meet others in the system:</b></label> <br />
           <asp:DropDownList class="btnLogin" ID="DropDownList1" runat="server" DataSourceID="SqlDataSource2" DataTextField="First" DataValueField="Username" Width="137px" >
           <asp:ListItem Value="">  </asp:ListItem>
           </asp:DropDownList>
           <asp:Button class="btnLogin" Text ="Visit Profile" runat="server" OnClick="visit_triggered" />
           <br />
       </fieldset>
   <fieldset class="boxBody_full"> 
       
        <asp:Button class="btnLogin" ID="update_btn" Text="Update Profile" runat="server" OnClick="update_clicked" />
       <br><br> 
       <asp:Label ID="Reminder1" runat="server" Text=""/>

    </fieldset>


  
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Id, First, Last, Age, Address, Gender, Email, Role, Username, Password, Phone FROM Users WHERE (Username = @Username)" UpdateCommand="UPDATE Users SET First = @first, Last = @last, Age = @age, Gender = @gender, Email = @email, Address = @address, Phone = @phone WHERE (Id = @id)" DeleteCommand="DELETE FROM Users WHERE (Id = @id)">
            <DeleteParameters>
                <asp:SessionParameter Name="id" SessionField="id" />
            </DeleteParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="username" DefaultValue="&quot;&quot;" Name="Username" PropertyName="Text" Type="String" />
            </SelectParameters>
            <UpdateParameters>
                <asp:SessionParameter Name="id" SessionField="id" />
                <asp:ControlParameter ControlID="first" Name="first" PropertyName="Text" />
                <asp:ControlParameter ControlID="last" Name="last" PropertyName="Text" />
                <asp:ControlParameter ControlID="age" Name="age" PropertyName="Text" />
                <asp:ControlParameter ControlID="gender" Name="gender" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="email" Name="email" PropertyName="Text" />
                <asp:ControlParameter ControlID="address" Name="address" PropertyName="Text" />
                <asp:ControlParameter ControlID="phone" Name="phone" PropertyName="Text" />
            </UpdateParameters>
        </asp:SqlDataSource>
      <label><b style="color:red;">
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Id], [First], [Last], [Age], [Address], [Gender], [Email], [Username], [Phone] FROM [Users] WHERE ([Username] &lt;&gt; @Username)">
            <SelectParameters>
                <asp:SessionParameter Name="Username" SessionField="username" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        </b></label>
    </div>
     <div style ="width:100%;height:100%;text-align:center; vertical-align:middle; float:right; padding-left:25%;">
      </div>
   </form>
</body>
</html>
