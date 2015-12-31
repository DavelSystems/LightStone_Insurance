<%@ Page Language="VB" AutoEventWireup="false" CodeFile="FindClaim.aspx.vb" Inherits="FindClaim" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <script type="text/javascript" src="calendar.js"></script>
<script type="text/javascript" src="calendar-en.js"></script>
<script type="text/javascript" src="calendar-setup.js"></script>

 
    <title>Find Claim</title>
 
    <meta http-equiv="Page-Exit" content="progid:DXImageTransform.Microsoft.GradientWipe(Duration=0,Transition=5)" />
 
   
    <LINK href="Mainstyle.css" type="text/css" rel="stylesheet" />
    <link href="Calendar.css" type="text/css" rel="stylesheet" />
    
    
    <script language="javascript" type="text/javascript">
    
           // var overLink = false;
            
            function init() 
			{
				parent.frames[0].SwitchBtn(parent.frames[0].FindClaim);
				//////eval(window.parent.frames[1].changebtn("AddReq"));
				//eval(top.MenuFrame.ReqBtn(top.MenuFrame.Permissions));
				shrinkDiv()
			}
			
    		function dgrdMouseOver(row,index)
			{
				if (index != form1.hidSelect.value)
				row.style.backgroundColor = getPropertyValueFromCss("overrow", "backgroundColor")
				//row.style.backgroundColor='Silver'
			}
			
			function dgrdMouseOut(row,index)
			{
				if (index != form1.hidSelect.value)
				row.style.backgroundColor = getPropertyValueFromCss("regrow", "backgroundColor")
				//row.style.backgroundColor='#CCCCCC'
				
			}
			
			function dgrdAltMouseOut(row,index)
			{
				
				if (index != form1.hidSelect.value)
				row.style.backgroundColor = getPropertyValueFromCss("altrow", "backgroundColor")
				//row.style.backgroundColor='#FFCC99'
		
			}
			
			function dgrdSelect(row,index)
			{
			  //  if(!overLink)
			        parent.frames[1].location = "Claim.aspx?ClaimId=" + row.id;
			}
			
			function NewClaim()
			{
			    parent.frames[1].location = "Claim.aspx?new=yes";
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
			
		
			
			function PageLink(loc)
			{
				//alert(loc);
				form1.hidBindDataGrid.value = 'False';
				
				form1.hidPageNum.value = loc;
				form1.submit();
				//__doPostBack(loc, '')
			}
			
			function shrinkDiv()
			{
				var table1 = document.getElementById("gridClaims");
						
				//alert(table1.offsetHeight);
				if(table1)
				{
					var height = table1.offsetHeight;
					if(height < 370)
					{
						document.getElementById('divGrid').style.height = table1.offsetHeight;
					}
					else
						document.getElementById('divGrid').style.height='370 px';
				}
				//else
				//	document.getElementById('divGrid').style.height = '50 px';
			}
</script>

</head>
<body onload="init();">
    <form id="form1" runat="server">
     <input id="hidSelect" type="hidden" name="hidSelect" runat="server" />
    <input id="hidPageNum" type="hidden" name="hidPageNum" runat="server"><input id="hidBindDataGrid" type="hidden" name="hidBindDataGrid" runat="server">
    
    
    <div>
        <table>
            <tr>
                <td class="labelText">
                    Claim #:
                </td>
                <td>
                    <asp:TextBox ID="txtClaimId" runat="server"></asp:TextBox>
                </td>
               
               <td class="labelText">
                    Claimant:
                </td>
                <td>
                    <asp:TextBox ID="txtClaimant" runat="server"></asp:TextBox>
                </td>
                <td class="labelText">
                    Property:
                </td>
                <td align="right">
                    
                        <asp:DropDownList ID="dropProperties" Width="250px"  runat="server">
                        <asp:ListItem></asp:ListItem>
                        </asp:DropDownList>
                    
                </td>
            </tr>
            <tr>
                
                 <td class="labelText">
                    Accident Start Date:
                </td>
                <td style="width:180px;">
                    <asp:TextBox ID="txtStartDate" runat="server"></asp:TextBox>
                    <input type="button" id="showCalendar1" class="btnCalendar"/>
                </td>
                 <td class="labelText">
                    End Date:
                </td>
                <td style="width:180px;">
                    <asp:TextBox ID="txtEndDate" runat="server"></asp:TextBox>
                    <input type="button" id="showCalendar2" class="btnCalendar"/>
                </td>
                
                <td class="labelText">
                    Status:
                </td>
                <td>
                    <asp:DropDownList ID="dropStatus" runat="server" Width="250px">
                        <asp:ListItem></asp:ListItem>
                        <asp:ListItem Value="Not Submitted" Text="Not Submitted"></asp:ListItem>
                        <asp:ListItem Value="Submitted" Text="Submitted"></asp:ListItem>
                        <asp:ListItem Value="Reviewed" Text="Reviewed"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                 <td colspan="6" align="right">
                    <asp:Button ID="btnSearch" Text="Search" runat="server" />
                    &nbsp;
                    &nbsp;
                    <input id="btnNewClaim" type="button" value="New Claim" onclick="NewClaim();" />
                </td>
            </tr>
        </table>
        
        
    <table width="98%">
        <tr>
            <td  align="center">
                <br />
                    <asp:label id="lblItemCount" Runat="server" Font-Size="smaller" ForeColor="#3366ff" Font-Bold="True"></asp:label>
					<asp:label id="lblNoMatches" Runat="server" Font-Size="smaller" ForeColor="#ff3333" Font-Bold="True" text="No Results Found."
							Visible="False"></asp:label>
					<div id="divGrid" style="OVERFLOW: auto; WIDTH: 100%; HEIGHT: 370px; border:1px solid black;" >	
					    <table cellSpacing="0" cellPadding="0" width="98%">
					        <tr style="CURSOR: hand">
					            <td style="CURSOR: hand" align="center">
                                     <asp:datagrid id="gridClaims" Runat="server" CssClass="grid" width="100%" OnItemDataBound="gridClaims_ItemDataBound" OnItemCreated="gridClaims_ItemCreated"
			                            DataKeyField="ClaimId" AllowCustomPaging="True" AllowPaging="True" PageSize="50" OnPageIndexChanged="gridClaims_PageIndexChanged" 
			                            PagerStyle-Mode="NumericPages" PagerStyle-HorizontalAlign="Center" AutoGenerateColumns="False" Height="100%" PagerStyle-Visible="false" ShowHeader= "True" enableviewstate="false">
			                            <SelectedItemStyle CssClass="selrow"></SelectedItemStyle>
			                            <AlternatingItemStyle CssClass="altrow"></AlternatingItemStyle>
			                            <ItemStyle CssClass="regrow"></ItemStyle>
			                            <HeaderStyle CssClass="headrow"></HeaderStyle>
			                            
				                    <Columns>
				                            <asp:BoundColumn DataField="ClaimId" HeaderText="Claim #" ItemStyle-Width="60px"></asp:BoundColumn>
				                            <asp:BoundColumn DataField="Claimant" HeaderText="Claimant"></asp:BoundColumn>
				                            <asp:BoundColumn DataField="Propname" HeaderText="Property" ></asp:BoundColumn>
				                            <asp:BoundColumn DataField="Bldgname" HeaderText="Bldg"></asp:BoundColumn>
				                            <asp:BoundColumn DataField="location" HeaderText="location"  ></asp:BoundColumn>
				                            <asp:BoundColumn DataField="AccidentDate" HeaderText="Accident Date" ItemStyle-Width="105px"></asp:BoundColumn>
				                            <asp:BoundColumn DataField="dateSubmitted" HeaderText="Submitted" ItemStyle-Width="70px"></asp:BoundColumn>
				                            <asp:BoundColumn DataField="UserName" HeaderText="User Name" ItemStyle-Width="90px"></asp:BoundColumn>
				                            <asp:BoundColumn DataField="Status" HeaderText="Status" ItemStyle-Width="85px"></asp:BoundColumn>
            				               
			                            </Columns>
			                            <PagerStyle HorizontalAlign="Center" Mode="NumericPages" CssClass="gridpager"></PagerStyle>
		                            </asp:datagrid>
		                        </td>
		                    </tr>
		                </table>
		            </div>	
		            <div align="center" style="DISPLAY: inline; WIDTH: 74%;">
						<asp:table id="PagerTable" Runat="server" Width="100%" name="PagerTable" CellPadding="0" CellSpacing="0"
							enableviewstate="false" style="font-weight:bold; font-size:smaller;">
							<asp:TableRow Runat="server" ID="Tablerow1">
								<asp:TableCell Runat="server" ID="Tablecell1"></asp:TableCell>
							</asp:TableRow>
						</asp:table>
					</div>
                </td>
            </tr>
        </table>
       
       
     
       
    </div>
       
      
    </form>
    
    <script type="text/javascript">
      Calendar.setup(
        {
          inputField  : "txtStartDate",      // ID of the input field
          button      : "showCalendar1"      // ID of the button
        }
      );
      Calendar.setup(
        {
          inputField  : "txtEndDate",      // ID of the input field
          button      : "showCalendar2"      // ID of the button
        }
      );
     
     
</script>
</body>
</html>
