<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Header.aspx.vb" Inherits="Header" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <script type="text/javascript" language="javascript">
        var oldelem;
        oldelem = null;

        function init()
        {
            oldelem=Claim;
            
            
            var x = <%=Session("AccessLevel")%> 
            var showAdmin = '<%=Session("ShowAdmin") %>'
            
            if(x < 3)
            {
               document.getElementById("Reports").style.display = "none";
               document.getElementById("NoReports").style.display = "";
               
               document.getElementById("UserAdmin").style.display = "none";
               document.getElementById("NoAdmin").style.display = "";
            }
            else if(x >= 3 && showAdmin.toLowerCase() == "false")
            {
                document.getElementById("UserAdmin").style.display = "none";
                document.getElementById("NoAdmin").style.display = "";
            }
            
        }
        
        function ChangeBtn(src)
        {
            if (src != null)
            {
		      locstr = src.id + '.aspx'; 
            }
        	
            if (oldelem != null)
	            oldelem.className = "InactiveMenu"
        	
        	
            src.className = "ActiveMenu";
            oldelem = src;
        	
            parent.frames[1].location = locstr;
          
        }
        
        function SwitchBtn(src)
        {
	       //alert('hi');
	        if (oldelem != null)
		        oldelem.className = "InactiveMenu"
        	
	        //alert(src.className);
	        src.className = "ActiveMenu";
	        oldelem = src;

        }
        
    </script>
    <title>Insurance Tracking</title>
    <link href="StyleSheet.css" type="text/css" rel="stylesheet" />
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>


</head>

<body onload="init();">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="2" bgcolor="003366"><img src="Images/spacer.gif" width="2" height="2" /></td>
        <td bgcolor="003366"></td>
        <td colspan="6" bgcolor="003366"></td>
      </tr>
      <tr>
        <td  background="Images/property_02.gif">&nbsp;</td><%--width="10%"--%>
        <td  background="Images/property_02.gif">&nbsp;</td>
        <td colspan="6" background="Images/property_02.gif">&nbsp;</td>
      </tr>
      <tr>
        <td background="Images/property_06.gif"><img src="Images/beaconlogowords.jpg" alt="beacon logo" width="112" height="32" /></td>
        <td height="32" width="75%" colspan="1" background="Images/property_06.gif" align="Center" style="font-weight:bold;">Insurance Tracking</td>
        
        <td onclick="ChangeBtn(FindClaim);" width="75px" align="center" id="FindClaim" class="InactiveMenu">&nbsp;Search&nbsp;</td>
        
        <td onclick="ChangeBtn(Claim);" width="75px" align="center" id="Claim" class="ActiveMenu">&nbsp;Claim&nbsp;</td>
        
        <td onclick="ChangeBtn(Reports);" width="75px" align="center" id="Reports" class="InactiveMenu">&nbsp;Reports&nbsp;</td>
        
        <td onclick="ChangeBtn(UserAdmin);" width="75px" align="center" id="UserAdmin" class="InactiveMenu">&nbsp;Admin&nbsp;</td>
        <td width="20px" class="InactiveMenu" id="NoReports" style="display:none; cursor: default;">&nbsp;</td>
        <td width="20px" class="InactiveMenu" id="NoAdmin" style="display:none; cursor: default;">&nbsp;</td>
        <td width="20px" class="InactiveMenu" style="cursor: default;">&nbsp;</td>
        
        <td width="60px" class="Logoff" onclick="parent.window.location='login.aspx'">LogOff</td>
     </tr>
    </table>
</body>
</html>

