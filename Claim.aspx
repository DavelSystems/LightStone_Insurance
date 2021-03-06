<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Claim.aspx.vb" Inherits="Claim"
    Trace="false" EnableViewState="true" %>
<%--
<%@ Register TagPrefix="IE" Namespace="Microsoft.Web.UI.WebControls" Assembly="Microsoft.Web.UI.WebControls" %>--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="Mainstyle.css" type="text/css" rel="stylesheet" />
    <link href="Calendar.css" type="text/css" rel="stylesheet" />
    <meta http-equiv="Page-Exit" content="progid:DXImageTransform.Microsoft.GradientWipe(Duration=0,Transition=5)" />
    <style type="text/css">
        a
        {
            font-weight: normal;
        }
        a:hover
        {
            color: #003366;
            font-weight: normal;
        }
    </style>
    <script type="text/javascript" src="calendar.js"></script>
    <script type="text/javascript" src="calendar-en.js"></script>
    <script type="text/javascript" src="calendar-setup.js"></script>
    <title>Insurance Claim</title>
    <script language="javascript" type="text/javascript">

        // var overLink = false;
        var txtBGColor = "#FFFF00"//"yellow" //"maroon";
        var txtColor = "red"//"yellow" //"maroon";

        var onDivReportChoice = false;

        function init() {
            parent.frames[0].SwitchBtn(parent.frames[0].Claim);

            toggleArrears();

            toggleWaiver();

            toggleMinor();

            togglePictures();
            togglePropDamage();
            toggleMedicalAttention();
            toggleWitnesses();

            toggleObstruction();
            toggleObjects();
            toggleFilm();


            toggleClaimType();

            //toggleSelfAdministered();


            toggleSubmitTpa();
            toggleTpaSubmitCarrier();
            toggleReportCarrier();
            toggleClaimLitigation();

            toggleLitigClaimSettled();

            SetCheckTotal();
            
             showPanel(document.getElementById("hidPanel").value,1 );
        }

        function toggleArrears() {//alert(document.getElementById("radClaimant_1").checked);
            if (document.getElementById("radClaimant_1").checked == true) {
                document.getElementById("trArrears").style.display = "";

                if (document.getElementById("radArrears_0").checked == true)
                    document.getElementById("trArrears1").style.display = "";
                else
                    document.getElementById("trArrears1").style.display = "none";
            }
            else {
                document.getElementById("trArrears").style.display = "none";
                document.getElementById("trArrears1").style.display = "none";

            }
        }
        
        function toggleWaiver() {
         var prop = document.getElementById("dropProp");
//         alert(prop.options[prop.selectedIndex].text);
         
         if (prop.options[prop.selectedIndex].text == "Crown Plaza Boston") {
                document.getElementById("radWaiver").style.display = "";
                document.getElementById("trWaiver").style.display = "";
            }
            else {
                document.getElementById("radWaiver").style.display = "none";
                document.getElementById("trWaiver").style.display = "none";
            }

        }


        function toggleMinor() {
            if (document.getElementById("radMinor_0").checked == true) {
                document.getElementById("trParentGuardian").style.display = "";
            }
            else {
                document.getElementById("trParentGuardian").style.display = "none";
            }

        }










        function togglePictures() {
            if (document.getElementById("radPictures_0").checked == true) {
                document.getElementById("trPictures").style.display = "";
                document.getElementById("btnAttachPhotos").style.display = "";

            }
            else {
                document.getElementById("trPictures").style.display = "none";
                document.getElementById("btnAttachPhotos").style.display = "none";
            }
        }
        function togglePropDamage() {//alert(document.getElementById("radPropertyDamage").checked);
            if (document.getElementById("radPropertyDamage_0").checked == true) {
                document.getElementById("trPropDamage1").style.display = "";
                document.getElementById("trPropDamage2").style.display = "";
                document.getElementById("trPropDamage3").style.display = "";
            }
            else {
                document.getElementById("trPropDamage1").style.display = "none";
                document.getElementById("trPropDamage2").style.display = "none";
                document.getElementById("trPropDamage3").style.display = "none";
            }
        }

        function toggleMedicalAttention() {//alert(document.getElementById("radPropertyDamage").checked);
            if (document.getElementById("radMedicalAttention_0").checked == true) {
                document.getElementById("trMedicalAttention").style.display = "";
                document.getElementById("trMedicalAttention2").style.display = "";
                document.getElementById("trMedicalAttention3").style.display = "";
                document.getElementById("trAmbulance").style.display = "";
            }
            else {
                document.getElementById("trMedicalAttention").style.display = "none";
                document.getElementById("trMedicalAttention2").style.display = "none";
                document.getElementById("trMedicalAttention3").style.display = "none";
                document.getElementById("trAmbulance").style.display = "none";
            }
        }

        function toggleWitnesses() {//alert(document.getElementById("radPropertyDamage").checked);
            if (document.getElementById("radWitnesses_0").checked == true) {
                document.getElementById("trWitnesses1").style.display = "";
                document.getElementById("trWitnesses2").style.display = "";
                document.getElementById("trWitnesses3").style.display = "";
                document.getElementById("trWitnesses4").style.display = "";
                document.getElementById("trWitnesses5").style.display = "";
                document.getElementById("trWitnesses12").style.display = "";
                document.getElementById("trWitnesses14").style.display = "";

                document.getElementById("trWitnesses6").style.display = "";
                document.getElementById("trWitnesses7").style.display = "";
                document.getElementById("trWitnesses8").style.display = "";
                document.getElementById("trWitnesses9").style.display = "";
                document.getElementById("trWitnesses10").style.display = "";
                document.getElementById("trWitnesses11").style.display = "";
                document.getElementById("trWitnesses13").style.display = "";

            }
            else {
                document.getElementById("trWitnesses1").style.display = "none";
                document.getElementById("trWitnesses2").style.display = "none";
                document.getElementById("trWitnesses3").style.display = "none";
                document.getElementById("trWitnesses4").style.display = "none";
                document.getElementById("trWitnesses5").style.display = "none";
                document.getElementById("trWitnesses12").style.display = "none";
                document.getElementById("trWitnesses14").style.display = "none";

                document.getElementById("trWitnesses6").style.display = "none";
                document.getElementById("trWitnesses7").style.display = "none";
                document.getElementById("trWitnesses8").style.display = "none";
                document.getElementById("trWitnesses9").style.display = "none";
                document.getElementById("trWitnesses10").style.display = "none";
                document.getElementById("trWitnesses11").style.display = "none";
                document.getElementById("trWitnesses13").style.display = "none";
            }
        }

        function toggleObstruction() {//alert(document.getElementById("radPropertyDamage").checked);
            if (document.getElementById("radObstruction_0").checked == true) {
                document.getElementById("trObstruction").style.display = "";
            }
            else {
                document.getElementById("trObstruction").style.display = "none";
            }
        }

        function toggleObjects() {//alert(document.getElementById("radPropertyDamage").checked);
            if (document.getElementById("radCarryingObjects_0").checked == true) {
                document.getElementById("trObjects").style.display = "";
            }
            else {
                document.getElementById("trObjects").style.display = "none";
            }
        }

        function toggleFilm() {
            if (document.getElementById("radSurveillance_0").checked == true) {
                document.getElementById("trFilm").style.display = "";
                document.getElementById("trFilmComment").style.display = "";
            }
            else {
                document.getElementById("trFilm").style.display = "none";
                document.getElementById("trFilmComment").style.display = "none";
            }
        }


        function toggleClaimType() {


            if (document.getElementById("radClaimType_0").checked == true) {

                document.getElementById("tableAutoClaim").style.display = "none";
                document.getElementById("tableGlClaim").style.display = "";
                document.getElementById("tblClaimSettled").style.display = "";

                document.getElementById("trglClaimSettled").style.display = "";



            }
            else {

                document.getElementById("tableGlClaim").style.display = "none";
                document.getElementById("tableAutoClaim").style.display = "";
                document.getElementById("tblClaimSettled").style.display = "";

                document.getElementById("trglClaimSettled").style.display = "";
            }

        }


        function toggleSubmitTpa() {//alert(document.getElementById("radPropertyDamager").checked);
            if (document.getElementById("radsubmitTpa_0").checked == true) {
                document.getElementById("trsubmitTpa1").style.display = "";
                document.getElementById("trSubmitTpa2").style.display = "";
                document.getElementById("trsubmitTpa3").style.display = "";

            }
            else {
                document.getElementById("trsubmitTpa1").style.display = "none";
                document.getElementById("trSubmitTpa2").style.display = "none";
                document.getElementById("trsubmitTpa3").style.display = "none";


            }
        }

        function toggleTpaSubmitCarrier() {//alert(document.getElementById("radPropertyDamager").checked);
            if (document.getElementById("radTpaSubmitCarrier_0").checked == true) {
                document.getElementById("trTpaSubmitCarrier1").style.display = "";
                document.getElementById("trTpaSubmitCarrier2").style.display = "";
                document.getElementById("trTpaSubmitCarrier3").style.display = "";

            }
            else {
                document.getElementById("trTpaSubmitCarrier1").style.display = "none";
                document.getElementById("trTpaSubmitCarrier2").style.display = "none";
                document.getElementById("trTpaSubmitCarrier3").style.display = "none";

            }
        }

        function toggleReportCarrier() {//alert(document.getElementById("radPropertyDamager").checked);
            if (document.getElementById("radReportCarrier_0").checked == true) {
                document.getElementById("trReportCarrier1").style.display = "";
                document.getElementById("trReportCarrier2").style.display = "";
                document.getElementById("trReportCarrier3").style.display = "";

            }
            else {
                document.getElementById("trReportCarrier1").style.display = "none";
                document.getElementById("trReportCarrier2").style.display = "none";
                document.getElementById("trReportCarrier3").style.display = "none";

            }
        }

        //        
        //          function toggleAutoClaimSettled()
        //        {//alert(document.getElementById("radPropertyDamager").checked);
        //           if(document.getElementById("radAutoClaimSettled_0").checked == true)  
        //          {   
        //                document.getElementById("trGlClaimSettled1").style.display = "";
        //                document.getElementById("trGlClaimSettled2").style.display = "";
        //                document.getElementById("trGlClaimSettled3").style.display = "";
        ////                document.getElementById("trGlClaimSettled4").style.display = "";
        ////                document.getElementById("trGlClaimSettled6").style.display = "";
        //            }
        //            else
        //            {
        //                document.getElementById("trGlClaimSettled1").style.display = "none";
        //                document.getElementById("trGlClaimSettled2").style.display = "none";
        //                document.getElementById("trGlClaimSettled3").style.display = "none";
        ////                document.getElementById("trGlClaimSettled4").style.display = "none";
        ////                document.getElementById("trGlClaimSettled5").style.display = "none";
        ////                document.getElementById("trGlClaimSettled6").style.display = "none";
        //                 
        //            }
        //        }

        function toggleClaimLitigation() {//alert(document.getElementById("radPropertyDamager").checked);
            if (document.getElementById("radClaimLitigation_0").checked == true) {
                document.getElementById("trClaimLitigation1").style.display = "";
                document.getElementById("trClaimLitigation2").style.display = "";
                document.getElementById("trClaimLitigation3").style.display = "";
                document.getElementById("trClaimLitigation4").style.display = "";
            }
            else {
                document.getElementById("trClaimLitigation1").style.display = "none";
                document.getElementById("trClaimLitigation2").style.display = "none";
                document.getElementById("trClaimLitigation3").style.display = "none";
                document.getElementById("trClaimLitigation4").style.display = "none";
            }
        }


        function toggleLitigClaimSettled() {//alert(document.getElementById("radPropertyDamager").checked);
            if (document.getElementById("radLitigClaimSettled_0").checked == true) {
                document.getElementById("trGlClaimSettled1").style.display = "";
                document.getElementById("trGlClaimSettled2").style.display = "";
                document.getElementById("trGlClaimSettled3").style.display = "";
                document.getElementById("trGlClaimSettled4").style.display = "";
                document.getElementById("trglClaimSettled5").style.display = "";
                //                document.getElementById("trGlClaimSettled6").style.display = "";
            }
            else {
                document.getElementById("trGlClaimSettled1").style.display = "none";
                document.getElementById("trGlClaimSettled2").style.display = "none";
                document.getElementById("trGlClaimSettled3").style.display = "none";
                document.getElementById("trGlClaimSettled4").style.display = "none";
                document.getElementById("trglClaimSettled5").style.display = "none";
                //                document.getElementById("trGlClaimSettled6").style.display = "none";

            }
        }


        function toggleSelfAdministered() {//alert(document.getElementById("radPropertyDamager").checked);
            ////////old function removed////////////
            if (document.getElementById("radSelfAdministered_0").checked == true) {
                document.getElementById("trSelfAdmin1").style.display = "";

            }
            else {
                document.getElementById("trSelfAdmin1").style.display = "none";


            }
        }



        function validate(submit, process) {//alert(form1.hidSubmitted.value);
            if (form1.hidSubmitted.value != "1") {
                var prop = document.getElementById("dropProp");
                var bldg = document.getElementById("dropBldg");
                var location = document.getElementById("txtLocation");

                var dAccident = document.getElementById("txtAccidentDate");
                var firstName = document.getElementById("txtFirstName");
                var lastName = document.getElementById("txtLastName");

                var dDOB = document.getElementById("txtDOB");
                var rentDues = document.getElementById("txtRentDues");
                var repairCost = document.getElementById("txtRepairCost");

                var propertyDamage = document.getElementById("txtPropertyDamage");
              

                var strValidate1 = "";
                var strValidate2 = "";
                var strValidate3 = "";
                var strValidate4 = "";
                
                if (prop.value.length == 0 || prop.value == "-1") {
                    strValidate1 += "Select a property.\n"
                    prop.parentNode.parentNode.cells[0].style.color = txtColor;
                    // prop.parentNode.parentNode.cells[0].style.backgroundColor = txtBGColor;
                    // prop.style.backgroundColor = txtBGColor;
                    //prop.parentNode.parentNode.cells[1].style.backgroundColor = txtBGColor;

                    // prop.parentNode.parentNode.style.backgroundColor = txtBGColor;
                }
                else
                    prop.parentNode.parentNode.cells[0].style.color = "";

                if (bldg.value.length == 0 || bldg.value == "-1") {
                    strValidate1 += "Select a bldg.\n";
                    bldg.parentNode.parentNode.cells[0].style.color = txtColor;
                }
                else
                    bldg.parentNode.parentNode.cells[0].style.color = "";

                if (location.value.length == 0) {
                    strValidate1 += "Input a location.\n"
                    location.parentNode.parentNode.cells[0].style.color = txtColor;
                }
                else
                    location.parentNode.parentNode.cells[0].style.color = "";




                if (!submit || document.getElementById("radPropertyDamage_0").checked == true) //just saving.
                {
                    /*if(strValidate1.length > 0)
                    {
                    document.getElementById("TabStripClaim").selectedIndex = 0;
                    alert("Please complete the following before saving:\n" + strValidate1);
                            
                    return false;
                    }*/


                    if (!ValidDate(dAccident.value) || dAccident.value.length == 0) {
                        // document.getElementById("TabStripClaim").selectedIndex = 1;
                        //dAccident.focus();
                        //alert("Please input a valid Accident Date.");	
                        strValidate2 += "Input a valid accident date.\n";
                        dAccident.parentNode.parentNode.cells[0].style.color = txtColor;
                        // return false;
                    }
                    else
                        dAccident.parentNode.parentNode.cells[0].style.color = "";

                    if (firstName.value.length == 0 || lastName.value.length == 0) {
                        //document.getElementById("TabStripClaim").selectedIndex = 1;
                        //dAccident.focus();
                        //alert("Please input a fist and last name for the claimant.");	
                        strValidate2 += "Please input a first and last name for the claimant.\n";

                        if (firstName.value.length == 0)
                            firstName.parentNode.parentNode.cells[0].style.color = txtColor;
                        else
                            firstName.parentNode.parentNode.cells[0].style.color = "";

                        if (lastName.value.length == 0)
                            lastName.parentNode.parentNode.cells[0].style.color = txtColor;
                        else
                            lastName.parentNode.parentNode.cells[0].style.color = "";
                        //return false;
                    }
                    else {
                        firstName.parentNode.parentNode.cells[0].style.color = "";
                        lastName.parentNode.parentNode.cells[0].style.color = "";
                    }


                    if (dDOB.value.length > 0 && !ValidDate(dDOB.value)) {
                        // document.getElementById("TabStripClaim").selectedIndex = 1;
                        // dDOB.focus();
                        //alert("Please input a valid Date of Birth.");		
                        strValidate2 += "Please input a valid Date of Birth.\n";
                        dDOB.parentNode.parentNode.cells[0].style.color = txtColor;
                        //return false;
                    }
                    else
                        dDOB.parentNode.parentNode.cells[0].style.color = "";

                    var regEx = /^\$?(\d*|\d{1,3}(,\d{3})*)(\.\d*)?\s*$/;

                    if (!regEx.test(rentDues.value)) {
                        //document.getElementById("TabStripClaim").selectedIndex = 1;
                        //rentDues.focus();
                        //alert("Please Input a valid amount for rent dues.");
                        strValidate2 += "Please Input a valid amount for rent dues.\n";
                        rentDues.parentNode.parentNode.cells[0].style.color = txtColor;
                        //return false;

                    }
                    else
                        rentDues.parentNode.parentNode.cells[0].style.color = "";

                    /*
                    if(!regEx.test(repairCost.value))
                    {
                    //document.getElementById("TabStripClaim").selectedIndex = 1;
                    //repairCost.focus();
                    //alert("Please Input a valid amount for estimated repair cost.");
                    strValidate3 += "Please Input a valid amount for estimated repair cost.\n";	
                    repairCost.parentNode.parentNode.cells[0].style.color = txtColor;			
                    //return false;
                       
                    }  
                    else
                    repairCost.parentNode.parentNode.cells[0].style.color = "";     
                    */

                    

                    if (submit) {
                        if (document.getElementById("radPropertyDamage_0").checked == true && propertyDamage.value.length == 0) {
                            strValidate3 += "Input type of property damage.\n";
                            propertyDamage.parentNode.parentNode.cells[0].style.color = txtColor;
                        }
                        else {
                            propertyDamage.parentNode.parentNode.cells[0].style.color = "";
                        }

                        if (document.getElementById("radPropertyDamage_0").checked == true && (!regEx.test(repairCost.value) || repairCost.value.length == 0)) {
                            strValidate3 += "Input a valid amount for estimated repair cost.\n";
                            repairCost.parentNode.parentNode.cells[0].style.color = txtColor;
                        }
                        else {
                            repairCost.parentNode.parentNode.cells[0].style.color = "";
                        }

                        if (document.getElementById("radPropertyDamage_0").checked == true && document.getElementById("radPropertyDamageOurPremises_0").checked == false && document.getElementById("radPropertyDamageOurPremises_1").checked == false) {
                            strValidate3 += "Select if property damage occured to our premises.\n";
                            document.getElementById("radPropertyDamageOurPremises").parentNode.parentNode.cells[0].style.color = txtColor;
                        }
                        else {
                            document.getElementById("radPropertyDamageOurPremises").parentNode.parentNode.cells[0].style.color = "";
                        }
                    }
                    else {
                        if (document.getElementById("radPropertyDamage_0").checked == true && (!regEx.test(repairCost.value) && repairCost.value.length > 0)) {
                            strValidate3 += "Input a valid amount for estimated repair cost.\n";
                            repairCost.parentNode.parentNode.cells[0].style.color = txtColor;
                        }
                        else {
                            repairCost.parentNode.parentNode.cells[0].style.color = "";
                        }

                    }
                    ////////////////////////////////////////////////       
                    if (strValidate1.length > 0) {                       
                        //document.getElementById("TabStripClaim").selectedIndex = 0;
                        showPanel('GeneralInformation',1 );
                        alert("Please complete the following before saving:\n" + strValidate1 + strValidate2 + strValidate3);

                        return false;
                    }
                    else if (strValidate2.length > 0) {
                        //document.getElementById("TabStripClaim").selectedIndex = 1;
                        showPanel('GuestInformation',1);
                        alert("Please complete the following before saving:\n" + strValidate2 + strValidate3);

                        return false;
                    }
                    else if (strValidate3.length > 0) {
                        //document.getElementById("TabStripClaim").selectedIndex = 2;
                        showPanel('IncidentDetails1',1);
                        alert("Please complete the following before saving:\n" + strValidate3);

                        return false;
                    }
                    /* else if(strValidate4.length > 0)
                    {
                    document.getElementById("TabStripClaim").selectedIndex = 3;
                    alert("Please complete the following before saving:\n" + strValidate4);
                            
                    return false;
                    }  */
                }
                else //submitting make sure all required fields are filled out.
                {
                    
                    var supervisorName = document.getElementById("txtSupervisorName");
                    var supervisorPhone = document.getElementById("txtSupervisorPhone");
                    var incidentType = document.getElementById("dropIncidentType");

                    if (supervisorName.value.length == 0) {
                        strValidate1 += "Input a Reported By name.\n"
                        supervisorName.parentNode.parentNode.cells[0].style.color = txtColor;
                    }
                    else
                        supervisorName.parentNode.parentNode.cells[0].style.color = "";

                    if (supervisorPhone.value.length == 0) {
                        strValidate1 += "Input a Reported By phone number.\n"
                        supervisorPhone.parentNode.parentNode.cells[0].style.color = txtColor;
                    }
                    else
                        supervisorPhone.parentNode.parentNode.cells[0].style.color = "";

                    if (document.getElementById("radInsuredPremises_0").checked == false && document.getElementById("radInsuredPremises_1").checked == false) {
                        strValidate1 += "Select whether incident occured on insured premises.\n"
                        document.getElementById("radInsuredPremises").parentNode.parentNode.cells[0].style.color = txtColor;
                    }
                    else
                        document.getElementById("radInsuredPremises").parentNode.parentNode.cells[0].style.color = "";

                    if (document.getElementById("radClaimant_0").checked == false && document.getElementById("radClaimant_1").checked == false && document.getElementById("radClaimant_2").checked == false) {
                        strValidate1 += "Choose a type of claim.\n"
                        document.getElementById("radClaimant").parentNode.parentNode.cells[0].style.color = txtColor;
                    }
                    else
                        document.getElementById("radClaimant").parentNode.parentNode.cells[0].style.color = "";

                    if (incidentType.value.length == 0) {
                        strValidate4 += "Select the type of incident.\n"
                        incidentType.parentNode.parentNode.cells[0].style.color = txtColor;
                    }
                    else
                        incidentType.parentNode.parentNode.cells[0].style.color = "";
                    ////////////Page 2//////////////////////////

                    if (!ValidDate(dAccident.value) || dAccident.value.length == 0) {
                        strValidate2 += "Input a valid accident date.\n";
                        dAccident.parentNode.parentNode.cells[0].style.color = txtColor;
                    }
                    else
                        dAccident.parentNode.parentNode.cells[0].style.color = "";


                    if (!ValidDate(dDOB.value) && dDOB.value.length > 0) {
                        strValidate2 += "Input a valid Date of Birth.\n";
                        dDOB.parentNode.parentNode.cells[0].style.color = txtColor;
                    }
                    else
                        dDOB.parentNode.parentNode.cells[0].style.color = "";

                    if (firstName.value.length == 0) {
                        strValidate2 += "Input a first name for the claimant.\n";
                        firstName.parentNode.parentNode.cells[0].style.color = txtColor;
                    }
                    else
                        firstName.parentNode.parentNode.cells[0].style.color = "";

                    if (lastName.value.length == 0) {
                        strValidate2 += "Input a last name for the claimant.\n";
                        lastName.parentNode.parentNode.cells[0].style.color = txtColor;
                    }
                    else
                        lastName.parentNode.parentNode.cells[0].style.color = "";

                    if (document.getElementById("radGender_0").checked == false && document.getElementById("radGender_1").checked == false) {
                        strValidate2 += "Select a gender for the claimant.\n";
                        document.getElementById("radGender").parentNode.parentNode.cells[0].style.color = txtColor;
                    }
                    else
                        document.getElementById("radGender").parentNode.parentNode.cells[0].style.color = "";
                    


                    var regEx = /^\$?(\d*|\d{1,3}(,\d{3})*)(\.\d*)?\s*$/;


                    if (document.getElementById("radClaimant_1").checked == true) {
                        if (document.getElementById("radArrears_0").checked == false && document.getElementById("radArrears_1").checked == false) {
                            strValidate2 += "Select if tenant is in arrears.\n"
                            document.getElementById("radArrears").parentNode.parentNode.cells[0].style.color = txtColor;
                        }
                        else
                            document.getElementById("radArrears").parentNode.parentNode.cells[0].style.color = "";



                        if (document.getElementById("radArrears_0").checked == true && (rentDues.value.length == 0 || !regEx.test(rentDues.value))) {
                            strValidate2 += "Input a valid amount for rent dues.\n";
                            rentDues.parentNode.parentNode.cells[0].style.color = txtColor;
                        }
                        else
                            rentDues.parentNode.parentNode.cells[0].style.color = "";


                    }
                    else {
                        rentDues.parentNode.parentNode.cells[0].style.color = "";
                        document.getElementById("radArrears").parentNode.parentNode.cells[0].style.color = "";
                    }

                    if (document.getElementById("radMinor_0").checked == false && document.getElementById("radMinor_1").checked == false) {
                        strValidate2 += "Select if individual was a minor.\n";
                        document.getElementById("radMinor").parentNode.parentNode.cells[0].style.color = txtColor;
                    }
                    else
                        document.getElementById("radMinor").parentNode.parentNode.cells[0].style.color = "";


                    if (document.getElementById("radMinor_0").checked == true && document.getElementById("txtParentGuardianName").value.length == 0) {
                        strValidate2 += "Input the Parent/Guardian name.\n";
                        document.getElementById("txtParentGuardianName").parentNode.parentNode.cells[0].style.color = txtColor;
                    }
                    else {
                        document.getElementById("txtParentGuardianName").parentNode.parentNode.cells[0].style.color = "";
                    }

                    
                    if (document.getElementById("radWaiver").style.display == "" && document.getElementById("radWaiver_0").checked == false && document.getElementById("radWaiver_1").checked == false) {
                        strValidate2 += "Please select if a waiver was signed.\n"
                        document.getElementById("radWaiver").parentNode.parentNode.cells[0].style.color = txtColor;
                    }
                    else
                        document.getElementById("radWaiver").parentNode.parentNode.cells[0].style.color = "";

                    ////////////Page 3//////////////////////////
                    var pictures = document.getElementById("txtpictures");


                    if (document.getElementById("radPictures_0").checked == false && document.getElementById("radPictures_1").checked == false) {
                        strValidate3 += "Select if pictures were taken.\n";
                        document.getElementById("radPictures").parentNode.parentNode.cells[0].style.color = txtColor;
                    }
                    else
                        document.getElementById("radPictures").parentNode.parentNode.cells[0].style.color = "";
                    

                    if (document.getElementById("radPropertyDamage_0").checked == false && document.getElementById("radPropertyDamage_1").checked == false) {
                        strValidate3 += "Select if there was property damage.\n";
                        document.getElementById("radPropertyDamage").parentNode.parentNode.cells[0].style.color = txtColor;
                    }
                    else {
                        document.getElementById("radPropertyDamage").parentNode.parentNode.cells[0].style.color = "";
                    }

                    if (document.getElementById("radPropertyDamage_0").checked == true && propertyDamage.value.length == 0) {
                        strValidate3 += "Input type of property damage.\n";
                        propertyDamage.parentNode.parentNode.cells[0].style.color = txtColor;
                    }
                    else {
                        propertyDamage.parentNode.parentNode.cells[0].style.color = "";
                    }

                    if (document.getElementById("radPropertyDamage_0").checked == true && (!regEx.test(repairCost.value) || repairCost.value.length == 0)) {
                        strValidate3 += "Input a valid amount for estimated repair cost.\n";
                        repairCost.parentNode.parentNode.cells[0].style.color = txtColor;
                    }
                    else {
                        repairCost.parentNode.parentNode.cells[0].style.color = "";
                    }

                    if (document.getElementById("radPropertyDamage_0").checked == true && document.getElementById("radPropertyDamageOurPremises_0").checked == false && document.getElementById("radPropertyDamageOurPremises_1").checked == false) {
                        strValidate3 += "Select if property damage occured to our premises.\n";
                        document.getElementById("radPropertyDamageOurPremises").parentNode.parentNode.cells[0].style.color = txtColor;
                    }
                    else {
                        document.getElementById("radPropertyDamageOurPremises").parentNode.parentNode.cells[0].style.color = "";
                    }

                    if (document.getElementById("radMedicalAttention_0").checked == false && document.getElementById("radMedicalAttention_1").checked == false) {
                        strValidate3 += "Select if medical attention was sought.\n";
                        document.getElementById("radMedicalAttention").parentNode.parentNode.cells[0].style.color = txtColor;
                    }
                    else
                        document.getElementById("radMedicalAttention").parentNode.parentNode.cells[0].style.color = "";


                    if (document.getElementById("radMedicalAttention_0").checked == true && document.getElementById("radAmbulance_0").checked == false && document.getElementById("radAmbulance_1").checked == false) {
                        strValidate3 += "Select if individual was removed by ambulance.\n";
                        document.getElementById("radAmbulance").parentNode.parentNode.cells[0].style.color = txtColor;
                    }
                    else
                        document.getElementById("radAmbulance").parentNode.parentNode.cells[0].style.color = "";

                    if (document.getElementById("radWitnesses_0").checked == false && document.getElementById("radWitnesses_1").checked == false) {
                        strValidate3 += "Select if there were any witnesses.\n";
                        document.getElementById("radWitnesses").parentNode.parentNode.cells[0].style.color = txtColor;
                    }
                    else
                        document.getElementById("radWitnesses").parentNode.parentNode.cells[0].style.color = "";


                    if (document.getElementById("radWitnesses_0").checked == true && document.getElementById("txtWitnessName1").value.length == 0) {
                        strValidate3 += "Input the witnesses name.\n";
                        document.getElementById("txtWitnessName1").parentNode.parentNode.cells[0].style.color = txtColor;
                    }
                    else {
                        document.getElementById("txtWitnessName1").parentNode.parentNode.cells[0].style.color = "";
                    }


                    
                    ///////////////Page 4/////////////
                    //var incidentType = document.getElementById("dropIncidentType");
                    var incidentTime = document.getElementById("txtIncidentTime");
                    var floorType = document.getElementById("txtFloorType");
                    var injuryDesc = document.getElementById("txtInjuryDesc");
                    var obstructionType = document.getElementById("txtObstructionType");
                    var weather = document.getElementById("txtWeather");
                    var shoeType = document.getElementById("txtShoeType");
                    var objectsCarried = document.getElementById("txtObjectsCarried");
                    var fullDesc = document.getElementById("txtFullDesc");
                    /*
                    if(incidentType.value.length == 0)
                    {
                    strValidate4 += "Select the type of incident.\n"
                    incidentType.parentNode.parentNode.cells[0].style.color = txtColor;
                    }
                    else
                    incidentType.parentNode.parentNode.cells[0].style.color = "";
                    */
                    if (incidentTime.value.length == 0) {
                        strValidate4 += "Input time of incident.\n"
                        incidentTime.parentNode.parentNode.cells[0].style.color = txtColor;
                    }
                    else
                        incidentTime.parentNode.parentNode.cells[0].style.color = "";

                    if (floorType.value.length == 0) {
                        strValidate4 += "Input type of floor.\n"
                        floorType.parentNode.parentNode.cells[0].style.color = txtColor;
                    }
                    else
                        floorType.parentNode.parentNode.cells[0].style.color = "";

                    if (injuryDesc.value.length == 0) {
                        strValidate4 += "Input injury description.\n"
                        injuryDesc.parentNode.parentNode.cells[0].style.color = txtColor;
                    }
                    else
                        injuryDesc.parentNode.parentNode.cells[0].style.color = "";

                    if (document.getElementById("radInspectedImmediately_0").checked == false && document.getElementById("radInspectedImmediately_1").checked == false) {
                        strValidate4 += "Select if location was inspected immediately .\n";
                        document.getElementById("radInspectedImmediately").parentNode.parentNode.cells[0].style.color = txtColor;                      
                    }
                    else
                        document.getElementById("radInspectedImmediately").parentNode.parentNode.cells[0].style.color = "";
                        

//                    if (document.getElementById("radLocationClean_0").checked == false && document.getElementById("radLocationClean_1").checked == false) {
//                        strValidate4 += "Select if location was clean.\n";
//                        document.getElementById("radLocationClean").parentNode.parentNode.cells[0].style.color = txtColor;
//                    }
//                    else
                    //                        document.getElementById("radLocationClean").parentNode.parentNode.cells[0].style.color = "";

                    if (document.getElementById("radLocationClean_0").checked == false && document.getElementById("radLocationClean_1").checked == false && document.getElementById("radLocationClean_2").checked == false) {
                        strValidate4 += "Select if location was clean.\n";
                        document.getElementById("radLocationClean").parentNode.parentNode.cells[0].style.color = txtColor;
                    }
                    else
                        document.getElementById("radLocationClean").parentNode.parentNode.cells[0].style.color = "";


                    if (document.getElementById("radLocationDry_0").checked == false && document.getElementById("radLocationDry_1").checked == false && document.getElementById("radLocationDry_2").checked == false) {
                        strValidate4 += "Select if location was dry.\n";
                        document.getElementById("radLocationDry").parentNode.parentNode.cells[0].style.color = txtColor;
                    }
                    else
                        document.getElementById("radLocationDry").parentNode.parentNode.cells[0].style.color = "";


//                    if (document.getElementById("radLocationDry_0").checked == false && document.getElementById("radLocationDry_1").checked == false) {
//                        strValidate4 += "Select if location was dry.\n";
//                        document.getElementById("radLocationDry").parentNode.parentNode.cells[0].style.color = txtColor;
//                    }
//                    else
//                        document.getElementById("radLocationDry").parentNode.parentNode.cells[0].style.color = "";

                    if (document.getElementById("radObstruction_0").checked == false && document.getElementById("radObstruction_1").checked == false) {
                        strValidate4 += "Select if there was any foreign substance or obstruction.\n";
                        document.getElementById("radObstruction").parentNode.parentNode.cells[0].style.color = txtColor;
                    }
                    else
                        document.getElementById("radObstruction").parentNode.parentNode.cells[0].style.color = "";

                    if (document.getElementById("radObstruction_0").checked == true && obstructionType.value.length == 0) {
                        strValidate4 += "Input type of foreign substance or obstruction.\n"
                        obstructionType.parentNode.parentNode.cells[0].style.color = txtColor;
                    }
                    else
                        obstructionType.parentNode.parentNode.cells[0].style.color = "";

                    if (weather.value.length == 0) {
                        strValidate4 += "Input weather conditions.\n"
                        weather.parentNode.parentNode.cells[0].style.color = txtColor;
                    }
                    else
                        weather.parentNode.parentNode.cells[0].style.color = "";

                    if (shoeType.value.length == 0) {
                        strValidate4 += "Input shoe type.\n"
                        shoeType.parentNode.parentNode.cells[0].style.color = txtColor;
                    }
                    else
                        shoeType.parentNode.parentNode.cells[0].style.color = "";

                    if (document.getElementById("radCarryingObjects_0").checked == false && document.getElementById("radCarryingObjects_1").checked == false && document.getElementById("radCarryingObjects_2").checked == false) {
                        strValidate4 += "Select if there was any objects carried during incident.\n";
                        document.getElementById("radCarryingObjects").parentNode.parentNode.cells[0].style.color = txtColor;
                    }
                    else
                        document.getElementById("radCarryingObjects").parentNode.parentNode.cells[0].style.color = "";

                    if (document.getElementById("radCarryingObjects_0").checked == true && objectsCarried.value.length == 0) {
                        strValidate4 += "Input type of objects carried during incident.\n"
                        objectsCarried.parentNode.parentNode.cells[0].style.color = txtColor;
                    }
                    else
                        objectsCarried.parentNode.parentNode.cells[0].style.color = "";

                    if (document.getElementById("radSurveillance_0").checked == false && document.getElementById("radSurveillance_1").checked == false) {
                        strValidate4 += "Select if surveillance captured the event.\n";
                        document.getElementById("radSurveillance").parentNode.parentNode.cells[0].style.color = txtColor;
                    }
                    else
                        document.getElementById("radSurveillance").parentNode.parentNode.cells[0].style.color = "";

                    if (document.getElementById("radSurveillance_0").checked == true && document.getElementById("radFilm_0").checked == false && document.getElementById("radFilm_1").checked == false && document.getElementById("radFilm_2").checked == false) {
                        strValidate4 += "Select if the film was preserved.\n";
                        document.getElementById("radFilm").parentNode.parentNode.cells[0].style.color = txtColor;
                    }
                    else
                        document.getElementById("radFilm").parentNode.parentNode.cells[0].style.color = "";
                    



                    if (fullDesc.value.length == 0) {
                        strValidate4 += "Input full description of incident.\n"
                        fullDesc.parentNode.parentNode.parentNode.rows[0].cells[0].style.color = txtColor;
                    }
                    else
                        fullDesc.parentNode.parentNode.parentNode.rows[0].cells[0].style.color = "";
                    

                    

                    ////////////////////////////////////////////////       
                    if (strValidate1.length > 0) {
                        //document.getElementById("TabStripClaim").selectedIndex = 0;
                         showPanel('GeneralInformation',1 );
                        alert("Please complete the following before saving:\n" + strValidate1 + strValidate2 + strValidate3 + strValidate4);

                        return false;
                    }
                    else if (strValidate2.length > 0) {
                        //document.getElementById("TabStripClaim").selectedIndex = 1;
                        showPanel('GuestInformation',1);
                        alert("Please complete the following before saving:\n" + strValidate2 + strValidate3 + strValidate4);

                        return false;
                    }
                    else if (strValidate3.length > 0) {
                        //document.getElementById("TabStripClaim").selectedIndex = 2;
                        showPanel('IncidentDetails1',1);
                        alert("Please complete the following before saving:\n" + strValidate3 + strValidate4);

                        return false;
                    }
                    else if (strValidate4.length > 0) {
                        
                        //document.getElementById("TabStripClaim").selectedIndex = 3;
                        showPanel('IncidentDetails1',1);
                        alert("Please complete the following before saving:\n" + strValidate4);

                        return false;
                    }
                }



            }
            else if (process) {

            }
            else {
                alert("This claim has already been submitted.\nYou cannot make any changes to this claim.")
                return false;
            }
            
            return true;
        }


        function ValidDate(strDate) {
            var objRegExp = /^\d{1,2}(\-|\/|\.)\d{1,2}(\-|\/|\.)(\d{4}|\d{2})$/;

            //check to see if in correct format
            //alert(date1);
            // alert(time1);
            if (!objRegExp.test(strDate)) {
                //alert("Please input a valid Date.");
                return false; //doesn't match pattern, bad date
            }
            else {
                //var strSeparator = strDate.substring(1,3) //find date separator

                //var arrayDate = strDate.split(strSeparator); //split date into month, day, year
                var arrayDate = strDate.split(/\D/);
                if (arrayDate[0].length == 1)
                    arrayDate[0] = "0" + arrayDate[0];
                //create a lookup for months not equal to Feb.
                var arrayLookup = { '01': 31, '03': 31, '04': 30, '05': 31, '06': 30, '07': 31,
                    '08': 31, '09': 30, '10': 31, '11': 30, '12': 31
                }
                //var intDay = parseInt(arrayDate[1]);
                var intDay = arrayDate[1];
                //alert(intDay);
                //check if month value and day value agree
                if (arrayDate[0] > 12 || arrayDate[0] < 1) {
                    //alert("Please input a valid Date.");
                    return false;
                } //alert('hi');
                if (arrayLookup[arrayDate[0]] != null) {
                    if (intDay <= arrayLookup[arrayDate[0]] && intDay > 0) {

                        return true; //found in lookup table, good date
                    }
                }

                //check for February
                var intYear = parseInt(arrayDate[2], 10);
                var intMonth = parseInt(arrayDate[0], 10);

                if (((intYear % 4 == 0 && intDay <= 29) || (intYear % 4 != 0 && intDay <= 28)) && intDay != 0)
                    return true; //Feb. had valid number of days

                //alert("Please input a valid Date.");
                return false; //any other values, bad date
            }

        }

        //var photoDirty = false;
        function AttachPhotos() {
            var returnPhotos = window.showModalDialog('AttachPhotos.htm', self, 'status:no;dialogHeight:300px;dialogWidth:530px');
            if (returnPhotos != null) {
                form1.hidPhotos.value = "true";

                form1.submit();
            }
        }

        function discardFile(file) {
            if (form1.hidSubmitted.value == 1) {
                alert('Cannot delete this image, claim has been submitted.');
                return false;
            }
            if (confirm("Are you sure you want to remove this file (" + file + ")?")) {
                document.getElementById("hidRemoveFile").value = file;
                form1.submit();
            }
            //else
            //     return false;
        }

        function OpenDoc(src) {
            // locstr = document.getElementById("imgItem").src;
            var locstr = src;
            //alert(locstr);
            // var returnArgs = window.showModalDialog(locstr,'',"status:no;dialogHeight:640px;dialogWidth:900px");
            window.open(locstr);
        }


        function discardDoc(file) {
            if (confirm("Are you sure you want to remove this file?" + file + ")")) {
                document.getElementById("hidRemoveFile2").value = file;
                form1.submit();
            }
            //else
            //     return false;
        }





        function SetCheckTotal() {

            var checktotal = 0.0
            var fval = parseFloat(document.getElementById("txtCheckAmnt1").value.replace(/\$/g, '').replace(/,/g, ''));
            if (fval >= 0)
                checktotal += fval;

            fval = parseFloat(document.getElementById("txtCheckAmnt2").value.replace(/\$/g, '').replace(/,/g, ''));
            if (fval >= 0)
                checktotal += fval;

            fval = parseFloat(document.getElementById("txtCheckAmnt3").value.replace(/\$/g, '').replace(/,/g, ''));
            if (fval >= 0)
                checktotal += fval;

            fval = parseFloat(document.getElementById("txtCheckAmnt4").value.replace(/\$/g, '').replace(/,/g, ''));
            if (fval >= 0)
                checktotal += fval;


            document.getElementById("txtTotalClaimCost").value = '$' + FormatMoney(checktotal);

        }

        function FormatMoney(amount) {
            // returns the amount in the .99 format 
            amount -= 0;
            amount = (Math.round(amount * 100)) / 100;
            return (amount == Math.floor(amount)) ? amount + '.00' : ((amount * 10 == Math.floor(amount * 10)) ? amount + '0' : amount);
        }

        function PrintClaim(Processing) {
            var claimId = document.getElementById("lblClaimId").innerText;
            strLoc = "PrintClaim.aspx?ClaimId=" + claimId + "&Processing=" + Processing + "&Images=" + form1.hidImages.value;

            //var returnPrint = window.showModalDialog(strLoc,self,"status:no;dialogHeight:870px;dialogWidth:850px;scroll:no");

            CloseReportChoice();

            var returnPrint = window.open(strLoc, "PrintClaim", "location=0,menubar=0,height=700px,width=900px,resizable=0,top=0,left=40,scrollbar=0;");

        }

        function GetReportChoice() {
            document.getElementById("divReportChoice").style.display = "";
        }

        function CloseReportChoice() {
            document.getElementById("divReportChoice").style.display = "none";
        }
        
         function showPanel(id, clearFlag)
         {

       
          
           var table1 = document.getElementById("tblTabs");
           for(x=0;x<table1.rows[0].cells.length -1; x++) 
           {
                table1.rows[0].cells[x].className = "inputTabOff";
                document.getElementById(table1.rows[0].cells[x].id.replace("btn","pnl")).style.display = "none";
           }
           document.getElementById("btn" + id).className = "inputTab";
           document.getElementById("pnl" + id).style.display = "block";
             
           document.getElementById("hidPanel").value = id;
           
           }
    </script>
