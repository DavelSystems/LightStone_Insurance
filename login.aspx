<%@ Page Language="VB" AutoEventWireup="false" CodeFile="login.aspx.vb" Inherits="login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<title>User Login</title>
		<meta content="Microsoft Visual Studio 7.0" name="GENERATOR">
		<meta content="vb" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="Mainstyle.css" type="text/css" rel="stylesheet">
		<SCRIPT language="JScript">
	if(self!= self.top){
		self.top.location.replace("Login.aspx")
	}
		</SCRIPT>
	</HEAD>
	<body onload="document.all('UserId').focus()" scroll="no">
	    
		<div style="PADDING-TOP: 100px">
			<form id="Form1" runat="server">
				<table class="forecolor" width="50%" align="center" border="0">
					<tr height="10">
						<td>&nbsp;</td>
					</tr>
					<tr height="30">
						<td style="FONT: 14pt Arial" vAlign="middle" align="center" colSpan="3"> 
							Insurance Tracking System</td>
					</tr>
					<tr>
						<td align="right">ID:</td>
						<td><input id="UserId" type="text" name="UserId" runat="server"></td>
					</tr>
					<tr>
						<td align="right">Password:</td>
						<td><input id="Password" type="password" name="Password" runat="server"></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td align="center" colSpan="3"><asp:button id="Login" runat="server" Font-Name="System" Text="OK" width="80"></asp:button></td>
					</tr>
					<tr height="20">
						<td>&nbsp;</td>
					</tr>
				</table>
				<asp:label id="Msg" runat="server" Font-Name="Verdana" Font-Size="14"></asp:label></form>
			<P></P>
		</div>
	</body>
</HTML>

