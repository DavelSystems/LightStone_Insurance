<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Reports.aspx.vb" Inherits="Reports" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
  <title>Generate Reports </title>
  <link href="Mainstyle.css" type="text/css" rel="stylesheet"/>
  <link href="Calendar.css" type="text/css" rel="stylesheet" />
  <script type="text/javascript" src="calendar.js"></script>
  <script type="text/javascript" src="calendar-en.js"></script>
  <script type="text/javascript" src="calendar-setup.js"></script>
  
  <script type="text/javascript" language="javascript">
   
     function init() 
	{
	    parent.frames[0].SwitchBtn(parent.frames[0].Reports);
	}
			
//		
//     function moveProp()
//     //Moves property into and out of the assigned properties list
//     {
//        val = event.srcElement.value;
//        selelem = document.all("listProp");
//        selassign = document.all("listAssignedProp")
//        	
//       
//        if (val == "4" || val=="8") //">" or ">>"
//        {
//	        for (i=0; i<selelem.options.length; i++) 
//	        {
//		      if (selelem.options(i).selected==true || val=="8") 
//		      {
//			     if (alreadyin(selelem.options(i).text))
//				     continue;			
//			     oOption = document.createElement("OPTION");
//			     oOption.text = selelem.options(i).text;
//			     oOption.value = selelem.options(i).value;
//			     selassign.add(oOption);
//			            
//			     form1.hidNewItems.value = form1.hidNewItems.value + selelem.options(i).text + ":" + selelem.options(i).value + "~";
//			            
//		       }
//        			
//	        }			
//           }
//         else 
//         {
//	        for (i=0; i<selassign.options.length; i++) // "<" or "<<"
//	        {
//		        if (selassign.options(i).selected==true || val=="7") 
//		        {
//		           form1.hidDeleteItems.value = form1.hidDeleteItems.value + selassign.options(i).text + ":" + selassign.options(i).value + "~";
//			       selassign.remove(i);		            
//			       i--;
//		        }
//	        }
//         }
//        	
//        selelem.selectedIndex = -1
//        selassign.selectedIndex = -1
//            
//     }