</head>
<body onload="init()" style="margin-top: 10px; margin-bottom: 0px;" onmouseup="if(!onDivReportChoice){ CloseReportChoice();}">
    <form id="form1" runat="server">
    <input type="hidden" runat="server" id="hidSubmitted" />
    <input type="hidden" runat="server" id="hidPhotos" />
    <asp:HiddenField ID="hidFolder" runat="server" />
    <asp:HiddenField ID="fillDocs" runat="server" />
    <asp:HiddenField ID="ROOT_DIRECTORY" runat="server" />
    <asp:HiddenField ID="hidRemoveFile" runat="server" />
    <asp:HiddenField ID="hidRemoveFile2" runat="server" />
     <asp:HiddenField ID="hidPanel" runat="server" Value="GeneralInformation" />
   
    <input type="hidden" runat="server" id="hidImages" />
    <div>
        <table width="100%" style="margin-bottom: 13px; background-color: #e6effd; font-family: Arial;
            font-size: 9pt; color: black; border-bottom: 1px solid black; border-top: 1px solid black;
            border-left: 1px solid black; border-right: 1px solid black;">
            <tr>
                <td style="width: 47px">
                    Claim #:
                </td>
                <td style="width: 60px">
                    <asp:Label ID="lblClaimId" runat="server" Text="New Claim" Font-Bold="true" Font-Names="Arial"
                        Font-Size="9pt" ForeColor="black"></asp:Label>
                </td>
                <td style="width: 31px">
                    Prop:
                </td>
                <td style="width: 180px">
                    <asp:Label ID="lblProp" runat="server" Font-Bold="true" Font-Names="Arial" Font-Size="9pt"
                        ForeColor="black"></asp:Label>
                </td>
                <td style="width: 34px">
                    Bldg:
                </td>
                <td style="width: 155px">
                    <asp:Label ID="lblBldg" runat="server" Font-Bold="true" Font-Names="Arial" Font-Size="9pt"
                        ForeColor="black"></asp:Label>
                </td>
                <td style="width: 55px">
                    Claimant:
                </td>
                <td style="width: 180px">
                    <asp:Label ID="lblClaimant" runat="server" Font-Bold="true" Font-Names="Arial" Font-Size="9pt"
                        ForeColor="black"></asp:Label>
                </td>
                <td style="width: 42px">
                    Status:
                </td>
                <td style="width: 80px">
                    <asp:Label ID="lblStatus" runat="server" Font-Bold="true" Font-Names="Arial" Font-Size="9pt"
                        ForeColor="black"></asp:Label>
                </td>
                <td align="right">
                    <asp:Button ID="btnPrintClaim" Enabled="false" runat="server" Text="Print" OnClientClick="GetReportChoice(); return false;" />
                </td>
            </tr>
        </table>
        <table style="border-collapse: collapse;" width="99.5%" cellpadding="0" cellspacing="0">
            <tr valign="bottom" id="trClaimTab">
                <td width="92%" id="tdClaimTab" style="">
                   <%-- <IE:TabStrip ID="TabStripClaim" Style="font-weight: bold; overflow: hidden;" runat="server"
                        TargetID="mpgPages" SepDefaultStyle="width: 10px; BORDER-BOTTOM: black 1px solid;BACKGROUND-COLOR: transparent;"
                        TabSelectedStyle="border-bottom: none; BORDER-RIGHT: black 1px solid; BACKGROUND-POSITION: center center;BORDER-TOP: #ff9933 3px solid; BACKGROUND-Color: #EFF3FB; BORDER-LEFT: black 1px solid; CURSOR: default; TEXT-ALIGN: center; PADDING-RIGHT: 5px; PADDING-LEFT: 5px;"
                        TabDefaultStyle="width: 125px; BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid; BACKGROUND-POSITION: center center; FONT-WEIGHT: bolder; FONT-SIZE: 8pt; BACKGROUND-Color: #dcdee0; FONT-FAMILY: Arial; HEIGHT: 28px; TEXT-ALIGN: Center; PADDING-RIGHT: 5px; PADDING-LEFT: 5px;"
                        TabHoverStyle="BORDER-RIGHT: black 1px outset; BORDER-TOP: black 1px outset; BORDER-LEFT: black 1px outset; CURSOR: Hand; BORDER-BOTTOM: black 1px outset; BACKGROUND-COLOR: #dcdee0;"
                        Width="100%" TabIndex="1">
                        <IE:Tab Text="General Information"></IE:Tab>
                        <IE:Tab Text="Guest Information"></IE:Tab>
                        <IE:Tab Text="Incident Details 1"></IE:Tab>
                        <IE:Tab Text="Incident Details 2"></IE:Tab>
                        <IE:Tab Text="Documents" ID="tabDocuments"></IE:Tab>
                        <IE:Tab Text="Notes" ID="tabNotes"></IE:Tab>
                        <IE:Tab Text="Processing" ID="tab1"></IE:Tab>
                        <IE:TabSeparator DefaultStyle="width: 100%"></IE:TabSeparator>
                    </IE:TabStrip>--%>
                    
                     <table id="tblTabs" width="100%" style="margin-top:3px;  border-collapse: collapse;" cellspacing="-1" cellpadding="-1" >
                            <tr>
                                <td style="width:13%"  id="btnGeneralInformation" onclick="showPanel('GeneralInformation',1);" class="inputTab" runat="server" >General Information</td>
                                <td style="width:13%"  id="btnGuestInformation" onclick="showPanel('GuestInformation',1);" class="inputTabOff" runat="server" >Guest Information</td>
                                <td style="width:12%"  id="btnIncidentDetails1" onclick="showPanel('IncidentDetails1',1);" class="inputTabOff" runat="server" >Incident Details 1</td>
                                <td style="width:12%"  id="btnIncidentDetails2" onclick="showPanel('IncidentDetails2',1);" class="inputTabOff" runat="server" >Incident Details 2</td>
                                <td style="width:9%"  id="btnDocuments" onclick="showPanel('Documents',1);" class="inputTabOff" runat="server" >Documents</td>
                                <td style="width:9%"  id="btnNotes" onclick="showPanel('Notes',1);" class="inputTabOff" runat="server" >Notes</td>
                                <td style="width:9%"  id="btnProcessing" onclick="showPanel('Processing',1);" class="inputTabOff" runat="server" >Processing</td>
                                 <td style="border-bottom:2px solid Silver; width:23%" align="right" >
                                  <asp:Button ID="btnNewClaim" runat="server" Text="New Claim" CssClass="Button2" />&nbsp; 
                                 </td>
                         
                             </tr>
                    </table>
                </td>
               <%-- <td width="8%" id="tdNewClaim" style="">
                   
                    <div style="width: 100%; text-align: right; border-bottom: black 1px solid; padding-bottom: 4px;">
                        
                        <asp:Button ID="btnNewClaim" runat="server" Text="New Claim" CssClass="Button2" />
                    </div>
                </td>--%>
            </tr>
        </table>
        <%--<IE:MultiPage ID="mpgPages" runat="server" Style="height: 100%; width: 98.4%; overflow: visible;
            border-right: black 1px solid; padding-right: 5px; border-top: medium none; padding-left: 5px;
            padding-bottom: 1px; border-left: black 1px solid; padding-top: 5px; border-bottom: black 1px solid;
            background-color: #EFF3FB;">--%>
             <asp:Panel ID="pnlGeneralInformation" runat="server" style="display: block;" >
             <table width="100%" border="0" style="border-left:solid 1px black;border-right:solid 1px black; border-bottom: black 1px solid; border-collapse: collapse;" cellpadding="1" >
            <tr><td>
                <!-- part 1 -->
                <table cellpadding="10" align="center" style="height: 420px;">
                    <%--width="100%"--%>
                    <tr>
                        <td valign="top" style="height: 366px;">
                            <table border="0" cellspacing="5">
                                <tr>
                               <td class="labelText">
                                        Property:
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="dropProp" runat="server" Width="350px" AutoPostBack="true">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelText">
                                        Building:
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="dropBldg" runat="server" Width="350px">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelText">
                                        <%--style="width: 250px;"--%>
                                        Exact location of injury<br />
                                        (i.e. restroom, sidewalk, food court):
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtLocation" runat="server" Width="244px"></asp:TextBox>
                                    </td>
                                </tr>
                                <%--<tr>
                                    <td class="labelText">
                                        Property Address:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPropAddress" runat="server" Width="244px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelText" style="vertical-align: middle;">
                                        City:
                                    </td>
                                    <td valign="middle">
                                        <asp:TextBox ID="txtPropCity" runat="server" Width="125px"></asp:TextBox>&nbsp;&nbsp;&nbsp;<span
                                            class="labelText" style="vertical-align: middle;">State:</span>&nbsp;
                                        <asp:TextBox ID="txtPropState" runat="server" Width="50px"></asp:TextBox>&nbsp;&nbsp;&nbsp;<span
                                            class="labelText" style="vertical-align: middle;">ZIP:</span>&nbsp;
                                        <asp:TextBox ID="txtPropZip" runat="server" Width="75px"></asp:TextBox>
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td class="labelText">
                                        Address:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPropAddress" runat="server" Width="244px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelText">
                                        City:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPropCity" runat="server" Width="100px"></asp:TextBox>
                                        &nbsp; <span class="labelText" style="vertical-align: middle;">State:</span>
                                        <asp:DropDownList ID="ddlPropState" runat="server" Width="156px">
                                        </asp:DropDownList>
                                        &nbsp; <span class="labelText" style="vertical-align: middle;">Zip:</span>
                                        <asp:TextBox ID="txtPropZip" runat="server" Width="56px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td colspan="2" align="center">
                                        <table>
                                            <tr>
                                                <td valign="top">
                                                    <fieldset>
                                                        <legend class="labelText" style="padding: 5px; color: Gray">Employee Completing Report:</legend>
                                                        <table>
                                                            <tr>
                                                                <td class="labelText">
                                                                    Name:
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtSupervisorName" runat="server" Width="175px"></asp:TextBox>
                                                                </td>
                                                                <td class="labelText">
                                                                    Phone:
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtSupervisorPhone" runat="server" Width="100px"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="4">
                                                                    <fieldset>
                                                                        <legend class="labelText" style="padding: 5px; color: Gray">Manager Information:</legend>
                                                                        <table>
                                                                            <tr>
                                                                                <td class="labelText">
                                                                                    Name:
                                                                                </td>
                                                                                <td>
                                                                                    <asp:TextBox ID="txtManagerName" runat="server" Width="175px"></asp:TextBox>
                                                                                </td>
                                                                                <td class="labelText">
                                                                                    Phone:
                                                                                </td>
                                                                                <td>
                                                                                    <asp:TextBox ID="txtManagerPhone" runat="server" Width="100px"></asp:TextBox>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td class="labelText">
                                                                                    Email:
                                                                                </td>
                                                                                <td>
                                                                                    <asp:TextBox ID="txtManagerEmail" runat="server" Width="175px"></asp:TextBox>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </fieldset>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </fieldset>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <%--<tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td class="labelText">
                                        <%--style="width: 175px;"--%>
                                        Did incident occur on<br />
                                        insured premises?
                                    </td>
                                    <td class="labelText" style="text-align: left;">
                                        <asp:RadioButtonList ID="radInsuredPremises" runat="server" RepeatDirection="horizontal"
                                            RepeatLayout="flow">
                                            <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="0"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <%--<tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td class="labelText">
                                        Type of claim:
                                    </td>
                                    <td class="labelText" style="text-align: left;">
                                        <asp:RadioButtonList ID="radClaimant" runat="server" RepeatDirection="horizontal"
                                            RepeatLayout="flow">
                                            <asp:ListItem Text="Commercial" Value="Commercial"></asp:ListItem>
                                            <asp:ListItem Text="Residential - Resident" Value="Resident"></asp:ListItem>
                                            <asp:ListItem Text="Residential - Guest" Value="Guest"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelText">
                                        Type of incident:
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="dropIncidentType" runat="server" Width="250px">
                                            <asp:ListItem></asp:ListItem>
                                            <asp:ListItem Value="Auto">Auto</asp:ListItem>
                                            <asp:ListItem Value="Property">Property</asp:ListItem>
                                            <asp:ListItem Value="GL - Slip and Fall">GL - Slip and Fall</asp:ListItem>
                                            <asp:ListItem Value="GL - Personal Injury">GL - Personal Injury</asp:ListItem>
                                            <asp:ListItem Value="GL - Other">GL - Other</asp:ListItem>
                                            <asp:ListItem Value="Section F">Section F</asp:ListItem>
                                            <asp:ListItem Value="Workman's Comp">Workman's Comp</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <%--<tr>
                        <td valign="bottom" align="right" style="width: 100%;">
                            <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="Button1" OnCommand="Save"
                                CommandName="Save" />
                        </td>
                    </tr>--%>
                </table>
                <div style="padding-bottom: 7px; height: 20px" align="right">
                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="Button1" OnCommand="Save"
                        CommandName="Save" />
                </div>
            </td></tr></table>
           </asp:Panel>
           <asp:Panel ID="pnlGuestInformation" runat="server" style="display: none;" >
                      <table width="100%" border="0" style="border-left:solid 1px black;border-right:solid 1px black; border-bottom: black 1px solid;" cellpadding="1" >
                 <tr><td>
                <!-- part 2 -->
                <table cellpadding="10" align="center" style="height: 420px;">
                    <%--width="100%" --%>
                    <tr>
                        <td valign="top">
                            <table border="0" cellspacing="4">
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelText">
                                        Date of Accident:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtAccidentDate" runat="server" Width="80px" Style="display: table-cell;"></asp:TextBox><input
                                            type="button" id="showCalendarAccidentDate" class="btnCalendar" style="display: table-cell;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelText">
                                        Social Security #:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtSocial" runat="server" Width="80px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelText">
                                        First Name:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtFirstName" runat="server" Width="244px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelText">
                                        Middle Name:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtMiddleName" runat="server" Width="244px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelText">
                                        Last Name:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtLastName" runat="server" Width="244px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelText">
                                        Gender:
                                    </td>
                                    <td class="labelText" style="text-align: left;">
                                        <asp:RadioButtonList ID="radGender" runat="server" RepeatDirection="horizontal" RepeatLayout="flow">
                                            <asp:ListItem Text="Male" Value="M"></asp:ListItem>
                                            <asp:ListItem Text="Female" Value="F"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelText">
                                        Date of Birth:
                                    </td>
                                    <td class="labelText" style="text-align: left;">
                                        <asp:TextBox ID="txtDOB" runat="server" Width="80px"></asp:TextBox>
                                        (mm/dd/yyyy)
                                        <input type="button" id="showCalendarDOB" class="btnCalendar" style="display: none;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelText">
                                        Address:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtAddress" runat="server" Width="244px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelText">
                                        City:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtCity" runat="server" Width="244px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelText">
                                        State:
                                    </td>
                                    <td class="labelText" style="text-align: left;">
                                        <asp:DropDownList ID="dropState" runat="server" Width="156px">
                                        </asp:DropDownList>
                                        &nbsp; Zip:
                                        <asp:TextBox ID="txtZip" runat="server" Width="56px"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td valign="top" style="height: 366px;">
                            <table border="0" cellspacing="5">
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelText">
                                        Home Phone:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPhone" runat="server" Width="150px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelText">
                                        Work Phone:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtWorkPhone" runat="server" Width="150px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelText">
                                        Mobile Phone:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtMobilePhone" runat="server" Width="150px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelText">
                                        Did the incident
                                        <br />
                                        involve a minor?
                                    </td>
                                    <td class="labelText" style="text-align: left;">
                                        <asp:RadioButtonList ID="radMinor" runat="server" RepeatDirection="horizontal" RepeatLayout="flow">
                                            <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="False"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr id="trParentGuardian" style="display: none;">
                                    <td colspan="2">
                                        <fieldset style="margin: 0px; padding: 0px;">
                                            <legend class="labelText">Parent/Guardian</legend>
                                            <div style="overflow: auto; width: 350px; height: 170px; margin: 0px; padding: 0px;">
                                                <table cellpadding="2" cellspacing="0">
                                                    <tr id="trParentGuardian1">
                                                        <td class="labelText">
                                                            Name:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtParentGuardianName" runat="server" Width="244px"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelText">
                                                            Address:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtParentGuardianAddress" runat="server" Width="244px"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr id="trParentGuardian2">
                                                        <td class="labelText">
                                                            City:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtParentGuardianCity" runat="server" Width="244px"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelText">
                                                            State:
                                                        </td>
                                                        <td class="labelText" style="text-align: left;">
                                                            <asp:DropDownList ID="dropState2" runat="server" Width="156px">
                                                            </asp:DropDownList>
                                                            &nbsp; Zip:
                                                            <asp:TextBox ID="TxtParentGuardianZip" runat="server" Width="56px"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr id="trParentGuardian3">
                                                        <td class="labelText">
                                                            Home Phone:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtParentGuardianHomePhone" runat="server" Width="150px"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelText">
                                                            Mobile Phone:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtParentGuardianMobilePhone" runat="server" Width="150px"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr id="trParentGuardian4">
                                                        <td class="labelText">
                                                            Work Phone:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtParentGuardianWorkPhone" runat="server" Width="150px"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </fieldset>
                                    </td>
                                </tr>
                                <tr id="trWaiver" style="display: "";">
                                    <td class="labelText" style="padding-top: 10px;">
                                        Was a waiver signed?
                                    </td>
                                    <td class="labelText" style="text-align: left; padding-top: 10px;">
                                        <asp:RadioButtonList ID="radWaiver" runat="server" RepeatDirection="horizontal"
                                            RepeatLayout="flow">
                                            <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="False"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr id="trArrears" style="display: none;">
                                    <td class="labelText" style="padding-top: 10px;">
                                        Rent in arrears?
                                    </td>
                                    <td class="labelText" style="text-align: left; padding-top: 10px;">
                                        <asp:RadioButtonList ID="radArrears" runat="server" RepeatDirection="horizontal"
                                            RepeatLayout="flow">
                                            <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="False"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr id="trArrears1" style="display: none;">
                                    <td class="labelText">
                                        Rent dues:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtRentDues" runat="server" Width="150px"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <%--<tr>
                        <td valign="bottom" colspan="3" align="right" style="width: 100%;">
                            <asp:Button ID="Button1" runat="server" Text="Save" CssClass="Button1" CommandName="Save"
                                OnCommand="Save" />
                        </td>
                    </tr>--%>
                </table>
                <div style="padding-bottom: 7px; height: 20px;" align="right">
                    <asp:Button ID="Button1" runat="server" Text="Save" CssClass="Button1" CommandName="Save"
                        OnCommand="Save" />
                </div>
                <script type="text/javascript">
                    Calendar.setup(
                                {
                                    inputField: "txtAccidentDate",      // ID of the input field
                                    button: "showCalendarAccidentDate"      // ID of the button
                                }
                              );

                    Calendar.setup(
                                {
                                    inputField: "txtDOB",      // ID of the input field
                                    button: "showCalendarDOB"      // ID of the button
                                }
                              );
                </script>
            </td> </tr> </table>
          </asp:Panel>
           <asp:Panel ID="pnlIncidentDetails1" runat="server" style="display: none" >
                 <table width="100%" border="0" style="border-left:solid 1px black;border-right:solid 1px black; border-bottom: black 1px solid;" cellpadding="1" >
               <tr><td>
                <!-- part 3 -->
                <table cellpadding="9" align="center" style="height: 420px;">
                    <%--width="100%"--%>
                    <tr>
                        <td valign="top">
                            <table border="0" cellspacing="3">
                                <tr>
                                    <td class="labelText" style="width: 175px;">
                                        Any property damage?
                                    </td>
                                    <td class="labelText" style="text-align: left; width: 327px;">
                                        <asp:RadioButtonList ID="radPropertyDamage" runat="server" RepeatDirection="horizontal"
                                            RepeatLayout="flow">
                                            <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="False"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr id="trPropDamage1" style="display: none;">
                                    <td class="labelText">
                                        Short description of property damage:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPropertyDamage" runat="server" Width="310px" TextMode="multiLine"
                                            Rows="3"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr id="trPropDamage2" style="display: none;">
                                    <td class="labelText">
                                        Estimated Repair Cost:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtRepairCost" runat="server" Width="150px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr id="trPropDamage3">
                                    <td class="labelText">
                                        <%--style="width: 180px;"--%>
                                        Did property damage occur to our premises?
                                    </td>
                                    <td class="labelText" style="text-align: left;">
                                        <%--width: 320px;--%>
                                        <asp:RadioButtonList ID="radPropertyDamageOurPremises" runat="server" RepeatDirection="horizontal"
                                            RepeatLayout="flow">
                                            <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="False"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr style="display: none;">
                                    <td colspan="2" class="labelText" align="Center" style="text-align: Center; text-decoration: underline;
                                        font-size: 10pt;">
                                        Medical Information
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelText">
                                        Was medical attention sought?
                                    </td>
                                    <td class="labelText" style="text-align: left;">
                                        <asp:RadioButtonList ID="radMedicalAttention" runat="server" RepeatDirection="horizontal"
                                            RepeatLayout="flow">
                                            <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="False"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr id="trAmbulance" style="display: none;">
                                    <td class="labelText">
                                        Was individual removed from scene by ambulance?
                                    </td>
                                    <td class="labelText" style="text-align: left;">
                                        <asp:RadioButtonList ID="radAmbulance" runat="server" RepeatDirection="horizontal"
                                            RepeatLayout="flow">
                                            <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="False"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr id="trMedicalAttention" style="display: none;">
                                    <td class="labelText">
                                        Facility Name:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPhysicianName" runat="server" Width="310px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr id="trMedicalAttention2" style="display: none;">
                                    <td class="labelText">
                                        Address:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPhysicianAddress" runat="server" Width="310px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr id="trMedicalAttention3" style="display: none;">
                                    <td class="labelText">
                                        Contact:
                                    </td>
                                    <td class="labelText" style="text-align: left;">
                                        <asp:TextBox ID="txtPhysicianContact" runat="server" Width="160px"></asp:TextBox>
                                        &nbsp; Phone:
                                        <asp:TextBox ID="txtPhysicianPhone" runat="server" Width="92px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelText">
                                        Any pictures taken?
                                    </td>
                                    <td class="labelText" style="text-align: left;">
                                        <asp:RadioButtonList ID="radPictures" runat="server" RepeatDirection="horizontal"
                                            RepeatLayout="flow">
                                            <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="False"></asp:ListItem>
                                        </asp:RadioButtonList>
                                        &nbsp; &nbsp; &nbsp;
                                        <asp:Button ID="btnAttachPhotos" runat="server" Text="Attach Photos" CssClass="Button2"
                                            Style="display: none;" />
                                    </td>
                                </tr>
                                <tr id="trPictures" style="display: none;">
                                    <td colspan="2">
                                        <fieldset style="margin: 0px; padding: 0px;">
                                            <legend class="labelText">Photos</legend>
                                            <div style="overflow: auto; width: 450px; height: 91px; margin: 0px; padding: 0px;">
                                                <table cellpadding="2" cellspacing="0">
                                                    <tr>
                                                        <asp:Repeater ID="rptPhotos" runat="server">
                                                            <ItemTemplate>
                                                                <td class="labelText" style="text-align: left; word-wrap: break-word;">
                                                                    <table cellpadding="0" cellspacing="0">
                                                                        <tr>
                                                                            <td style="width: 70px; height: 70px; vertical-align: bottom; cursor: hand;" onclick="OpenDoc('<%# (ROOT_DIRECTORY.Value & hidFolder.Value & "\" & Container.DataItem(0)).replace("\","\\")%>')">
                                                                                <%#Container.DataItem(1)%>
                                                                            </td>
                                                                            <td align="left" style="vertical-align: bottom; width: 35px;">
                                                                                <span title="Click here to delete file." onclick="discardFile('<%#Container.DataItem(0)%>');"
                                                                                    style="vertical-align: middle; width: 20px; height: 20px;">
                                                                                    <img id="imgTrash" src="images/trashcan.gif" width="20px" height="20px" /></span>
                                                                                &nbsp; &nbsp;
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </ItemTemplate>
                                                        </asp:Repeater>
                                                    </tr>
                                                </table>
                                            </div>
                                        </fieldset>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td valign="top" style="height: 366px;">
                            <table cellpadding="0" cellspacing="0">
                                <tr>
                                    <td valign="top" style="height: 398px; width: 375px;" align="left">
                                        <%--418px--%>
                                        <table border="0" cellspacing="2">
                                            <tr>
                                                <td class="labelText" style="width: 150px;">
                                                    Were there any witnesses?
                                                </td>
                                                <td class="labelText" style="text-align: left; width: 210px;">
                                                    <asp:RadioButtonList ID="radWitnesses" runat="server" RepeatDirection="horizontal"
                                                        RepeatLayout="flow">
                                                        <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                                        <asp:ListItem Text="No" Value="False"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>
                                            </tr>
                                            <tr id="trWitnesses1" style="display: none;">
                                                <td class="labelText">
                                                    Witness Name:
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtWitnessName1" runat="server" Width="200px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr id="trWitnesses2">
                                                <td class="labelText">
                                                    Address:
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtWitnessAddress1" runat="server" Width="200px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr id="trWitnesses3">
                                                <td class="labelText">
                                                    City:
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtWitnessCity1" runat="server" Width="200px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr id="trWitnesses4">
                                                <td class="labelText">
                                                    State:
                                                </td>
                                                <td class="labelText" style="text-align: left;">
                                                    <asp:DropDownList ID="dropWitnessState1" runat="server" Width="112px">
                                                    </asp:DropDownList>
                                                    &nbsp; Zip:
                                                    <asp:TextBox ID="txtWitnessZip1" runat="server" Width="56px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr id="trWitnesses5">
                                                <td class="labelText">
                                                    Home Phone:
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtWitnessPhone1" runat="server" Width="92px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr id="trWitnesses12">
                                                <td class="labelText">
                                                    Mobile Phone:
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtWitnessMobile1" runat="server" Width="92px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr id="trWitnesses14">
                                                <td class="labelText">
                                                    Work Phone:
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtWitnessWork1" runat="server" Width="92px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr id="trWitnesses6" style="display: none;">
                                                <td class="labelText">
                                                    Witness Name:
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtWitnessName2" runat="server" Width="200px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr id="trWitnesses7">
                                                <td class="labelText">
                                                    Address:
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtWitnessAddress2" runat="server" Width="200px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr id="trWitnesses8">
                                                <td class="labelText">
                                                    City:
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtWitnessCity2" runat="server" Width="200px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr id="trWitnesses9">
                                                <td class="labelText">
                                                    State:
                                                </td>
                                                <td class="labelText" style="text-align: left;">
                                                    <asp:DropDownList ID="dropWitnessState2" runat="server" Width="112px">
                                                    </asp:DropDownList>
                                                    &nbsp; Zip:
                                                    <asp:TextBox ID="txtWitnessZip2" runat="server" Width="56px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr id="trWitnesses10">
                                                <td class="labelText">
                                                    Home Phone:
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtWitnessPhone2" runat="server" Width="92px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr id="trWitnesses11">
                                                <td class="labelText">
                                                    Mobile Phone:
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtWitnessMobile2" runat="server" Width="92px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr id="trWitnesses13">
                                                <td class="labelText">
                                                    Work Phone:
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtWitnessWork2" runat="server" Width="92px"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <%--<tr>
                                    <td valign="bottom" colspan="1" align="right" style="width: 100%;">
                                        <asp:Button ID="Button3" runat="server" Text="Save" CssClass="Button1" CommandName="Save"
                                            OnCommand="Save" />
                                    </td>
                                </tr>--%>
                            </table>
                        </td>
                    </tr>
                </table>
                <div align="right" style="padding-bottom: 7px; height: 20px">
                    <asp:Button ID="Button3" runat="server" Text="Save" CssClass="Button1" CommandName="Save"
                        OnCommand="Save" /></div>
            </td></tr>     </table>
           </asp:Panel>
             <asp:Panel ID="pnlIncidentDetails2" runat="server" style="display: none;" >
                     <table width="100%" border="0" style="border-left:solid 1px black;border-right:solid 1px black; border-bottom: black 1px solid;" cellpadding="1" >
           <tr><td>
                <!-- part 4 -->
                <table cellpadding="10" width="100%" style="height: 420px;">
                    <tr>
                        <td valign="top" style="width: 48%;">
                            <table border="0" cellspacing="5">
                                <tr>
                                    <td class="labelText">
                                        Time of incident:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtIncidentTime" runat="server" Width="100px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelText">
                                        Floor Type:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtFloorType" runat="server" Width="240px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelText">
                                        Injury Description:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtInjuryDesc" runat="server" Width="240px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelText">
                                        Was the location inspected immediately after the incident?
                                    </td>
                                    <td class="labelText" style="text-align: left;">
                                        <asp:RadioButtonList ID="radInspectedImmediately" runat="server" RepeatDirection="horizontal"
                                            RepeatLayout="flow">
                                            <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="False"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelText">
                                        Was the location clean?
                                    </td>
