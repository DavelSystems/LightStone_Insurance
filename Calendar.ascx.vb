
Partial Class Calendar
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        Calendar1.ShowTitle = False

        'Populate month and year dropdown list boxes which
        'replace the original calendar title
        If Not Page.IsPostBack Then
            blockCalendar.Visible = False
            blockSelect.Visible = False
            Call Populate_MonthList()
            Call Populate_YearList()
        End If

    End Sub

    Sub Populate_MonthList()

        ddlMonth.Items.Add("January")
        ddlMonth.Items.Add("February")
        ddlMonth.Items.Add("March")
        ddlMonth.Items.Add("April")
        ddlMonth.Items.Add("May")
        ddlMonth.Items.Add("June")
        ddlMonth.Items.Add("July")
        ddlMonth.Items.Add("August")
        ddlMonth.Items.Add("September")
        ddlMonth.Items.Add("October")
        ddlMonth.Items.Add("November")
        ddlMonth.Items.Add("December")

        ddlMonth.Items.FindByValue(MonthName(Now.Month)).Selected = True

    End Sub


    Sub Populate_YearList()

        'Year list can be extended
        Dim intYear As Integer

        For intYear = DateTime.Now.Year - 20 To DateTime.Now.Year + 20

            ddlYear.Items.Add(intYear)
        Next

        ddlYear.Items.FindByValue(Now.Year).Selected = True

    End Sub

    Protected Sub Calendar1_SelectionChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles Calendar1.SelectionChanged
        txtDate.Text = Calendar1.SelectedDate
        blockCalendar.Visible = False
        blockSelect.Visible = False
    End Sub

    Sub Set_Calendar(ByVal Sender As Object, ByVal E As EventArgs)

        'Whenever month or year selection changes display the calendar for that month/year        
        Calendar1.TodaysDate = CDate(ddlMonth.SelectedItem.Value & " 1, " & ddlYear.SelectedItem.Value)


    End Sub
   

    Protected Sub btnToggle_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnToggle.Click
        If blockCalendar.Visible = True Then
            blockCalendar.Visible = False
            blockSelect.Visible = False
        Else
            blockSelect.Visible = True
            blockCalendar.Visible = True
        End If
    End Sub
End Class
