Imports System.IO

Partial Class login
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Response.Expires = -1
        Session("UserName") = ""

        Session.Clear()

        Dim curSession As String = HttpContext.Current.Session.SessionID
        Dim savePath As String = "Claims\Temp\" & curSession

        If Directory.Exists(Server.MapPath(savePath)) Then

            Dim folder As New DirectoryInfo(Server.MapPath(savePath))

            Try

                For Each file As FileInfo In folder.GetFiles
                    file.Delete()
                Next

                folder.Delete()

            Catch ex As Exception
                'Response.Write(ex.Message)
            End Try

        End If
    End Sub

    Protected Sub Login_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Login.Click
        Dim Lockout As Boolean = False
        Dim Admit As Boolean = False


        Dim conn As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("Insurance").ConnectionString)


        Dim reader As SqlDataReader

        Dim client As String = Request.ServerVariables("REMOTE_ADDR")
        Dim strsql As String = "SELECT COUNT(*) AS Attempts FROM ENTRYLOG WHERE Address='" & client & "' " & _
          " AND Date>DATEADD(mi,-10,GetDate()) AND Status='Failed'"

        Dim cmd As SqlCommand = New SqlCommand(strsql, conn)

        conn.Open()

        Dim count As Int16 = cmd.ExecuteScalar()

        Trace.Warn("failures: " & count.ToString())

        If count >= 5 Then

            Lockout = True
            Msg.Text = "Your login has failed 5 times!<BR>Please Try Again Later"

        End If


        Trace.Warn(UserId.Value)


        If UserId.Value <> "" And Lockout = False Then



            Dim strsql1 As StringBuilder = New StringBuilder
            strsql1.Append("SELECT UserName, AccessLevel, Name, Password, Email, isnull(ShowAdmin,0)[ShowAdmin] FROM Permissions ")
            strsql1.Append("WHERE UserName='" & UserId.Value.ToLower() & "'")



            cmd.CommandText = strsql1.ToString()
            cmd.Connection = conn
            reader = cmd.ExecuteReader()

            If reader.Read() Then

                Dim pass As String = Password.Value.ToLower()
                Dim SrvrPass As String = (reader("Password"))
                SrvrPass = SrvrPass.ToLower()
                Trace.Warn(pass & " = " & SrvrPass)

                If pass = SrvrPass Then

                    Session("AccessLevel") = Convert.ToInt16(reader("AccessLevel"))
                    Session("UserName") = reader("UserName").ToString
                    Session("ShowAdmin") = reader("ShowAdmin")


                    Admit = True


                End If

            End If
            reader.Close()
        End If


        Trace.Warn(Admit.ToString())

        Dim stat As String = "Failed"
        If Admit Then
            stat = "Success"
        ElseIf (Lockout) Then
            stat = "Locked"
        End If


        strsql = "INSERT ENTRYLOG VALUES ('"
        strsql = strsql & DateTime.Now & "','"
        strsql = strsql & Request.ServerVariables("REMOTE_HOST") & "','"
        strsql = strsql & client & "','"
        strsql = strsql & Request.ServerVariables("REMOTE_USER") & "','"
        strsql = strsql & UserId.Value & "','"
        strsql = strsql & Password.Value & "','"
        strsql = strsql & stat & "')"

        cmd.CommandText = strsql
        cmd.Connection = conn
        cmd.ExecuteNonQuery()

        conn.Close()

        If Admit = True Then
            Response.Redirect("Topframe.htm")
        End If

    End Sub
End Class
