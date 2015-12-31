<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AttachPhotos.aspx.vb" Inherits="AttachPhotos" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Attach Photos</title>
    <LINK href="Mainstyle.css" type="text/css" rel="stylesheet">
</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data" >
     <input id="hidImage" runat="server" type="hidden" />
          
          <table>
            <tr>
                <td class="labelText" style="text-align:left;">
                     Select Image to Upload: 
                    <input id="uploadedFile" type="file" style="width:480px;" runat="server" />
                </td>
            </tr>
            <tr>
                <td  align="center">
                   <br />
                    <input type=button id="Send" 
                    value="Upload" 
                    OnServerClick="Upload_Click" 
                    runat="server" />
                    &nbsp; &nbsp;
                    <input type=button value='Cancel' onclick='window.close();' />
                </td>
            
            </tr>
            <tr>
                <td>
                 <br />
                 <asp:Label id="message" runat="server"/>
                </td>
               
            </tr>
          </table>
    </form>
</body>
</html>
