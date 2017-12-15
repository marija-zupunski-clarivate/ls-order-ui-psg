

  function processFormData(currentObject, linkVal) {

    var strVal=linkVal;
    location=strVal;
    }

  function goToOrderPage(linkVal) {

       var basicUrl ="/ListSales/servlet/Driver?Menu=Create+Order&Page=Create+Page+View";
       var strVal=basicUrl+"&orderId="+linkVal;
//       alert(strVal);

 //       location=strVal;
    var location = "width=900,height=700,resizable=1,status=0,left=0,top=0,menubar=0,scrollbars=1,toolbar=0,location=0,directories=0";

    var newWind = window.open(strVal, linkVal, location);
    newWind.focus();
    }

    function goToOrderResultsPage(linkVal1, linkVal2, linkVal3) {

//     alert("linkVal1="+linkVal1+"linkVal2="+linkVal2+"linkVal3="+linkVal3)
    var editviewflag ="Y";
       var basicUrl ="/ListSales/servlet/Driver?Menu=View+Results+Info&Page=Results+Page";
       var strVal=basicUrl+"&orderId="+linkVal1+"&searchId="+linkVal2+"&clnId="+linkVal3+"&editviewflag="+editviewflag;
//       alert(strVal);

 //       location=strVal;
    var location = "width=900,height=700,resizable=1,status=0,left=0,top=0,menubar=0,scrollbars=1,toolbar=0,location=0,directories=0";
    var linkVal = linkVal1+linkVal2+linkVal3;

    var newWind = window.open(strVal, linkVal, location);
    newWind.focus();
    }


    function putNbsp()
  {
    document.write('&nbsp');
//    document.write('<font color="' + document.body.backgroundColor + '">&nbsp</font>');

  }

  function validateFields(OrderObjct)
  {

//      alert("The valu is " + OrderObjct.contactId + " and the rtn is " + rtn)
//    alert("Validating the Create Order Page ");

    var rtn = isNotEmpty(OrderObjct.customerId);
    if(rtn)
      var rtn = isNotEmpty(OrderObjct.contactId);
    else
      return rtn;
    if(rtn)
      var rtn = isNotEmpty(OrderObjct.orderDate);
    else
      return rtn;
    if(rtn)
      var rtn = isNotEmpty(OrderObjct.wantedQty);
    else
      return rtn;
    if(rtn)
      rtn = isNumber(OrderObjct.wantedQty, OrderObjct.wantedQty.name)
    else
      return rtn;
    if(rtn)
      rtn = isNotEmpty(OrderObjct.orderName);
    if(rtn)
      rtn = validateOrderName(OrderObjct.orderName);
     return rtn;

  }

  //function to validate special characters for order name and length should not exceed more than 400 characters.

  function validateOrderName(elem)
  {
    var str = elem.value;
    //alert("Entered into function");
      if(str.length>75)
      {
      alert("Order Name is too long");
      return false;
      }
      else
    {
         if(str.indexOf('\'')!=-1)
      {
       alert("Special character is included in the order name");
     return false;
      }
    }
    return true;
  }
  //end of function

  function isNotEmpty(elem)
  {
        var str = elem.value;
    //alert("Element "+elem.value);
        if(str == null || str.length == 0)
        {
      if(elem.name=='customerId'){

                customAlert("Please enter a value in customerName Field");
      }else if(elem.name=='wantedQty')
      {
                customAlert("Please enter a value in Postal Counts Field");
      }else{
                customAlert("Please enter a value in " + elem.name + " Field");
      }
            return false;
        }
        else
        {
      var oneChr = str.charAt(0);
      if(oneChr == ' ')
      {
                customAlert("An empty char is not allowed in the first place. Please enter a regular character.");
        return false;
      }
      else
              return true;
        }
    }


    function customAlert(message) {
     var dlg = $("<div>"+message+"</div>");
     dlg.dialog({modal:true, dialogClass: "no-titlebar no-close",
           buttons: [
               {
                   text: "OK",
                   click: function() {
                       $( this ).dialog( "close" );
                   }
               }
           ]});
  }

  function isNumber(fldObject, fldName)
    {
        if (isNaN(fldObject.value))
        {
            customAlert("Please enter a numeric value in the " + fldName + " Field.");
            return false;
        }
        else
        {
            return true;
        }
    }

  function highlightSelections(rslObject, listObject, rgnData, cstData)
  {

    if(cstData != null)
    {
      if(cstData.notes.value == ' ')
                cstData.notes.value="";
    }

    if(rslObject != null)
    {
//      alert("Its Order Results");
//      setRsltTotalValues(rslObject);
    }
    if(listObject != null)
    {
//      alert("Its Order Create");
      setSelections(listObject, listObject.includeRegions, listObject.incReg);
      setSelections(listObject, listObject.excludeRegions, listObject.excReg);
      setSelections(listObject, listObject.includeCountries, listObject.incCoun);
      setSelections(listObject, listObject.excludeCountries, listObject.excCoun);
      setSelections(listObject, listObject.includeStates, listObject.incSt);
      setSelections(listObject, listObject.excludeStates, listObject.excSt);
      if(listObject.zipCodes.value == ' ')
        listObject.zipCodes.value="";
      if(listObject.notes.value == ' ')
        listObject.notes.value="";
      if(listObject.qFlag.value != "N")
        listObject.customerId.disabled=false;
           if(listObject.qFlag.value == "N")
      {
        var myDt = new Date();
        var mnt1 = myDt.getMonth();
        var dt1 = myDt.getDate();
        var yr1 = myDt.getFullYear();
        myDt.setDate(dt1 + 1);
        var mnt2 = myDt.getMonth();
            var dt2 = myDt.getDate();
            var yr2 = myDt.getFullYear();
        listObject.orderDate.value=yr1 + "-" + (mnt1 + 1) + "-" + dt1;
//        listObject.shipDate.value=yr1 + "-" + mnt1 + "-" + dt1;
//        listObject.requiredByDate.value=yr1 + "-" + (mnt1 + 1) + "-" + dt1;
//        listObject.promisedByDate.value=yr2 + "-" + (mnt2 + 1) + "-" + dt2;
      }

    }
  }

  // code added for requirement 3 to populate date in the order date start