//    function alreadyin(val)
//    //Checks if property is already assigned
//    {
//       selassign = document.all("listAssignedProp");
//       for (j=0; j<selassign.options.length; j++)
//	        if (selassign.options(j).text == val) 
//		        return true;
//       return false;
//    }
//    
//   
//    
   function Validate()
    {
        var fromdate = document.getElementById("fromdate");
        var todate = document.getElementById("todate");
       
////        var assign = document.all("ddlprop");
////        if(assign.options.length == 0)
////        {
////            alert("Please select at least 1 property.");
////            return false;
////        }
       if(!ValidDate(fromdate.value) && fromdate.value.length > 0  )
		    {
		        alert("Please input a valid start date.");
			    fromdate.focus();
    			    
			    return false; //doesn't match pattern, bad due date
		   }
       if(!ValidDate(todate.value) && todate.value.length > 0 )
		    {
		        alert("Please input a valid end date.");
			    todate.focus();
    			    
			    return false; //doesn't match pattern, bad due date
		   }
        return true;
   }
 
    function ValidDate(strDate)
		{
			var objRegExp = /^\d{1,2}(\-|\/|\.)\d{1,2}(\-|\/|\.)(\d{4}|\d{2})$/;
			
			//check to see if in correct format
			//alert(date1);
			// alert(time1);
			if(!objRegExp.test(strDate))
			{
				//alert("Please input a valid Date.");
				return false; //doesn't match pattern, bad date
			}
			else
			{
				//var strSeparator = strDate.substring(1,3) //find date separator
				
				//var arrayDate = strDate.split(strSeparator); //split date into month, day, year
				var arrayDate = strDate.split(/\D/);
				if(arrayDate[0].length ==1)
					arrayDate[0] = "0" + arrayDate[0];
				//create a lookup for months not equal to Feb.
				var arrayLookup = { '01' : 31,'03' : 31, '04' : 30,'05' : 31,'06' : 30,'07' : 31,
									'08' : 31,'09' : 30,'10' : 31,'11' : 30,'12' : 31}
				//var intDay = parseInt(arrayDate[1]);
				var intDay = arrayDate[1];
				//alert(intDay);
				//check if month value and day value agree
				if(arrayDate[0] >12 || arrayDate[0] < 1)
				{
					//alert("Please input a valid Date.");
					return false;
				}//alert('hi');
				if(arrayLookup[arrayDate[0]] != null) 
				{
				if(intDay <= arrayLookup[arrayDate[0]] && intDay > 0){
				
					return true; //found in lookup table, good date
					}
				}

				//check for February
				var intYear = parseInt(arrayDate[2],10);
				var intMonth = parseInt(arrayDate[0],10);
				
				if(((intYear % 4 == 0 && intDay <= 29) || (intYear % 4 != 0 && intDay <=28)) && intDay !=0)
					return true; //Feb. had valid number of days
			
				//alert("Please input a valid Date.");
				return false; //any other values, bad date
			}				
		
		}
		
    function GenerateReport()
	{	       
	    if(!Validate())
	        return false;
	   //get values
	    var fromdate = document.getElementById("fromdate").value;
        var todate = document.getElementById("todate").value;
        var props = document.getElementById("ddlprop").value;
        var bldg = document.getElementById("ddlbuilding").value;
        var loc = document.getElementById("ddlxctloc").value;
        var inctype = document.getElementById("ddltype").value;
        var tpa = document.getElementById("chbxtpa").checked;
        var lit = document.getElementById("chbxlit").checked;
        var car = document.getElementById("Chbxcar").checked;
        var stat = "";
        
        var notSubmitted = document.getElementById("chkStatus_0").checked;
        var submitted = document.getElementById("chkStatus_1").checked;
        var reviewed = document.getElementById("chkStatus_2").checked;
        
        var report = document.all("ddlreportlist").value;
        
	    var strLoc = "ReportsPopUp.aspx?prop=" + props + "&bldg=" + bldg + "&loc=" + loc + "&inctype=" + inctype + "&tpa=" + tpa + "&lit=" + lit + "&car=" + car + "&stat=" + stat + "&fromdate=" + fromdate + "&todate=" + todate + "&report=" + report;
	    strLoc += "&notSubmitted=" + notSubmitted + "&Submitted=" + submitted + "&Reviewed=" + reviewed;
	    
	    //alert(strLoc)
	    var returnPrint = window.open(strLoc, "Reports","location=0,menubar=0,height=700px,width=940px,top=0,left=40,resizable, scrollbars=yes;");
	}
	  
    </script>
