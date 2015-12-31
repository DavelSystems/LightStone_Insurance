
Partial Class FindClaim
    Inherits System.Web.UI.Page

  

    Private Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.PreRender

        Dim Dgitem As DataGridItem
        Dim z, x As Int16
        Dim str As String

        Dim y As Int16
        y = -1

        If gridClaims.HasControls Then
            For Each Dgitem In gridClaims.Controls(0).Controls
                If Dgitem.ItemType = ListItemType.Pager Then
                    Dim i As Int16

                    For i = 0 To Dgitem.Controls(0).Controls.Count - 1
                        If Dgitem.Controls(0).HasControls Then
                            If Dgitem.Controls(0).Controls(i).GetType.ToString = "System.Web.UI.WebControls.DataGridLinkButton" Then
                                Dim lbutton As New LinkButton
                                Dim oControl As New LinkButton
                                oControl = CType(Dgitem.Controls(0).Controls(i), LinkButton)
                                lbutton = PagerTable.Rows(0).Cells(0).Controls(i)
                                'lbutton = PagerTable.Rows(0).Cells(1).Controls(i)
                                lbutton.Text = oControl.Text
                                If IsNumeric(lbutton.Text) Then
                                    z = lbutton.Text
                                    If y = -1 Then
                                        y = z
                                    End If
                                    z = z - 1

                                Else 'calculate what the value of the "..." should be.
                                    str = Dgitem.Controls(0).Controls(i).ClientID
                                    x = str.IndexOf("ctl")
                                    str = str.Substring(x + 1)

                                    x = str.IndexOf("ctl")
                                    str = str.Substring(x + 3)

                                    If str = "0" Then
                                        'z = z - 1
                                        z = y - 3
                                        If (z + 1) Mod 10 <> 0 Then
                                            z = z + 1
                                        End If
                                        If z = -1 Then
                                            z = 0
                                        End If
                                    Else
                                        z = y + 8
                                        If z Mod 10 <> 0 Then
                                            z = z + 1
                                        End If
                                    End If
                                End If
                                'lbutton.Attributes.Add("href", "Javascript: PageLink(""" & Page.GetPostBackClientHyperlink(Dgitem.Controls(0).Controls(i), "") & """);" )
                                lbutton.Attributes.Add("href", "Javascript: PageLink('" & z & "');")
                                'lbutton.Attributes.Add("href", "Javascript: PageLink('" & Dgitem.Controls(0).Controls(i).clientId & "');" )
                                'lbutton.Attributes.Add("onmouseover", "form.hidBindDataGrid.value = 'False';")
                                'lbutton.Attributes.Add("onmouseout", "form.hidBindDataGrid.value = '';")
                            End If
                        End If

                    Next
                End If
            Next
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("UserName") = "" Then
            Response.Redirect("login.aspx")
            Response.Expires = -1
        End If

        'Session.Remove("ClaimId")

        If Not IsPostBack Then
            If Request.QueryString("GetNotSubmitted") = "True" Then
                Session("FindClaimStatus") = "Not Submitted"
            ElseIf Request.QueryString("GetSubmitted") = "True" Then
                Session("FindClaimStatus") = "Submitted"
            End If

            Dim conClaims As SqlConnection
            Dim cmdSelect As SqlCommand
            Dim reader As SqlDataReader

            conClaims = New SqlConnection(ConfigurationManager.ConnectionStrings("Insurance").ConnectionString)
            conClaims.Open()

            cmdSelect = New SqlCommand("select p.propid,p.propname from propusers pu left join prop p on p.propid = pu.propid where pu.username=@username and p.propname is not null and isnull(p.deleted,0) <> 1 order by p.propname", conClaims)
            cmdSelect.Parameters.Add("@UserName", SqlDbType.VarChar).Value = Session("UserName")

            reader = cmdSelect.ExecuteReader
            dropProperties.DataSource = reader
            dropProperties.DataTextField = "propname"
            dropProperties.DataValueField = "propid"
            dropProperties.AppendDataBoundItems = True

            dropProperties.DataBind()

            reader.Close()

            conClaims.Close()

            If Session("FindClaimClaimId") <> "" Then
                txtClaimId.Text = Session("FindClaimClaimId")
            End If

            If Session("FindClaimResident") <> "" Then
                txtClaimant.Text = Session("FindClaimClaimant")
            End If

            If Session("FindClaimProperties") <> "" Then
                dropProperties.SelectedIndex = -1
                dropProperties.Items.FindByValue(Session("FindClaimProperties")).Selected = True
            End If

            If Session("FindClaimStatus") <> "" Then
                dropStatus.SelectedIndex = -1
                dropStatus.Items.FindByValue(Session("FindClaimStatus")).Selected = True
            End If

            If Session("FindClaimStartDate") = "" And Session("FindClaimEndDate") = "" Then
                txtStartDate.Text = Date.Today().AddMonths(-1)
                txtEndDate.Text = Date.Today()
            Else
                txtStartDate.Text = Session("FindClaimStartDate")
                txtEndDate.Text = Session("FindClaimEndDate")
            End If

            ViewState("pageIndex") = 0
            BindGrid()

        Else
            If hidPageNum.Value <> "" Then
                PageIndexChanged(hidPageNum.Value)
                hidPageNum.Value = ""
            End If
        End If
    End Sub


    Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSearch.Click
        ViewState("pageIndex") = 0

        BindGrid()
    End Sub


    Private Sub BindGrid()
        Dim conClaims As SqlConnection
        Dim reader As SqlDataReader

        gridClaims.CurrentPageIndex = CInt(ViewState("pageIndex"))


        conClaims = New SqlConnection(ConfigurationManager.ConnectionStrings("Insurance").ConnectionString)

        Dim cmdSelect As New SqlCommand("GetClaimsPageWithTempTable", conClaims)
        cmdSelect.CommandType = Data.CommandType.StoredProcedure

        If gridClaims.VirtualItemCount > 0 Then

            Dim ipagecount As Int32 = Math.Ceiling(gridClaims.VirtualItemCount / gridClaims.PageSize)
            If gridClaims.CurrentPageIndex > ipagecount Then
                gridClaims.CurrentPageIndex = ipagecount - 1
            End If
        End If

        With cmdSelect.Parameters
            .Add("@PageNumber", SqlDbType.Int).Value = gridClaims.CurrentPageIndex + 1
            .Add("@PageSize", SqlDbType.Int).Value = gridClaims.PageSize

            .Add("@UserName", SqlDbType.VarChar).Value = Session("UserName")
            .Add("@Accesslevel", SqlDbType.Int).Value = Session("AccessLevel")

            If txtClaimId.Text.Length > 0 Then
                .Add("@ClaimId", SqlDbType.Int).Value = txtClaimId.Text
            Else
                .Add("@ClaimId", SqlDbType.VarChar).Value = DBNull.Value
            End If

            Session("FindClaimClaimId") = txtClaimId.Text

            If IsDate(txtStartDate.Text) Then
                .Add("@StartDate", SqlDbType.VarChar).Value = txtStartDate.Text
            ElseIf IsDate(txtEndDate.Text) Then
                txtStartDate.Text = txtEndDate.Text
                .Add("@StartDate", SqlDbType.VarChar).Value = txtStartDate.Text
            Else
                .Add("@StartDate", SqlDbType.VarChar).Value = DBNull.Value
            End If

            If IsDate(txtEndDate.Text) Then
                .Add("@EndDate", SqlDbType.VarChar).Value = Date.Parse(txtEndDate.Text).AddDays(1)
            ElseIf IsDate(txtStartDate.Text) Then
                txtEndDate.Text = Date.Today() 'txtStartDate.Text
                .Add("@EndDate", SqlDbType.VarChar).Value = Date.Parse(txtEndDate.Text).AddDays(1)
            Else
                .Add("@EndDate", SqlDbType.VarChar).Value = DBNull.Value
            End If

            Session("FindClaimStartDate") = txtStartDate.Text
            Session("FindClaimEndDate") = txtEndDate.Text

            If txtClaimant.Text.Length > 0 Then
                .Add("@Claimant", SqlDbType.VarChar).Value = "%" & txtClaimant.Text & "%"
            Else
                .Add("@Claimant", SqlDbType.VarChar).Value = DBNull.Value
            End If

            Session("FindClaimClaimant") = txtClaimant.Text

            If dropProperties.SelectedItem.Text.Length > 0 Then
                .Add("@PropId", Data.SqlDbType.Int).Value = dropProperties.SelectedValue
            Else
                .Add("@PropId", Data.SqlDbType.Int).Value = DBNull.Value
            End If

            Session("FindClaimProperties") = dropProperties.SelectedValue

            If dropStatus.SelectedItem.Text.Length > 0 Then
                .Add("@Status", Data.SqlDbType.VarChar).Value = dropStatus.SelectedValue
            Else
                .Add("@Status", Data.SqlDbType.VarChar).Value = DBNull.Value
            End If

            Session("FindClaimStatus") = dropStatus.SelectedValue

        End With

        conClaims.Open()
        reader = cmdSelect.ExecuteReader()
        reader.Read()
        Try
            gridClaims.VirtualItemCount = Convert.ToInt32(reader.Item(0))
        Catch
        End Try

        If reader.NextResult() Then
            'Trace.Warn(reader.HasRows)
            gridClaims.DataSource = reader
            Try
                gridClaims.DataBind()

                lblItemCount.Text = "Displaying " & (gridClaims.CurrentPageIndex * gridClaims.PageSize) + 1 & " - " & (gridClaims.Items.Count() + ((gridClaims.CurrentPageIndex) * gridClaims.PageSize)) & " of " & gridClaims.VirtualItemCount
            Catch

            End Try
        End If
        conClaims.Close()

        If gridClaims.Items.Count() = 0 Then
            lblNoMatches.Visible = "true"
            gridClaims.DataSource = Nothing
            gridClaims.DataBind()
            lblItemCount.Text = ""
            PagerTable.Rows(0).Cells().Clear()

        Else
            lblNoMatches.Visible = "false"

        End If
    End Sub


    Sub PageIndexChanged(ByVal str As String)
        hidSelect.Value = -1
        gridClaims.SelectedIndex = -1

        ''gridClaims.CurrentPageIndex = e.NewPageIndex
        'dim i as int16 = str.indexOf("ctl")
        'dim str1 as string = str.substring(i + 1)

        'i = str1.indexOf("ctl")
        'str1 = str1.substring(i + 3)

        Viewstate("pageIndex") = str
        'saveScrollPos.Value = ""

        BindGrid()
    End Sub

    Sub gridClaims_PageIndexChanged(ByVal s As Object, ByVal e As System.Web.UI.WebControls.DataGridPageChangedEventArgs)

        hidSelect.Value = -1
        gridClaims.SelectedIndex = -1

        'gridClaims.CurrentPageIndex = e.NewPageIndex
        ViewState("pageIndex") = e.NewPageIndex


        BindGrid()

    End Sub

    Sub gridClaims_ItemDataBound(ByVal s As Object, ByVal e As DataGridItemEventArgs)

        If e.Item.ItemType = ListItemType.Item Then

            e.Item.Attributes.Add("onmouseenter", "dgrdMouseOver(this,'" & e.Item.ItemIndex & "')")
            e.Item.Attributes.Add("onmouseleave", "dgrdMouseOut(this,'" & e.Item.ItemIndex & "')")
            e.Item.Attributes.Add("onclick", "dgrdSelect(this,'" & e.Item.ItemIndex & "')")
            e.Item.Attributes.Add("ID", DataBinder.Eval(e.Item.DataItem, "ClaimId"))
        ElseIf e.Item.ItemType = ListItemType.AlternatingItem Then

            e.Item.Attributes.Add("onmouseenter", "dgrdMouseOver(this,'" & e.Item.ItemIndex & "')")
            e.Item.Attributes.Add("onmouseleave", "dgrdAltMouseOut(this,'" & e.Item.ItemIndex & "')")
            e.Item.Attributes.Add("onclick", "dgrdSelect(this,'" & e.Item.ItemIndex & "')")
            e.Item.Attributes.Add("ID", DataBinder.Eval(e.Item.DataItem, "ClaimId"))
        ElseIf e.Item.ItemType = ListItemType.Header Then
            Dim i As Int16
            'e.Item.CssClass = "lockrow"
            For i = 0 To e.Item.Cells.Count - 1
                e.Item.Cells(i).CssClass = "lockrow"
            Next
            e.Item.Cells(0).Style.Item("border-left") = "0px solid;"
        End If

       

    End Sub

    Sub gridClaims_ItemCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs)
        If e.Item.ItemType = ListItemType.Pager Then
            Dim i As Int16
            PagerTable.Rows(0).Cells().Clear()
            'PagerTable.Rows(0).Cells().RemoveAt(1)
            Dim oCell As New TableCell
            oCell.ColumnSpan = 4
            'oCell.Width = New Unit(800, UnitType.Pixel)
            oCell.Width = New Unit(100, UnitType.Percentage)

            oCell.HorizontalAlign = HorizontalAlign.Center
            PagerTable.Rows(0).Cells.Add(oCell)
            For i = 0 To e.Item.Controls(0).Controls.Count - 1
                If e.Item.Controls(0).HasControls Then
                    If e.Item.Controls(0).Controls(i).GetType.ToString = "System.Web.UI.WebControls.DataGridLinkButton" Then
                        Dim lbutton As New LinkButton
                        Dim oControl As New LinkButton
                        oControl = CType(e.Item.Controls(0).Controls(i), LinkButton)
                        lbutton.ID = oControl.ID
                        lbutton.Text = oControl.Text
                        lbutton.ForeColor = System.Drawing.Color.Blue
                        lbutton.Style.Item("TEXT-DECORATION") = "None"
                        'lbutton.Font.Bold = True

                        lbutton.Attributes.Add("href", Page.GetPostBackClientHyperlink(e.Item.Controls(0).Controls(i), ""))
                        PagerTable.Rows(0).Cells(0).Controls.Add(lbutton)
                        ' PagerTable.Rows(0).Cells(1).Controls.Add(lbutton)
                    ElseIf TypeOf e.Item.Controls(0).Controls(i) Is LiteralControl Then
                        Dim oControl As New LiteralControl
                        Dim oControlTemp As New LiteralControl
                        oControl = e.Item.Controls(0).Controls(i)
                        oControlTemp.Text = oControl.Text
                        'oControlTemp.font.bold = True

                        PagerTable.Rows(0).Cells(0).Controls.Add(oControlTemp)
                        'PagerTable.Rows(0).Cells(1).Controls.Add(oControlTemp)
                    ElseIf TypeOf e.Item.Controls(0).Controls(i) Is Label Then
                        Dim oControl As New Label
                        Dim oControlTemp As New Label
                        oControl = e.Item.Controls(0).Controls(i)
                        oControlTemp.Text = oControl.Text
                        PagerTable.Rows(0).Cells(0).Controls.Add(oControlTemp)
                        'PagerTable.Rows(0).Cells(1).Controls.Add(oControlTemp)

                    End If
                End If

            Next
        End If
    End Sub

End Class
