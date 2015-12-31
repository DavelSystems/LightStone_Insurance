Imports System.Net.Mail
Imports System.Net.NetworkCredential
Imports System.IO

Partial Class Claim
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("UserName") = "" Then
            Response.Redirect("login.aspx")
            Response.Expires = -1
        End If

        If Not IsPostBack Then
            Dim conInsurance As SqlConnection
            Dim cmdSelect As SqlCommand
            Dim reader As SqlDataReader

            conInsurance = New SqlConnection(ConfigurationManager.ConnectionStrings("Insurance").ConnectionString)

            If Request.QueryString("First") = "True" Then
                If CInt(Session("AccessLevel")) = 1 Then
                    conInsurance.Open()
                    cmdSelect = New SqlCommand("select count(claimid) from claims where username=@username and status='Not Submitted' ", conInsurance)
                    cmdSelect.Parameters.Add("@UserName", SqlDbType.VarChar).Value = Session("UserName")

                    Dim nCount As Int32 = cmdSelect.ExecuteScalar

                    If nCount > 0 Then
                        conInsurance.Close()
                        Response.Redirect("FindClaim.aspx?GetNotSubmitted=True")
                    End If
                Else
                    Response.Redirect("FindClaim.aspx?GetSubmitted=True")
                End If

            End If


            If CInt(Session("AccessLevel")) <> 3 Then
                'TabStripClaim.Items(4).DefaultStyle.Item("display") = "none"
                'TabStripClaim.Items(5).DefaultStyle.Item("display") = "none"
                'TabStripClaim.Items(6).DefaultStyle.Item("display") = "none"
                btnDocuments.Visible = False
                btnNotes.Visible = False
                btnProcessing.Visible = False


                btnPrintClaim.Visible = False
            End If

            ROOT_DIRECTORY.Value = "Claims\"


            If conInsurance.State <> ConnectionState.Open Then
                conInsurance.Open()
            End If


            cmdSelect = New SqlCommand("select p.propid,p.propname from propusers pu left join prop p on p.propid = pu.propid where pu.username=@username and p.propname is not null and isnull(p.deleted,0) <> 1 order by p.propname", conInsurance)
            cmdSelect.Parameters.Add("@UserName", SqlDbType.VarChar).Value = Session("UserName")

            reader = cmdSelect.ExecuteReader
            dropProp.DataSource = reader
            dropProp.DataTextField = "propname"
            dropProp.DataValueField = "propid"
            'dropProp.AppendDataBoundItems = True

            dropProp.DataBind()
            reader.Close()

            dropProp.Items.Insert(0, New WebControls.ListItem("", "-1"))

            dropBldg.Items.Insert(0, New WebControls.ListItem("", "-1"))


            cmdSelect = New SqlCommand("select stateAbbr,state from states order by state", conInsurance)
            Dim dt As New DataTable
            Dim sa As New SqlDataAdapter(cmdSelect)
            sa.Fill(dt)

            dropState.DataSource = dt
            dropState.DataTextField = "state"
            dropState.DataValueField = "stateabbr"
            dropState.DataBind()
            dropState.Items.Insert(0, New WebControls.ListItem("", "-1"))
            dropState.SelectedIndex = 0

            ddlPropState.DataSource = dt
            ddlPropState.DataTextField = "state"
            ddlPropState.DataValueField = "stateabbr"
            ddlPropState.DataBind()
            ddlPropState.Items.Insert(0, New WebControls.ListItem("", "-1"))
            ddlPropState.SelectedIndex = 0

            cmdSelect = New SqlCommand("select stateAbbr,state from states order by state", conInsurance)
            Dim dt2 As New DataTable
            Dim sa2 As New SqlDataAdapter(cmdSelect)
            sa2.Fill(dt2)

            dropState2.DataSource = dt2
            dropState2.DataTextField = "state"
            dropState2.DataValueField = "stateabbr"
            dropState2.DataBind()
            dropState2.Items.Insert(0, New WebControls.ListItem("", "-1"))
            dropState2.SelectedIndex = 0





            dropWitnessState1.DataSource = dt
            dropWitnessState1.DataTextField = "state"
            dropWitnessState1.DataValueField = "stateabbr"
            dropWitnessState1.DataBind()
            dropWitnessState1.Items.Insert(0, New WebControls.ListItem("", "-1"))
            dropWitnessState1.SelectedIndex = 0

            dropWitnessState2.DataSource = dt
            dropWitnessState2.DataTextField = "state"
            dropWitnessState2.DataValueField = "stateabbr"
            dropWitnessState2.DataBind()
            dropWitnessState2.Items.Insert(0, New WebControls.ListItem("", "-1"))
            dropWitnessState2.SelectedIndex = 0

            Dim curSession As String = HttpContext.Current.Session.SessionID
            Dim savePath As String = "Claims\Temp\" & curSession

            If Directory.Exists(Server.MapPath(savePath)) Then
                ' System.IO.Directory.Delete(Server.MapPath(savePath))
                Dim folder As New DirectoryInfo(Server.MapPath(savePath))

                Try

                    For Each file As FileInfo In folder.GetFiles
                        file.Delete()
                    Next

                    folder.Delete()

                Catch ex As Exception

                End Try

            End If

            hidSubmitted.Value = 0

            If Request.QueryString("ClaimId") <> "" Then
                'Response.Write(Request.QueryString("ClaimId"))
                Session("ClaimId") = Request.QueryString("ClaimId")
                GetClaim(conInsurance)
            ElseIf Request.QueryString("New") = "yes" Then
                Session("ClaimId") = Nothing
            ElseIf Session("ClaimId") IsNot Nothing Then
                GetClaim(conInsurance)
            End If

            conInsurance.Close()

            radClaimant.Attributes.Add("onclick", "toggleArrears();")
            radMinor.Attributes.Add("onclick", "toggleMinor();")

            radPictures.Attributes.Add("onclick", "togglePictures();")

            radPropertyDamage.Attributes.Add("onclick", "togglePropDamage();")
            radArrears.Attributes.Add("onclick", "toggleArrears();")
            radMedicalAttention.Attributes.Add("onclick", "toggleMedicalAttention();")
            radWitnesses.Attributes.Add("onclick", "toggleWitnesses();")

            radObstruction.Attributes.Add("onclick", "toggleObstruction();")
            radCarryingObjects.Attributes.Add("onclick", "toggleObjects();")
            radSurveillance.Attributes.Add("onclick", "toggleFilm();")

            'radSelfAdministered.Attributes.Add("onclick", "toggleSelfAdministered();")
            radClaimType.Attributes.Add("onclick", "toggleClaimType();")


            radReportCarrier.Attributes.Add("onclick", "toggleReportCarrier();")

            radsubmitTpa.Attributes.Add("onclick", "toggleSubmitTpa();")
            radTpaSubmitCarrier.Attributes.Add("onclick", "toggleTpaSubmitCarrier();")
            radClaimLitigation.Attributes.Add("onclick", "toggleClaimLitigation();")
            radLitigClaimSettled.Attributes.Add("onclick", "toggleLitigClaimSettled();")



            btnSubmit.Attributes.Add("onclick", "return validate(1,false);")
            btnSave.Attributes.Add("onclick", "return validate(0,false);")
            Button1.Attributes.Add("onclick", "return validate(0,false);")
            Button2.Attributes.Add("onclick", "return validate(0,false);")
            Button3.Attributes.Add("onclick", "return validate(0,false);")
            Button4.Attributes.Add("onclick", "return validate(0,true);")
            txtCheckAmnt1.Attributes.Add("onchange", "SetCheckTotal();")
            txtCheckAmnt2.Attributes.Add("onchange", "SetCheckTotal();")
            txtCheckAmnt3.Attributes.Add("onchange", "SetCheckTotal();")
            txtCheckAmnt4.Attributes.Add("onchange", "SetCheckTotal();")




            btnAttachPhotos.Attributes.Add("onclick", "AttachPhotos(); return false;")
            ViewState("Reviewed") = False


        Else
            If hidPhotos.Value = "true" Then
                GetPhotos()

            End If

            If hidRemoveFile.Value.Length > 0 Then

                'DeleteDocument()
                DeleteFile()
            End If

            If hidRemoveFile2.Value.Length > 0 Then

                'DeleteDocument()
                DeleteDocument()
            End If



            End If
    End Sub

   
    Protected Sub dropProp_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles dropProp.SelectedIndexChanged
        PropSelect()

    End Sub

    Private Sub PropSelect()
        Dim conInsurance As SqlConnection
        Dim cmdSelect As SqlCommand
        Dim reader As SqlDataReader

        If dropProp.SelectedItem.Text.Trim.Length > 0 Then

            conInsurance = New SqlConnection(ConfigurationManager.ConnectionStrings("Insurance").ConnectionString)
            conInsurance.Open()

            cmdSelect = New SqlCommand("select b.bldgid, b.bldgname from bldg b where propid = @propid and isnull(b.deleted,0) <> 1 order by bldgname", conInsurance)
            cmdSelect.Parameters.Add("@propid", SqlDbType.Int).Value = dropProp.SelectedValue


            reader = cmdSelect.ExecuteReader
            dropBldg.DataSource = reader
            dropBldg.DataTextField = "bldgname"
            dropBldg.DataValueField = "bldgid"
            'dropBldg.AppendDataBoundItems = True

            dropBldg.DataBind()
            reader.Close()

            dropBldg.Items.Insert(0, New WebControls.ListItem("", "-1"))

            If dropBldg.Items.Count = 2 Then
                dropBldg.SelectedIndex = 1
            End If
            conInsurance.Close()

        Else
            dropBldg.ClearSelection()
            dropBldg.Items.Clear()

            dropBldg.DataSource = Nothing
            dropBldg.DataBind()

            dropBldg.Items.Insert(0, New WebControls.ListItem("", "-1"))
        End If

    End Sub



    Sub Save(ByVal s As Object, ByVal e As CommandEventArgs)
        If e.CommandName = "Save" Then
            SaveClaim(False)
        ElseIf e.CommandName = "Submit" Then
            SaveClaim(True)
        End If

    End Sub

    Private Sub SaveClaim(ByVal blnSubmit As Boolean)
        Dim conInsurance As SqlConnection
        Dim cmdSave As SqlCommand
        Dim parmClaimId As SqlParameter

        Trace.Warn("hidSubmitted.Value: " & hidSubmitted.Value)

        If hidSubmitted.Value.ToString <> "1" Or CInt(Session("AccessLevel")) = 3 Then

            conInsurance = New SqlConnection(ConfigurationManager.ConnectionStrings("Insurance").ConnectionString)
            conInsurance.Open()

            cmdSave = New SqlCommand("SaveClaim", conInsurance)
            cmdSave.CommandType = Data.CommandType.StoredProcedure

            With cmdSave.Parameters

                .Add("@UserName", Data.SqlDbType.VarChar).Value = Session("UserName")

                .Add("@Submit", Data.SqlDbType.Bit).Value = Convert.ToInt32(blnSubmit)
                .Add("@Reviewed", SqlDbType.Bit).Value = Convert.ToInt32(chkReviewed.Checked)

                If Not Session("ClaimId") Is Nothing Then
                    .Add("@ClaimId", Data.SqlDbType.Int).Value = Convert.ToInt32(Session("ClaimId"))
                Else
                    .Add("@ClaimId", Data.SqlDbType.Int).Value = DBNull.Value
                End If


                If dropProp.SelectedItem.Text.Length > 0 Then
                    .Add("@PropId", Data.SqlDbType.Int).Value = dropProp.SelectedValue
                Else
                    .Add("@PropId", Data.SqlDbType.Int).Value = DBNull.Value
                End If


                If dropBldg.SelectedItem.Text.Length > 0 Then
                    .Add("@bldgId", Data.SqlDbType.Int).Value = dropBldg.SelectedValue
                Else
                    .Add("@bldgId", Data.SqlDbType.Int).Value = DBNull.Value
                End If

                If txtLocation.Text.Length > 0 Then
                    .Add("@Location", SqlDbType.VarChar).Value = txtLocation.Text
                Else
                    .Add("@Location", SqlDbType.VarChar).Value = DBNull.Value
                End If




                '5/16/11 cmb
                If txtPropAddress.Text.Length > 0 Then
                    .Add("@PropAddress", SqlDbType.VarChar).Value = txtPropAddress.Text
                Else
                    .Add("@PropAddress", SqlDbType.VarChar).Value = DBNull.Value
                End If

                If txtPropCity.Text.Length > 0 Then
                    .Add("@PropCity", SqlDbType.VarChar).Value = txtPropCity.Text
                Else
                    .Add("@PropCity", SqlDbType.VarChar).Value = DBNull.Value
                End If

                .Add("@PropState", SqlDbType.VarChar).Value = ddlPropState.SelectedItem.Text

                If txtPropZip.Text.Length > 0 Then
                    .Add("@PropZip", SqlDbType.VarChar).Value = txtPropZip.Text
                Else
                    .Add("@PropZip", SqlDbType.VarChar).Value = DBNull.Value
                End If





                If txtSupervisorName.Text.Length > 0 Then
                    .Add("@SupervisorName", SqlDbType.VarChar).Value = txtSupervisorName.Text
                Else
                    .Add("@SupervisorName", SqlDbType.VarChar).Value = DBNull.Value
                End If

                If txtSupervisorPhone.Text.Length > 0 Then
                    .Add("@SupervisorPhone", SqlDbType.VarChar).Value = txtSupervisorPhone.Text
                Else
                    .Add("@SupervisorPhone", SqlDbType.VarChar).Value = DBNull.Value
                End If

                If txtManagerName.Text.Length > 0 Then
                    .Add("@ManagerName", SqlDbType.VarChar).Value = txtManagerName.Text
                Else
                    .Add("@ManagerName", SqlDbType.VarChar).Value = DBNull.Value
                End If

                If txtManagerPhone.Text.Length > 0 Then
                    .Add("@ManagerPhone", SqlDbType.VarChar).Value = txtManagerPhone.Text
                Else
                    .Add("@ManagerPhone", SqlDbType.VarChar).Value = DBNull.Value
                End If

                If txtManagerEmail.Text.Length > 0 Then
                    .Add("@ManagerEmail", SqlDbType.VarChar).Value = txtManagerEmail.Text
                Else
                    .Add("@ManagerEmail", SqlDbType.VarChar).Value = DBNull.Value
                End If






                If radInsuredPremises.SelectedIndex > -1 Then
                    .Add("@InsuredPremises", SqlDbType.VarChar).Value = radInsuredPremises.SelectedValue
                Else
                    .Add("@InsuredPremises", SqlDbType.VarChar).Value = DBNull.Value
                End If

                If radClaimant.SelectedIndex > -1 Then
                    .Add("@ClaimType", SqlDbType.VarChar).Value = radClaimant.SelectedValue
                Else
                    .Add("@ClaimType", SqlDbType.VarChar).Value = DBNull.Value
                End If

                If txtAccidentDate.Text.Length > 0 Then
                    .Add("@AccidentDate", SqlDbType.SmallDateTime).Value = txtAccidentDate.Text
                Else
                    .Add("@AccidentDate", SqlDbType.SmallDateTime).Value = DBNull.Value
                End If

                .Add("@SSNum", SqlDbType.VarChar).Value = txtSocial.Text

                .Add("@FirstName", SqlDbType.VarChar).Value = txtFirstName.Text
                .Add("@LastName", SqlDbType.VarChar).Value = txtLastName.Text
                .Add("@MiddleName", SqlDbType.VarChar).Value = txtMiddleName.Text

                If radGender.SelectedIndex > -1 Then
                    .Add("@Gender", SqlDbType.Char).Value = radGender.SelectedValue
                Else
                    .Add("@Gender", SqlDbType.Char).Value = DBNull.Value
                End If

                If txtDOB.Text.Length > 0 Then
                    .Add("@DOB", SqlDbType.SmallDateTime).Value = txtDOB.Text
                Else
                    .Add("@DOB", SqlDbType.SmallDateTime).Value = DBNull.Value
                End If

                .Add("@Address", SqlDbType.VarChar).Value = txtAddress.Text
                .Add("@City", SqlDbType.VarChar).Value = txtCity.Text
                .Add("@State", SqlDbType.VarChar).Value = dropState.SelectedItem.Text 'txtState.Text
                .Add("@Zip", SqlDbType.VarChar).Value = txtZip.Text


                .Add("@HomePhone", SqlDbType.VarChar).Value = txtPhone.Text
                .Add("@WorkPhone", SqlDbType.VarChar).Value = txtWorkPhone.Text
                .Add("@MobilePhone", SqlDbType.VarChar).Value = txtMobilePhone.Text



                If radPictures.SelectedIndex > -1 Then
                    .Add("@PicturesTaken", SqlDbType.Bit).Value = Convert.ToBoolean(radPictures.SelectedValue)
                Else
                    .Add("@PicturesTaken", SqlDbType.Bit).Value = DBNull.Value
                End If

                If radPropertyDamage.SelectedIndex > -1 Then
                    .Add("@PropertyDamage", SqlDbType.Bit).Value = Convert.ToBoolean(radPropertyDamage.SelectedValue)
                    If radPropertyDamage.SelectedValue = True Then
                        .Add("@PropertyDamageDesc", SqlDbType.VarChar).Value = txtPropertyDamage.Text

                        If txtRepairCost.Text.Length > 0 Then
                            .Add("@RepairCost", SqlDbType.Money).Value = txtRepairCost.Text
                        Else
                            .Add("@RepairCost", SqlDbType.Money).Value = DBNull.Value
                        End If

                        If radPropertyDamageOurPremises.SelectedIndex > -1 Then
                            .Add("@PropertyDamageOurPremises", SqlDbType.Bit).Value = Convert.ToBoolean(radPropertyDamageOurPremises.SelectedValue)
                        Else
                            .Add("@PropertyDamageOurPremises", SqlDbType.Bit).Value = DBNull.Value
                        End If

                    Else
                        .Add("@PropertyDamageDesc", SqlDbType.VarChar).Value = DBNull.Value
                        .Add("@RepairCost", SqlDbType.Money).Value = DBNull.Value

                        .Add("@PropertyDamageOurPremises", SqlDbType.Bit).Value = DBNull.Value
                    End If
                Else
                    .Add("@PropertyDamage", SqlDbType.Bit).Value = DBNull.Value
                    .Add("@PropertyDamageDesc", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@RepairCost", SqlDbType.Money).Value = DBNull.Value

                    .Add("@PropertyDamageOurPremises", SqlDbType.Bit).Value = DBNull.Value
                End If


                If radArrears.SelectedIndex > -1 Then
                    .Add("@RentArrears", SqlDbType.Bit).Value = Convert.ToBoolean(radArrears.SelectedValue)
                    If radArrears.SelectedValue = True Then
                        If txtRentDues.Text.Length > 0 Then
                            .Add("@RentDues", SqlDbType.Money).Value = txtRentDues.Text
                        Else
                            .Add("@RentDues", SqlDbType.Money).Value = DBNull.Value
                        End If
                    Else
                        .Add("@RentDues", SqlDbType.Money).Value = DBNull.Value
                    End If
                Else
                    .Add("@RentArrears", SqlDbType.Bit).Value = DBNull.Value
                    .Add("@RentDues", SqlDbType.Money).Value = DBNull.Value
                End If

                If radWaiver.SelectedIndex > -1 Then
                    .Add("@Waiver", SqlDbType.Bit).Value = Convert.ToBoolean(radWaiver.SelectedValue)
                Else
                    .Add("@Waiver", SqlDbType.Bit).Value = DBNull.Value
                End If



                If radMinor.SelectedIndex > -1 Then
                    .Add("@Minor", SqlDbType.Bit).Value = Convert.ToBoolean(radMinor.SelectedValue)
                    If radMinor.SelectedValue = True Then
                        .Add("@ParentGuardianName", SqlDbType.VarChar).Value = txtParentGuardianName.Text
                        .Add("@ParentGuardianAddress", SqlDbType.VarChar).Value = txtParentGuardianAddress.Text
                        .Add("@ParentGuardianCity", SqlDbType.VarChar).Value = txtParentGuardianCity.Text
                        .Add("@ParentGuardianState", SqlDbType.VarChar).Value = dropState2.SelectedItem.Text
                        .Add("@ParentGuardianZip", SqlDbType.VarChar).Value = TxtParentGuardianZip.Text
                        .Add("@ParentGuardianHomePhone", SqlDbType.VarChar).Value = txtParentGuardianHomePhone.Text
                        .Add("@ParentGuardianMobile", SqlDbType.VarChar).Value = txtParentGuardianMobilePhone.Text
                        .Add("@ParentGuardianWork", SqlDbType.VarChar).Value = txtParentGuardianWorkPhone.Text


                    Else
                        .Add("@ParentGuardianName", SqlDbType.VarChar).Value = DBNull.Value
                        .Add("@ParentGuardianAddress", SqlDbType.VarChar).Value = DBNull.Value
                        .Add("@ParentGuardianCity", SqlDbType.VarChar).Value = DBNull.Value
                        .Add("@ParentGuardianState", SqlDbType.VarChar).Value = DBNull.Value
                        .Add("@ParentGuardianZip", SqlDbType.VarChar).Value = DBNull.Value
                        .Add("@ParentGuardianHomePhone", SqlDbType.VarChar).Value = DBNull.Value
                        .Add("@ParentGuardianMobile", SqlDbType.VarChar).Value = DBNull.Value
                        .Add("@ParentGuardianWork", SqlDbType.VarChar).Value = DBNull.Value

                    End If
                Else
                    .Add("@Minor", SqlDbType.Bit).Value = DBNull.Value
                    .Add("@ParentGuardianName", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@ParentGuardianAddress", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@ParentGuardianCity", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@ParentGuardianState", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@ParentGuardianZip", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@ParentGuardianHomePhone", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@ParentGuardianMobile", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@ParentGuardianWork", SqlDbType.VarChar).Value = DBNull.Value

                End If





                If radMedicalAttention.SelectedIndex > -1 Then
                    .Add("@MedicalAttention", SqlDbType.Bit).Value = Convert.ToBoolean(radMedicalAttention.SelectedValue)
                    If radMedicalAttention.SelectedValue = True Then
                        .Add("@PhysicianName", SqlDbType.VarChar).Value = txtPhysicianName.Text
                        .Add("@PhysicianAddress", SqlDbType.VarChar).Value = txtPhysicianAddress.Text
                        .Add("@PhysicianContact", SqlDbType.VarChar).Value = txtPhysicianContact.Text
                        .Add("@PhysicianPhone", SqlDbType.VarChar).Value = txtPhysicianPhone.Text
                    Else
                        .Add("@PhysicianName", SqlDbType.VarChar).Value = DBNull.Value
                        .Add("@PhysicianAddress", SqlDbType.VarChar).Value = DBNull.Value
                        .Add("@PhysicianContact", SqlDbType.VarChar).Value = DBNull.Value
                        .Add("@PhysicianPhone", SqlDbType.VarChar).Value = DBNull.Value
                    End If
                Else
                    .Add("@MedicalAttention", SqlDbType.Bit).Value = DBNull.Value
                    .Add("@PhysicianName", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@PhysicianAddress", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@PhysicianContact", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@PhysicianPhone", SqlDbType.VarChar).Value = DBNull.Value
                End If

                If radAmbulance.SelectedIndex > -1 Then
                    .Add("@Ambulance", SqlDbType.Bit).Value = Convert.ToBoolean(radAmbulance.SelectedValue)
                Else
                    .Add("@Ambulance", SqlDbType.Bit).Value = DBNull.Value
                End If

                If radWitnesses.SelectedIndex > -1 Then
                    .Add("@Witnesses", SqlDbType.Bit).Value = Convert.ToBoolean(radWitnesses.SelectedValue)
                    If radWitnesses.SelectedValue = True Then
                        .Add("@WitnessName1", SqlDbType.VarChar).Value = txtWitnessName1.Text
                        .Add("@WitnessAddress1", SqlDbType.VarChar).Value = txtWitnessAddress1.Text
                        .Add("@WitnessCity1", SqlDbType.VarChar).Value = txtWitnessCity1.Text
                        .Add("@WitnessState1", SqlDbType.VarChar).Value = dropWitnessState1.SelectedItem.Text 'txtWitnessState1.Text
                        .Add("@WitnessZip1", SqlDbType.VarChar).Value = txtWitnessZip1.Text
                        .Add("@WitnessPhone1", SqlDbType.VarChar).Value = txtWitnessPhone1.Text
                        .Add("@WitnessMobile1", SqlDbType.VarChar).Value = txtWitnessMobile1.Text
                        .Add("@WitnessWork1", SqlDbType.VarChar).Value = txtWitnessWork1.Text


                        .Add("@WitnessName2", SqlDbType.VarChar).Value = txtWitnessName2.Text
                        .Add("@WitnessAddress2", SqlDbType.VarChar).Value = txtWitnessAddress2.Text
                        .Add("@WitnessCity2", SqlDbType.VarChar).Value = txtWitnessCity2.Text
                        .Add("@WitnessState2", SqlDbType.VarChar).Value = dropWitnessState2.SelectedItem.Text
                        .Add("@WitnessZip2", SqlDbType.VarChar).Value = txtWitnessZip2.Text
                        .Add("@WitnessPhone2", SqlDbType.VarChar).Value = txtWitnessPhone2.Text
                        .Add("@WitnessMobile2", SqlDbType.VarChar).Value = txtWitnessMobile2.Text
                        .Add("@WitnessWork2", SqlDbType.VarChar).Value = txtWitnessWork2.Text

                    Else
                        .Add("@WitnessName1", SqlDbType.VarChar).Value = DBNull.Value
                        .Add("@WitnessAddress1", SqlDbType.VarChar).Value = DBNull.Value
                        .Add("@WitnessCity1", SqlDbType.VarChar).Value = DBNull.Value
                        .Add("@WitnessState1", SqlDbType.VarChar).Value = DBNull.Value
                        .Add("@WitnessZip1", SqlDbType.VarChar).Value = DBNull.Value
                        .Add("@WitnessPhone1", SqlDbType.VarChar).Value = DBNull.Value
                        .Add("@WitnessMobile1", SqlDbType.VarChar).Value = DBNull.Value
                        .Add("@WitnessWork1", SqlDbType.VarChar).Value = DBNull.Value

                        .Add("@WitnessName2", SqlDbType.VarChar).Value = DBNull.Value
                        .Add("@WitnessAddress2", SqlDbType.VarChar).Value = DBNull.Value
                        .Add("@WitnessCity2", SqlDbType.VarChar).Value = DBNull.Value
                        .Add("@WitnessState2", SqlDbType.VarChar).Value = DBNull.Value
                        .Add("@WitnessZip2", SqlDbType.VarChar).Value = DBNull.Value
                        .Add("@WitnessPhone2", SqlDbType.VarChar).Value = DBNull.Value
                        .Add("@WitnessMobile2", SqlDbType.VarChar).Value = DBNull.Value
                        .Add("@WitnessWork2", SqlDbType.VarChar).Value = DBNull.Value
                    End If
                Else
                    .Add("@Witnesses", SqlDbType.Bit).Value = DBNull.Value
                    .Add("@WitnessName1", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@WitnessAddress1", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@WitnessCity1", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@WitnessState1", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@WitnessZip1", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@WitnessPhone1", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@WitnessMobile1", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@WitnessWork1", SqlDbType.VarChar).Value = DBNull.Value

                    .Add("@WitnessName2", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@WitnessAddress2", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@WitnessCity2", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@WitnessState2", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@WitnessZip2", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@WitnessPhone2", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@WitnessMobile2", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@WitnessWork2", SqlDbType.VarChar).Value = DBNull.Value
                End If


                If dropIncidentType.SelectedItem.Text.Length > 0 Then
                    .Add("@IncidentType", Data.SqlDbType.VarChar).Value = dropIncidentType.SelectedValue
                Else
                    .Add("@IncidentType", Data.SqlDbType.VarChar).Value = DBNull.Value
                End If

                .Add("@IncidentTime", SqlDbType.VarChar).Value = txtIncidentTime.Text
                .Add("@FloorType", SqlDbType.VarChar).Value = txtFloorType.Text
                .Add("@InjuryDesc", SqlDbType.VarChar).Value = txtInjuryDesc.Text

                If radInspectedImmediately.SelectedIndex > -1 Then
                    .Add("@InspectedImmediately", SqlDbType.Bit).Value = Convert.ToBoolean(radInspectedImmediately.SelectedValue)
                Else
                    .Add("@InspectedImmediately", SqlDbType.Bit).Value = DBNull.Value
                End If

                'If radLocationClean.SelectedIndex > -1 Then
                '    .Add("@LocationClean", SqlDbType.Bit).Value = Convert.ToBoolean(radLocationClean.SelectedValue)
                'Else
                '    .Add("@LocationClean", SqlDbType.Bit).Value = DBNull.Value
                'End If
                If radLocationClean.SelectedIndex > -1 Then
                    .Add("@LocationClean", SqlDbType.Int).Value = radLocationClean.SelectedValue
                Else
                    .Add("@LocationClean", SqlDbType.Int).Value = DBNull.Value
                End If

                If radLocationDry.SelectedIndex > -1 Then
                    .Add("@LocationDry", SqlDbType.Int).Value = radLocationDry.SelectedValue
                Else
                    .Add("@LocationDry", SqlDbType.Int).Value = DBNull.Value
                End If

                'If radLocationDry.SelectedIndex > -1 Then
                '    .Add("@LocationDry", SqlDbType.Bit).Value = Convert.ToBoolean(radLocationDry.SelectedValue)
                'Else
                '    .Add("@LocationDry", SqlDbType.Bit).Value = DBNull.Value
                'End If

                If radObstruction.SelectedIndex > -1 Then
                    .Add("@Obstruction", SqlDbType.Bit).Value = Convert.ToBoolean(radObstruction.SelectedValue)
                    If radObstruction.SelectedValue = True Then
                        .Add("@ObstructionType", SqlDbType.VarChar).Value = txtObstructionType.Text
                    Else
                        .Add("@ObstructionType", SqlDbType.VarChar).Value = DBNull.Value
                    End If
                Else
                    .Add("@Obstruction", SqlDbType.Bit).Value = DBNull.Value
                    .Add("@ObstructionType", SqlDbType.VarChar).Value = DBNull.Value
                End If

                .Add("@Weather", SqlDbType.VarChar).Value = txtWeather.Text
                .Add("@ShoeType", SqlDbType.VarChar).Value = txtShoeType.Text

                If radCarryingObjects.SelectedIndex > -1 Then
                    .Add("@CarryingObjects", SqlDbType.Int).Value = radCarryingObjects.SelectedValue
                    If radCarryingObjects.SelectedValue = 1 Then
                        .Add("@ObjectsCarried", SqlDbType.VarChar).Value = txtObjectsCarried.Text
                    Else
                        .Add("@ObjectsCarried", SqlDbType.VarChar).Value = DBNull.Value
                    End If
                Else
                    .Add("@CarryingObjects", SqlDbType.Int).Value = DBNull.Value
                    .Add("@ObjectsCarried", SqlDbType.VarChar).Value = DBNull.Value
                End If


                If radSurveillance.SelectedIndex > -1 Then
                    .Add("@Surveillance", SqlDbType.Bit).Value = Convert.ToBoolean(radSurveillance.SelectedValue)
                    If radSurveillance.SelectedValue = True Then
                        .Add("@Film", SqlDbType.Int).Value = radFilm.SelectedValue
                        .Add("@FilmComment", SqlDbType.VarChar).Value = txtFilm.Text
                    Else
                        .Add("@Film", SqlDbType.Int).Value = DBNull.Value
                        .Add("@FilmComment", SqlDbType.VarChar).Value = DBNull.Value
                    End If
                Else
                    .Add("@Surveillance", SqlDbType.Bit).Value = DBNull.Value
                    .Add("@Film", SqlDbType.Int).Value = DBNull.Value
                    .Add("@FilmComment", SqlDbType.VarChar).Value = DBNull.Value
                End If





                .Add("@FullIncidentDesc", SqlDbType.VarChar).Value = txtFullDesc.Text


                If radClaimType.SelectedIndex > -1 Then
                    .Add("@GLorAutoClaim", SqlDbType.VarChar).Value = radClaimType.SelectedValue
                Else
                    .Add("@GLorAutoClaim", SqlDbType.VarChar).Value = DBNull.Value
                End If

                'If radsubmitTpa.SelectedIndex > -1 Then
                '    .Add("@SubmitTpa", SqlDbType.VarChar).Value = radsubmitTpa.SelectedValue
                'Else
                '    .Add("@SubmitTpa", SqlDbType.VarChar).Value = DBNull.Value
                'End If


                If radSelfAdministered.SelectedIndex > -1 Then
                    .Add("@SelfAdministered", SqlDbType.Bit).Value = Convert.ToBoolean(radSelfAdministered.SelectedValue)

                    'If radSelfAdministered.SelectedValue = True Then
                    '    .Add("@SelfAdminSttlmnt", SqlDbType.VarChar).Value = txtSelfAdminSttlmnt.Text

                    'Else
                    '    .Add("@SelfAdminSttlmnt", SqlDbType.Bit).Value = DBNull.Value

                    'End If

                Else
                    ' .Add("@SelfAdminSttlmnt", SqlDbType.Bit).Value = DBNull.Value
                    .Add("@SelfAdministered", SqlDbType.VarChar).Value = DBNull.Value
                End If


                If radsubmitTpa.SelectedIndex > -1 Then
                    .Add("@SubmitTpa", SqlDbType.Bit).Value = Convert.ToBoolean(radsubmitTpa.SelectedValue)

                    If radsubmitTpa.SelectedValue = True Then
                        .Add("@FileNum", SqlDbType.VarChar).Value = txtFileNum.Text
                        .Add("@TpaAdjusterName", SqlDbType.VarChar).Value = txtTpaAdjuster.Text

                    Else
                        .Add("@FileNum", SqlDbType.Bit).Value = DBNull.Value
                        .Add("@TpaAdjusterName", SqlDbType.VarChar).Value = DBNull.Value

                    End If
                Else
                    .Add("@SubmitTpa", SqlDbType.Bit).Value = DBNull.Value
                    .Add("@FileNum", SqlDbType.Bit).Value = DBNull.Value
                    .Add("@TpaAdjusterName", SqlDbType.VarChar).Value = DBNull.Value

                End If


                If radTpaSubmitCarrier.SelectedIndex > -1 Then
                    .Add("@TpaSubmitCarrier", SqlDbType.Bit).Value = Convert.ToBoolean(radTpaSubmitCarrier.SelectedValue)

                    If radTpaSubmitCarrier.SelectedValue = True Then
                        .Add("@TpaCarrierClaimNum", SqlDbType.VarChar).Value = txtTpaCarrierClaimNum.Text
                        .Add("@TpaCarrierAdjName", SqlDbType.VarChar).Value = txtTpaCarrierAdjName.Text
                        .Add("@TpaCarrierAdjContact", SqlDbType.VarChar).Value = txtTpaCarrierAdjContact.Text

                    Else
                        .Add("@TpaCarrierClaimNum", SqlDbType.VarChar).Value = DBNull.Value
                        .Add("@TpaCarrierAdjName", SqlDbType.VarChar).Value = DBNull.Value
                        .Add("@TpaCarrierAdjContact", SqlDbType.VarChar).Value = DBNull.Value

                    End If
                Else
                    .Add("@TpaCarrierClaimNum", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@TpaCarrierAdjName", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@TpaCarrierAdjContact", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@TpaSubmitCarrier", SqlDbType.VarChar).Value = DBNull.Value



                End If



                'If radReportCarrier.SelectedIndex > -1 Then
                '    .Add("@ReportCarrier", SqlDbType.Bit).Value = radReportCarrier.SelectedValue
                'Else
                '    .Add("@ReportCarrier", SqlDbType.Bit).Value = DBNull.Value
                'End If


                If radReportCarrier.SelectedIndex > -1 Then
                    .Add("@ReportCarrier", SqlDbType.Bit).Value = Convert.ToBoolean(radReportCarrier.SelectedValue)

                    If radReportCarrier.SelectedValue = True Then
                        .Add("@CarrierClaimNum", SqlDbType.VarChar).Value = txtCarrierClaimNum.Text
                        .Add("@CarrierAdjusterName", SqlDbType.VarChar).Value = txtCarrierAdjuster.Text
                        .Add("@CarrierAdjusterPhone", SqlDbType.VarChar).Value = txtCarrierAdjusterPhone.Text

                    Else
                        .Add("@CarrierClaimNum", SqlDbType.VarChar).Value = DBNull.Value
                        .Add("@CarrierAdjusterName", SqlDbType.VarChar).Value = DBNull.Value
                        .Add("@CarrierAdjusterPhone", SqlDbType.VarChar).Value = DBNull.Value
                    End If


                Else
                    .Add("@ReportCarrier", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@CarrierClaimNum", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@CarrierAdjusterName", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@CarrierAdjusterPhone", SqlDbType.VarChar).Value = DBNull.Value
                End If


                'If radAutoClaimSettled.SelectedIndex > -1 Then
                '    .Add("@AutoClaimSettled", SqlDbType.Bit).Value = radAutoClaimSettled.SelectedValue
                '    .Add("@LitigClaimSettled", SqlDbType.Bit).Value = radLitigClaimSettled.SelectedValue

                'Else
                '    .Add("@AutoClaimSettled", SqlDbType.Bit).Value = DBNull.Value
                '    .Add("@LitigClaimSettled", SqlDbType.Bit).Value = DBNull.Value
                'End If


                'If radLitigClaimSettled.SelectedIndex > -1 Then
                '    .Add("@LitigClaimSettled", SqlDbType.Bit).Value = radLitigClaimSettled.SelectedValue

                'Else

                '    .Add("@LitigClaimSettled", SqlDbType.Bit).Value = DBNull.Value
                'End If



                If radLitigClaimSettled.SelectedIndex > -1 Then
                    .Add("@ClaimSettled", SqlDbType.Bit).Value = Convert.ToBoolean(radLitigClaimSettled.SelectedValue)

                    If radLitigClaimSettled.SelectedValue = True Then
                        If txtGlSettlementAmount.Text.Length > 0 Then
                            .Add("@SettlementAmount", SqlDbType.Money).Value = txtGlSettlementAmount.Text
                        Else
                            .Add("@SettlementAmount", SqlDbType.Money).Value = DBNull.Value
                        End If

                        If txtCheckDate1.Text.Length > 0 Then
                            .Add("@CheckDate1", SqlDbType.SmallDateTime).Value = txtCheckDate1.Text
                        Else
                            .Add("@CheckDate1", SqlDbType.SmallDateTime).Value = DBNull.Value
                        End If

                        If txtCheckDate2.Text.Length > 0 Then
                            .Add("@CheckDate2", SqlDbType.SmallDateTime).Value = txtCheckDate2.Text
                        Else
                            .Add("@CheckDate2", SqlDbType.SmallDateTime).Value = DBNull.Value
                        End If

                        If txtCheckDate3.Text.Length > 0 Then
                            .Add("@CheckDate3", SqlDbType.SmallDateTime).Value = txtCheckDate3.Text
                        Else
                            .Add("@CheckDate3", SqlDbType.SmallDateTime).Value = DBNull.Value
                        End If

                        If txtCheckDate4.Text.Length > 0 Then
                            .Add("@CheckDate4", SqlDbType.SmallDateTime).Value = txtCheckDate4.Text
                        Else
                            .Add("@CheckDate4", SqlDbType.SmallDateTime).Value = DBNull.Value
                        End If

                        If txtCheckAmnt1.Text.Length > 0 Then
                            .Add("@CheckAmnt1", SqlDbType.Money).Value = txtCheckAmnt1.Text

                        Else
                            .Add("@CheckAmnt1", SqlDbType.Money).Value = DBNull.Value
                        End If

                        If txtCheckAmnt2.Text.Length > 0 Then
                            .Add("@CheckAmnt2", SqlDbType.Money).Value = txtCheckAmnt2.Text

                        Else
                            .Add("@CheckAmnt2", SqlDbType.Money).Value = DBNull.Value
                        End If

                        If txtCheckAmnt3.Text.Length > 0 Then
                            .Add("@CheckAmnt3", SqlDbType.Money).Value = txtCheckAmnt3.Text

                        Else
                            .Add("@CheckAmnt3", SqlDbType.Money).Value = DBNull.Value
                        End If

                        If txtCheckAmnt4.Text.Length > 0 Then
                            .Add("@CheckAmnt4", SqlDbType.Money).Value = txtCheckAmnt4.Text

                        Else
                            .Add("@CheckAmnt4", SqlDbType.Money).Value = DBNull.Value
                        End If

                        If txtTotalClaimCost.Text.Length > 0 Then

                            .Add("@Total", SqlDbType.Money).Value = txtTotalClaimCost.Text
                        Else
                            .Add("@Total", SqlDbType.Money).Value = DBNull.Value
                        End If

                        .Add("@CheckNum1", SqlDbType.VarChar).Value = txtCheckNum1.Text
                        .Add("@CheckNum2", SqlDbType.VarChar).Value = txtCheckNum2.Text
                        .Add("@CheckNum3", SqlDbType.VarChar).Value = txtCheckNum3.Text
                        .Add("@CheckNum4", SqlDbType.VarChar).Value = txtCheckNum4.Text

                        .Add("@Payee1", SqlDbType.VarChar).Value = txtPayee1.Text
                        .Add("@Payee2", SqlDbType.VarChar).Value = txtPayee2.Text
                        .Add("@Payee3", SqlDbType.VarChar).Value = txtPayee3.Text
                        .Add("@Payee4", SqlDbType.VarChar).Value = txtPayee4.Text
                    Else

                        .Add("@CheckNum1", SqlDbType.VarChar).Value = DBNull.Value
                        .Add("@CheckNum2", SqlDbType.VarChar).Value = DBNull.Value
                        .Add("@CheckNum3", SqlDbType.VarChar).Value = DBNull.Value
                        .Add("@CheckNum4", SqlDbType.VarChar).Value = DBNull.Value

                        .Add("@Payee1", SqlDbType.VarChar).Value = DBNull.Value
                        .Add("@Payee2", SqlDbType.VarChar).Value = DBNull.Value
                        .Add("@Payee3", SqlDbType.VarChar).Value = DBNull.Value
                        .Add("@Payee4", SqlDbType.VarChar).Value = DBNull.Value


                        .Add("@CheckDate1", SqlDbType.SmallDateTime).Value = DBNull.Value
                        .Add("@CheckDate2", SqlDbType.SmallDateTime).Value = DBNull.Value
                        .Add("@CheckDate3", SqlDbType.SmallDateTime).Value = DBNull.Value
                        .Add("@CheckDate4", SqlDbType.SmallDateTime).Value = DBNull.Value

                        .Add("@CheckAmnt1", SqlDbType.Money).Value = DBNull.Value
                        .Add("@CheckAmnt2", SqlDbType.Money).Value = DBNull.Value
                        .Add("@CheckAmnt3", SqlDbType.Money).Value = DBNull.Value
                        .Add("@CheckAmnt4", SqlDbType.Money).Value = DBNull.Value

                        .Add("@Total", SqlDbType.Money).Value = DBNull.Value

                        .Add("@SettlementAmount", SqlDbType.Money).Value = DBNull.Value
                        .Add("@ClaimSettled", SqlDbType.Money).Value = DBNull.Value


                    End If

                Else
                    .Add("@CheckNum1", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@CheckNum2", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@CheckNum3", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@CheckNum4", SqlDbType.VarChar).Value = DBNull.Value

                    .Add("@Payee1", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@Payee2", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@Payee3", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@Payee4", SqlDbType.VarChar).Value = DBNull.Value

                    .Add("@CheckDate1", SqlDbType.SmallDateTime).Value = DBNull.Value
                    .Add("@CheckDate2", SqlDbType.SmallDateTime).Value = DBNull.Value
                    .Add("@CheckDate3", SqlDbType.SmallDateTime).Value = DBNull.Value
                    .Add("@CheckDate4", SqlDbType.SmallDateTime).Value = DBNull.Value

                    .Add("@CheckAmnt1", SqlDbType.Money).Value = DBNull.Value
                    .Add("@CheckAmnt2", SqlDbType.Money).Value = DBNull.Value
                    .Add("@CheckAmnt3", SqlDbType.Money).Value = DBNull.Value
                    .Add("@CheckAmnt4", SqlDbType.Money).Value = DBNull.Value

                    .Add("@Total", SqlDbType.Money).Value = DBNull.Value

                    .Add("@SettlementAmount", SqlDbType.Money).Value = DBNull.Value
                    .Add("@ClaimSettled", SqlDbType.Money).Value = DBNull.Value
                End If





                If radClaimLitigation.SelectedIndex > -1 Then
                    .Add("@ClaimLitigation", SqlDbType.Bit).Value = Convert.ToBoolean(radClaimLitigation.SelectedValue)

                    If radClaimLitigation.SelectedValue = True Then
                        .Add("@DefenseCounselName", SqlDbType.VarChar).Value = txtDefenseCounsel.Text
                        .Add("@CounselContact", SqlDbType.VarChar).Value = txtCounselContact.Text
                        .Add("@DocketNum", SqlDbType.VarChar).Value = txtDocketNum.Text
                        .Add("@LitigClaimNum", SqlDbType.VarChar).Value = txtLitigClaimNum.Text


                    Else
                        .Add("@DefenseCounselName", SqlDbType.VarChar).Value = DBNull.Value
                        .Add("@CounselContact", SqlDbType.VarChar).Value = DBNull.Value
                        .Add("@DocketNum", SqlDbType.VarChar).Value = DBNull.Value
                        .Add("@LitigClaimNum", SqlDbType.VarChar).Value = DBNull.Value
                    End If


                Else
                    .Add("@ClaimLitigation", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@DefenseCounselName", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@CounselContact", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@DocketNum", SqlDbType.VarChar).Value = DBNull.Value
                    .Add("@LitigClaimNum", SqlDbType.VarChar).Value = DBNull.Value
                End If


            End With


            parmClaimId = cmdSave.Parameters.Add("@insid", Data.SqlDbType.Int)
            parmClaimId.Size = 4
            parmClaimId.Direction = Data.ParameterDirection.Output

            cmdSave.ExecuteNonQuery()

            If Session("ClaimId") Is Nothing Then
                Session("ClaimId") = cmdSave.Parameters("@insid").Value
                lblClaimId.Text = Session("ClaimId")

                Dim curSession As String = HttpContext.Current.Session.SessionID
                Dim savePath As String = "Claims\Temp\" & curSession
                Dim savePath2 As String = "Claims\" & Session("ClaimId")


                If Directory.Exists(Server.MapPath(savePath)) Then
                    'System.IO.Directory.Delete(Server.MapPath(savePath))
                    If Directory.Exists(Server.MapPath(savePath)) Then
                        ' System.IO.Directory.Delete(Server.MapPath(savePath))

                        Dim folder As New DirectoryInfo(Server.MapPath(savePath))

                        If folder.GetFiles.Length > 0 Then
                            Try
                                Directory.CreateDirectory(Server.MapPath(savePath2))
                                Dim folder2 As New DirectoryInfo(Server.MapPath(savePath2))

                                For Each file As FileInfo In folder.GetFiles
                                    'Response.Write(Server.MapPath(savePath2) & "\" & file.Name)
                                    file.MoveTo(Server.MapPath(savePath2) & "\" & file.Name)
                                    'file.Delete()
                                Next

                                folder.Delete()

                            Catch ex As Exception
                                Response.Write(ex.Message)
                            End Try

                        End If

                    End If
                End If
            End If


            'lblClaimant.Text = txtFirstName.Text & " " & txtLastName.Text
            'lblProp.Text = dropProp.SelectedItem.Text
            'lblBldg.Text = dropBldg.SelectedItem.Text

            Trace.Warn("ViewState(""Reviewed""): " & ViewState("Reviewed") & "  hidSubmitted.Value: " & hidSubmitted.Value & " chkReviewed.Checked: " & chkReviewed.Checked)
            If ViewState("Reviewed") = False And hidSubmitted.Value = 1 And chkReviewed.Checked = True Then
                SendEmailReviewed(conInsurance)
            End If

            Trace.Warn("blnSubmit: " & blnSubmit)
            If blnSubmit Then
                SendEmailSubmitted(conInsurance)
            End If

            GetClaim(conInsurance)

            conInsurance.Close()



        End If
    End Sub

    Private Sub SendEmailReviewed(ByVal conInsurance As SqlConnection)
        Dim strTo, strFrom As String

        Trace.Warn("In Email Review")

        Dim cmdSelect As New SqlCommand("select top 1 isnull(email,'')  from permissions p where username='" & Session("UserName") & "'", conInsurance)
        strFrom = cmdSelect.ExecuteScalar

        cmdSelect = New SqlCommand("select top 1 isnull(email,'')  from permissions p where username='" & ViewState("SubmittedBy") & "'", conInsurance)
        strTo = cmdSelect.ExecuteScalar


        If strTo.Length > 0 And strFrom.Length > 0 Then
            Dim msgMail As New MailMessage()
            msgMail.From = New MailAddress(strFrom)

            msgMail.To.Add(New MailAddress(strTo))
            msgMail.Subject = "Insurance Claim #: " & Session("ClaimId")

            Dim strBody As String = "This is to inform you that Insurance Claim #: " & Session("ClaimId") & " has been reviewed. "
            strBody += "If you have any questions please contact the office."

            msgMail.Body = strBody
            msgMail.IsBodyHtml = False


            Dim smtp As New SmtpClient()
            'smtp.Host = "mail.managertechnologies.com"
            'smtp.Host = "www.remotelandlord.net"
            'smtp.Port = 58012
            'smtp.Credentials = New Net.NetworkCredential("dlieberman", "davel")

            Dim strResult As String

            Try
                smtp.Send(msgMail)
                strResult = "An Email informing of reviewed claim was sent successfully to " & strTo & "."
            Catch smtpEx As SmtpException
                'sendStatus = 0
                strResult = smtpEx.Message

            Catch generalEx As Exception
                ' sendStatus = 0
                strResult = generalEx.Message

            End Try

            Dim end1 As String = "</"
            Dim strScript As String = "<script language=""javascript"">" & vbCrLf & "<!-- " & vbCrLf & "alert('" & strResult & "');//-->" & end1 & "script>"
            ClientScript.RegisterStartupScript(GetType(Page), "EmailUser", strScript)
        Else
            If strTo.Length = 0 Then
                Dim end1 As String = "</"
                Dim strScript As String = "<script language=""javascript"">" & vbCrLf & "<!-- " & vbCrLf & "alert('An email has not been sent to user notifying that claim has been reviewed\nbecause user " & ViewState("SubmittedBy") & " does not have an email address in the system.\nPlease contact your administrator.');//-->" & end1 & "script>"
                ClientScript.RegisterStartupScript(GetType(Page), "NOEmailUser", strScript)
            Else
                Dim end1 As String = "</"
                Dim strScript As String = "<script language=""javascript"">" & vbCrLf & "<!-- " & vbCrLf & "alert('An email has not been sent to user notifying that claim has been reviewed\nbecause you do not have an email address in the system.\nPlease contact your administrator.');//-->" & end1 & "script>"
                ClientScript.RegisterStartupScript(GetType(Page), "NOEmailFrom", strScript)
            End If

        End If
    End Sub

    Private Sub SendEmailSubmitted(ByVal conInsurance As SqlConnection)
        Dim strTo, strFrom As String

        Trace.Warn("in sendEmailSubmitted")

        ' Dim cmdSelect As New SqlCommand("select top 1 isnull(email,'')  from permissions p where username='" & Session("UserName") & "'", conInsurance)
        'strFrom = cmdSelect.ExecuteScalar
        strFrom = "claims@lightstonegroup.com"
        'strFrom = "mbrodsky@lightstonegroup.com"
        'strFrom = "verygross@gmail.com"

        Dim cmdSelect As New SqlCommand("select top 1 isnull(email,'')  from permissions p where username='" & Session("UserName") & "'", conInsurance)
        strTo = cmdSelect.ExecuteScalar


        If strTo.Length > 0 Then
            Dim msgMail As New MailMessage()
            msgMail.From = New MailAddress(strFrom)

            msgMail.To.Add(New MailAddress(strTo))
            msgMail.Subject = "Insurance Claim #: " & Session("ClaimId")

            Dim strBody As String = "This is to inform you that Insurance Claim #: " & Session("ClaimId") & " has been submitted. "
            strBody += "If you have any questions please contact the office."

            msgMail.Body = strBody
            msgMail.IsBodyHtml = False


            Dim smtp As New SmtpClient()
            'smtp.Host = "www.remotelandlord.net"
            'smtp.Port = 58012
            'smtp.Credentials = New Net.NetworkCredential("dlieberman", "davel")

            smtp.Send(msgMail)
            'Dim strResult As String

            'Try
            '    smtp.Send(msgMail)
            '    strResult = "Email was sent successfully to " & strTo & "."
            'Catch smtpEx As SmtpException
            '    'sendStatus = 0
            '    strResult = smtpEx.Message

            'Catch generalEx As Exception
            '    ' sendStatus = 0
            '    strResult = generalEx.Message

            'End Try

            'Dim end1 As String = "</"
            'Dim strScript As String = "<script language=""javascript"">" & vbCrLf & "<!-- " & vbCrLf & "alert('" & strResult & "');//-->" & end1 & "script>"
            'ClientScript.RegisterStartupScript(GetType(Page), "EmailUser", strScript)
        Else
            'If strTo.Length = 0 Then
            '    Dim end1 As String = "</"
            '    Dim strScript As String = "<script language=""javascript"">" & vbCrLf & "<!-- " & vbCrLf & "alert('An email has not been sent to user notifying that claim has been reviewed\nbecause user " & ViewState("SubmittedBy") & " does not have an email address in the system.\nPlease contact your administrator.');//-->" & end1 & "script>"
            '    ClientScript.RegisterStartupScript(GetType(Page), "NOEmailUser", strScript)
            'Else
            '    Dim end1 As String = "</"
            '    Dim strScript As String = "<script language=""javascript"">" & vbCrLf & "<!-- " & vbCrLf & "alert('An email has not been sent to user notifying that claim has been reviewed\nbecause you do not have an email address in the system.\nPlease contact your administrator.');//-->" & end1 & "script>"
            '    ClientScript.RegisterStartupScript(GetType(Page), "NOEmailFrom", strScript)
            'End If

        End If
    End Sub

    Private Sub GetClaim(ByVal conInsurance As SqlConnection)
        Dim reader As SqlDataReader

        Dim cmdSelect As New SqlCommand("GetClaim", conInsurance)
        cmdSelect.CommandType = Data.CommandType.StoredProcedure
        'Response.Write(Session("ClaimId"))
        'Response.End()
        cmdSelect.Parameters.Add("@ClaimId", SqlDbType.Int).Value = Session("ClaimId")

        lblClaimId.Text = Session("ClaimId")

        reader = cmdSelect.ExecuteReader

        If reader.HasRows Then
            reader.Read()

            Dim strClaimant As String = ""
            If reader.Item("FirstName") IsNot DBNull.Value Then strClaimant = reader.Item("FirstName")
            If reader.Item("MiddleName") IsNot DBNull.Value Then strClaimant = strClaimant & " " & reader.Item("MiddleName")
            If reader.Item("LastName") IsNot DBNull.Value Then strClaimant = strClaimant & " " & reader.Item("LastName")


            If reader.Item("Submitted") = True Then
                btnSubmit.Visible = False
                btnSave.Visible = False
                Button1.Visible = False
                Button2.Visible = False
                Button3.Visible = False

                btnAttachPhotos.Enabled = False
            End If



            lblClaimant.Text = strClaimant

            lblStatus.Text = reader.Item("Status")

            If reader.Item("Status") = "Reviewed" Then
                chkReviewed.Checked = True
            Else
                chkReviewed.Checked = False
            End If

            ViewState("Reviewed") = chkReviewed.Checked
            ViewState("SubmittedBy") = reader.Item("username")

            hidSubmitted.Value = Convert.ToInt32(reader.Item("Submitted")).ToString
            Trace.Warn("hidSubmitted.Value: " & hidSubmitted.Value)

            dropProp.SelectedIndex = -1
            If Not reader.Item("Propid") Is DBNull.Value Then
                dropProp.Items.FindByValue(reader.Item("Propid")).Selected = True
                'lblProp.Text = dropProp.SelectedItem.Text
                lblProp.Text = Left(dropProp.SelectedItem.Text, 50)

                PropSelect()
            Else
                dropBldg.Items.Add(New WebControls.ListItem("", -1))
            End If

            dropBldg.SelectedIndex = -1
            If Not reader.Item("bldgid") Is DBNull.Value Then
                dropBldg.Items.FindByValue(reader.Item("bldgid")).Selected = True
                ' lblBldg.Text = dropBldg.SelectedItem.Text
                lblBldg.Text = Left(dropBldg.SelectedItem.Text, 40)
            End If



            If reader("location") IsNot DBNull.Value Then
                txtLocation.Text = reader("location")
            Else
                txtLocation.Text = ""
            End If



            '5/13/11
            If reader("PropAddress") IsNot DBNull.Value Then
                txtPropAddress.Text = reader("PropAddress")
            Else
                txtPropAddress.Text = ""
            End If


            If reader("PropCity") IsNot DBNull.Value Then
                txtPropCity.Text = reader("PropCity")
            Else
                txtPropCity.Text = ""
            End If

            ddlPropState.SelectedIndex = -1
            If reader("PropState") IsNot DBNull.Value Then
                ddlPropState.Items.FindByText(reader("PropState")).Selected = True
            Else
                ddlPropState.SelectedIndex = 0
            End If


            If reader("PropZip") IsNot DBNull.Value Then
                txtPropZip.Text = reader("PropZip")
            Else
                txtPropZip.Text = ""
            End If





            If reader("SupervisorName") IsNot DBNull.Value Then
                txtSupervisorName.Text = reader("SupervisorName")
            Else
                txtSupervisorName.Text = ""
            End If

            If reader("SupervisorPhone") IsNot DBNull.Value Then
                txtSupervisorPhone.Text = reader("SupervisorPhone")
            Else
                txtSupervisorPhone.Text = ""
            End If

            If reader("ManagerName") IsNot DBNull.Value Then
                txtManagerName.Text = reader("ManagerName")
            Else
                txtManagerName.Text = ""
            End If

            If reader("ManagerPhone") IsNot DBNull.Value Then
                txtManagerPhone.Text = reader("ManagerPhone")
            Else
                txtManagerPhone.Text = ""
            End If

            If reader("ManagerEmail") IsNot DBNull.Value Then
                txtManagerEmail.Text = reader("ManagerEmail")
            Else
                txtManagerEmail.Text = ""
            End If







            If Not reader.Item("InsuredPremises") Is DBNull.Value Then
                radInsuredPremises.SelectedValue = Convert.ToInt32(reader.Item("InsuredPremises"))
            Else
                radInsuredPremises.SelectedIndex = -1
            End If

            If Not reader.Item("ClaimType") Is DBNull.Value Then
                radClaimant.SelectedValue = reader.Item("ClaimType")
            Else
                radClaimant.SelectedIndex = -1
            End If

            If Not reader.Item("AccidentDate") Is DBNull.Value Then
                txtAccidentDate.Text = reader.Item("AccidentDate")
            Else
                txtAccidentDate.Text = ""
            End If

            txtSocial.Text = reader.Item("SSNum")
            txtFirstName.Text = reader.Item("FirstName")
            txtLastName.Text = reader.Item("LastName")
            txtMiddleName.Text = reader.Item("MiddleName")

            If Not reader.Item("Gender") Is DBNull.Value Then
                radGender.SelectedValue = reader.Item("Gender")
            Else
                radGender.SelectedIndex = -1
            End If

            If Not reader.Item("DOB") Is DBNull.Value Then
                txtDOB.Text = reader.Item("DOB")
            Else
                txtDOB.Text = ""
            End If

            txtAddress.Text = reader.Item("Address")
            txtCity.Text = reader.Item("City")

            dropState.SelectedIndex = -1
            If reader("state") IsNot DBNull.Value Then
                dropState.Items.FindByText(reader("State")).Selected = True
            Else
                dropState.SelectedIndex = 0
            End If


            txtZip.Text = reader.Item("Zip")

            If Not reader.Item("HomePhone") Is DBNull.Value Then
                txtPhone.Text = reader.Item("HomePhone")
            Else
                txtPhone.Text = ""
            End If

            If Not reader.Item("WorkPhone") Is DBNull.Value Then
                txtWorkPhone.Text = reader.Item("WorkPhone")
            Else
                txtWorkPhone.Text = ""
            End If

            If Not reader.Item("MobilePhone") Is DBNull.Value Then
                txtMobilePhone.Text = reader.Item("MobilePhone")
            Else
                txtMobilePhone.Text = ""
            End If


            If Not reader.Item("PicturesTaken") Is DBNull.Value Then
                radPictures.SelectedValue = Convert.ToBoolean(reader.Item("PicturesTaken"))
                hidImages.Value = Convert.ToInt32(reader.Item("PicturesTaken"))
            Else
                radPictures.SelectedIndex = -1
                hidImages.Value = 0
            End If

            If Not reader.Item("PropertyDamage") Is DBNull.Value Then
                radPropertyDamage.SelectedValue = Convert.ToBoolean(reader.Item("PropertyDamage"))
            Else
                radPropertyDamage.SelectedIndex = -1
            End If


            If Not reader.Item("PropertyDamageDesc") Is DBNull.Value Then
                txtPropertyDamage.Text = reader.Item("PropertyDamageDesc")
            Else
                txtPropertyDamage.Text = ""
            End If

            If Not reader.Item("PropertyDamageOurPremises") Is DBNull.Value Then
                radPropertyDamageOurPremises.SelectedValue = Convert.ToBoolean(reader.Item("PropertyDamageOurPremises"))
            Else
                radPropertyDamageOurPremises.SelectedIndex = -1
            End If

            If Not reader.Item("RepairCost") Is DBNull.Value Then
                txtRepairCost.Text = FormatCurrency(reader.Item("RepairCost"), 2, TriState.True, TriState.False, TriState.False)
            Else
                txtRepairCost.Text = ""
            End If

            If Not reader.Item("RentArrears") Is DBNull.Value Then
                radArrears.SelectedValue = Convert.ToBoolean(reader.Item("RentArrears"))
            Else
                radArrears.SelectedIndex = -1
            End If


            If Not reader.Item("RentDues") Is DBNull.Value Then
                txtRentDues.Text = FormatCurrency(reader.Item("RentDues"), 2, TriState.True, TriState.False, TriState.False)
            Else
                txtRentDues.Text = ""
            End If

            If Not reader.Item("Minor") Is DBNull.Value Then
                radMinor.SelectedValue = Convert.ToBoolean(reader.Item("Minor"))
            Else
                radMinor.SelectedIndex = -1
            End If

            If Not reader.Item("ParentGuardianName") Is DBNull.Value Then
                txtParentGuardianName.Text = reader.Item("ParentGuardianName")
            Else
                txtParentGuardianName.Text = ""
            End If

            If Not reader.Item("ParentGuardianAddress") Is DBNull.Value Then
                txtParentGuardianAddress.Text = reader.Item("ParentGuardianAddress")
            Else
                txtParentGuardianAddress.Text = ""
            End If

            If Not reader.Item("ParentGuardianCity") Is DBNull.Value Then
                txtParentGuardianCity.Text = reader.Item("ParentGuardianCity")
            Else
                txtParentGuardianCity.Text = ""
            End If

            dropState2.SelectedIndex = -1
            If Not reader.Item("ParentGuardianState") Is DBNull.Value Then
                dropState2.Items.FindByText(reader("ParentGuardianState")).Selected = True
            Else
                dropState2.SelectedIndex = 0
            End If

            If Not reader.Item("ParentGuardianZip") Is DBNull.Value Then
                TxtParentGuardianZip.Text = reader.Item("ParentGuardianZip")
            Else
                TxtParentGuardianZip.Text = ""
            End If

            If Not reader.Item("ParentGuardianHomePhone") Is DBNull.Value Then
                txtParentGuardianHomePhone.Text = reader.Item("ParentGuardianHomePhone")
            Else
                txtParentGuardianHomePhone.Text = ""
            End If

            If Not reader.Item("ParentGuardianMobile") Is DBNull.Value Then
                txtParentGuardianMobilePhone.Text = reader.Item("ParentGuardianMobile")
            Else
                txtParentGuardianMobilePhone.Text = ""
            End If

            If Not reader.Item("ParentGuardianWork") Is DBNull.Value Then
                txtParentGuardianWorkPhone.Text = reader.Item("ParentGuardianWork")
            Else
                txtParentGuardianWorkPhone.Text = ""
            End If

            If Not reader.Item("Waiver") Is DBNull.Value Then
                radWaiver.SelectedValue = Convert.ToBoolean(reader.Item("Waiver"))
            Else
                radWaiver.SelectedIndex = -1
            End If



            If Not reader.Item("MedicalAttention") Is DBNull.Value Then
                radMedicalAttention.SelectedValue = Convert.ToBoolean(reader.Item("MedicalAttention"))
            Else
                radMedicalAttention.SelectedIndex = -1
            End If

            If Not reader.Item("Ambulance") Is DBNull.Value Then
                radAmbulance.SelectedValue = Convert.ToBoolean(reader.Item("Ambulance"))
            Else
                radAmbulance.SelectedIndex = -1
            End If

            If Not reader.Item("PhysicianName") Is DBNull.Value Then
                txtPhysicianName.Text = reader.Item("PhysicianName")
            Else
                txtPhysicianName.Text = ""
            End If

            If Not reader.Item("PhysicianAddress") Is DBNull.Value Then
                txtPhysicianAddress.Text = reader.Item("PhysicianAddress")
            Else
                txtPhysicianAddress.Text = ""
            End If

            If Not reader.Item("PhysicianContact") Is DBNull.Value Then
                txtPhysicianContact.Text = reader.Item("PhysicianContact")
            Else
                txtPhysicianContact.Text = ""
            End If

            If Not reader.Item("PhysicianPhone") Is DBNull.Value Then
                txtPhysicianPhone.Text = reader.Item("PhysicianPhone")
            Else
                txtPhysicianPhone.Text = ""
            End If


            If Not reader.Item("Witnesses") Is DBNull.Value Then
                radWitnesses.SelectedValue = Convert.ToBoolean(reader.Item("Witnesses"))
            Else
                radWitnesses.SelectedIndex = -1
            End If

            If Not reader.Item("WitnessName1") Is DBNull.Value Then
                txtWitnessName1.Text = reader.Item("WitnessName1")
            Else
                txtWitnessName1.Text = ""
            End If

            If Not reader.Item("WitnessAddress1") Is DBNull.Value Then
                txtWitnessAddress1.Text = reader.Item("WitnessAddress1")
            Else
                txtWitnessAddress1.Text = ""
            End If

            If Not reader.Item("WitnessCity1") Is DBNull.Value Then
                txtWitnessCity1.Text = reader.Item("WitnessCity1")
            Else
                txtWitnessCity1.Text = ""
            End If

            dropWitnessState1.SelectedIndex = -1
            If Not reader.Item("WitnessState1") Is DBNull.Value Then
                dropWitnessState1.Items.FindByText(reader("WitnessState1")).Selected = True
            Else
                dropWitnessState1.SelectedIndex = 0
            End If

            If Not reader.Item("WitnessZip1") Is DBNull.Value Then
                txtWitnessZip1.Text = reader.Item("WitnessZip1")
            Else
                txtWitnessZip1.Text = ""
            End If

            If Not reader.Item("WitnessPhone1") Is DBNull.Value Then
                txtWitnessPhone1.Text = reader.Item("WitnessPhone1")
            Else
                txtWitnessPhone1.Text = ""
            End If

            If Not reader.Item("WitnessName2") Is DBNull.Value Then
                txtWitnessName2.Text = reader.Item("WitnessName2")
            Else
                txtWitnessName2.Text = ""
            End If

            If Not reader.Item("WitnessAddress2") Is DBNull.Value Then
                txtWitnessAddress2.Text = reader.Item("WitnessAddress2")
            Else
                txtWitnessAddress2.Text = ""
            End If

            If Not reader.Item("WitnessCity2") Is DBNull.Value Then
                txtWitnessCity2.Text = reader.Item("WitnessCity2")
            Else
                txtWitnessCity2.Text = ""
            End If

            dropWitnessState2.SelectedIndex = -1
            If Not reader.Item("WitnessState2") Is DBNull.Value Then
                dropWitnessState2.Items.FindByText(reader("WitnessState2")).Selected = True
            Else
                dropWitnessState2.SelectedIndex = 0
            End If

            If Not reader.Item("WitnessZip2") Is DBNull.Value Then
                txtWitnessZip2.Text = reader.Item("WitnessZip2")
            Else
                txtWitnessZip2.Text = ""
            End If

            If Not reader.Item("WitnessPhone2") Is DBNull.Value Then
                txtWitnessPhone2.Text = reader.Item("WitnessPhone2")
            Else
                txtWitnessPhone2.Text = ""
            End If


            dropIncidentType.SelectedIndex = -1
            If Not reader.Item("IncidentType") Is DBNull.Value Then
                dropIncidentType.Items.FindByValue(reader.Item("IncidentType")).Selected = True
            End If

            txtIncidentTime.Text = reader.Item("IncidentTime")
            txtFloorType.Text = reader.Item("FloorType")
            txtInjuryDesc.Text = reader.Item("InjuryDesc")


            If Not reader.Item("InspectedImmediately") Is DBNull.Value Then
                radInspectedImmediately.SelectedValue = Convert.ToBoolean(reader.Item("InspectedImmediately"))
            Else
                radInspectedImmediately.SelectedIndex = -1
            End If


            If Not reader.Item("LocationClean") Is DBNull.Value Then
                radLocationClean.SelectedValue = Convert.ToBoolean(reader.Item("LocationClean"))
            Else
                radLocationClean.SelectedIndex = -1
            End If

            If Not reader.Item("LocationDry") Is DBNull.Value Then
                radLocationDry.SelectedValue = Convert.ToBoolean(reader.Item("LocationDry"))
            Else
                radLocationDry.SelectedIndex = -1
            End If

            'If Not reader.Item("LocationDry") Is DBNull.Value Then
            '    radLocationDry.SelectedValue = Convert.ToBoolean(reader.Item("LocationDry"))
            'Else
            '    radLocationDry.SelectedIndex = -1
            'End If

            If Not reader.Item("InspectedImmediately") Is DBNull.Value Then
                radInspectedImmediately.SelectedValue = Convert.ToBoolean(reader.Item("InspectedImmediately"))
            Else
                radInspectedImmediately.SelectedIndex = -1
            End If


            If Not reader.Item("Obstruction") Is DBNull.Value Then
                radObstruction.SelectedValue = Convert.ToBoolean(reader.Item("Obstruction"))
            Else
                radObstruction.SelectedIndex = -1
            End If

            If Not reader.Item("ObstructionType") Is DBNull.Value Then
                txtObstructionType.Text = reader.Item("ObstructionType")
            Else
                txtObstructionType.Text = ""
            End If


            txtWeather.Text = reader.Item("Weather")
            txtShoeType.Text = reader.Item("ShoeType")

            If Not reader.Item("CarryingObjects") Is DBNull.Value Then
                radCarryingObjects.SelectedValue = reader.Item("CarryingObjects")
            Else
                radCarryingObjects.SelectedIndex = -1
            End If

            If Not reader.Item("ObjectsCarried") Is DBNull.Value Then
                txtObjectsCarried.Text = reader.Item("ObjectsCarried")
            Else
                txtObjectsCarried.Text = ""
            End If

            If Not reader.Item("Surveillance") Is DBNull.Value Then
                radSurveillance.SelectedValue = Convert.ToBoolean(reader.Item("Surveillance"))
            Else
                radSurveillance.SelectedIndex = -1
            End If


            If Not reader.Item("Film") Is DBNull.Value Then
                radFilm.SelectedValue = reader.Item("Film")
            Else
                radFilm.SelectedIndex = -1
            End If

            If Not reader.Item("FilmComment") Is DBNull.Value Then
                txtFilm.Text = reader.Item("FilmComment")
            Else
                txtFilm.Text = ""
            End If
            txtFullDesc.Text = reader.Item("FullIncidentDesc")


            '''''Processing'''''''''''''''''''''
            If Not reader.Item("GLorAutoClaim") Is DBNull.Value Then
                radClaimType.SelectedValue = Convert.ToBoolean(reader.Item("GLorAutoClaim"))
            Else
                radClaimType.SelectedIndex = -1
            End If


            If Not reader.Item("SelfAdministered") Is DBNull.Value Then
                radSelfAdministered.SelectedValue = Convert.ToBoolean(reader.Item("SelfAdministered"))
            Else
                radSelfAdministered.SelectedIndex = -1
            End If

            If Not reader.Item("SubmitTpa") Is DBNull.Value Then
                If Convert.ToBoolean(reader.Item("SubmitTpa")) = True Then
                    txtFileNum.Text = reader.Item("FileNum")
                    txtTpaAdjuster.Text = reader.Item("TpaAdjusterName")
                Else
                    txtFileNum.Text = ""
                    txtTpaAdjuster.Text = ""
                End If

                radsubmitTpa.SelectedValue = Convert.ToBoolean(reader.Item("SubmitTpa"))
            Else
                txtFileNum.Text = ""
                txtTpaAdjuster.Text = ""
                radsubmitTpa.SelectedIndex = -1
            End If


            If Not reader.Item("TpaSubmitCarrier") Is DBNull.Value Then
                If Convert.ToBoolean(reader.Item("TpaSubmitCarrier")) = True Then
                    txtTpaCarrierClaimNum.Text = reader.Item("TpaCarrierClaimNum")
                    txtTpaCarrierAdjName.Text = reader.Item("TpaCarrierAdjName")
                    txtTpaCarrierAdjContact.Text = reader.Item("TpaCarrierAdjContact")
                Else
                    txtTpaCarrierClaimNum.Text = ""
                    txtTpaCarrierAdjName.Text = ""
                    txtTpaCarrierAdjContact.Text = ""
                End If

                radTpaSubmitCarrier.SelectedValue = Convert.ToBoolean(reader.Item("TpaSubmitCarrier"))
            Else
                txtTpaCarrierClaimNum.Text = ""
                txtTpaCarrierAdjName.Text = ""
                txtTpaCarrierAdjContact.Text = ""
                radTpaSubmitCarrier.SelectedIndex = -1
            End If


            If Not reader.Item("ReportCarrier") Is DBNull.Value Then
                If Convert.ToBoolean(reader.Item("ReportCarrier")) = True Then
                    txtCarrierClaimNum.Text = reader.Item("CarrierClaimNum")
                    txtCarrierAdjuster.Text = reader.Item("CarrierAdjusterName")
                    txtCarrierAdjusterPhone.Text = reader.Item("CarrierAdjusterPhone")
                Else
                    txtCarrierClaimNum.Text = ""
                    txtCarrierAdjuster.Text = ""
                    txtCarrierAdjusterPhone.Text = ""
                End If

                radReportCarrier.SelectedValue = Convert.ToBoolean(reader.Item("ReportCarrier"))
            Else
                txtCarrierClaimNum.Text = ""
                txtCarrierAdjuster.Text = ""
                txtCarrierAdjusterPhone.Text = ""
                radReportCarrier.SelectedIndex = -1
            End If


            ''''''''''''''''''''''''Settlement''''''''''''''''''''''
            txtGlSettlementAmount.Text = ""

            txtCheckDate1.Text = ""
            txtCheckDate2.Text = ""
            txtCheckDate3.Text = ""
            txtCheckDate4.Text = ""

            txtCheckAmnt1.Text = ""
            txtCheckAmnt2.Text = ""
            txtCheckAmnt3.Text = ""
            txtCheckAmnt4.Text = ""

            txtTotalClaimCost.Text = ""

            txtCheckNum1.Text = ""
            txtCheckNum2.Text = ""
            txtCheckNum3.Text = ""
            txtCheckNum4.Text = ""

            txtPayee1.Text = ""
            txtPayee2.Text = ""
            txtPayee3.Text = ""
            txtPayee4.Text = ""


            If Not reader.Item("ClaimSettled") Is DBNull.Value Then
                If Convert.ToBoolean(reader.Item("ClaimSettled")) = True Then
                    If reader.Item("SettlementAmount") IsNot DBNull.Value Then txtGlSettlementAmount.Text = FormatCurrency(reader.Item("SettlementAmount"), 2, TriState.True, TriState.False, TriState.False)
                    If reader.Item("CheckDate1") IsNot DBNull.Value Then txtCheckDate1.Text = reader.Item("CheckDate1")
                    If reader.Item("CheckDate2") IsNot DBNull.Value Then txtCheckDate2.Text = reader.Item("CheckDate2")
                    If reader.Item("CheckDate3") IsNot DBNull.Value Then txtCheckDate3.Text = reader.Item("CheckDate3")
                    If reader.Item("CheckDate4") IsNot DBNull.Value Then txtCheckDate4.Text = reader.Item("CheckDate4")

                    If reader.Item("CheckAmnt1") IsNot DBNull.Value Then txtCheckAmnt1.Text = FormatCurrency(reader.Item("CheckAmnt1"), 2, TriState.True, TriState.False, TriState.False)
                    If reader.Item("CheckAmnt2") IsNot DBNull.Value Then txtCheckAmnt2.Text = FormatCurrency(reader.Item("CheckAmnt2"), 2, TriState.True, TriState.False, TriState.False)
                    If reader.Item("CheckAmnt3") IsNot DBNull.Value Then txtCheckAmnt3.Text = FormatCurrency(reader.Item("CheckAmnt3"), 2, TriState.True, TriState.False, TriState.False)
                    If reader.Item("CheckAmnt4") IsNot DBNull.Value Then txtCheckAmnt4.Text = FormatCurrency(reader.Item("CheckAmnt4"), 2, TriState.True, TriState.False, TriState.False)

                    If reader.Item("Total") IsNot DBNull.Value Then txtTotalClaimCost.Text = FormatCurrency(reader.Item("Total"), 2, TriState.True, TriState.False, TriState.False)

                    If reader.Item("CheckNum1") IsNot DBNull.Value Then txtCheckNum1.Text = reader.Item("CheckNum1")
                    If reader.Item("CheckNum2") IsNot DBNull.Value Then txtCheckNum2.Text = reader.Item("CheckNum2")
                    If reader.Item("CheckNum3") IsNot DBNull.Value Then txtCheckNum3.Text = reader.Item("CheckNum3")
                    If reader.Item("CheckNum4") IsNot DBNull.Value Then txtCheckNum4.Text = reader.Item("CheckNum4")

                    If reader.Item("Payee1") IsNot DBNull.Value Then txtPayee1.Text = reader.Item("Payee1")
                    If reader.Item("Payee2") IsNot DBNull.Value Then txtPayee2.Text = reader.Item("Payee2")
                    If reader.Item("Payee3") IsNot DBNull.Value Then txtPayee3.Text = reader.Item("Payee3")
                    If reader.Item("Payee4") IsNot DBNull.Value Then txtPayee4.Text = reader.Item("Payee4")

                End If
                radLitigClaimSettled.SelectedValue = Convert.ToBoolean(reader.Item("ClaimSettled"))
            Else

                radLitigClaimSettled.SelectedIndex = -1
            End If

            ''''''''''''''''''End Settlement''''''''''''''''''''''''''''''''''''''''''''

            If Not reader.Item("ClaimLitigation") Is DBNull.Value Then
                If Convert.ToBoolean(reader.Item("ClaimLitigation")) = True Then
                    txtDefenseCounsel.Text = reader.Item("DefenseCounselName")
                    txtCounselContact.Text = reader.Item("CounselContact")
                    txtDocketNum.Text = reader.Item("DocketNum")
                    txtLitigClaimNum.Text = reader.Item("LitigClaimNum")
                Else
                    txtDefenseCounsel.Text = ""
                    txtCounselContact.Text = ""
                    txtDocketNum.Text = ""
                    txtLitigClaimNum.Text = ""
                End If

                radClaimLitigation.SelectedValue = Convert.ToBoolean(reader.Item("ClaimLitigation"))
            Else
                txtDefenseCounsel.Text = ""
                txtCounselContact.Text = ""
                txtDocketNum.Text = ""
                txtLitigClaimNum.Text = ""
                radClaimLitigation.SelectedIndex = -1
            End If




            'If Not reader.Item("GLorAutoClaim") Is DBNull.Value Then
            '    radClaimType.SelectedValue = Convert.ToBoolean(reader.Item("GLorAutoClaim"))
            'End If


            'If Not reader.Item("SubmitTpa") Is DBNull.Value Then
            '    radsubmitTpa.SelectedValue = Convert.ToBoolean(reader.Item("SubmitTpa"))
            'Else
            '    radsubmitTpa.SelectedIndex = -1
            'End If

            'If Not reader.Item("FileNum") Is DBNull.Value Then
            '    txtFileNum.Text = reader.Item("FileNum")
            'Else
            '    txtFileNum.Text = ""
            'End If

            'If Not reader.Item("AdjusterName") Is DBNull.Value Then
            '    txtTpaAdjuster.Text = reader.Item("AdjusterName")
            'Else
            '    txtTpaAdjuster.Text = ""
            'End If




        End If

        reader.Close()

        GetPhotos()
        GetDocuments()

        btnPrintClaim.Enabled = True

    End Sub

    Protected Sub btnNewClaim_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNewClaim.Click
        Session("claimid") = Nothing

        Dim curSession As String = HttpContext.Current.Session.SessionID
        Dim savePath As String = "Claims\Temp\" & curSession

        If Directory.Exists(Server.MapPath(savePath)) Then
            'System.IO.Directory.Delete(Server.MapPath(savePath))
            If Directory.Exists(Server.MapPath(savePath)) Then
                ' System.IO.Directory.Delete(Server.MapPath(savePath))
                Dim folder As New DirectoryInfo(Server.MapPath(savePath))

                Try

                    For Each file As FileInfo In folder.GetFiles
                        file.Delete()
                    Next

                    folder.Delete()

                Catch ex As Exception

                End Try

            End If
        End If
        Response.Redirect("claim.aspx")

    End Sub

    'Private Sub GetPhotos()
    '    If Session("ClaimId") IsNot Nothing Then
    '        hidFolder.Value = Session("ClaimId")
    '    Else
    '        Dim curSession As String = HttpContext.Current.Session.SessionID
    '        hidFolder.Value = "Temp\" & curSession
    '    End If

    '    'ROOT_DIRECTORY

    '    Dim fullPath As String = Server.MapPath(ROOT_DIRECTORY.Value & hidFolder.Value)
    '    If Directory.Exists(fullPath) Then
    '        Dim folder As New DirectoryInfo(fullPath)
    '        Dim fileList As FileInfo() = folder.GetFiles()

    '        rptPhotos.DataSource = fileList
    '        rptPhotos.DataBind()
    '    Else
    '        rptPhotos.DataSource = Nothing
    '        rptPhotos.DataBind()
    '    End If

    'End Sub

    Private Sub GetPhotos()
        If Session("ClaimId") IsNot Nothing Then
            hidFolder.Value = Session("ClaimId")
        Else
            Dim curSession As String = HttpContext.Current.Session.SessionID
            hidFolder.Value = "Temp\" & curSession
        End If

        'ROOT_DIRECTORY

        Dim fullPath As String = Server.MapPath(ROOT_DIRECTORY.Value & hidFolder.Value)
        If Directory.Exists(fullPath) Then
            Dim pics As ArrayList = New ArrayList
            Dim s As String
            Dim arr As New ArrayList
            Dim html As String
            Dim imgHeight, imgWidth As Integer
            imgHeight = 70
            imgWidth = 70

            Dim maxLength As Int16 = 28

            Dim strName As String = ""
            ' Dim currentImage As System.Drawing.Image


            For Each s In System.IO.Directory.GetFiles(fullPath)
                'Get information about the image
                ' Try


                'currentImage = System.Drawing.Image.FromFile(s)

                ' If System.IO.Path.GetFileName(s) <> "noimage.gif" Then
                arr = New ArrayList
                arr.Add(System.IO.Path.GetFileName(s))

                html = "<img src=""showimage.aspx?img=" & System.IO.Path.GetFileName(s) & "&w=" & imgWidth & "&h=" & imgHeight & """" & """height=""" & imgHeight & """ width=""" & imgWidth & """>"



                arr.Add(html)
                ' arr.Add(System.IO.File.GetCreationTime(s))
                'arr.Add(Microsoft.VisualBasic.FileSystem.FileDateTime(s))
                'strName = System.IO.Path.GetFileName(s)

                'If strName.Length > maxLength Then
                '    strName = Left(strName, maxLength) & "..."
                'End If

                'arr.Add(strName)

                ' arr.Add(System.IO.Path.GetFullPath(s))
                pics.Add(arr)

                '  End If
                'currentImage.Dispose()

                ' Catch ex As Exception


                ' End Try
            Next

            rptPhotos.DataSource = pics
            rptPhotos.DataBind()
        Else
            rptPhotos.DataSource = Nothing
            rptPhotos.DataBind()
        End If

    End Sub

    Private Sub DeleteFile()
        Dim fullPath As String = Server.MapPath(ROOT_DIRECTORY.Value & hidFolder.Value & "\" & hidRemoveFile.Value)

        Try
            Dim file As New FileInfo(fullPath)
            file.Delete()
        Catch ex As Exception
            Dim strScript As String = "<script type='text/javascript' >" & vbCrLf & " <!-- " & vbCrLf & " errorAlert(""" & ex.Message.Replace("\", "\\").Replace("'", "\'") & """)" & vbCrLf & " --> " & vbCrLf & " <" & "/script>"
            ClientScript.RegisterStartupScript(GetType(Page), "errorAlert", strScript)
        End Try

        hidRemoveFile.Value = ""

        GetPhotos()

    End Sub

    Protected Sub btnAddNote_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddNote.Click
        DataNotes.InsertParameters("DateEntered").DefaultValue = Now()
        DataNotes.InsertParameters("Notes").DefaultValue = txtNotes.Text
        DataNotes.InsertParameters("MeasuresTaken").DefaultValue = txtMeasuresTaken.Text
        DataNotes.InsertParameters("UserName").DefaultValue = Session("UserName")
        DataNotes.InsertParameters("ClaimId").DefaultValue = Session("ClaimId")
        DataNotes.Insert()
        gridNotes.DataBind()
    End Sub

    Protected Sub gridNotes_PageIndexChanged(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridPageChangedEventArgs) Handles gridNotes.PageIndexChanged
        ' gridNotes.DataBind()
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


    Private Sub GetDocuments()
        If Session("ClaimId") IsNot Nothing Then
            hidFolder.Value = Session("ClaimId")
        Else
            Dim curSession As String = HttpContext.Current.Session.SessionID
            hidFolder.Value = "Temp\" & curSession
        End If



        Dim fullPath As String = Server.MapPath(ROOT_DIRECTORY.Value & hidFolder.Value & "/Documents")
        If Directory.Exists(fullPath) Then
            Dim docs As ArrayList = New ArrayList
            Dim s As String
            Dim arr As New ArrayList
            Dim html As String
            Dim imgHeight, imgWidth As Integer
            imgHeight = 70
            imgWidth = 70

            Dim maxLength As Int16 = 28

            Dim strName As String = ""
            ' Dim currentImage As System.Drawing.Image


            For Each s In System.IO.Directory.GetFiles(fullPath)
                'Get information about the image
                ' Try


                'currentImage = System.Drawing.Image.FromFile(s)

                ' If System.IO.Path.GetFileName(s) <> "noimage.gif" Then
                arr = New ArrayList
                arr.Add(System.IO.Path.GetFileName(s))
                'html = "<img src= ""ShowDocuments.aspx?img=" & fullPath & System.IO.Path.GetFileName(s) & "&w=" & imgWidth & "&h=" & imgHeight & """""  & _height=""" & imgHeight & """ width=""" & imgWidth & """>"
                'html = "<img src=" & fullPath & System.IO.Path.GetFileName(s) & " > "
                'arr.Add(html)
                'arr.Add(System.IO.File.GetCreationTime(s))

                strName = System.IO.Path.GetFileName(s)
                arr.Add(System.IO.Path.GetFileName(s))
                arr.Add(Microsoft.VisualBasic.FileSystem.FileDateTime(s))


                If strName.Length > maxLength Then
                    strName = Left(strName, maxLength) & "..."
                End If

                arr.Add(strName)
                arr.Add(System.IO.Path.GetFullPath(s))

                docs.Add(arr)

                '  End If
                'currentImage.Dispose()

                ' Catch ex As Exception


                ' End Try
            Next

            Repeater1.DataSource = docs
            Repeater1.DataBind()
        Else
            Repeater1.DataSource = Nothing
            Repeater1.DataBind()
        End If


    End Sub

    Sub Load_Click(ByVal source As Object, ByVal e As EventArgs)

        Dim savePath As String = ""

        If Not (uploadedFile.PostedFile Is Nothing) Then
            Try
                Dim postedFile = uploadedFile.PostedFile
                Dim filename As String = Path.GetFileName(postedFile.FileName)
                Dim contentType As String = postedFile.ContentType
                Dim contentLength As Integer = postedFile.ContentLength

                If Session("ClaimId") IsNot Nothing Then
                    savePath = "Claims\" & Session("ClaimId") & "\Documents" & "\" '& filename
                Else
                    Dim curSession As String = HttpContext.Current.Session.SessionID
                    savePath = "Claims\Temp\" & curSession & "\Documents" & "\" '& filename
                End If

                If Not Directory.Exists(Server.MapPath(savePath)) Then
                    Directory.CreateDirectory(Server.MapPath(savePath))
                End If


                savePath = savePath
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
                GetDocuments()
                '   "<br>content type: " & contentType & _
                '    "<br>content length: " & contentLength.ToString()
            Catch exc As Exception
                message.Text = "Failed uploading file.Try again."
            End Try
        End If



    End Sub

    Private Sub DeleteDocument()
        Dim fullPath As String = Server.MapPath(ROOT_DIRECTORY.Value & hidFolder.Value & "\Documents" & "\" & hidRemoveFile2.Value)

        Try
            Dim file As New FileInfo(fullPath)
            file.Delete()
        Catch ex As Exception
            Dim strScript As String = "<script type='text/javascript' >" & vbCrLf & " <!-- " & vbCrLf & " errorAlert(""" & ex.Message.Replace("\", "\\").Replace("'", "\'") & """)" & vbCrLf & " --> " & vbCrLf & " <" & "/script>"
            ClientScript.RegisterStartupScript(GetType(Page), "errorAlert", strScript)
        End Try

        hidRemoveFile.Value = ""

        GetDocuments()
        'GetDocs(hidFolder.Value)

    End Sub


End Class



