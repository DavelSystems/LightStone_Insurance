﻿<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ReportsPopUp.aspx.vb" Inherits="ReportsPopUp" Trace="true"  %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
 <link href="Mainstyle.css" type="text/css" rel="stylesheet"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>View Report</title>
</head>
<body>
    <form id="form1" runat="server">
   <div>
        <table>
            <tr>
                <td colspan="2" align="CENTER" style="width:100%;height:645px;">
                
                   <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt"
                        Height="100%" ProcessingMode="Remote" Width="900px" BorderColor="black" BorderStyle="solid" BorderWidth="1">
                        <ServerReport  />
                    </rsweb:ReportViewer>
                </td>
            </tr>
        </table>
    </div>
    
    
    </form>
    
</body>
</html>
