Imports Microsoft.Reporting

Partial Class ReportsPopUp
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal Sender As Object, ByVal e As EventArgs) Handles Me.Load
        Trace.Warn("In PageLoad()")
        If (Session("UserName")) = "" Then
            Response.Redirect("login.aspx")
        End If
        If Not IsPostBack Then
            GenerateReport()
        End If

    End Sub

    Private Sub GenerateReport()
        Trace.Warn("In GenerateReport()")

        Dim reportType As String = Request.QueryString("report")
        Select Case reportType
            Case "claimlist"
                ReportViewer1.ServerReport.ReportPath = "/report project4/ClaimsReport"
        End Select
        Trace.Warn("reportType= ", reportType)

        ReportViewer1.ServerReport.ReportServerUrl = New System.Uri("http://localhost:5200/reportserver")
        'ReportViewer1.ServerReport.ReportServerUrl = New System.Uri("http://localhost/reportserver$SQL2005")

        Dim RptParameters(12) As Microsoft.Reporting.WebForms.ReportParameter

        Dim propID As String = Request.QueryString("prop")
        Dim bldg As String = Request.QueryString("bldg")
        Dim loc As String = Request.QueryString("loc")
        Dim inctype As String = Request.QueryString("inctype")
        Dim tpa As String = Request.QueryString("tpa")
        Dim lit As String = Request.QueryString("lit")
        Dim car As String = Request.QueryString("car")
        Dim status As String = Request.QueryString("stat")
        Dim fromdate As String = Request.QueryString("fromdate")
        Dim todate As String = Request.QueryString("todate")
        Trace.Warn("propID=", propID)
        Trace.Warn("bldg=", bldg)
        Trace.Warn("loc=", loc)
        Trace.Warn("inctype=", inctype)
        Trace.Warn("tpa=", tpa)
        Trace.Warn("lit=", lit)
        Trace.Warn("car=", car)
        Trace.Warn("Status=", status)
        Trace.Warn("From Date=", fromdate)
        Trace.Warn("To Date=", todate)

        If Request.QueryString("prop").Length > 0 Then
            RptParameters(0) = New Microsoft.Reporting.WebForms.ReportParameter("PropID", propID)
        Else
            RptParameters(0) = New Microsoft.Reporting.WebForms.ReportParameter("PropID")
        End If

        If Request.QueryString("stat").Length > 0 Then
            RptParameters(1) = New Microsoft.Reporting.WebForms.ReportParameter("status", status)
        Else
            RptParameters(1) = New Microsoft.Reporting.WebForms.ReportParameter("status")
        End If

        If Request.QueryString("fromdate").Length > 0 Then
            RptParameters(2) = New Microsoft.Reporting.WebForms.ReportParameter("fromdate", fromdate)
        Else
            RptParameters(2) = New Microsoft.Reporting.WebForms.ReportParameter("fromdate")
        End If

        If Request.QueryString("todate").Length > 0 Then
            RptParameters(3) = New Microsoft.Reporting.WebForms.ReportParameter("todate", todate)
        Else
            RptParameters(3) = New Microsoft.Reporting.WebForms.ReportParameter("todate", Today())
        End If

        If Request.QueryString("bldg").Length > 0 Then
            RptParameters(4) = New Microsoft.Reporting.WebForms.ReportParameter("bldg", bldg)
        Else
            RptParameters(4) = New Microsoft.Reporting.WebForms.ReportParameter("bldg")
        End If

        If Request.QueryString("loc").Length > 0 Then
            RptParameters(5) = New Microsoft.Reporting.WebForms.ReportParameter("loc", loc)
        Else
            RptParameters(5) = New Microsoft.Reporting.WebForms.ReportParameter("loc")
        End If

        If Request.QueryString("inctype").Length > 0 Then
            RptParameters(6) = New Microsoft.Reporting.WebForms.ReportParameter("inctype", inctype)
        Else
            RptParameters(6) = New Microsoft.Reporting.WebForms.ReportParameter("inctype")
        End If

        If Request.QueryString("tpa").Length = 4 Then
            RptParameters(7) = New Microsoft.Reporting.WebForms.ReportParameter("tpa", tpa)
        Else
            RptParameters(7) = New Microsoft.Reporting.WebForms.ReportParameter("tpa")
        End If

        If Request.QueryString("lit").Length < 5 Then
            RptParameters(8) = New Microsoft.Reporting.WebForms.ReportParameter("lit", lit)
        Else
            RptParameters(8) = New Microsoft.Reporting.WebForms.ReportParameter("lit")
        End If

        If Request.QueryString("car").Length < 5 Then
            RptParameters(9) = New Microsoft.Reporting.WebForms.ReportParameter("car", car)
        Else
            RptParameters(9) = New Microsoft.Reporting.WebForms.ReportParameter("car")
        End If

        If Request.QueryString("NotSubmitted") <> "" Then
            RptParameters(10) = New Microsoft.Reporting.WebForms.ReportParameter("NotSubmitted", CBool(Request.QueryString("NotSubmitted")))
        Else
            RptParameters(10) = New Microsoft.Reporting.WebForms.ReportParameter("NotSubmitted")
        End If

        If Request.QueryString("Submitted") <> "" Then
            RptParameters(11) = New Microsoft.Reporting.WebForms.ReportParameter("Submitted", CBool(Request.QueryString("Submitted")))
        Else
            RptParameters(11) = New Microsoft.Reporting.WebForms.ReportParameter("Submitted")
        End If

        If Request.QueryString("Reviewed") <> "" Then
            RptParameters(12) = New Microsoft.Reporting.WebForms.ReportParameter("Reviewed", CBool(Request.QueryString("Reviewed")))
        Else
            RptParameters(12) = New Microsoft.Reporting.WebForms.ReportParameter("Reviewed")
        End If







        ReportViewer1.ShowParameterPrompts = False

        ReportViewer1.ServerReport.SetParameters(RptParameters)
        ReportViewer1.ServerReport.Refresh()



    End Sub
End Class
