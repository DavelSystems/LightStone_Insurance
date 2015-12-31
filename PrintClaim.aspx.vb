Imports Microsoft.Reporting
Imports System.IO


Partial Class PrintClaim
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("UserName") = "" Then
            Response.Redirect("login.aspx")
            Response.Expires = -1
        End If

        If Not IsPostBack Then
            GenerateReport()
        End If
    End Sub

    Private Sub GenerateReport()
        ReportViewer1.ServerReport.ReportPath = "/Report Project4/Lightstone Group Insurance Claim Report"
       

        ReportViewer1.ServerReport.ReportServerUrl = New System.Uri("http://localhost:5200/reportserver")
        'ReportViewer1.ServerReport.ReportServerUrl = New System.Uri("http://localhost/reportserver$SQL2005")

        'While ReportViewer1.ServerReport.IsDrillthroughReport  'dont know y we need this yet
        '    ReportViewer1.PerformBack()
        'End While

        Dim RptParameters(2) As Microsoft.Reporting.WebForms.ReportParameter '= New Microsoft.Reporting.WebForms.ReportParameter(1)

      
        RptParameters(0) = New Microsoft.Reporting.WebForms.ReportParameter("ClaimID", Request.QueryString("ClaimId"))

        Dim strImages As String = ""

        If Request.QueryString("Images") = "1" Then
            strImages = GetPhotos(Request.QueryString("ClaimId"))
        End If

        If strImages.Length > 0 Then
            RptParameters(1) = New Microsoft.Reporting.WebForms.ReportParameter("Images", strImages)
        Else
            RptParameters(1) = New Microsoft.Reporting.WebForms.ReportParameter("Images")
        End If

        RptParameters(2) = New Microsoft.Reporting.WebForms.ReportParameter("showProcessing", Request.QueryString("Processing"))

        ReportViewer1.DocumentMapCollapsed = True

        ReportViewer1.ServerReport.SetParameters(RptParameters)
        ReportViewer1.ServerReport.Refresh()


    End Sub

    Private Function GetPhotos(ByVal claimid As Int32) As String
        Dim strImages As String = ""
        Dim ROOT_DIRECTORY As String = "Claims\"
        Dim s As String

      '  Dim strWebPath As String = "http://localhost/insurance/claims/" & claimid & "/"
         Dim strWebPath As String = "http://localhost:5200/instracking/claims/" & claimid & "/"

        Dim fullPath As String = Server.MapPath(ROOT_DIRECTORY & claimid)
        If Directory.Exists(fullPath) Then

            For Each s In System.IO.Directory.GetFiles(fullPath)
                'Get information about the image
                ' Try


                If strImages.Length > 0 Then
                    strImages = strImages & ","
                End If

                strImages = strImages & strWebPath & System.IO.Path.GetFileName(s)

                'catch
                'end try
            Next
        End If

        Return strImages
    End Function

End Class