<%--                                    <td class="labelText" style="text-align: left;">
                                        <asp:RadioButtonList ID="radLocationClean" runat="server" RepeatDirection="horizontal"
                                            RepeatLayout="flow">
                                            <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="False"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>--%>
                                        <td class="labelText" style="text-align: left;">
                                        <asp:RadioButtonList ID="radLocationClean" runat="server" RepeatDirection="horizontal"
                                            RepeatLayout="flow">
                                            <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="0"></asp:ListItem>
                                            <asp:ListItem Text="Unknown" Value="-1"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelText">
                                        Was the location dry?
                                    </td>
<%--                                    <td class="labelText" style="text-align: left;">
                                        <asp:RadioButtonList ID="radLocationDry" runat="server" RepeatDirection="horizontal"
                                            RepeatLayout="flow">
                                            <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="False"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>--%>
                                    <td class="labelText" style="text-align: left;">
                                        <asp:RadioButtonList ID="radLocationDry" runat="server" RepeatDirection="horizontal"
                                            RepeatLayout="flow">
                                            <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="0"></asp:ListItem>
                                            <asp:ListItem Text="Unknown" Value="-1"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td valign="top">
                            <table border="0" cellspacing="5">
                                <tr>
                                    <td class="labelText" style="width: 250px;">
                                        Any foreign substance or obstruction?
                                    </td>
                                    <td class="labelText" style="text-align: left;">
                                        <asp:RadioButtonList ID="radObstruction" runat="server" RepeatDirection="horizontal"
                                            RepeatLayout="flow">
                                            <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="False"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr id="trObstruction" style="display: none;">
                                    <td class="labelText">
                                        Type of foreign substance or obstruction:
                                    </td>
                                    <td class="labelText">
                                        <asp:TextBox ID="txtObstructionType" runat="server" Width="240px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelText">
                                        Describe weather conditions:
                                    </td>
                                    <td class="labelText">
                                        <asp:TextBox ID="txtWeather" runat="server" Width="240px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelText">
                                        Type of shoes worn during incident:
                                    </td>
                                    <td class="labelText">
                                        <asp:TextBox ID="txtShoeType" runat="server" Width="240px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelText">
                                        Any objects carried during the incident?
                                    </td>
                                    <td class="labelText" style="text-align: left;">
                                        <asp:RadioButtonList ID="radCarryingObjects" runat="server" RepeatDirection="horizontal"
                                            RepeatLayout="flow">
                                            <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="0"></asp:ListItem>
                                            <asp:ListItem Text="Unknown" Value="-1"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr id="trObjects" style="display: none;">
                                    <td class="labelText">
                                        Type of objects carried during incident:
                                    </td>
                                    <td class="labelText">
                                        <asp:TextBox ID="txtObjectsCarried" runat="server" Width="240px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelText">
                                        Did surveillance capture the event?
                                    </td>
                                        <td class="labelText" style="text-align: left;">
                                        <asp:RadioButtonList ID="radSurveillance" runat="server" RepeatDirection="horizontal"
                                            RepeatLayout="flow">
                                            <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="False"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr id="trFilm" style="display: none;">
                                    <td class="labelText">
                                        Was the film preserved?
                                    </td>
                                       <td class="labelText" style="text-align: left;">
                                        <asp:RadioButtonList ID="radFilm" runat="server" RepeatDirection="horizontal"
                                            RepeatLayout="flow">
                                            <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="0"></asp:ListItem>
                                            <asp:ListItem Text="N/A" Value="-1"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr id="trFilmComment" style="display: none;"> 
                                    <td class="labelText">Comment:</td>
                                    <td class="labelText">
                                        <asp:TextBox ID="txtFilm" runat="server" Width="240px"></asp:TextBox>
                                    </td>
                                    </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" align="center" colspan="2">
                            <table border="0" cellspacing="5">
                                <tr>
                                    <td class="labelText" style="text-align: left;">
                                        Please write full description of the incident:
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtFullDesc" runat="server" Width="850px" TextMode="multiLine" Rows="6"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <%--<tr>
                        <td class="labelText" valign="bottom" colspan="2" align="right" style="width: 100%;">
                            <span class="labelText" style="font-size: smaller;">Please note after claim has been
                                submitted, no changes to claim will be allowed.</span> &nbsp; &nbsp;
                            <asp:Button ID="btnSubmit" runat="server" Text="Submit Claim" CssClass="Button1"
                                CommandName="Submit" OnCommand="Save" />
                            <asp:Button ID="Button2" runat="server" Text="Save" CssClass="Button1" CommandName="Save"
                                OnCommand="Save" />
                        </td>
                    </tr>--%>
                </table>
                <div align="right" style="padding-bottom: 7px; height: 20px;" class="labelText">
                    <span class="labelText" style="font-size: smaller;">Please note after claim has been
                        submitted, no changes to claim will be allowed.</span> &nbsp; &nbsp;
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit Claim" CssClass="Button1"
                        CommandName="Submit" OnCommand="Save" />
                    <asp:Button ID="Button2" runat="server" Text="Save" CssClass="Button1" CommandName="Save"
                        OnCommand="Save" /></div>
             </td></tr>   </table>
           </asp:Panel>
              <asp:Panel ID="pnlDocuments" runat="server" style="display: none;" >
                     <table width="100%" border="0" style="border-left:solid 1px black;border-right:solid 1px black; border-bottom: black 1px solid;" cellpadding="1" >
           <tr><td>
                <table style="height: 440px;" align="center">
                    <tr style="height: 25px;">
                    </tr>
                    <tr>
                        <td class="labelText" style="text-align: center;">
                            Select Image to Upload:
                            <input id="uploadedFile" type="file" style="width: 480px;" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <br />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="button" id="Send" value="Upload" onserverclick="Load_Click" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <br />
                            <asp:Label ID="message" runat="server" />
                        </td>
                    </tr>
                    <tr id="tr1" style="text-align: center;">
                        <td align="center" style="text-align: center;">
                            <fieldset style="margin-left: 50px; padding: 0px;">
                                <legend class="labelText">Documents</legend>
                                <div style="overflow: auto; width: 845px; height: 258px; margin: 0px; padding: 0px;
                                    margin-left: 30px;">
                                    <table cellpadding="2" cellspacing="0">
                                        <tr>
                                            <td class="labelText" style="text-align: left; word-wrap: break-word;">
                                                <asp:Repeater ID="Repeater1" runat="server">
                                                    <ItemTemplate>
                                                        <table cellpadding="0" cellspacing="0" width="800px">
                                                            <tr>
                                                                <td width="100px">
                                                                </td>
                                                                <td style="width: 295px; height: 20px; vertical-align: bottom; cursor: hand;" onclick="OpenDoc('<%# (ROOT_DIRECTORY.Value & hidFolder.Value & "\Documents" & "\" & Container.DataItem(0)).replace("\","\\")%>')">
                                                                    <%#Container.DataItem(1)%>
                                                                </td>
                                                                <td style="width: 295px; height: 20px; vertical-align: bottom; cursor: hand;" onclick="OpenDoc('<%# (ROOT_DIRECTORY.Value & hidFolder.Value & "\Documents" & "\" & Container.DataItem(0)).replace("\","\\")%>')">
                                                                    <%#Container.DataItem(2)%>
                                                                </td>
                                                                <td align="left" style="vertical-align: bottom; width: 35px;">
                                                                    <span title="Click here to delete file." onclick="discardDoc('<%#Container.DataItem(0)%>');"
                                                                        style="vertical-align: middle; width: 20px; height: 20px;">
                                                                        <img id="imgTrash" src="images/trashcan.gif" width="20px" height="20px" style="vertical-align: bottom;" /></span>
                                                                    &nbsp; &nbsp;
                                                                </td>
                                                                <td width="100px">
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </fieldset>
                        </td>
                    </tr>
                </table>
            </td></tr>   </table>
           </asp:Panel>
              <asp:Panel ID="pnlNotes" runat="server" style="display: none" >
                <table width="100%" border="0" style="border-left:solid 1px black;border-right:solid 1px black; border-bottom: black 1px solid;" cellpadding="1" >
               <tr><td>
                <table border="0px" cellspacing="3" align="center">
                    <%--width="100%"--%>
                    <tr>
                        <td>
                            <table>
                                <tr>
                                    <td class="labelText" style="text-align: left">
                                        Notes:
                                    </td>
                                    <td width="100px">
                                    </td>
                                    <td class="labelText" style="text-align: left">
                                        Measures Taken:
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtNotes" runat="server" Width="470px" TextMode="multiLine" Rows="6"></asp:TextBox>
                                    </td>
                                    <td width="20px">
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtMeasuresTaken" runat="server" Width="470px" TextMode="multiLine"
                                            Rows="6"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="bottom" align="right">
                                    </td>
                                    <td>
                                    </td>
                                    <td valign="bottom" align="right" style="padding-right: 5px;">
                                        <asp:Button ID="btnAddNote" runat="server" Text="Add" CssClass="Button2" Width="100px" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <table width="100%">
                    <tr>
                        <td style="width: 100%;">
                            <asp:SqlDataSource ID="DataNotes" runat="server" ConnectionString="<%$ ConnectionStrings:Insurance %>"
                                SelectCommand="SELECT [UserName], [Notes], [DateEntered], [ClaimId], [MeasuresTaken] FROM [Notes] WHERE [ClaimId] = @ClaimId ORDER BY [DateEntered] DESC "
                                DeleteCommand="DELETE FROM [Notes] WHERE [ClaimId] = @ClaimId" InsertCommand="INSERT INTO [Notes] ([UserName], [Notes], [DateEntered], [ClaimId], [MeasuresTaken]) VALUES (@UserName, @Notes, @DateEntered, @ClaimId, @MeasuresTaken)"
                                UpdateCommand="UPDATE [Notes] SET [UserName] = @UserName, [Notes] = @Notes, [DateEntered] = @DateEntered, [MeasuresTaken] = @MeasuresTaken WHERE [ClaimId] = @ClaimId">
                                <DeleteParameters>
                                    <asp:Parameter Name="ClaimId" Type="Int32" />
                                </DeleteParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="UserName" Type="String" />
                                    <asp:Parameter Name="Notes" Type="String" />
                                    <asp:Parameter Name="DateEntered" Type="DateTime" />
                                    <asp:Parameter Name="ClaimId" Type="Int32" />
                                    <asp:Parameter Name="MeasuresTaken" Type="String" />
                                </UpdateParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="UserName" Type="String" />
                                    <asp:Parameter Name="Notes" Type="String" />
                                    <asp:Parameter Name="DateEntered" Type="DateTime" />
                                    <asp:Parameter Name="ClaimId" Type="Int32" />
                                    <asp:Parameter Name="MeasuresTaken" Type="String" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:SessionParameter Name="ClaimId" SessionField="ClaimId" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <div style="height: 274px; width: 99%; overflow: auto;" id="divGrid">
                                <asp:DataGrid ID="gridNotes" runat="server" CssClass="grid" AutoGenerateColumns="False"
                                    DataSourceID="DataNotes" AllowPaging="false" AllowSorting="true" PageSize="8"
                                    PagerStyle-Font-Bold="true" PagerStyle-HorizontalAlign="Center" PagerStyle-Mode="NextPrev"
                                    PagerStyle-VerticalAlign="Bottom" AllowCustomPaging="FALSE" Width="98%">
                                    <Columns>
                                        <asp:BoundColumn DataField="DateEntered" HeaderText="Date Entered" HeaderStyle-CssClass="lockrow">
                                            <HeaderStyle Width="15%" />
                                        </asp:BoundColumn>
                                        <asp:BoundColumn DataField="UserName" HeaderText="Username" HeaderStyle-CssClass="lockrow">
                                            <HeaderStyle Width="5%" />
                                        </asp:BoundColumn>
                                        <asp:BoundColumn DataField="Notes" HeaderText="Notes" HeaderStyle-CssClass="lockrow">
                                            <HeaderStyle Width="40%" />
                                        </asp:BoundColumn>
                                        <asp:BoundColumn DataField="MeasuresTaken" HeaderText="MeasuresTaken" HeaderStyle-CssClass="lockrow">
                                            <HeaderStyle Width="40%" />
                                        </asp:BoundColumn>
                                    </Columns>
                                    <SelectedItemStyle CssClass="selrowNotes"></SelectedItemStyle>
                                    <ItemStyle CssClass="regrowNotes"></ItemStyle>
                                    <AlternatingItemStyle CssClass="altrowNotes"></AlternatingItemStyle>
                                </asp:DataGrid></div>
                        </td>
                    </tr>
                </table>
            </td></tr></table>
          </asp:Panel>
           <asp:Panel ID="pnlProcessing" runat="server" style="display: none" >
            <table width="100%" border="0" style="border-left:solid 1px black;border-right:solid 1px black; border-bottom: black 1px solid;" cellpadding="1" >
           <tr><td>
                <!--Part 5-->
                <table cellpadding="2px" cellspacing="2px" style="height: 420px;" align="center">
                    <%--width="965px"--%>
                    <tr>
                        <td valign="top">
                            <table border="0" cellspacing="3">
                                <tr>
                                    <td class="labelText" style="text-align: left; width: 400px;">
                                        What kind of claim is this?<asp:RadioButtonList ID="radClaimType" runat="server"
                                            RepeatDirection="horizontal" RepeatLayout="flow">
                                            <asp:ListItem Text="GL" Value="True"></asp:ListItem>
                                            <asp:ListItem Text="Auto" Value="False"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top" align="left">
                                        <table style="height: 300px;" width="950px">
                                            <tr>
                                                <td valign="top">
                                                    <table id="tableAutoClaim" width="450px" style="vertical-align: top; height: auto;
                                                        display: none;">
                                                        <tr style="text-align: left;">
                                                            <td class="labelText" width="auto" valign="bottom" style="text-align: left;">
                                                                Was this claim reported to our carrier?
                                                                <asp:RadioButtonList ID="radReportCarrier" runat="server" RepeatDirection="horizontal"
                                                                    RepeatLayout="flow">
                                                                    <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                                                    <asp:ListItem Text="No" Value="False"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </td>
                                                        </tr>
                                                        <tr id="trReportCarrier1" style="display: none;">
                                                            <td class="labelText" valign="top" style="text-align: center;">
                                                                Claim #:
                                                                <asp:TextBox ID="txtCarrierClaimNum" runat="server" Width="77px"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr id="trReportCarrier2" style="display: none;">
                                                            <td class="labelText" valign="top" style="text-align: center;">
                                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Adjuster's Name:
                                                                <asp:TextBox ID="txtCarrierAdjuster" runat="server" Width="150px"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr id="trReportCarrier3" style="display: none;" valign="top">
                                                            <td class="labelText" valign="top" style="text-align: center;">
                                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Phone Number:
                                                                <asp:TextBox ID="txtCarrierAdjusterPhone" runat="server" Width="150px"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <table id="tableGlClaim" width="450px" style="vertical-align: top; height: auto;
                                                        display: none;">
                                                        <tr>
                                                            <td class="labelText" valign="top" style="width: 230px;">
                                                                Was this claim submitted to TPA?
                                                            </td>
                                                            <td class="labelText" style="text-align: left; width: auto;" valign="top">
                                                                <asp:RadioButtonList ID="radsubmitTpa" runat="server" RepeatDirection="horizontal"
                                                                    RepeatLayout="flow">
                                                                    <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                                                    <asp:ListItem Text="No" Value="False"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </td>
                                                        </tr>
                                                        <tr id="trsubmitTpa1" style="display: none;">
                                                            <td class="labelText" valign="top">
                                                                File #:
                                                            </td>
                                                            <td valign="top">
                                                                <asp:TextBox ID="txtFileNum" runat="server" Width="77px"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr id="trSubmitTpa2" style="display: none;">
                                                            <td class="labelText" valign="top">
                                                                Adjuster Name:
                                                            </td>
                                                            <td valign="top">
                                                                <asp:TextBox ID="txtTpaAdjuster" runat="server" Width="150px"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr id="trsubmitTpa3" style="display: none;" valign="top">
                                                            <td class="labelText" valign="top">
                                                                Was this claim submitted to our carrier?
                                                            </td>
                                                            <td class="labelText" style="text-align: left; width: auto;" valign="top">
                                                                <asp:RadioButtonList ID="radTpaSubmitCarrier" runat="server" RepeatDirection="horizontal"
                                                                    RepeatLayout="flow">
                                                                    <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                                                    <asp:ListItem Text="No" Value="False"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </td>
                                                        </tr>
                                                        <tr id="trTpaSubmitCarrier1" style="display: none;" valign="top">
                                                            <td class="labelText">
                                                                Claim #:
                                                            </td>
                                                            <td valign="top">
                                                                <asp:TextBox ID="txtTpaCarrierClaimNum" runat="server" Width="77px"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr id="trTpaSubmitCarrier2" style="display: none;">
                                                            <td class="labelText" valign="top">
                                                                Adjuster Name:
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtTpaCarrierAdjName" runat="server" Width="150px"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr id="trTpaSubmitCarrier3" style="display: none;">
                                                            <td class="labelText">
                                                                Adjuster Contact:
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtTpaCarrierAdjContact" runat="server" Width="150px"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="labelText">
                                                                Is this claim in litigation?
                                                            </td>
                                                            <td class="labelText" style="text-align: left; width: auto;">
                                                                <asp:RadioButtonList ID="radClaimLitigation" runat="server" RepeatDirection="horizontal"
                                                                    RepeatLayout="flow">
                                                                    <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                                                    <asp:ListItem Text="No" Value="False"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </td>
                                                        </tr>
                                                        <tr id="trClaimLitigation1" style="display: none;">
                                                            <td class="labelText">
                                                                Defense Counsel Assigned:
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtDefenseCounsel" runat="server" Width="150px"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr id="trClaimLitigation2" style="display: none;">
                                                            <td class="labelText">
                                                                Defense Counsel Contact:
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtCounselContact" runat="server" Width="150px"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr id="trClaimLitigation3" style="display: none;">
                                                            <td class="labelText">
                                                                Docket #:
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtDocketNum" runat="server" Width="77px"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr id="trClaimLitigation4" style="display: none;">
                                                            <td class="labelText">
                                                                Claim #:
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtLitigClaimNum" runat="server" Width="77px"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="height: 6px;">
                                                            <td>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td valign="top">
                                                    <table id="tblClaimSettled" width="500px" style="vertical-align: top; height: auto;
                                                        display: none;">
                                                        <tr style="text-align: left; display: none;" id="trglClaimSettled">
                                                            <td class="labelText" style="text-align: left">
                                                                Was this claim settled?
                                                                <asp:RadioButtonList ID="radLitigClaimSettled" runat="server" RepeatDirection="horizontal"
                                                                    RepeatLayout="flow">
                                                                    <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                                                    <asp:ListItem Text="No" Value="False"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </td>
                                                        </tr>
                                                        <tr style="text-align: left; display: none;" id="trglClaimSettled5">
                                                            <td class="labelText" style="text-align: left">
                                                                Was this Claim self administered?<asp:RadioButtonList ID="radSelfAdministered" runat="server"
                                                                    RepeatDirection="horizontal" RepeatLayout="flow">
                                                                    <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                                                    <asp:ListItem Text="No" Value="False"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </td>
                                                        </tr>
                                                        <tr style="height: 10px;">
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr id="trGlClaimSettled1" style="display: none; text-align: left">
                                                            <td class="labelText" style="text-align: left">
                                                                Settlement Amount:
                                                                <asp:TextBox ID="txtGlSettlementAmount" runat="server" Width="150px"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                        </tr>
                                                        <tr style="height: 10px;">
                                                        </tr>
                                                        <tr>
                                                        </tr>
                                                        <tr id="trGlClaimSettled4" style="display: none;">
                                                            <td class="labelText" style="text-align: left; font-weight: bold;">
                                                                Cost of Claim:
                                                            </td>
                                                        </tr>
                                                        <tr id="trGlClaimSettled2" style="display: none;">
                                                            <td>
                                                                <table width="380px" cellpadding="0px" cellspacing="0px" style="height: 100px;">
                                                                    <tr style="width: 475px; border: 1px black solid;">
                                                                        <td class="labelcellhead">
                                                                            Check #
                                                                        </td>
                                                                        <td class="labelcellhead">
                                                                            Check Date
                                                                        </td>
                                                                        <td class="labelcellhead">
                                                                            Payee
                                                                        </td>
                                                                        <td class="labelcellhead">
                                                                            Check Amount
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="width: 475px; border: 1px black solid;">
                                                                        <td class="txtboxCell">
                                                                            <asp:TextBox ID="txtCheckNum1" runat="server" Width="95px"></asp:TextBox>
                                                                        </td>
                                                                        <td class="txtboxCell">
                                                                            <asp:TextBox ID="txtCheckDate1" runat="server" Width="95px"></asp:TextBox>
                                                                        </td>
                                                                        <td class="txtboxCell">
                                                                            <asp:TextBox ID="txtPayee1" runat="server" Width="95px"></asp:TextBox>
                                                                        </td>
                                                                        <td class="txtboxCell">
                                                                            <asp:TextBox ID="txtCheckAmnt1" runat="server" Width="95px" Style="text-align: right;"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="width: 475px; border: 1px black solid;">
                                                                        <td class="txtboxCell">
                                                                            <asp:TextBox ID="txtCheckNum2" runat="server" Width="95px"></asp:TextBox>
                                                                        </td>
                                                                        <td class="txtboxCell">
                                                                            <asp:TextBox ID="txtCheckDate2" runat="server" Width="95px"></asp:TextBox>
                                                                        </td>
                                                                        <td class="txtboxCell">
                                                                            <asp:TextBox ID="txtPayee2" runat="server" Width="95px"></asp:TextBox>
                                                                        </td>
                                                                        <td class="txtboxCell">
                                                                            <asp:TextBox ID="txtCheckAmnt2" runat="server" Width="95px" Style="text-align: right;"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="width: 475px; border: 1px black solid;">
                                                                        <td class="txtboxCell">
                                                                            <asp:TextBox ID="txtCheckNum3" runat="server" Width="95px"></asp:TextBox>
                                                                        </td>
                                                                        <td class="txtboxCell">
                                                                            <asp:TextBox ID="txtCheckDate3" runat="server" Width="95px"></asp:TextBox>
                                                                        </td>
                                                                        <td class="txtboxCell">
                                                                            <asp:TextBox ID="txtPayee3" runat="server" Width="95px"></asp:TextBox>
                                                                        </td>
                                                                        <td class="txtboxCell">
                                                                            <asp:TextBox ID="txtCheckAmnt3" runat="server" Width="95px" Style="text-align: right;"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="width: 475px; border: 1px black solid;">
                                                                        <td class="txtboxCell">
                                                                            <asp:TextBox ID="txtCheckNum4" runat="server" Width="95px"></asp:TextBox>
                                                                        </td>
                                                                        <td class="txtboxCell">
                                                                            <asp:TextBox ID="txtCheckDate4" runat="server" Width="95px"></asp:TextBox>
                                                                        </td>
                                                                        <td class="txtboxCell">
                                                                            <asp:TextBox ID="txtPayee4" runat="server" Width="95px"></asp:TextBox>
                                                                        </td>
                                                                        <td class="txtboxCell">
                                                                            <asp:TextBox ID="txtCheckAmnt4" runat="server" Width="95px" Style="text-align: right;"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr id="trGlClaimSettled3" style="display: none;">
                                                            <td class="labelText" style="text-align: center;">
                                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Total:
                                                                <asp:TextBox ID="txtTotalClaimCost" runat="server" Width="95px" Style="text-align: right;"
                                                                    ReadOnly="true" AutoPostBack="false"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <%--<tr style="height: 10px">
                        <td align="right" width="965px" class="labelText" style="vertical-align: bottom;
                            padding-bottom: 7px;">
                            <asp:CheckBox ID="chkReviewed" runat="server" Text="Mark claim as Reviewed" Height="12" />
                            &nbsp; &nbsp;
                            <asp:Button ID="Button4" runat="server" Text="Save" CssClass="Button1" CommandName="Save"
                                OnCommand="Save" Style="text-align: center; vertical-align: bottom;" />
                        </td>
                    </tr>--%>
                </table>
                <div style="padding-bottom: 7px; height: 20px;" align="right" class="labelText">
                    <asp:CheckBox ID="chkReviewed" runat="server" Text="Mark claim as Reviewed" Height="12" />
                    &nbsp; &nbsp;
                    <asp:Button ID="Button4" runat="server" Text="Save" CssClass="Button1" CommandName="Save"
                        OnCommand="Save" Style="text-align: center; vertical-align: bottom;" /></div>
             </td></tr> </table>  
           </asp:Panel>
        <%--</IE:MultiPage>--%>
    </div>
    <div id="divReportChoice" onmouseover="onDivReportChoice = true;" onmouseout="onDivReportChoice = false;"
        style="display: none; position: absolute; top: 100px; left: 580px; height: 150px;
        width: 260px; background-color: #e6e7e9; border: 2px outset #003366; z-index: 99;">
        <h4 style="text-align: center;">
            Please select a report type.</h4>
        <br />
        &nbsp;<a href='' onclick='PrintClaim(true);return false;'>Include Processing Data</a>
        <br />
        &nbsp;<a href='' onclick='PrintClaim(false);return false;'>Do not include Processing
            Data</a>
    </div>
    </form>
</body>
</html>