function populateDate(listObject)
{
  if (listObject.orderDate.value != null && listObject.orderDate.value != '') {
    return;
  }

  //alert('entered in date '+listObject.orderDate.value);
  //if((listObject.orderDate.value==null)||(listObject.orderDate.value=='')){
  var myDt = new Date();
        var mnt1 = myDt.getMonth();
        var dt1 = myDt.getDate();
        var yr1 = myDt.getFullYear();
        myDt.setDate(dt1 + 1);
        var mnt2 = myDt.getMonth();
            var dt2 = myDt.getDate();
            var yr2 = myDt.getFullYear();
        var mntCh = (mnt1 + 1);
        if (mntCh<=9)
        {
          //alert(mnt1+"\t"+ mntCh);
          mntCh="0"+mntCh;
          //listObject.orderDate.value=yr1 + "-" + (mnt1 + 1) + "-" +"0"+dt1;
        }
        if(dt1<=9)
        {
          //alert("True");
          listObject.orderDate.value=yr1 + "-" + mntCh + "-" +"0"+dt1;
        }else
        {
          listObject.orderDate.value=yr1 + "-" + mntCh + "-" + dt1;
        }
  //}
}

// code added for requirement 3 to populate date in the order date end



  function setCountriesInfo(regObj)
  {
    var listSize = regObj.country.options.length;
    var regionIndex = regObj.region.value;
    var j = 0;
    var cnts = "<b>COUNTRIES : </b>";
    var firstTime = 1;

    for(b = 0; b < listSize; b++)
        {
      regObj.country.options[b].selected="";
    }
    for(b = 0; b < listSize; b++)
        {
      var ValsStr = regObj.country.options[b].value;
      var indxVals = ValsStr.split("|");
      if(indxVals != null && indxVals[1] != null && indxVals[1] != "")
      {
        var rgnVal = indxVals[1];
               if(regionIndex == rgnVal)
               {
                  regObj.country.options[b].selected=true;
          if(firstTime == 1)
          {
            cnts = cnts + regObj.country.options[b].text;
            firstTime = 2;
          }
          else if((j % 6) == 0)
          {
            cnts = cnts + ", " + "<br>";
            cnts = cnts + regObj.country.options[b].text;
          }
          else
            cnts = cnts + ", " + regObj.country.options[b].text;
          j = j + 1;
               }
      }
        }
    show(regObj, cnts);
  }

  function setCountriesInfoNew(regObj)
    {
//      alert("Hello");
        var countries = regObj.allCountriesInfo.value.split(",");
        var listSize = countries.length - 1;
        var regionIndex = regObj.region.value;

//      alert("The listSize and regionIndex are " + listSize + ", " + regionIndex);

    regObj.country.options.length = 0;

    var j = 0;
    var cnts = "<b>COUNTRIES : </b>";
        for(b = 0; b < listSize; b++)
        {
            var ValsStr = countries[b];
            var indxVals = ValsStr.split("|");
            if(indxVals != null && indxVals[1] != null && indxVals[1] != "")
            {
                var rgnVal = indxVals[1];
                if(regionIndex == rgnVal || regionIndex == "")
                {
//          alert("The indxVals[0] is " + indxVals[0]);
          var cntNmVal = indxVals[0].split("^");
          if(cntNmVal != null && cntNmVal[0] != null && cntNmVal[1] != null)
          {
//            alert("country value is " + cntNmVal[0] + " and the text is " + cntNmVal[1]);
            regObj.country.options[j++] = new Option(cntNmVal[1], cntNmVal[0], false, true);
            cnts = cnts + cntNmVal[1] + ", ";
            if((j % 6) == 0)
              cnts = cnts + "<br>";
          }

                }
            }
        }
    if(regionIndex != "")
    {
      show(regObj, cnts);
    }

    }



  function setSelections(listObject, columnToChange, dataVals)
  {
//    alert("Hi");
    if(listObject != null)
    {
        var ValsStr = null;
          var indxVals = null;
          var listSize = 0;
          var b;
          var j;

      if(dataVals.value != null)
        ValsStr = dataVals.value;
//      alert("The ValsStr is " + ValsStr);
      if(ValsStr != null)
        indxVals = ValsStr.split(",");
      if(columnToChange != null)
        listSize = columnToChange.options.length;
 //         alert("The length is " + listSize);


      if(indxVals != null && listObject != null && columnToChange != null)
      {
            for(j = 0; j < indxVals.length; j++)
            {
                var indxStr = indxVals[j];
  //              alert("The indxStr is " + indxStr);
                for(b = 0; b < listSize; b++)
                {
                    if(columnToChange.options[b].value == indxStr)
                    {
   //                     alert("This name is selected : " + indxStr);
                        columnToChange.options[b].selected=true;
                    }
                }
            }// for
          }// if

    }//if not null
  }

    function setRsltTotalValues(rsltObject) {

     var acadPstCnt = getZoneColumnTotal(rsltObject, "ACAD", "PSTKEY", "CTT");
     var nonAcadPstCnt = getZoneColumnTotal(rsltObject, "NONACD", "PSTKEY", "CTT");
     var allPstCnt = getZoneColumnTotal(rsltObject, "ALLTOTAL", "PSTKEY", "CTT");
     var acadEmlCnt = getZoneColumnTotal(rsltObject, "ACAD", "EMLKEY", "CTT");
     var nonAcadEmlCnt = getZoneColumnTotal(rsltObject, "NONACD", "EMLKEY", "CTT");
     var allEmlCnt = getZoneColumnTotal(rsltObject, "ALLTOTAL", "EMLKEY", "CTT");
        var acadImlCnt = getZoneColumnTotal(rsltObject, "ACAD", "IMLKEY", "CTT");
        var nonAcadImlCnt = getZoneColumnTotal(rsltObject, "NONACD", "IMLKEY", "CTT");
        var allImlCnt = getZoneColumnTotal(rsltObject, "ALLTOTAL", "IMLKEY", "CTT");


      if(rsltObject.acadTotalPostalCTT != null)
            rsltObject.acadTotalPostalCTT.value=acadPstCnt;
        if(rsltObject.nonAcadTotalPostalCTT != null)
            rsltObject.nonAcadTotalPostalCTT.value=nonAcadPstCnt;
        if(rsltObject.allTotalPostalCTT != null)
            rsltObject.allTotalPostalCTT.value=allPstCnt;
        if(rsltObject.acadTotalEmailCTT != null)
            rsltObject.acadTotalEmailCTT.value=acadEmlCnt;
        if(rsltObject.nonAcadTotalEmailCTT != null)
            rsltObject.nonAcadTotalEmailCTT.value=nonAcadEmlCnt;
        if(rsltObject.allTotalEmailCTT != null)
            rsltObject.allTotalEmailCTT.value=allEmlCnt;
        if(rsltObject.acadTotalImailCTT != null)
            rsltObject.acadTotalImailCTT.value=acadImlCnt;
        if(rsltObject.nonAcadTotalImailCTT != null)
            rsltObject.nonAcadTotalImailCTT.value=nonAcadImlCnt;
        if(rsltObject.allTotalImailCTT != null)
            rsltObject.allTotalImailCTT.value=allImlCnt;

     var acadPstStt = getZoneColumnTotal(rsltObject, "ACAD", "PSTKEY", "STT");
     var nonAcadPstStt = getZoneColumnTotal(rsltObject, "NONACD", "PSTKEY", "STT");
     var allPstStt = getZoneColumnTotal(rsltObject, "ALLTOTAL", "PSTKEY", "STT");
     var acadEmlStt = getZoneColumnTotal(rsltObject, "ACAD", "EMLKEY", "STT");
     var nonAcadEmlStt = getZoneColumnTotal(rsltObject, "NONACD", "EMLKEY", "STT");
     var allEmlStt = getZoneColumnTotal(rsltObject, "ALLTOTAL", "EMLKEY", "STT");
        var acadImlStt = getZoneColumnTotal(rsltObject, "ACAD", "IMLKEY", "STT");
        var nonAcadImlStt = getZoneColumnTotal(rsltObject, "NONACD", "IMLKEY", "STT");
        var allImlStt = getZoneColumnTotal(rsltObject, "ALLTOTAL", "IMLKEY", "STT");

      if(rsltObject.acadTotalPostalSTT != null)
            rsltObject.acadTotalPostalSTT.value=acadPstStt;
        if(rsltObject.nonAcadTotalPostalSTT != null)
            rsltObject.nonAcadTotalPostalSTT.value=nonAcadPstStt;
        if(rsltObject.allTotalPostalSTT != null)
            rsltObject.allTotalPostalSTT.value=allPstStt;
        if(rsltObject.acadTotalEmailSTT != null)
            rsltObject.acadTotalEmailSTT.value=acadEmlStt;
        if(rsltObject.nonAcadTotalEmailSTT != null)
            rsltObject.nonAcadTotalEmailSTT.value=nonAcadEmlStt;
        if(rsltObject.allTotalEmailSTT != null)
            rsltObject.allTotalEmailSTT.value=allEmlStt;
        if(rsltObject.acadTotalImailSTT != null)
            rsltObject.acadTotalImailSTT.value=acadImlStt;
        if(rsltObject.nonAcadTotalImailSTT != null)
            rsltObject.nonAcadTotalImailSTT.value=nonAcadImlStt;
        if(rsltObject.allTotalImailSTT != null)
            rsltObject.allTotalImailSTT.value=allImlStt;

     var acadPstZip = getZoneColumnTotal(rsltObject, "ACAD", "PSTKEY", "ZIP");
     var nonAcadPstZip = getZoneColumnTotal(rsltObject, "NONACD", "PSTKEY", "ZIP");
     var allPstZip = getZoneColumnTotal(rsltObject, "ALLTOTAL", "PSTKEY", "ZIP");
     var acadEmlZip = getZoneColumnTotal(rsltObject, "ACAD", "EMLKEY", "ZIP");
     var nonAcadEmlZip = getZoneColumnTotal(rsltObject, "NONACD", "EMLKEY", "ZIP");
     var allEmlZip = getZoneColumnTotal(rsltObject, "ALLTOTAL", "EMLKEY", "ZIP");
        var acadImlZip = getZoneColumnTotal(rsltObject, "ACAD", "IMLKEY", "ZIP");
        var nonAcadImlZip = getZoneColumnTotal(rsltObject, "NONACD", "IMLKEY", "ZIP");
        var allImlZip = getZoneColumnTotal(rsltObject, "ALLTOTAL", "IMLKEY", "ZIP");

      if(rsltObject.acadTotalPostalZIP != null)
            rsltObject.acadTotalPostalZIP.value=acadPstZip;
        if(rsltObject.nonAcadTotalPostalZIP != null)
            rsltObject.nonAcadTotalPostalZIP.value=nonAcadPstZip;
        if(rsltObject.allTotalPostalZIP != null)
            rsltObject.allTotalPostalZIP.value=allPstZip;
        if(rsltObject.acadTotalEmailZIP != null)
            rsltObject.acadTotalEmailZIP.value=acadEmlZip;
        if(rsltObject.nonAcadTotalEmailZIP != null)
            rsltObject.nonAcadTotalEmailZIP.value=nonAcadEmlZip;
        if(rsltObject.allTotalEmailZIP != null)
            rsltObject.allTotalEmailZIP.value=allEmlZip;
        if(rsltObject.acadTotalImailZIP != null)
            rsltObject.acadTotalImailZIP.value=acadImlZip;
        if(rsltObject.nonAcadTotalImailZIP != null)
            rsltObject.nonAcadTotalImailZIP.value=nonAcadImlZip;
        if(rsltObject.allTotalImailZIP != null)
            rsltObject.allTotalImailZIP.value=allImlZip;

    }


  function getZoneColumnTotal(rsltObject, catgTp, pstEmlTp, zoneTp)
    {

      var rsltLen=rsltObject.elements.length;
      var totalVal=0;
      for(i=0; i < rsltLen; i++)
      {
    if(rsltObject.elements[i].name.indexOf("pstCount") == -1 && rsltObject.elements[i].name.indexOf("emlCount") == -1 && rsltObject.elements[i].name.indexOf("imlCount") == -1)
    {
          if(rsltObject.elements[i].name.indexOf("ALLCOUN") != -1)
          {
          if(rsltObject.elements[i].name.indexOf(catgTp) != -1 && rsltObject.elements[i].name.indexOf(pstEmlTp) != -1 && rsltObject.elements[i].name.indexOf(zoneTp) != -1)
          {
               var pstVal = rsltObject.elements[i].value;
               if(pstVal != "")
               {
                  var pstValNew = parseInt(pstVal, 10);
                  if(! isNaN(pstValNew))
                     totalVal = totalVal + pstValNew;
               }
          } // if catgTp
      } // ALLCOUN
    } // if pstCount
      } // for

    return totalVal;

    }

  function validateZoneData(rsltObject)
  {
    var numZones = 0;
    var sumPst, sumEml, allCntPst, allCntEml;

    sumPst = checkValueInZone(rsltObject, "PSTKEY", "DOMESFOREIGN")
    numZones += sumPst;

    sumEml = checkValueInZone(rsltObject, "EMLKEY", "DOMESFOREIGN")
    numZones += sumEml;
    if(numZones == 2)
    {
      alert("Its not Valid to enter values in both the Postal and Email Fields, in the Summary");
      return false;
    }

    allCntPst = checkValueInZone(rsltObject, "PSTKEY", "ALLCOUN")
    numZones += allCntPst;
    if(numZones == 2)
    {
      alert("Its not Valid to enter values in both Summary and Country Fields");
      return false;
    }

    allCntEml = checkValueInZone(rsltObject, "EMLKEY", "ALLCOUN")
    numZones += allCntEml;
    if(allCntPst == 1 && allCntEml == 1)
    {
      alert("Its not Valid to enter values in both the Postal and Email Fields, in the Countries breakdown");
      return false;
    }

    if((allCntPst == 1 || allCntEml == 1) && numZones == 2)
    {
      alert("Its not Valid to enter values in both Summary and Country Fields");
      return false;
    }
    if(sumEml == 1 || allCntEml == 1)
    {
       rsltObject.includeEmail.checked=true;
    }
    return true;
  }


  function checkValueInZone(rsltObject, pstEmlTp, sumCntZone)
    {

      var rsltLen=rsltObject.elements.length;
      for(i=0; i < rsltLen; i++)
      {
        if(rsltObject.elements[i].name.indexOf("pstCount") == -1 && rsltObject.elements[i].name.indexOf("emlCount") ==-1)
        {
          if(rsltObject.elements[i].name.indexOf(sumCntZone) != -1 && rsltObject.elements[i].name.indexOf(pstEmlTp) != -1)
          {
                var pstVal = rsltObject.elements[i].value;
                if(pstVal != "")
                {
                    var pstValNew = parseInt(pstVal, 10);
                    if(! isNaN(pstValNew))
          {
//            alert("Value for " + sumCntZone  + ", " + pstEmlTp + " is " + pstValNew)
            return 1;
          }
                }
          } // ALLCOUN
        } // if pstCount
      } // for

      return 0;

    }




  function resetOtherFields(rslObject, txtObject)
  {
    var i;
    var keyVals = (txtObject.name).split(";");
//    alert("The field name is " + keyVals[0]);
    var rsltLen=rslObject.elements.length;

    for(i=0; i < rsltLen; i++)
        {
      if(rslObject.elements[i].name.indexOf(keyVals[0]) == -1)
      {
        if(rslObject.elements[i].name.indexOf("DOM") != -1 || rslObject.elements[i].name.indexOf("ACAD") != -1 || rslObject.elements[i].name.indexOf("ALLCOUN") != -1)
          rslObject.elements[i].value=0;
//          alert("setting the field value to 0 " + rslObject.elements[i].name);
      }
    }
    setRsltTotalValues(rslObject);

  }


  function selectAllAndCopy(rslObject, txtObject, ctgType, zoneTyp)
    {
//    alert("txtObject="+txtObject+", ctgType="+ctgType+", zoneTyp="+zoneTyp);
        var i;
        var rsltLen=rslObject.elements.length;

    if(txtObject == "pstCount")
    {
          for(i=0; i < rsltLen; i++)
          {
            if(rslObject.elements[i].name.indexOf("pstCount") != -1 && rslObject.elements[i].name.indexOf(ctgType) != -1 && rslObject.elements[i].name.indexOf(zoneTyp) != -1)
            {
        var keyVals = (rslObject.elements[i].name).split("|");
        var keyNm = keyVals[1];
        if(keyNm != "")
        {
            var elmNm =  rslObject.elements[keyNm];
          if(elmNm != null)
                    elmNm.value=rslObject.elements[i].value;

//          alert("Elements[i].name=" + rslObject.elements[i].name + ", and the keyVals=" + keyVals + ", and  keyNm=" + keyNm + ", and  elmNm=" + elmNm + ", and  elements[i].value=" + rslObject.elements[i].value);
        }
      }
      }
        }
    if(txtObject == "emlCount")
        {
          for(i=0; i < rsltLen; i++)
          {
            if(rslObject.elements[i].name.indexOf("emlCount") != -1 && rslObject.elements[i].name.indexOf(ctgType) != -1 && rslObject.elements[i].name.indexOf(zoneTyp) != -1)
            {
                var keyVals = (rslObject.elements[i].name).split("|");
        var keyNm = keyVals[1];
                if(keyNm != "")
                {
                   var elmNm =  rslObject.elements[keyNm];
           if(elmNm != null)
                      elmNm.value=rslObject.elements[i].value;
        }
            }
          }
        }
        if(txtObject == "imlCount")
        {
          for(i=0; i < rsltLen; i++)
          {
            if(rslObject.elements[i].name.indexOf("imlCount") != -1 && rslObject.elements[i].name.indexOf(ctgType) != -1 && rslObject.elements[i].name.indexOf(zoneTyp) != -1)
            {
                var keyVals = (rslObject.elements[i].name).split("|");
                var keyNm = keyVals[1];
                if(keyNm != "")
                {
                   var ilmNm =  rslObject.elements[keyNm];
                   if(ilmNm != null)
                      ilmNm.value=rslObject.elements[i].value;
                }
            }
          }
        }
        setRsltTotalValues(rslObject);
    }

  function selectIncludeEmail(rslObject, currentBox)
    {
    var inclEmailVal = currentBox.checked;

      if(rslObject.includeEmail != null)
        rslObject.includeEmail.checked=inclEmailVal;
      if(rslObject.includeEmail2 != null)
        rslObject.includeEmail2.checked=inclEmailVal;
      if(rslObject.includeEmail3 != null)
        rslObject.includeEmail3.checked=inclEmailVal;
      if(rslObject.includeEmail4 != null)
        rslObject.includeEmail4.checked=inclEmailVal;
  }

  function custPageButton(object, custBtnVal) {
      object.Page.value=custBtnVal;
      object.submit();
  }

  function viewOrderButton(object, viewBtnVal) {
      object.Page.value=viewBtnVal;
      object.submit();
  }

  function setCustEditPage(cstObj) {
      cstObj.Page.value="Cust Info Page";
      object.submit();
  }

  function getOrderResults(OrdResobject) {
//    alert("searchId.value and profileId.value " + OrdResobject.searchId.value + " And " + OrdResobject.profileId.value);
        OrdResobject.searchId.value="";
        OrdResobject.clnId.value="";
        OrdResobject.submit();
    }
    function getSearchResults(OrdResobject) {
        OrdResobject.searchId.value=OrdResobject.searchIdList.value;
//    alert("searchId.value and profileId.value " + OrdResobject.searchId.value + " And " + OrdResobject.profileId.value);
        OrdResobject.clnId.value="";
        OrdResobject.submit();
    }
    function getProfileResults(OrdResobject) {
        OrdResobject.searchId.value=OrdResobject.searchIdList.value;
        OrdResobject.clnId.value=OrdResobject.clnIdList.value;
//    alert("searchId.value and profileId.value " + OrdResobject.searchId.value + " And " + OrdResobject.profileId.value);
        OrdResobject.submit();
    }

    function getResults(OrdResobject) {

        OrdResobject.searchId.value=OrdResobject.searchIdList.value;
        OrdResobject.clnId.value=OrdResobject.clnIdList.value;
//    alert("searchId.value and profileId.value " + OrdResobject.searchId.value + " And " + OrdResobject.profileId.value);

    OrdResobject.qFlag.value="U";

    return validateZoneData(OrdResobject);

    }

    function setOrderId(ordObject, elementNm) {
//      alert("The select value is " + elementNm.value);

        ordObject.orderId.value=elementNm.value;

        ordObject.qFlag.value="Q";
        ordObject.submit();
    }

  function setContactId(ordObject, elementNm) {
//      alert("The select value is " + elementNm.value);

        ordObject.customerId.value=elementNm.value;

        ordObject.Page.value="Start Page";
        ordObject.submit();
    }


  function printPageView(ordObjectView) {
//        ordObject.qFlag.value="Q";
    ordObjectView.Page.value="Create Page View";
        ordObjectView.submit();
    }



  function setCustomerId(custObject, elementNm) {
//    alert("The select value is " + elementNm.value);

      custObject.customerId.value=elementNm.value;

//    alert("The qFlag old is " + custObject.qFlag.value);
      custObject.qFlag.value="Q";
//    alert("The new qFlag is " + custObject.qFlag.value);
      custObject.submit();
  }

  function setQFlagData(frmObject) {
//        alert("The qFlag old is " + frmObject.qFlag.value);
    if(frmObject.qFlag.value != "N")
    {
          frmObject.qFlag.value="U";
//          alert("The new qFlag is " + frmObject.qFlag.value);
    }
    }

  function printNotes(custObject) {
        alert("Executing the print command..." + custObject.notes.value);

    var printWin = window.open("","printSpecial");
    printWin.document.open();
    printWin.document.write(custObject.notes.value);
    printWin.document.close();
       printWin.print();
//    printWin.close();

    //    custObject.print();
    }

  function createOrderButton(object, createBtnVal) {
      object.Page.value=createBtnVal;
      object.submit();
  }

    function addRegionInfo(RegionObj) {
      var regVal = RegionObj.addRegion.value;
//    alert("The name is " + regVal);

      var listSize = RegionObj.region.options.length;
//    alert("The length is " + listSize);
      var b;
    var myArrayTxt = new Array();
    var myArrayVal = new Array();
      for(b = 0; b < listSize; b++)
       {
     myArrayVal[b] = RegionObj.region.options[b].value;
     myArrayTxt[b] = RegionObj.region.options[b].text;
         if(RegionObj.region.options[b].text == regVal)
         {
            alert("This name already exists");
            return;
         }
       }
     myArrayVal[b] = "ID;" + regVal;
     myArrayTxt[b] = regVal;
       RegionObj.region.options.length = 0;

       var i;
       for(i = 0; i <= listSize; i++)
       {
          RegionObj.region.options[i] = new Option(myArrayTxt[i], myArrayVal[i], false, false);
       }
    }


  function addCountryInfo(RegionObj) {
    var regVal = RegionObj.addCountry.value;
//    alert("The name is " + regVal);

    var listSize = RegionObj.country.options.length;
//    alert("The length is " + listSize);
      var b;
    var myArrayTxt = new Array();
    var myArrayVal = new Array();
    for(b = 0; b < listSize; b++)
       {
     myArrayVal[b] = RegionObj.country.options[b].value;
     myArrayTxt[b] = RegionObj.country.options[b].text;
//     alert("The name value is " + myArrayTxt[b] + ", " + myArrayVal[b]);
         if(RegionObj.country.options[b].text == regVal)
         {
            alert("This name already exists");
            return;
      }
       }
     myArrayVal[b] = "ID;" + regVal;
     myArrayTxt[b] = regVal;
       RegionObj.country.options.length = 0;

     var i;
     for(i = 0; i <= listSize; i++)
     {
          RegionObj.country.options[i] = new Option(myArrayTxt[i], myArrayVal[i], false, false);
//      alert("The text value is " + myArrayTxt[i] + ", " + myArrayVal[i]);
     }
    }


