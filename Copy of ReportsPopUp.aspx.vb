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

        'ReportViewer1.ServerReport.ReportServerUrl = New System.Uri("http://localhost:5080/reportserver")
        ReportViewer1.ServerReport.ReportServerUrl = New System.Uri("http://localhost/reportserver$SQL2005")

        Dim RptParameters(3) As Microsoft.Reporting.WebForms.ReportParameter

        Dim propID As String = Request.QueryString("prop")
        Dim status As String = Request.QueryString("stat")
        Dim fromdate As String = Request.QueryString("fromdate")
        Dim todate As String = Request.QueryString("todate")
        Trace.Warn("propID=", propID)
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


        ReportViewer1.ShowParameterPrompts = False

        ReportViewer1.ServerReport.SetParameters(RptParameters)
        ReportViewer1.ServerReport.Refresh()



    End Sub
End Class
