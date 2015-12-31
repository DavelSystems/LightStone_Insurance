<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AddEditProps.aspx.vb" Inherits="AddEditProps" EnableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Add/Edit Properties</title>
    
     <meta http-equiv="Page-Exit" content="progid:DXImageTransform.Microsoft.GradientWipe(Duration=0,Transition=5)" />
 
   
    <LINK href="Mainstyle.css" type="text/css" rel="stylesheet" />
    
    <script language="javascript" type="text/javascript">
    function dgrdStyleChange(row,index, style)
    {
        if (style != "" )
	    {
	        //if(form1.hidOldRow.value != row.id)
	        if(form1.hidEditProp.value != index)
	        {   // row.className = style;
	          row.style.backgroundColor = getPropertyValueFromCss(style, "backgroundColor")
	         row.style.Color = getPropertyValueFromCss(style, "color")
	        }
	    }   
    	 
    }
    
     function dgrdStyleChange2(row,index, style)
    {
        if (style != "" )
	    {
	        //if(form1.hidOldRow.value != row.id)
	        if(form1.hidEditBldg.value != index)
	        {   // row.className = style;
	          row.style.backgroundColor = getPropertyValueFromCss(style, "backgroundColor")
	         row.style.Color = getPropertyValueFromCss(style, "color")
	        }
	    }   
    	 
    }
    
    function dgrdSelect(row,style,index)
    {
        //if(!onChk)
        //{
        
            //if(form1.hidOldRow.value != row.id)
            if(form1.hidEditProp.value != index)
            { 
            /*
            if(form1.hidOldRow.value.length > 0)
            {
                var oldRow = document.getElementById(form1.hidOldRow.value)
                oldRow.className = form1.hidOldRowType.value;
            }
            */
            form1.hidOldRowProp.value = row.id;
           // form1.hidOldRowType.value = style;
          
            form1.hidEditProp.value = index;
          //alert(form1.hidEdit.value);
            //row.className = "GridSelect";
          
            //document.getElementById("hidPanel").value = "DetailTab";
            
           // document.getElementById("btnPrint").disabled = false;
                 
            form1.submit();
            }
           
           
           // else
          //  {
           //     Cancel();
                /*
                row.className = form1.hidOldRowType.value;
                form1.hidOldRow.value = "";
                form1.hidOldRowType.value = "";
                
                form1.hidFillDetails.value = "false";
                ClearInvoiceDetails();
                */
           // }
       // }
    }
    
     function dgrdSelect2(row,style,index)
    {
       
        if(form1.hidEditBldg.value != index)
        { 
       
        form1.hidOldRowBldg.value = row.id;
    
        form1.hidEditBldg.value = index;
     
             
        form1.submit();
        }
           
         
    }
    
    function getPropertyValueFromCss(className, propertyName)
{
    var toReturn = null;

	for (var i = 0; i < document.styleSheets.length; i++)
	{
		var cssRules = null;

		// IE
		if (document.styleSheets[i].rules)
		{
			cssRules = document.styleSheets[i].rules;
		}
		// Mozilla and others
		else if (document.styleSheets[i].cssRules)
		{
			cssRules = document.styleSheets[i].cssRules;
		}

		if (cssRules != null)
		{
			for (var j = 0; j < cssRules.length; j++)
			{
				if (cssRules[j].selectorText == ("." + className) && cssRules[j].style[propertyName] != null)
				{				
					toReturn = cssRules[j].style[propertyName];
					break;
				}
			}
		}
	}
    return toReturn;
}


