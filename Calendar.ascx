<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Calendar.ascx.vb" Inherits="Calendar" EnableTheming="true" %>

<table cellspacing="0" cellpadding="0" border="0">
    <tr>
        <td><asp:TextBox ID="txtDate" runat="server" Width="60px"></asp:TextBox></td>
        <td><asp:Button ID="btnToggle" runat="server"  SkinID="btnCalendar" /></td>
    </tr>  

<tr>
    <td>
    <!-- used to fix ie bug that select lists show through divs - they don't show through iframes -->
  <iframe id="blockSelect"  runat="server" src="" scrolling="no" frameborder="0"
  style="position:absolute;width:130px;height:120px;border:none;z-index:0"></iframe>

    <div id="blockCalendar"  runat="server" style="position:absolute;z-index:1;">
        <table cellspacing="0" cellpadding="0" border="0">
            <tr>
                <td><asp:DropDownList ID="ddlMonth" runat="server" Width="80px" OnSelectedIndexChanged="Set_Calendar" AutoPostBack="True"/></td>
                <td><asp:DropDownList ID="ddlYear" runat="server" Width="50px" OnSelectedIndexChanged="Set_Calendar" AutoPostBack="True"/></td>
            </tr>
           <tr>
            <td colspan="2">
            <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="#999999"
                CellPadding="2" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="7pt"
                ForeColor="Black" Height="120px" Width="130px"
                 OnSelectionChanged="Calendar1_SelectionChanged" 
                 >
                <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                <SelectorStyle BackColor="#CCCCCC" />
                <WeekendDayStyle  />
                <OtherMonthDayStyle ForeColor="DimGray" BackColor="#0099ff" />
                <NextPrevStyle VerticalAlign="Bottom" />
                <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
            </asp:Calendar>
            </td>
           </tr> 
        </table>
      </div>
    </td>
</tr>
</table> 







