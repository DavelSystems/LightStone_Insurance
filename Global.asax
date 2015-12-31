<%@ Application Language="VB" %>

<script runat="server">

    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application startup
    End Sub
    
    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application shutdown
    End Sub
        
    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when an unhandled error occurs
    End Sub

    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a new session is started
    End Sub

    Sub Session_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a session ends. 
        ' Note: The Session_End event is raised only when the sessionstate mode
        ' is set to InProc in the Web.config file. If session mode is set to StateServer 
        ' or SQLServer, the event is not raised.
        
        Dim curSession As String = HttpContext.Current.Session.SessionID
        Dim savePath As String = "Claims\Temp\" & curSession
        
        If System.IO.Directory.Exists(Server.MapPath(savePath)) Then
            'System.IO.Directory.Delete(Server.MapPath(savePath))
            
            If System.IO.Directory.Exists(Server.MapPath(savePath)) Then
                ' System.IO.Directory.Delete(Server.MapPath(savePath))
                Dim folder As New System.IO.DirectoryInfo(Server.MapPath(savePath))

                Try

                    For Each file As System.IO.FileInfo In folder.GetFiles
                        file.Delete()
                    Next

                    folder.Delete()

                Catch ex As Exception

                End Try

            End If
        End If
        
    End Sub
       
</script>