function Welcome()
{
alert("Welcome to List Sales" + document.referrer);
}


var isNS = navigator.appName.indexOf("Netscape")  != -1
var isIE = navigator.appName.indexOf("Microsoft") != -1

function show(obj, cVal) {
  if (isNS)
  {
//  document.getElementById("d1").style.visibility = "show";
    var netValu = document.getElementById('d1');
    netValu.innerHTML=cVal;
  }
  if (isIE)
  {
//  document.all.d1.style.visibility = "visible";
    document.all.d1.innerHTML=cVal;
  }
}

function hide() {
  if (isNS) document.layers["d1"].visibility = "hide";
  if (isIE) document.all.d1.style.visibility = "hidden";
}


//export t0 excel start here
/*    var elem = "TD";
    var thead="th";

function ToExcel(){

if (window.ActiveXObject){
 try{
var  xlApp = new ActiveXObject("Excel.Application");
var xlBook = xlApp.Workbooks.Add();

// alert("Entered");
xlBook.worksheets("Sheet1").activate;
var XlSheet = xlBook.activeSheet;
xlApp.visible = true;
var check=false;
  if(document.getElementsByTagName){

var p =0;q=0;
var etab = document.getElementsByTagName("table");
  //alert("Number Of TabLes "+etab.length);
    for(var i=0; i<etab.length; i++){
    //alert(etab[i].childNodes[0].tagName);
    var ebody = etab[i].getElementsByTagName("tbody");
    //alert("Number Of Bodys "+ebody.length);
    for(var j=0; j<ebody.length; j++){
      //alert(ebody[j].childNodes[0].tagName);
      var erow = ebody[j].getElementsByTagName("tr");
      //alert("Number Of table Rows "+erow.length);
      for(var k=0; k<erow.length; k++){
      //alert("Here TR is Generating : "+erow[k].childNodes[0].tagName);
      p=p+1;
      //alert("P is "+p)
      if(erow[k].childNodes[0].tagName=="th" || erow[k].childNodes[0].tagName=="TH")
      {
        var eth =erow[k].getElementsByTagName("th");
        //alert("Number of ths for"+erow[k].childNodes[0].tagName+"\t is "+eth.length);
        //alert("Colum Span is "+erow[k].childNodes[0].colspan)
        if(eth.length > '1' && !check)
        {
        q=q+1;
        //alert("Th length "+q+" Check "+check);
        check=true;
        }//end of if

        for(var i3=0; i3<eth.length; i3++){
        q=q+1;
        //alert("Inside for"+eth.length);

        //alert("Check is"+check);
        if(eth[i3].childNodes[0]!= null)
          {
          //q=q+1;
          if(eth[i3].childNodes[0].data!= null)
          {
          XlSheet.cells(p,q).value =eth[i3].childNodes[0].data;
          }else{
              var ethInner = eth[i3].getElementsByTagName("input");
            //alert("Th Inner Elements are "+ethInner.length);
              for(var nm=0; nm<ethInner.length; nm++){
                //alert("Input Elements are "+e2.length);
                //alert("NodeType is"+ethInner[nm].value);
                switch(ethInner[nm].type){
                case 'text':
                  //alert("Nodetype is Text");
                  //alert("Text value is"+ethInner[nm].value);
                  XlSheet.cells(p,q).value =ethInner[nm].value;
                  continue;
                case 'radio':
                    //alert("Nodetype is Radio");
                    //alert("Radio value is"+eth[i3].innerText);
                    XlSheet.cells(p,q).value =eth[i3].innerText;
                    continue;
                case 'checkbox':
                    //alert("Nodetype is checkbox");
                    //alert("checkbox value is"+eth[i3].innerText);
                    XlSheet.cells(p,q).value =eth[i3].innerText;
                    continue;
                    }
                //XlSheet.cells(p,q).value =ethInner[nm].value;
                }
          }//end of if
        //alert("Th Value Is "+eth[i3].childNodes[0].data);
          check=false;
          }//end of for
         }
      }
      var etd1 = erow[k].getElementsByTagName("td");
        for(var kl=0; kl<etd1.length; kl++){
        q=q+1;
        if(etd1[kl].childNodes[0]!= null)
          {
          if(etd1[kl].childNodes[0].data!= null)
          {

          XlSheet.cells(p,q).value =etd1[kl].childNodes[0].data;
          }else{
              var etdInner = etd1[kl].getElementsByTagName("input");
            //alert("Th Inner Elements are "+etdInner.length);
              for(var nm2=0; nm2<etdInner.length; nm2++){
              switch(etdInner[nm2].type){
                case 'text':
                  //alert("Nodetype is Text");
                  //alert("Text value is"+etdInner[nm2].value);
                  XlSheet.cells(p,q).value =etdInner[nm2].value;
                  continue;
                case 'radio':
                    //alert("Nodetype is Radio");
                    //alert("Radio value is"+etd1[kl].innerText);
                    XlSheet.cells(p,q).value =etd1[kl].innerText;
                    continue;
                case 'checkbox':
                    //alert("Nodetype is checkbox");
                    //alert("checkbox value is"+etd1[kl].innerText);
                    XlSheet.cells(p,q).value =etd1[kl].innerText;
                    continue;
                    }
                //alert("Input Elements are "+e2.length);
                //alert("NodeType is"+etdInner[nm2].value);
                //XlSheet.cells(p,q).value =etdInner[nm2].value;
                }
          }
          }


        }
        //alert("p is "+p+"\t q is"+q);
        q=0;
      }

    }

      q=0;
      XlSheet.columns.autofit;
  }


}
}catch(e)//end of try
{
if(confirm("Settings Needed to your browser pls continue for knowing settings")){
alert("Tools Menu--->Internet Options--->Security-->Local intranet-->Custom Level-->(Enable)Initialize and script ActiveX controls not marked as safe for scripting");
}
}//end of catch

  }
  //return false;
}*/


