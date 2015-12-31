<%@ Page Language="VB" AutoEventWireup="false" CodeFile="UserAdmin.aspx.vb" Inherits="UserAdmin" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <script language="javascript">
        var c;
			var dClick=0;
			var blnWait; 
			var blnRefresh = false;
			
			var form_dirty = false;
			var warn_onunload = true;	
			window.onbeforeunload = warn_if_form_dirty;
			
			function init() 
			{
				parent.frames[0].SwitchBtn(parent.frames[0].UserAdmin);
				//////eval(window.parent.frames[1].changebtn("AddReq"));
				//eval(top.MenuFrame.ReqBtn(top.MenuFrame.Permissions));
			}
			
			
			function warn_if_form_dirty()
			{
				////form_dirty = true;
				form.txtUserName.blur();
				form.txtUserName.focus();
				form.txtUserName.blur();
				
				//alert('warn_onunload: ' + warn_onunload + ' dirty: ' + form_dirty);
				if(warn_onunload == true && form_dirty == true)// && form.hidRptSelect.value.length > 0 && form.hidRptSelect.value != '-1')
				{	//eval(parent.frames[0].SwitchBtn(UserAdmin));
				   // top.frames[0].SwitchBtn(UserAdmin);
				    parent.frames[0].SwitchBtn(parent.frames[0].UserAdmin);
				    //parent.frames[0].UserAdmin.className = "ActiveMenu";;
				
					//return (confirm('Warning: all changes that you have made will be lost! \n Do you want to Proceed?'))
					return "You have not saved information for this User.";
				}
			}	
			
			function ResetWarn_Unload()
			{
				warn_onunload = true;
				form_dirty = true
				//alert("hi");
			}
			
			function WarnNotSaved()
			{
			    warn_onunload = false;
			    //form_dirty = false;
			    
				if(form_dirty == true)
				{
					if(confirm('You have not saved information for this User.\n Do you want to continue?'))
						{
							return true;
						}
						else
						{
						    warn_onunload = false;
							return false;
				        }
				}
				else
					return true;
			}
			
			function MouseOver(row,index)
			{
				if (index != form.hidRptSelect.value)
				row.style.backgroundColor = getPropertyValueFromCss("overrow", "backgroundColor")
				//row.style.backgroundColor='Silver'
			}
			
			function MouseOut(row,index)
			{
				if (index != form.hidRptSelect.value)
				row.style.backgroundColor = getPropertyValueFromCss("regrow", "backgroundColor")
				//row.style.backgroundColor='#CCCCCC'
				
			}
			
			function AltMouseOut(row,index)
			{
				
				if (index != form.hidRptSelect.value)
				row.style.backgroundColor = getPropertyValueFromCss("altrow", "backgroundColor")
				//row.style.backgroundColor='#FFCC99'
		
			}
		
			function Rpt_Click(row,index,type,userName)
			{
				if(row.id.length > 0)
				{
					//Cancel();
					
					if (!(form.hidRptSelect.value.length > 0 && form.hidRptSelect.value != "-1" && !WarnNotSaved()))
					{
						if (form.hidRptOldRowType.value != "")
						{
						
							if(form.hidRptOldRowType.value == "Alt")
							{
								if (document.getElementById(form.hidRptSelect.value))
								{
									document.getElementById(form.hidRptSelect.value).className="altrow";
									document.getElementById(form.hidRptSelect.value).style.backgroundColor=getPropertyValueFromCss("altrow", "backgroundColor");
								}
							}
							else
							{
								if (document.getElementById(form.hidRptSelect.value))
								{
									document.getElementById(form.hidRptSelect.value).className="regrow";
									document.getElementById(form.hidRptSelect.value).style.backgroundColor=getPropertyValueFromCss("regrow", "backgroundColor");
								}
							}
						}
					
						if(index == form.hidRptSelect.value)
						{
							//Uncheck();
							
							form.hidRptSelect.value = -1;
							if(type == "Alt")
								row.className="altrow";
								//row.style.backgroundColor=getPropertyValueFromCss("altrow", "backgroundColor");
							else
								row.className="regrow";
								//row.style.backgroundColor=getPropertyValueFromCss("regrow", "backgroundColor");	
								
							form.hidRptOldRow.value = "";
							form.hidRptOldRowType.value = "";
							
							
							//document.getElementById("btnSelect").disabled = true;
							
							//form.hidItemNum.value = ""
							//form.btnOrderHistory.disabled = true;
							
							///document.getElementById("divEdit").style.display = "none";
							//document.getElementById("divAdd").style.display = "";
							
							document.getElementById("btnCancel").click();
							
						}
						else
						{			
							form.hidRptSelect.value = index;
							row.className="selrow";
							row.style.backgroundColor=getPropertyValueFromCss("selrow", "backgroundColor");
							form.hidRptOldRow.value = userName; // row.id;
							form.hidRptOldRowType.value = type;
							//document.getElementById("btnSelect").disabled = false;
							
							form.hidRptSelectFlag.value = "True";	
							UnSelectAssignedProp();		
							
							document.getElementById("divEdit").style.display = "";
							document.getElementById("divAdd").style.display = "none";
																
							form.submit();
						}	
					}		
					
				
				}	
					//Cancel();
				////form.btnFake.click(");
															
			}
			
			function Keep()
			{	
				if (form.hidRptSelect.value != "")
				{
					if(document.getElementById(form.hidRptSelect.value))
					{
						document.getElementById(form.hidRptSelect.value).className="selrow"				
						document.getElementById(form.hidRptSelect.value).style.backgroundColor=getPropertyValueFromCss("selrow", "backgroundColor");
					//form.btnDetails.disabled = false;				
					//form.btnSelect.disabled = false;
					   
					}
					
				    document.getElementById("divEdit").style.display = "";
					document.getElementById("divAdd").style.display = "none";
				}
				else
				{
				    document.getElementById("divEdit").style.display = "none";
					document.getElementById("divAdd").style.display = "";
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
			
			function moveprop()
            {
	            val = event.srcElement.value;
	            selelem = document.all("listProps");
	            selassign = document.all("listAssignedProps")
            	
	            if (val == ">" || val==">>") {
            	
		            for (i=0; i<selelem.options.length; i++) {
            			
			            if (selelem.options(i).selected==true || val==">>") {
				            if (alreadyin(selelem.options(i).text))
					            continue;			
				            oOption = document.createElement("OPTION");
				            oOption.text = selelem.options(i).text;
				            oOption.value = selelem.options(i).value;
				            selassign.add(oOption);
				            
				            form.hidNewItems.value = form.hidNewItems.value + selelem.options(i).text + ":" + selelem.options(i).value + "~";
				            
			            }
            			
		            }			
	            }
	            else {
		            for (i=0; i<selassign.options.length; i++) {
			            if (selassign.options(i).selected==true || val=="<<") {
			            
			                form.hidDeleteItems.value = form.hidDeleteItems.value + selassign.options(i).text + ":" + selassign.options(i).value + "~";
				            
				            selassign.remove(i);
				            
				            
				            i--;
			            }
		            }
	            }
            	
	            selelem.selectedIndex = -1
	            selassign.selectedIndex = -1
	            
	            //alert(form.hidDeleteItems.value);
	            
	            form_dirty = true;
            }

            function alreadyin(val)
            {
	            selassign = document.all("listAssignedProps");
	            for (j=0; j<selassign.options.length; j++)
		            if (selassign.options(j).text == val) 
			            return true;
            		
	            return false;
            }

            function UnSelectAssignedProp()
            {
                document.all("listAssignedProps").selectedIndex = -1;
            }
            
            function Validate()
            {
                if(document.getElementById("txtNewUserId").value.length == 0)
                {
                    alert("Please Enter a User ID before saving.");
                    return false;
                }
                if(document.getElementById("txtPassword").value.length == 0)
                {
                    alert("Please Enter a Password before saving.");
                    return false;
                }
                if(document.getElementById("txtPassword").value != document.getElementById("txtPassword1").value)
                {
                    alert("The passwords you have entered do not match. Please try again.");
                    return false;
                }
               
           
                 warn_onunload=false;
                 return true;
                
            }
            
            function RemoveUser()
            {
                if(!confirm('This user will be permanently deleted.\nAre you sure you want to continue?')) 
                    return false; 
                else
                {
                    UnSelectAssignedProp();
                    warn_onunload=false;
                    return true;
                }
            }
            
            var propsChanged = false;
            
            function AddEditProps()
            {
                locstr = "AddEditProps.htm"
	            var stringopt = 'dialogHeight:700px; dialogWidth:860px;dialogTop:200px;status:no';
	            retval = window.showModalDialog(locstr,self,stringopt);
	            
	            return propsChanged;
            }
    </script>

    <title>User Admin</title>
    <meta http-equiv="Page-Exit" content="progid:DXImageTransform.Microsoft.GradientWipe(Duration=0,Transition=5)" />
    <link href="StyleSheet.css" type="text/css" rel="stylesheet" />
    <link href="Mainstyle.css" type="text/css" rel="stylesheet" />
</head>
<body onload="init();Keep();">
    <form id="form" runat="server">
    <input id="hidRptOldRowType" type="hidden" name="hidRptOldRowType" runat="server"><input
        id="hidRptOldRow" type="hidden" name="hidRptOldRow" runat="server">
    <input id="hidRptSelectFlag" type="hidden" name="hidRptSelectFlag" runat="server"><input
        id="hidRptSelect" type="hidden" runat="server"><input id="saveScrollPos" type="hidden"
            name="saveScrollPos" runat="server">
    <input id="hidNewItems" type="hidden" runat="server" />
    <input id="hidDeleteItems" type="hidden" runat="server" />
    <div>
        <table cellpadding="5">
            <tr>
                <td valign="top">
                    <table>
                        <tr>
                            <td class="labelText">
                                Name:
                            </td>
                            <td>
                                <asp:TextBox ID="txtUserName" Width="130px" runat="server"></asp:TextBox>
                            </td>
                            <td style="width: 65px" class="labelText">
                                User Id:
                            </td>
                            <td>
                                <asp:TextBox ID="txtUserId" Width="90px" runat="server"></asp:TextBox>
                            </td>
                            <td>
                                <asp:Button ID="btnSearch" runat="server" Text="Search"></asp:Button>
                            </td>
                        </tr>
                        <tr>
                            <td width="100%" colspan="5">
                                <% Dim scrollPosURL As String = "ScrollPos.htc"%>
                                <div align="center" style="behavior: url(<%= ResolveURL(scrollPosURL)%>); overflow: auto;
                                    width: 100%; height: 250px" scrollpos="<%= saveScrollPos.value %>" persistid="<%= saveScrollPos.UniqueID %>">
                                    <asp:Label ID="lblNoResults" runat="server" ForeColor="Red" Visible="False">No Results Found.</asp:Label><asp:Label
                                        ID="lblCount" runat="server"></asp:Label>
                                    <table class="grid" id="RptTable" cellspacing="0" cellpadding="2" width="100%">
                                        <asp:Repeater ID="rptUsers" runat="server">
                                            <HeaderTemplate>
                                                <thead class="headrow">
                                                    <tr>
                                                        <th align="left" style="width: 60%;">
                                                            User Name
                                                        </th>
                                                        <th align="left">
                                                            User Id
                                                        </th>
                                                    </tr>
                                                </thead>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <tr id="<%#  rptUsers.Items.Count()%>" class="regrow" onmouseover="MouseOver(this,'<%#  rptUsers.Items.Count()%>')"
                                                    onmouseout="MouseOut(this,'<%#  rptUsers.Items.Count()%>')" onclick="Rpt_Click(this,'<%#  rptUsers.Items.Count()%>','Reg','<%# DataBinder.Eval(Container.DataItem, "UserName")%>');">
                                                    <td align="left">
                                                        <%# Container.DataItem("Name") %>
                                                    </td>
                                                    <td align="left">
                                                        <%# Container.DataItem("UserName") %>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                            <AlternatingItemTemplate>
                                                <tr id="<%#  rptUsers.Items.Count()%>" class="altrow" onmouseover="MouseOver(this,'<%#  rptUsers.Items.Count()%>')"
                                                    onmouseout="AltMouseOut(this,'<%#  rptUsers.Items.Count()%>')" onclick="Rpt_Click(this,'<%#  rptUsers.Items.Count()%>','Alt','<%# DataBinder.Eval(Container.DataItem, "UserName")%>');">
                                                    <td align="left">
                                                        <%# Container.DataItem("Name") %>
                                                    </td>
                                                    <td align="left">
                                                        <%# Container.DataItem("UserName") %>
                                                    </td>
                                                </tr>
                                            </AlternatingItemTemplate>
                                        </asp:Repeater>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
                <td valign="top">
                    <table>
                        <tr>
                            <td align="center" class="labelText" style="text-align: center; vertical-align: bottom;">
                                Properties &nbsp;
                                <asp:Button ID="btnEditProps" runat="server" Text="..." OnClientClick="return AddEditProps();" />
                            </td>
                            <td>
                            </td>
                            <td align="center" class="labelText" style="text-align: center; vertical-align: bottom;">
                                Assigned
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:ListBox ID="listProps" runat="server" Width="230px" Height="220px" SelectionMode="multiple">
                                </asp:ListBox>
                            </td>
                            <td>
                                <table>
                                    <tr>
                                        <td>
                                            <input type="button" style="width: 32px; height: 32px;" value="&gt;" onclick="moveprop()" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <input type="button" style="width: 32px; height: 32px" value="&lt;" onclick="moveprop()" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <input type="button" style="width: 32px; height: 32px" value=">>" onclick="moveprop()" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <input type="button" style="width: 32px; height: 32px" value="<<" onclick="moveprop()" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td>
                                <asp:ListBox ID="listAssignedProps" runat="server" Width="230px" Height="220px" SelectionMode="multiple">
                                </asp:ListBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <fieldset style="width: 95%;">
                        <legend style="font-weight: bold;">User Details </legend>
                        <table cellpadding="3">
                            <tr>
                                <td style="width: 85px; vertical-align: baseline;" class="labelText">
                                    User Name:
                                </td>
                                <td style="width: 165px">
                                    <asp:TextBox ID="txtNewUserName" Width="150px" runat="server"></asp:TextBox>
                                </td>
                                <td style="width: 65px; vertical-align: baseline;" class="labelText">
                                    User Id:
                                </td>
                                <td style="width: 145px">
                                    <asp:TextBox ID="txtNewUserId" Width="130px" runat="server"></asp:TextBox>
                                </td>
                                <td style="width: 85px; vertical-align: baseline;" class="labelText">
                                    User Level:
                                </td>
                                <td>
                                    <asp:DropDownList ID="dropUserLevel" runat="server">
                                        <asp:ListItem Value="1" Text="User" Selected="true"></asp:ListItem>
                                        <asp:ListItem Value="2" Text="Manager"></asp:ListItem>
                                        <asp:ListItem Value="3" Text="Administrator"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td style="width: 60px; vertical-align: baseline;" class="labelText">
                                    Email:
                                </td>
                                <td style="width: 125px">
                                    <asp:TextBox ID="txtEmail" Width="120px" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelText" style="vertical-align: baseline;">
                                    Password:
                                </td>
                                <td>
                                    <asp:TextBox ID="txtPassword" runat="server" TextMode="password" Width="150px"></asp:TextBox>
                                </td>
                                <td colspan="4" class="labelText" style="vertical-align: baseline;">
                                    <div id="divPassword1" style="display: none; text-align: left;">
                                        Re-Type Password: &nbsp;
                                        <asp:TextBox ID="txtPassword1" runat="server" TextMode="password" Width="150px"></asp:TextBox>
                                    </div>
                                </td>
                                
                                <td colspan ='2' align='right'>
                                    <asp:CheckBox ID="cbShowAdmin" runat="server" Text="Allow User Admin" CssClass="labelText" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="8" align="right">
                                    <div id="divAdd">
                                        <asp:Button ID="btnAddNew" runat="server" Text="Create New" CommandName="New" OnCommand="Save">
                                        </asp:Button>
                                    </div>
                                    <div id="divEdit" style="display: none;">
                                        <asp:Button ID="btnEditNew" runat="server" Text="Create New" CommandName="New" OnCommand="Save">
                                        </asp:Button>
                                        <asp:Button ID="btnUpdate" runat="server" Text="Update" CommandName="Update" OnCommand="Save">
                                        </asp:Button>
                                        <asp:Button ID="btnRemove" runat="server" Text="Remove" CommandName="Remove" OnCommand="Save">
                                        </asp:Button>
                                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CommandName="Cancel" OnCommand="Save">
                                        </asp:Button>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
