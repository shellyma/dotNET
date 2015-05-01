<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
  
    <link rel="stylesheet" type="text/css" href="style.css"/>
</head>
<body>
    <form id="form1" class="box login" runat="server">
   	<fieldset class="boxBody_full">
	  <label>Username</label>
	  <asp:Textbox class="txtField" ID="username"  runat="server"/>
	  <label>Password</label>
	  <asp:Textbox class="txtField" ID="password" TextMode="Password" runat="server"/>
	</fieldset>
    <footer class =" boxBody_full"> 
        <asp:Button class="btnLogin" Text="Login" runat="server" OnClick="Login_clicked"/>
        <asp:Button class="btnLogin" Text="Signup" runat="server" OnClick="Signup_Clicked"/>
    </footer>
        
    <div class="reminder">
     <asp:Label ID="Reminder" runat="server" Text=""></asp:Label>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Users] where username = (@user)" InsertCommand="INSERT INTO Users(Username, Password) VALUES (@username, @password)">
            <InsertParameters>
                <asp:ControlParameter ControlID="username" Name="username" PropertyName="Text" />
                <asp:SessionParameter Name="password" SessionField="hashedPassword" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="username" Name="user" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>    
        
    </form>
</body>
</html>
