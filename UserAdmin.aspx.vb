
Partial Class UserAdmin
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Session("UserName") = "" Then
            Response.Redirect("login.aspx")
            Response.Expires = -1
        End If

        If Not IsPostBack Then

            btnSearch.Attributes.Add("onclick", "UnSelectAssignedProp(); if (!WarnNotSaved()) return false; else 1;")
            btnAddNew.Attributes.Add("onclick", "UnSelectAssignedProp(); if(!Validate()) return false; else 1;")
            btnEditNew.Attributes.Add("onclick", "UnSelectAssignedProp(); if(!Validate()) return false; else 1;")
            btnUpdate.Attributes.Add("onclick", "UnSelectAssignedProp(); if(!Validate()) return false; else 1;")
            'btnRemove.Attributes.Add("onclick", "UnSelectAssignedProp(); warn_onunload=false;")

            btnRemove.Attributes.Add("onclick", "return RemoveUser();")

            txtPassword.Attributes.Add("onKeyUp", "document.getElementById('divPassword1').style.display='';document.getElementById('txtPassword1').value='';")


            txtNewUserName.Attributes.Add("onchange", "form_dirty = true;")
            txtNewUserId.Attributes.Add("onchange", "form_dirty = true;")
            txtPassword.Attributes.Add("onchange", "form_dirty = true;")
            dropUserLevel.Attributes.Add("onchange", "form_dirty = true;")

            Dim conLease As SqlConnection
            Dim cmdSelect As SqlCommand

            Dim str As String = "select propid, propname from prop where propname is not null and propname <> '' and isnull(deleted,0) <> 1 order by propName"

            conLease = New SqlConnection(ConfigurationManager.ConnectionStrings("Insurance").ConnectionString)

            conLease.Open()

            cmdSelect = New SqlCommand(str, conLease)

            Dim reader As SqlDataReader

            reader = cmdSelect.ExecuteReader

            listProps.DataSource = reader
            listProps.DataTextField = "propname"
            listProps.DataValueField = "propid"

            listProps.DataBind()

            reader.Close()
            conLease.Close()

            'chkProps.Attributes.Add("onclick", "form_dirty = true;")
        Else
            If hidNewItems.Value.Length > 0 Then
                Dim arrProps As Array = hidNewItems.Value.Split("~")


                For Each str As String In arrProps
                    If str.Length > 0 Then
                        Dim arrProp As Array = str.Split(":")

                        listAssignedProps.Items.Add(New ListItem(arrProp(0), arrProp(1)))

                    End If

                Next

                hidNewItems.Value = ""
            End If

            Dim lstItem As ListItem


            If hidDeleteItems.Value.Length > 0 Then
                Dim arrProps As Array = hidDeleteItems.Value.Split("~")

                For Each str As String In arrProps
                    If str.Length > 0 Then
                        Dim arrProp As Array = str.Split(":")
                        lstItem = listAssignedProps.Items.FindByValue(arrProp(1))
                        listAssignedProps.Items.Remove(lstItem)
                        ' listAssignedProps.Items.Remove(New ListItem(arrProp(0), arrProp(1)))

                    End If
                Next

                hidDeleteItems.Value = ""

            End If

            listAssignedProps.SelectedIndex = -1
            If hidRptSelect.Value <> "-1" And hidRptSelect.Value <> "" And hidRptSelectFlag.Value = "True" Then
                FillUserDetails()

                hidRptSelectFlag.Value = "False"
            End If
        End If
    End Sub

    Sub btnSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSearch.Click
        'hidRptSelect.value = ""
        'hidRptOldRowType.value = ""
        'hidRptOldRow.value = ""

        'For Each chk As ListItem In chkListPages.Items
        '    chk.selected = False
        'Next
        'listAssignedProps.ClearSelection()

        Cancel()

        BindRptr()
    End Sub

    Sub BindRptr()
        Dim conLease As SqlConnection
        Dim cmdSelect As SqlCommand
        Dim dtrUsers As SqlDataReader

        Dim str As String = "select Username, isnull(name,'') as name from permissions where (@name is null or name like @name) and (@UserName is null or UserName like @UserName) order by Name asc"

        conLease = New SqlConnection(ConfigurationManager.ConnectionStrings("Insurance").ConnectionString)

        conLease.Open()

        cmdSelect = New SqlCommand(str, conLease)

        If txtUserId.Text.Length > 0 Then
            txtUserName.Text = ""
        End If

        If txtUserName.Text.Length > 0 Then
            cmdSelect.Parameters.Add("@Name", SqlDbType.VarChar).Value = "%" & txtUserName.Text & "%"
        Else
            cmdSelect.Parameters.Add("@Name", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txtUserId.Text.Length > 0 Then
            cmdSelect.Parameters.Add("@UserName", SqlDbType.VarChar).Value = "%" & txtUserId.Text & "%"
        Else
            cmdSelect.Parameters.Add("@UserName", SqlDbType.VarChar).Value = DBNull.Value
        End If

        dtrUsers = cmdSelect.ExecuteReader()

        rptUsers.DataSource = dtrUsers
        rptUsers.DataBind()

        If rptUsers.Items.Count = 0 Then
            rptUsers.DataSource = Nothing
            rptUsers.DataBind()
            lblNoResults.Visible = True
        Else
            lblNoResults.Visible = False
        End If

        dtrUsers.Close()
        conLease.Close()
    End Sub

    Private Sub FillUserDetails()
        Dim conLease As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("Insurance").ConnectionString)
        Dim cmdSelect As SqlCommand
        Dim dtrUsers As SqlDataReader

        Dim str As String = "Select name, P.username, p.accesslevel as userlevel,p.password,p.email,isnull(p.showAdmin,0)[showAdmin] from permissions P where p.username=@username"

        conLease.Open()

        cmdSelect = New SqlCommand(str, conLease)
        cmdSelect.Parameters.Add("@UserName", SqlDbType.VarChar).Value = hidRptOldRow.Value

        dtrUsers = cmdSelect.ExecuteReader




        If dtrUsers.HasRows Then
            dtrUsers.Read()

            If Not dtrUsers("Name") Is DBNull.Value Then
                txtNewUserName.Text = dtrUsers("Name")
            Else
                txtNewUserName.Text = ""
            End If

            If Not dtrUsers("UserName") Is DBNull.Value Then
                txtNewUserId.Text = dtrUsers("UserName")
            Else
                txtNewUserId.Text = ""
            End If

            dropUserLevel.SelectedIndex = -1

            If Not dtrUsers("userlevel") Is DBNull.Value Then
                dropUserLevel.Items.FindByValue(dtrUsers("userlevel")).Selected = True
            End If

            If Not dtrUsers("password") Is DBNull.Value Then
                txtPassword.Attributes.Add("value", dtrUsers("password"))
                txtPassword1.Attributes.Add("value", dtrUsers("password"))
            Else
                txtPassword.Attributes.Add("value", "")
                txtPassword1.Attributes.Add("value", "")
            End If

            If Not dtrUsers("Email") Is DBNull.Value Then
                txtEmail.Text = dtrUsers("Email")
            Else
                txtEmail.Text = ""
            End If

            '7/13/11 cmb
            cbShowAdmin.Checked = dtrUsers("showAdmin")

        End If

        dtrUsers.Close()

        listAssignedProps.SelectedIndex = -1
        listProps.SelectedIndex = -1

        str = "Select distinct p.propid,p.propname from propusers Pu left join prop p on P.propid = pu.propid where pu.username=@username"

        cmdSelect = New SqlCommand(str, conLease)

        cmdSelect.Parameters.Add("@UserName", SqlDbType.VarChar).Value = hidRptOldRow.Value

        dtrUsers = cmdSelect.ExecuteReader


        listAssignedProps.DataSource = dtrUsers
        listAssignedProps.DataTextField = "propname"
        listAssignedProps.DataValueField = "propid"

        listAssignedProps.DataBind()



        dtrUsers.Close()
        conLease.Close()

    End Sub


    Private Sub SaveProps(ByVal userName As String)
        Dim conLease As SqlConnection
        Dim cmdupdate As SqlCommand

        conLease = New SqlConnection(ConfigurationManager.ConnectionStrings("Insurance").ConnectionString)

        conLease.Open()

        Dim strB As StringBuilder = New StringBuilder
        Dim blnFirst As Boolean = True

        strB.Append("delete propusers where username=@username ")

        If listAssignedProps.Items.Count > 0 Then
            strB.Append("Insert into propusers(username,propid) ")


            For Each prop As ListItem In listAssignedProps.Items

                If Not blnFirst Then
                    strB.Append("union ")
                Else
                    blnFirst = False
                End If
                strB.Append("Select ")
                strB.Append("@username, " & prop.Value & " ")

            Next

        End If


        cmdupdate = New SqlCommand(strB.ToString, conLease)
        cmdupdate.Parameters.Add("@UserName", SqlDbType.VarChar).Value = userName 'hidRptOldRow.Value

        cmdupdate.ExecuteNonQuery()
        conLease.Close()

    End Sub

   
    Protected Sub Save(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs)
        If e.CommandName = "New" Then
            NewUser()
        ElseIf e.CommandName = "Update" Then
            UpdateUser()
        ElseIf e.CommandName = "Remove" Then
            RemoveUser()
        ElseIf e.CommandName = "Cancel" Then
            Cancel()
        End If
    End Sub

    Private Sub NewUser()
        Dim conLease As SqlConnection
        Dim cmdupdate As SqlCommand
        Dim ParmExists As SqlParameter

        conLease = New SqlConnection(ConfigurationManager.ConnectionStrings("Insurance").ConnectionString)
        conLease.Open()

        cmdupdate = New SqlCommand("CreateNewUser", conLease)
        cmdupdate.CommandType = CommandType.StoredProcedure

        If txtNewUserName.Text.Length > 0 Then
            cmdupdate.Parameters.Add("@Name", SqlDbType.VarChar).Value = txtNewUserName.Text  'hidRptOldRow.Value
        Else
            cmdupdate.Parameters.Add("@Name", SqlDbType.VarChar).Value = DBNull.Value
        End If

        cmdupdate.Parameters.Add("@UserId", SqlDbType.VarChar).Value = txtNewUserId.Text
        cmdupdate.Parameters.Add("@UserLevel", SqlDbType.Int).Value = dropUserLevel.SelectedValue
        cmdupdate.Parameters.Add("@Password", SqlDbType.VarChar).Value = txtPassword.Text
        cmdupdate.Parameters.Add("@Email", SqlDbType.VarChar).Value = txtEmail.Text
        cmdupdate.Parameters.Add("@ShowAdmin", SqlDbType.Bit).Value = cbShowAdmin.Checked

        ParmExists = cmdupdate.Parameters.Add("@Exists", SqlDbType.Bit)
        ParmExists.Size = 50
        ParmExists.Direction = ParameterDirection.Output

        cmdupdate.ExecuteNonQuery()
        conLease.Close()

        If Not cmdupdate.Parameters("@Exists").Value Is DBNull.Value Then
            Dim end1 As String = "</"
            Dim strScript1 As String = "<script language=""javascript"">" & vbCrLf & "<!-- " & vbCrLf & "alert('Cannot create new user. This user id already exists.');//-->" & end1 & "script>"
            ClientScript.RegisterStartupScript(Me.GetType, "alertDuplicatUser", strScript1)

        Else
            SaveProps(txtNewUserId.Text)
            Cancel()
            BindRptr()
        End If
    End Sub

    Private Sub UpdateUser()
        Dim conLease As SqlConnection
        Dim cmdupdate As SqlCommand
        Dim ParmExists As SqlParameter

        conLease = New SqlConnection(ConfigurationManager.ConnectionStrings("Insurance").ConnectionString)
        conLease.Open()

        cmdupdate = New SqlCommand("UpdateUser", conLease)
        cmdupdate.CommandType = CommandType.StoredProcedure

        If txtNewUserName.Text.Length > 0 Then
            cmdupdate.Parameters.Add("@Name", SqlDbType.VarChar).Value = txtNewUserName.Text
        Else
            cmdupdate.Parameters.Add("@Name", SqlDbType.VarChar).Value = DBNull.Value
        End If

        cmdupdate.Parameters.Add("@OldUserId", SqlDbType.VarChar).Value = hidRptOldRow.Value

        cmdupdate.Parameters.Add("@NewUserId", SqlDbType.VarChar).Value = txtNewUserId.Text
        cmdupdate.Parameters.Add("@UserLevel", SqlDbType.Int).Value = dropUserLevel.SelectedValue
        cmdupdate.Parameters.Add("@Password", SqlDbType.VarChar).Value = txtPassword.Text
        cmdupdate.Parameters.Add("@Email", SqlDbType.VarChar).Value = txtEmail.Text
        cmdupdate.Parameters.Add("@ShowAdmin", SqlDbType.Bit).Value = cbShowAdmin.Checked

        ParmExists = cmdupdate.Parameters.Add("@Exists", SqlDbType.Bit)
        ParmExists.Size = 50
        ParmExists.Direction = ParameterDirection.Output

        cmdupdate.ExecuteNonQuery()
        conLease.Close()

        If Not cmdupdate.Parameters("@Exists").Value Is DBNull.Value Then
            Dim end1 As String = "</"
            Dim strScript1 As String = "<script language=""javascript"">" & vbCrLf & "<!-- " & vbCrLf & "alert('Cannot complete update. This user id already exists.');//-->" & end1 & "script>"
            ClientScript.RegisterStartupScript(Me.GetType, "alertDuplicatUser", strScript1)

        Else
            SaveProps(txtNewUserId.Text)
            BindRptr()
        End If


    End Sub

    Private Sub RemoveUser()
        Dim conLease As SqlConnection
        Dim cmdupdate As SqlCommand

        conLease = New SqlConnection(ConfigurationManager.ConnectionStrings("Insurance").ConnectionString)
        conLease.Open()

        cmdupdate = New SqlCommand("RemoveUser", conLease)
        cmdupdate.CommandType = CommandType.StoredProcedure

        cmdupdate.Parameters.Add("@UserId", SqlDbType.VarChar).Value = hidRptOldRow.Value

        cmdupdate.ExecuteNonQuery()
        conLease.Close()

        Cancel()
        BindRptr()
    End Sub

    Private Sub Cancel()
        listAssignedProps.ClearSelection()
        listAssignedProps.Items.Clear()

        txtNewUserName.Text = ""
        txtNewUserId.Text = ""
        dropUserLevel.SelectedIndex = 0

        txtPassword.Attributes.Add("value", "")
        txtPassword1.Attributes.Add("value", "")

        cbShowAdmin.Checked = False
        txtEmail.Text = ""

        hidRptSelect.Value = ""
        hidRptOldRowType.Value = ""
        hidRptOldRow.Value = ""

        Dim end1 As String = "</"
        Dim strScript1 As String = "<script language=""javascript"">" & vbCrLf & "<!-- " & vbCrLf & "document.getElementById('divEdit').style.display = 'none'; document.getElementById('divAdd').style.display = '';;//-->" & end1 & "script>"
        ClientScript.RegisterStartupScript(Me.GetType, "resetDivBtns", strScript1)

    End Sub

    Protected Sub btnEditProps_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnEditProps.Click
        Dim conLease As SqlConnection
        Dim cmdSelect As SqlCommand

        Dim str As String = "select propid, propname from prop where propname is not null and propname <> '' and isnull(deleted,0) <> 1 order by propName"

        conLease = New SqlConnection(ConfigurationManager.ConnectionStrings("Insurance").ConnectionString)

        conLease.Open()

        cmdSelect = New SqlCommand(str, conLease)

        Dim reader As SqlDataReader

        reader = cmdSelect.ExecuteReader

        listProps.DataSource = reader
        listProps.DataTextField = "propname"
        listProps.DataValueField = "propid"

        listProps.DataBind()

        reader.Close()
        conLease.Close()
    End Sub
End Class