//Export to excel from server side
function test2Export(orderId,srchId,clnId,ord_Name,cust_id_name,cmp_name,cnt_name)
{
    //alert("OrderId "+orderId.value+" SrchID "+srchId.value+" CLNID "+clnId.value);
    //alert("OrderName "+ord_Name.value+" customeID "+cust_id_name.value+" Company name "+cmp_name.value+" contact"+cnt_name.value);
    //var basicUrl ="/ListSales/jsp/export_to_excel.jsp?ORDERID="+orderId.value+"&SRCHID="+srchId.value+"&CLNID="+clnId.value+"&ORDNAME="+ord_Name.value+"&CUSTLSTNAME="+cust_id_name.value+"&CMPNAME="+cmp_name.value+"&CONTACT="+cnt_name.value+"";
    var basicUrl ="/ListSales/servlet/exportToExcel?ORDERID="+orderId.value+"&SRCHID="+srchId.value+"&CLNID="+clnId.value+"&ORDNAME="+ord_Name.value+"&CUSTLSTNAME="+cust_id_name.value+"&CMPNAME="+cmp_name.value+"&CONTACT="+cnt_name.value+"";
    //var strVal=basicUrl+"&orderId="+linkVal;
    var location = "width=900,height=700,resizable=1,status=0,left=0,top=0,menubar=0,scrollbars=1,toolbar=0,location=0,directories=0";
    //var newWind = window.open(basicUrl,"",location);
    window.location=basicUrl;
    //newWind.focus();
}

function selectDateBox(listObject) {
  if(listObject.orderDate.value != null && listObject.orderDate.value !=''){
    listObject.dateBox.checked=true;
  } else {
    listObject.dateBox.checked=false;
  }
}

function validateSubmission(listObject) {
  if(listObject.customerId.selectedIndex != 0){
    return true;
  }

  if(listObject.orderDate.value != null && listObject.orderDate.value.length >0){
    return true;
  }

  if(listObject.orderDateEnd.value != null && listObject.orderDateEnd.value.length >0){
    return true;
  }

  if(listObject.orderStatus.selectedIndex != 0){
    return true;
  }

  if(listObject.exprStatus.selectedIndex != 0){
    return true;
  }

  alert("Please provide at least one search criteria.")

  return false;
}

function clearViewOrderForm(listObject) {
  listObject.customerId.selectedIndex = 0;
  listObject.orderDate.value    = null;
  listObject.orderDateEnd.value   = null;
  listObject.orderStatus.selectedIndex = 0;
  listObject.exprStatus.selectedIndex = 0;

  return false;
}

//end here