function DeleteItem()
{
    event.cancelBubble = true;
    return(confirm("Are you sure you want to delete this?"));
}

  var keystr,oldel,seltxt;
        keystr = new String();   
        
         function processkeys()
        {
	        actel = document.activeElement;
        	
	        kc = event.keyCode;
            //alert("kc = " +kc)
	        if (kc==27) {	// allow escape key to restart typing
		        keystr = ""
		        actel.value = "";
		        //showtooltip(true," ",115,88);
		        return;		//don't store escape key in keystr
	        }
	        else if (kc==9) {
		        event.keyCode = 9;
		        return;
	        }
		        //event.returnValue = true; 
	        else if (oldel != actel) {	// field change restarts typing
		        keystr = "";
		        oldel = actel;
	        }
		    if (kc==13) 
		    {
		        event.cancelBubble=true;
		       // alert("actel.id: " + actel.id);
		        
		        if(actel.id.indexOf("txtPropName") > -1)
		        {
		            //alert("actel.id: " + actel.id);
		            document.getElementById(actel.id.replace("txtPropName","btnSaveItem")).click();
		        }
		        else if(actel.id.indexOf("txtRMPROPID") > -1)
		        {
		            
		            document.getElementById(actel.id.replace("txtRMPROPID","btnSaveItem")).click();
		        }
		        else if(actel.id.indexOf("txtBldgName") > -1)
		        {
		            
		            document.getElementById(actel.id.replace("txtBldgName","btnSaveItemBldg")).click();
		        }
		        else if(actel.id.indexOf("txtRMBLDGID") > -1)
		        {
		            
		            document.getElementById(actel.id.replace("txtRMBLDGID","btnSaveItemBldg")).click();
		        }
		        else
		        {
    		        event.cancelBubble=true;
    		        //document.getElementById("btnSave").click();
    		        event.returnValue = false;
    		    }
    		    
    		    event.returnValue = false;
		    }
    		
	    }
	    
    </script>
