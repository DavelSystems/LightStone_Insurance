Imports System.IO

Partial Class AttachPhotos
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("UserName") = "" Then
            Response.Write("Session Timed out. Please login again")
            Response.Redirect("login.aspx")

        End If
        Response.Expires = -1


    End Sub


    Sub Upload_Click(ByVal source As Object, ByVal e As EventArgs)

        Dim savePath As String = ""

        If Not (uploadedFile.PostedFile Is Nothing) Then
            Try
                Dim postedFile = uploadedFile.PostedFile
                Dim filename As String = Path.GetFileName(postedFile.FileName)
                Dim contentType As String = postedFile.ContentType
                Dim contentLength As Integer = postedFile.ContentLength

                If Session("ClaimId") IsNot Nothing Then
                    savePath = "Claims\" & Session("ClaimId") & "\" '& filename
                Else
                    Dim curSession As String = HttpContext.Current.Session.SessionID
                    savePath = "Claims\Temp\" & curSession & "\" '& filename
                End If

                If Not Directory.Exists(Server.MapPath(savePath)) Then
                    Directory.CreateDirectory(Server.MapPath(savePath))
                End If

                savePath = savePath & filename


                Dim mpath As String = Server.MapPath(savePath)



                postedFile.SaveAs(mpath)


                'message.Text = " uploaded " & postedFile.Filename

                Dim end1 As String = "</"
                Dim strScript As String = "<script language=""javascript"">" & vbCrLf & "<!-- " & vbCrLf & "top.returnValue = '" & filename & "'; window.close(); //-->" & end1 & "script>"
                ClientScript.RegisterStartupScript(GetType(Page), "CloseUp", strScript)

                '   "<br>content type: " & contentType & _
                '    "<br>content length: " & contentLength.ToString()
            Catch exc As Exception
                message.Text = "Failed uploading file.Try again."
            End Try
        End If


    End Sub

End Class
