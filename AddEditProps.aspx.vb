
Partial Class AddEditProps
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("UserName") = "" Then
            Response.Redirect("login.aspx")
            Response.Expires = -1
        End If

        If Not IsPostBack Then
            gvProps.EditIndex = 0
            BindProps()
        Else
            If hidEditProp.Value <> "" And CStr(gvProps.EditIndex) <> hidEditProp.Value Then

                gvProps.EditIndex = hidEditProp.Value
                gvProps.DataSourceID = "SqlDataSource1"
                BindProps()

            End If

            If hidEditBldg.Value <> "" And CStr(gvBldgs.EditIndex) <> hidEditBldg.Value Then

                gvBldgs.EditIndex = hidEditBldg.Value
                gvBldgs.DataSourceID = "SqlDataSource2"
                BindBldgs()

            End If
        End If
       
    End Sub

    Private Sub BindProps()
       
        Dim str As String = "select propid, propname,rmpropid from prop where propname is not null and propname <> '' and isnull(deleted,0) <> 1 "
        str += "union select -1,null,null "
        str += "order by 2"

        SqlDataSource1.ConnectionString = ConfigurationManager.ConnectionStrings("Insurance").ConnectionString
        SqlDataSource1.SelectCommand = str
        gvProps.DataBind()

        gvBldgs.EditIndex = 0
        hidEditBldg.Value = ""
        hidOldRowBldg.Value = ""

        If gvProps.EditIndex <> 0 Then
            gvProps.Rows(0).Visible = False
            BindBldgs()
            divBldgs.Visible = True
        Else
            gvProps.Rows(0).Visible = True
            divBldgs.Visible = False
        End If
    End Sub

    Private Sub BindBldgs()
        Dim str As String = "select bldgid, bldgname,rmbldgid from bldg where bldgname is not null and bldgname <> '' and isnull(deleted,0) <> 1 and propid = " & gvProps.DataKeys(gvProps.EditIndex)(0)
        str += " union select -1,null,null "
        str += "order by 2"

        SqlDataSource2.ConnectionString = ConfigurationManager.ConnectionStrings("Insurance").ConnectionString
        SqlDataSource2.SelectCommand = str
        gvBldgs.DataBind()

        If gvBldgs.EditIndex <> 0 Then
            gvBldgs.Rows(0).Visible = False

        Else
            gvBldgs.Rows(0).Visible = True
            'gvBldgs.Rows(0).Controls(0).Focus()

        End If

    End Sub
    Protected Sub gvProps_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvProps.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            'Dim drop As DropDownList
            ' Dim btn As Button

            If e.Row.RowState = DataControlRowState.Alternate Then
                e.Row.Attributes.Add("onmouseout", "dgrdStyleChange(this,'" & e.Row.RowIndex & "','altrow')")
                e.Row.Attributes.Add("onclick", "dgrdSelect(this,'GridOutAlt','" & e.Row.RowIndex & "');")
                e.Row.Attributes.Add("onmouseover", "dgrdStyleChange(this,'" & e.Row.RowIndex & "','overrow')")

                ' btn = e.Row.FindControl("btn
            ElseIf e.Row.RowState = DataControlRowState.Normal Then
                e.Row.Attributes.Add("onmouseout", "dgrdStyleChange(this,'" & e.Row.RowIndex & "','regrow')")
                e.Row.Attributes.Add("onclick", "dgrdSelect(this,'GridOut','" & e.Row.RowIndex & "');")
                e.Row.Attributes.Add("onmouseover", "dgrdStyleChange(this,'" & e.Row.RowIndex & "','overrow')")
                ' Response.Write("e.Row.RowIndex: " & e.Row.RowIndex)

            End If


            e.Row.Attributes.Add("ID", DataBinder.Eval(e.Row.DataItem, "PropId"))

        End If
    End Sub


    Public Sub btnCancelItem_Click(ByVal sender As Object, ByVal e As CommandEventArgs)

        gvProps.EditIndex = 0
        hidEditProp.Value = ""
        hidOldRowProp.Value = ""

        BindProps()

    End Sub

    Public Sub btnDeleteItem_Click(ByVal sender As Object, ByVal e As CommandEventArgs)
        'Response.Write("")
        Dim con As SqlConnection
        Dim cmd As SqlCommand

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("Insurance").ConnectionString)
        con.Open()

        cmd = New SqlCommand("update prop set deleted = 1  where propid= " & e.CommandArgument, con)
        cmd.ExecuteNonQuery()

        gvProps.EditIndex = 0
        hidEditProp.Value = ""
        hidOldRowProp.Value = ""

        con.Close()

        BindProps()

        Dim end1 As String = "</"
        Dim strScript As String = "<script language=""javascript"">" & vbCrLf & "<!-- " & vbCrLf & "window.dialogArguments.propsChanged = true;//-->" & end1 & "script>"
        ClientScript.RegisterStartupScript(GetType(Page), "changedProps", strScript)
    End Sub


    Public Sub btnSaveItem_Click(ByVal sender As Object, ByVal e As CommandEventArgs)
        Dim curRow As GridViewRow = gvProps.Rows(gvProps.EditIndex)
        Dim propname, rmpropid As String
       
        Dim txt As TextBox = curRow.FindControl("txtPropname")
        propname = txt.Text

        txt = curRow.FindControl("txtRMPROPID")
        rmpropid = txt.Text

        Dim strB As New StringBuilder
        If gvProps.EditIndex > 0 Then
            strB.Append("if not exists (select 1 from prop where propname =@propname and rmpropid=@rmpropid and propid<>@propid  ) ")
            strB.Append("update prop set propname = @propname, rmpropid = @rmpropid where propid=@propid ")
            'strB.Append("else if not exists (select 1 from prop where propname =@propname and rmpropid=@rmpropid and propid<>@propid)  ")
        Else
            strB.Append("if not exists (select 1 from prop where propname =@propname and rmpropid=@rmpropid) ")
            strB.Append("insert into prop(propname,rmpropid) select @propname,@rmpropid ")

        End If
       
        Dim con As SqlConnection
        Dim cmd As SqlCommand

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("Insurance").ConnectionString)
        con.Open()

        cmd = New SqlCommand(strB.ToString, con)
       
        With cmd.Parameters
            .Add("propid", SqlDbType.Int).Value = gvProps.DataKeys(gvProps.EditIndex)(0)
            .Add("Propname", SqlDbType.VarChar).Value = propname
            .Add("RmPropid", SqlDbType.VarChar).Value = rmpropid
        End With

        cmd.ExecuteNonQuery()

        
        gvProps.EditIndex = 0
        hidEditProp.Value = ""
        hidOldRowProp.Value = ""

        con.Close()

        BindProps()

        Dim end1 As String = "</"
        Dim strScript As String = "<script language=""javascript"">" & vbCrLf & "<!-- " & vbCrLf & "window.dialogArguments.propsChanged = true;//-->" & end1 & "script>"
        ClientScript.RegisterStartupScript(GetType(Page), "changedProps", strScript)
    End Sub

    Protected Sub gvBldgs_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvBldgs.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            'Dim drop As DropDownList
            ' Dim btn As Button

            If e.Row.RowState = DataControlRowState.Alternate Then
                e.Row.Attributes.Add("onmouseout", "dgrdStyleChange2(this,'" & e.Row.RowIndex & "','altrow')")
                e.Row.Attributes.Add("onclick", "dgrdSelect2(this,'GridOutAlt','" & e.Row.RowIndex & "');")
                e.Row.Attributes.Add("onmouseover", "dgrdStyleChange2(this,'" & e.Row.RowIndex & "','overrow')")

                ' btn = e.Row.FindControl("btn
            ElseIf e.Row.RowState = DataControlRowState.Normal Then
                e.Row.Attributes.Add("onmouseout", "dgrdStyleChange2(this,'" & e.Row.RowIndex & "','regrow')")
                e.Row.Attributes.Add("onclick", "dgrdSelect2(this,'GridOut','" & e.Row.RowIndex & "');")
                e.Row.Attributes.Add("onmouseover", "dgrdStyleChange2(this,'" & e.Row.RowIndex & "','overrow')")
                ' Response.Write("e.Row.RowIndex: " & e.Row.RowIndex)

            End If


            e.Row.Attributes.Add("ID", DataBinder.Eval(e.Row.DataItem, "BldgId"))

        End If
    End Sub

    Public Sub btnCancelItemBldg_Click(ByVal sender As Object, ByVal e As CommandEventArgs)

        gvBldgs.EditIndex = 0
        hidEditBldg.Value = ""
        hidOldRowBldg.Value = ""

        BindBldgs()

    End Sub

    Public Sub btnDeleteItemBldg_Click(ByVal sender As Object, ByVal e As CommandEventArgs)
        'Response.Write("")
        Dim con As SqlConnection
        Dim cmd As SqlCommand

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("Insurance").ConnectionString)
        con.Open()

        cmd = New SqlCommand("update Bldg set deleted = 1  where Bldgid= " & e.CommandArgument, con)
        cmd.ExecuteNonQuery()

        gvBldgs.EditIndex = 0
        hidEditBldg.Value = ""
        hidOldRowBldg.Value = ""

        con.Close()

        BindBldgs()

        Dim end1 As String = "</"
        Dim strScript As String = "<script language=""javascript"">" & vbCrLf & "<!-- " & vbCrLf & "window.dialogArguments.propsChanged = true;//-->" & end1 & "script>"
        ClientScript.RegisterStartupScript(GetType(Page), "changedProps", strScript)
    End Sub

    Public Sub btnSaveItemBldg_Click(ByVal sender As Object, ByVal e As CommandEventArgs)
        Dim curRow As GridViewRow = gvBldgs.Rows(gvBldgs.EditIndex)
        Dim Bldgname, rmBldgid As String

        Dim txt As TextBox = curRow.FindControl("txtBldgname")
        Bldgname = txt.Text

        txt = curRow.FindControl("txtRMBldgID")
        rmBldgid = txt.Text

        Dim strB As New StringBuilder
        If gvBldgs.EditIndex > 0 Then
            strB.Append("if not exists (select 1 from Bldg where Bldgname =@Bldgname and rmBldgid=@rmBldgid and Bldgid<>@Bldgid and propid=@propid ) ")
            strB.Append("update Bldg set Bldgname = @Bldgname, rmBldgid = @rmBldgid where Bldgid=@Bldgid ")
            'strB.Append("else if not exists (select 1 from Bldg where Bldgname =@Bldgname and rmBldgid=@rmBldgid and Bldgid<>@Bldgid)  ")
        Else
            strB.Append("if not exists (select 1 from Bldg where Bldgname =@Bldgname and rmBldgid=@rmBldgid and propid=@propid) ")
            strB.Append("insert into Bldg(propid,Bldgname,rmBldgid) select @propid,@Bldgname,@rmBldgid ")

        End If

        Dim con As SqlConnection
        Dim cmd As SqlCommand

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("Insurance").ConnectionString)
        con.Open()

        cmd = New SqlCommand(strB.ToString, con)

        With cmd.Parameters
            .Add("propid", SqlDbType.Int).Value = gvProps.DataKeys(gvProps.EditIndex)(0)
            .Add("Bldgid", SqlDbType.Int).Value = gvBldgs.DataKeys(gvBldgs.EditIndex)(0)
            .Add("Bldgname", SqlDbType.VarChar).Value = Bldgname
            .Add("RmBldgid", SqlDbType.VarChar).Value = rmBldgid
        End With

        cmd.ExecuteNonQuery()


        gvBldgs.EditIndex = 0
        hidEditBldg.Value = ""
        hidOldRowBldg.Value = ""

        con.Close()

        BindBldgs()

        Dim end1 As String = "</"
        Dim strScript As String = "<script language=""javascript"">" & vbCrLf & "<!-- " & vbCrLf & "window.dialogArguments.propsChanged = true;//-->" & end1 & "script>"
        ClientScript.RegisterStartupScript(GetType(Page), "changedProps", strScript)
    End Sub
End Class