</head>
<body onkeypress="processkeys();">
    <form id="form1" runat="server">
        <input id="saveScrollPos" type="hidden" name="saveScrollPos" runat="server" />
        <input id="saveScrollPos2" type="hidden" name="saveScrollPos2" runat="server" />
        <input type="hidden" id="hidEditProp" runat="server" />
        <input type="hidden" id="hidOldRowProp" runat="server" /> 
        <input type="hidden" id="hidOldRowTypeProp" runat="server" />
        <input type="hidden" id="hidEditBldg" runat="server" />
        <input type="hidden" id="hidOldRowBldg" runat="server" /> 
        <input type="hidden" id="hidOldRowTypeBldg" runat="server" />
    
        <table width="100%">
            <tr>
                <td style="width:52%">
                      <fieldset style="display:inline;">
            <legend style="font-weight:bold;">Properties</legend>
            
             <% Dim scrollPosURL As String = "ScrollPos.htc" %>
           
                    <div id="div1" style="BEHAVIOR: url(<%= ResolveURL(scrollPosURL)%>); OVERFLOW: auto; WIDTH: 98%; HEIGHT: 500px;" 
                    scrollPOS="<%= saveScrollPos.value %>" persistID="<%= saveScrollPos.UniqueID %>">
                             
                    <asp:GridView ID="gvProps" runat="server" AutoGenerateColumns="False"  ShowHeader="true"  DataKeyNames="PropId" 
                        DataSourceID="SqlDataSource1"     EnableViewState="true" RowStyle-CssClass="regrow" AlternatingRowStyle-CssClass="altrow" >
                                
                        <Columns>
                           
                            <asp:BoundField DataField="PropId"  HeaderStyle-CssClass="noShow" ItemStyle-Width="0px" ItemStyle-CssClass="noShow"  />
                          
                                          
                            <asp:TemplateField ItemStyle-Width="221px" HeaderStyle-CssClass="headrow" >
                                <HeaderTemplate>Property</HeaderTemplate>
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "PropName")%>        
                                </ItemTemplate>
                                <EditItemTemplate >
                                       <asp:TextBox ID="txtPropName" runat="server" Width="217px" Text='<%#DataBinder.Eval(Container.DataItem, "PropName")%>'></asp:TextBox> 
                                </EditItemTemplate>
                            </asp:TemplateField>
                            
                          <asp:TemplateField ItemStyle-Width="55px" HeaderStyle-CssClass="headrow" >
                                <HeaderTemplate>RMPROPID</HeaderTemplate>
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "RMPROPID")%>        
                                </ItemTemplate>
                                <EditItemTemplate >
                                       <asp:TextBox ID="txtRMPROPID" runat="server" Width="50px" Text='<%#DataBinder.Eval(Container.DataItem, "RMPROPID")%>'></asp:TextBox> 
                                </EditItemTemplate>
                            </asp:TemplateField>
                            
                          
                           
                            <asp:TemplateField ItemStyle-Width="92px" ItemStyle-HorizontalAlign="right" HeaderStyle-CssClass="headrow">
                                 <HeaderTemplate></HeaderTemplate>
                                 <ItemTemplate>
                                    <asp:Button ID="btnDeleteItem"  runat="server" Text="Delete" Width="48px" style=" height:19px;" OnClientClick="return DeleteItem();" OnCommand="btnDeleteItem_Click" CommandArgument='<%#DataBinder.Eval(Container.DataItem, "propid")%>'  />
                                       
                                </ItemTemplate>
                                <EditItemTemplate >
                                    <asp:Button ID="btnSaveItem"  runat="server" Text="Save" Width="38px" style=" height:19px;" OnCommand="btnSaveItem_Click"  />
                                    <asp:Button ID="btnCancelItem"  runat="server" Text="Cancel" Width="45px" style=" height:19px;" OnCommand="btnCancelItem_Click" />
                                </EditItemTemplate>
                            </asp:TemplateField>    
                        </Columns>
                    </asp:GridView>
                     </div>   
                     <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="">
                        </asp:SqlDataSource>
                        
        </fieldset>
                </td>
                <td style="width:4%">&nbsp;</td>
                <td style="width:44%">
                 <fieldset runat="server" id="divBldgs" visible="false" style="display:inline;">
            <legend style="font-weight:bold;">Bldgs</legend>
            
                     <% Dim scrollPosURL As String = "ScrollPos.htc" %>
                    <div id="div2" style="BEHAVIOR: url(<%= ResolveURL(scrollPosURL)%>); OVERFLOW: auto; WIDTH: 98%; HEIGHT: 410px;" 
                    scrollPOS="<%= saveScrollPos2.value %>" persistID="<%= saveScrollPos2.UniqueID %>">
                             
                    <asp:GridView ID="gvBldgs" runat="server" AutoGenerateColumns="False"  ShowHeader="true"  DataKeyNames="BldgId" 
                        DataSourceID="SqlDataSource2"     EnableViewState="true" RowStyle-CssClass="regrow" AlternatingRowStyle-CssClass="altrow" >
                                
                        <Columns>
                           
                            <asp:BoundField DataField="BldgId"  HeaderStyle-CssClass="noShow" ItemStyle-Width="0px" ItemStyle-CssClass="noShow"  />
                          
                                          
                            <asp:TemplateField ItemStyle-Width="162px" HeaderStyle-CssClass="headrow" >
                                <HeaderTemplate>Bldg</HeaderTemplate>
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "BldgName")%>        
                                </ItemTemplate>
                                <EditItemTemplate >
                                       <asp:TextBox ID="txtBldgName" runat="server" Width="157px" Text='<%#DataBinder.Eval(Container.DataItem, "BldgName")%>'></asp:TextBox> 
                                </EditItemTemplate>
                            </asp:TemplateField>
                            
                          <asp:TemplateField ItemStyle-Width="55px" HeaderStyle-CssClass="headrow" >
                                <HeaderTemplate>RMBLDGID</HeaderTemplate>
                                <ItemTemplate>
                                    <%#DataBinder.Eval(Container.DataItem, "RMBLDGID")%>        
                                </ItemTemplate>
                                <EditItemTemplate >
                                       <asp:TextBox ID="txtRMBLDGID" runat="server" Width="50px" Text='<%#DataBinder.Eval(Container.DataItem, "RMBLDGID")%>'></asp:TextBox> 
                                </EditItemTemplate>
                            </asp:TemplateField>
                            
                          
                           
                            <asp:TemplateField ItemStyle-Width="92px" ItemStyle-HorizontalAlign="right" HeaderStyle-CssClass="headrow">
                                 <HeaderTemplate></HeaderTemplate>
                                 <ItemTemplate>
                                    <asp:Button ID="btnDeleteItemBldg"  runat="server" Text="Delete" Width="48px" style=" height:19px;" OnClientClick="return DeleteItem();" OnCommand="btnDeleteItemBldg_Click" CommandArgument='<%#DataBinder.Eval(Container.DataItem, "bldgid")%>'  />
                                       
                                </ItemTemplate>
                                <EditItemTemplate >
                                    <asp:Button ID="btnSaveItemBldg"  runat="server" Text="Save" Width="38px" style=" height:19px;" OnCommand="btnSaveItemBldg_Click"  />
                                    <asp:Button ID="btnCancelItemBldg"  runat="server" Text="Cancel" Width="45px" style=" height:19px;" OnCommand="btnCancelItemBldg_Click" />
                                </EditItemTemplate>
                            </asp:TemplateField>    
                        </Columns>
                    </asp:GridView>
                     </div>   
                     <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="">
                        </asp:SqlDataSource>
                        
        </fieldset>
                </td>
            </tr>
        </table>
      
        
     
       
    </form>
</body>
</html>
