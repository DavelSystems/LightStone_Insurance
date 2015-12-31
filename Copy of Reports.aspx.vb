
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
            Dim statusSelect As SqlCommand
            Dim reader As SqlDataReader
            Dim reader2 As SqlDataReader

            conClaims = New SqlConnection(ConfigurationManager.ConnectionStrings("Insurance").ConnectionString)
            conClaims.Open()

            cmdSelect = New SqlCommand("select distinct p.propid, p.propname from prop p full join claims c on p.propid=c.propid where deleted is null order by p.propname", conClaims)
            'cmdSelect = New SqlCommand("select p.propid,p.propname from propusers pu left join prop p on p.propid = pu.propid where pu.username=@username and p.propname is not null and isnull(p.deleted,0) <> 1 order by p.propname", conClaims)
            'cmdSelect.Parameters.Add("@UserName", SqlDbType.VarChar).Value = Session("UserName")

            reader = cmdSelect.ExecuteReader
            ddlprop.DataSource = reader
            ddlprop.DataTextField = "propname"
            ddlprop.DataValueField = "propid"
            ddlprop.AppendDataBoundItems = True

            ddlprop.DataBind()
            reader.Close()

            statusSelect = New SqlCommand("select distinct status from claims", conClaims)

            reader2 = statusSelect.ExecuteReader
            ddlstatus.DataSource = reader2
            ddlstatus.DataTextField = "status"
            ddlstatus.DataValueField = "status"
            ddlstatus.AppendDataBoundItems = True

            ddlstatus.DataBind()
            reader2.Close()
            conClaims.Close()

           
        End If

       
    End Sub


End Class