</head>
<body onload="init();">
    <form id="form1" runat="server">
        <br />
        <input id="hidNewItems" type="hidden" runat="server" />
        <input id="hidDeleteItems" type="hidden" runat="server" />&nbsp;
        <table style="width: 534px; height: 235px">
        <tr><td></td></tr>
      
           <tr>
           <td  class="labelText" style="vertical-align: baseline;" >Select Report: </td>
               <td> <asp:DropDownList ID="ddlreportlist" runat="server" Width="219px">
                <asp:ListItem Value="claimlist">Claim List</asp:ListItem> </asp:DropDownList></td>
            </tr>
           
            
             <tr><td style="height: 39px">&nbsp;</td></tr>

                <tr>
                    <td class="labelText" style="vertical-align: baseline;" >
                        Property:</td>
                    <td >
                        <asp:DropDownList ID="ddlprop" runat="server" Width="272px" AutoPostBack="True">
                        </asp:DropDownList>
                    </td>
                    <!--<td>
                        <asp:Button ID="buttonViewAll" runat="server" Text="View All" OnClientClick="GenerateEntireReport();"/>
                    </td>-->
                </tr>
                
                <tr>
                    <td class="labelText" style="vertical-align: baseline" valign="middle" >
                       Building:
                    </td>
                    <td class="labelText" style="text-align:left;">
                    <asp:DropDownList ID="ddlbuilding" runat="server" Width="272px" AutoPostBack="True">
                    </asp:DropDownList>
                   </td>
                </tr>  
                
                <tr>
                    <td class="labelText" style="vertical-align: baseline" valign="middle" >
                       Exact Location:
                    </td>
                    <td class="labelText" style="text-align:left;">
                    <asp:DropDownList ID="ddlxctloc" runat="server" Width="272px">
                        </asp:DropDownList>
                   </td>
                </tr> 
                   
                <tr><td>&nbsp;</td></tr>
                
                <tr>
                    <td class="labelText" style="vertical-align: baseline" valign="middle" >
                       Type of Incident:
                    </td>
                    <td class="labelText" style="text-align:left;">
                    <asp:DropDownList ID="ddltype" runat="server" Width="120px">
                        </asp:DropDownList>
                   </td>
                </tr> 
                
                <tr><td>&nbsp;</td></tr>
                
                <tr>
                    <td class="labelText" style="vertical-align: baseline" valign="middle" >
                       Claims Submitted to TPA:
                    </td>
                    <td class="labelText" style="text-align:left;">
                        <asp:CheckBox ID="chbxtpa" runat="server" />
                   </td>
                </tr> 
                <tr>
                    <td class="labelText" style="vertical-align: baseline" valign="middle" >
                       Claims in Litigation:
                    </td>
                    <td class="labelText" style="text-align:left;">
                        <asp:CheckBox ID="chbxlit" runat="server" />
                   </td>
                </tr> 
                <tr>
                    <td class="labelText" style="vertical-align: baseline" valign="middle" >
                       Claims Reported to Carrier:
                    </td>
                    <td class="labelText" style="text-align:left;">
                        <asp:CheckBox ID="Chbxcar" runat="server" />
                   </td>
                </tr> 
        
                <tr><td>&nbsp;</td></tr>
        
                <tr>
                    <td class="labelText" style="vertical-align: baseline" valign="middle"  >
                        Status:
                    </td>
                    <td class="labelText" style="text-align:left;" >
                        <asp:CheckBoxList ID="chkStatus" runat="server" RepeatLayout="flow" RepeatDirection="horizontal">
                            <asp:ListItem Value="Not Submitted" Text="Not Submitted"></asp:ListItem>
                            <asp:ListItem Value="Submitted" Text="Submitted" Selected="true"></asp:ListItem>
                            <asp:ListItem Value="Reviewed" Text="Reviewed" Selected="true"></asp:ListItem>
                            
                        </asp:CheckBoxList>
                    
                    </td>
                </tr>
                 
                
                <tr><td>&nbsp;</td></tr>
                <tr>
                    <td class="labelText" style="vertical-align: baseline" valign="middle" >
                       From:
                    </td>
                <td class="labelText" style="text-align:left;">
                
                   <asp:TextBox ID="fromdate" Width="70px" runat="server"/><input type="button" id="showFromCalendar" class="btnCalendar"/>
                    &nbsp; To:
                    <asp:TextBox ID="todate" Width="70px" runat="server"/><input type="button" id="showToCalendar" class="btnCalendar"/>
                </tr>
                           
                <%--<tr>
                    <td class="labelText" style="vertical-align: baseline;">
                        Status:</td>
                        
                         <td>
                    <asp:DropDownList ID="ddlstatus" runat="server" Width="219px">
                    </asp:DropDownList>
                </td>
                </tr>--%>
              
          
             <tr><td>&nbsp;</td></tr>
              
            <tr>
                <td colspan="2" style="height: 39px">
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                <asp:Button ID="buttonReport" style="margin-left: 140px;" runat="server" Text="Generate Report" OnClientClick="GenerateReport(); return false;" />
                    
                    </td>
            </tr>
            <tr>
                <td colspan="2" style="height: 39px">
                </td>
            </tr>
            </table>
            
     
       
        <script type="text/javascript">
        Calendar.setup(
        {
          inputField  : "fromDate",      // ID of the input field
          button      : "showFromCalendar",      // ID of the button
          align       : "Br"
        }
      );
    </script>
    <script type="text/javascript">
        Calendar.setup(
        {
          inputField  : "toDate",      // ID of the input field
          button      : "showToCalendar",      // ID of the button
          align       : "Br"
        }
      );


    </script>
    </form>
</body>
</html>
