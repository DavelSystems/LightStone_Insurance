
Partial Class Reports
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("UserName") = "" Then
            Response.Redirect("login.aspx")
            Response.Expires = -1
        End If

        'Session.Remove("ClaimId")

        If Not IsPostBack Then

            Dim conClaims As SqlConnection
            Dim cmdSelect As SqlCommand
            'Dim statusSelect As SqlCommand
            Dim reader As SqlDataReader
            'Dim reader2 As SqlDataReader
            'Dim strsql As String

            conClaims = New SqlConnection(ConfigurationManager.ConnectionStrings("Insurance").ConnectionString)
            conClaims.Open()

            cmdSelect = New SqlCommand("select distinct propid, propname from prop where deleted is null order by propname", conClaims)
            'cmdSelect = New SqlCommand("select p.propid,p.propname from propusers pu left join prop p on p.propid = pu.propid where pu.username=@username and p.propname is not null and isnull(p.deleted,0) <> 1 order by p.propname", conClaims)
            'cmdSelect.Parameters.Add("@UserName", SqlDbType.VarChar).Value = Session("UserName")

            reader = cmdSelect.ExecuteReader

            ddlprop.DataSource = reader
            ddlprop.DataTextField = "propname"
            ddlprop.DataValueField = "propid"
            ddlprop.AppendDataBoundItems = False
            ddlprop.DataBind()
            ddlprop.Items.Insert(0, "")

            reader.Close()

            'strsql = "select distinct c.bldgname, c.location, c.incidenttype from claims c where c.propid="
            'strsql = strsql & ddlprop.SelectedItem.Value
            'cmdSelect = New SqlCommand(strsql, conClaims)
            cmdSelect = New SqlCommand("select distinct incidenttype from claims", conClaims)
            reader = cmdSelect.ExecuteReader

            ddltype.DataSource = reader
            ddltype.DataTextField = "incidenttype"
            ddltype.DataValueField = "incidenttype"
            ddltype.AppendDataBoundItems = False
            ddltype.DataBind()

            reader.Close()

            'statusSelect = New SqlCommand("select distinct status from claims", conClaims)

            'reader2 = statusSelect.ExecuteReader
            'ddlstatus.DataSource = reader2
            'ddlstatus.DataTextField = "status"
            'ddlstatus.DataValueField = "status"
            'ddlstatus.AppendDataBoundItems = True

            'ddlstatus.DataBind()
            'reader2.Close()
            conClaims.Close()

        End If

       
    End Sub


    Private Sub ddlprop_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlprop.SelectedIndexChanged

        If ddlprop.SelectedItem.Text.Trim.Length > 0 Then

            Dim strsql As String
            Dim conClaims As SqlConnection
            Dim cmdSelect As SqlCommand
            Dim reader As SqlDataReader

            conClaims = New SqlConnection(ConfigurationManager.ConnectionStrings("Insurance").ConnectionString)
            conClaims.Open()

            strsql = "select distinct bldgid, bldgname from bldg where propid = " & ddlprop.SelectedItem.Value
            cmdSelect = New SqlCommand(strsql, conClaims)
            reader = cmdSelect.ExecuteReader

            ddlbuilding.DataSource = reader
            ddlbuilding.DataTextField = "bldgname"
            ddlbuilding.DataValueField = "bldgid"
            ddlbuilding.AppendDataBoundItems = False
            ddlbuilding.DataBind()
            ddlbuilding.Items.Insert(0, "")

            ddlxctloc.Items.Clear()
            strsql = ""

            reader.Close()

            'strsql = "select distinct location from claims where propid = " & ddlprop.SelectedItem.Value '& " and bldgname = " & ddlbuilding.SelectedItem.Value
            'cmdSelect = New SqlCommand(strsql, conClaims)
            'reader = cmdSelect.ExecuteReader

            'ddlxctloc.DataSource = reader
            'ddlxctloc.DataTextField = "location"
            'ddlxctloc.DataValueField = "location"
            'ddlxctloc.AppendDataBoundItems = False
            'ddlxctloc.DataBind()
            'ddlxctloc.Items.Insert(0, "")

            'reader.Close()
            conClaims.Close()

        Else
            ddlbuilding.ClearSelection()
            ddlbuilding.Items.Clear()
            ddlbuilding.DataSource = Nothing
            ddlbuilding.DataBind()

            ddlxctloc.ClearSelection()
            ddlxctloc.Items.Clear()
            ddlxctloc.DataSource = Nothing
            ddlxctloc.DataBind()

        End If
    End Sub

    Protected Sub ddlbuilding_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlbuilding.SelectedIndexChanged

        If ddlbuilding.SelectedItem.Text.Trim.Length > 0 Then

            Dim strsql As String
            Dim conClaims As SqlConnection
            Dim cmdSelect As SqlCommand
            Dim reader As SqlDataReader

            conClaims = New SqlConnection(ConfigurationManager.ConnectionStrings("Insurance").ConnectionString)
            conClaims.Open()

            strsql = ""
            strsql = "select distinct location from claims where propid = " & ddlprop.SelectedItem.Value & "and bldgid = " & ddlbuilding.SelectedItem.Value
            cmdSelect = New SqlCommand(strsql, conClaims)
            reader = cmdSelect.ExecuteReader

            ddlxctloc.DataSource = reader
            ddlxctloc.DataTextField = "location"
            ddlxctloc.DataValueField = "location"
            ddlxctloc.AppendDataBoundItems = False
            ddlxctloc.DataBind()
            ddlxctloc.Items.Insert(0, "")

            reader.Close()
            conClaims.Close()

        Else
            ddlxctloc.ClearSelection()
            ddlxctloc.Items.Clear()

            ddlxctloc.DataSource = Nothing
            ddlxctloc.DataBind()

        End If
    End Sub
End Class
