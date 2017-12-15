<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0"
    xmlns:xalan="http://xml.apache.org/xslt">

    <xsl:template match="Records">
<!--     <xsl:apply-templates select="Record"/> -->
  <TITLE>D2W <xsl:value-of select="Title"/> </TITLE>
    <p><center><font color="#000099" size="+2"><b> Create Order</b> </font></center></p>


    <form action='/ListSales/servlet/Driver' method="POST"  name='createForm'>

  <xsl:variable name="errVal">
          <xsl:value-of select="Record/ERROR" />
    </xsl:variable>
    <xsl:if test="$errVal != ''">
      <table border="1">
        <tr><td>
        <TH align="left"><font color="orange">Messages:</font></TH>
        <th align="left"><xsl:value-of select="Record/ERROR"/></th>
        </td></tr>
      </table>
    </xsl:if>
  <br></br>
  <center>
    <table align='center'>

   <xsl:variable name="ordVal">
          <xsl:value-of select="Record/ORDERID" />
        </xsl:variable>
      <tr>
      <!-- Req 2
      <td>
      <TH align="left">Existing Order Names:</TH>
      <th align="left">
    <select name="orderIdPrev" onchange="javascript:setOrderId(document.createForm, document.createForm.orderIdPrev)">
           <option name=""></option>
           <xsl:for-each select="Record">
           <xsl:if test="./ORDID">
           <option>
            <xsl:attribute name="value">
             <xsl:value-of select="./ORDID" />
            </xsl:attribute>
            <xsl:if test="./ORDID = $ordVal">
               <xsl:attribute name="selected">true</xsl:attribute>
            </xsl:if>
             <xsl:value-of select="./ORDNM" /> (<xsl:value-of select="./ORDID" />)
           </option>
           </xsl:if>
        </xsl:for-each>
      </select>
      </th>

  </td>  -->

  <td>
      <TH align="left">*Company Name:</TH>
    <xsl:variable name="cstVal">
          <xsl:value-of select="Record/CUSTOMERID" />
        </xsl:variable>
    <xsl:variable name="qVal">
          <xsl:value-of select="Record/QFLAG" />
        </xsl:variable>

     <xsl:if test="'Q' = $qVal">
        <INPUT type="hidden" name='customerId' value="{$cstVal}" />
       <td align="left"><font color="blue">
           <xsl:for-each select="Record">
            <xsl:if test="./CID = $cstVal">
               <xsl:value-of select="./CNAME" /> (<xsl:value-of select="./CID" />)
            </xsl:if>
          </xsl:for-each>
      </font></td>
        </xsl:if>

    <xsl:if test="'N' = $qVal">
         <th align="left"><select name="customerId"
      onchange="javascript:setContactId(document.createForm, document.createForm.customerId)">
       <option name=""></option>
           <xsl:for-each select="Record">
           <xsl:if test="./CNAME">
           <option>
            <xsl:attribute name="value">
             <xsl:value-of select="./CID" />
            </xsl:attribute>
            <xsl:if test="./CID = $cstVal">
               <xsl:attribute name="selected">true</xsl:attribute>
            </xsl:if>
             <xsl:value-of select="./CNAME" /> (<xsl:value-of select="./CID" />)
           </option>
           </xsl:if>
          </xsl:for-each>
        </select> </th>
      </xsl:if>
  </td>

  <td>
  <th align="left">*Contact:</th>
    <xsl:variable name="qVal2">
          <xsl:value-of select="Record/QFLAG" />
        </xsl:variable>

     <xsl:if test="'Q' = $qVal2">
                <INPUT type="hidden" name='contactId' value="{Record/CONTACTID}" />
           <td align="left"><font color="blue">
               <xsl:value-of select="Record/CONTACTFIRSTNAME" />, <xsl:value-of select="Record/CONTACTLASTNAME" /> (<xsl:value-of select="Record/CONTACTID" />)
          </font></td>
        </xsl:if>

        <xsl:if test="'N' = $qVal2">
         <th align="left"><select name="contactId">
           <option name=""></option>
           <xsl:for-each select="Record">
           <xsl:if test="./CONTACTID">
           <option>
            <xsl:attribute name="value">
             <xsl:value-of select="./CONTACTID" />
            </xsl:attribute>
               <xsl:value-of select="./CONTACTLASTNAME" />
        <xsl:if test="./CONTACTLASTNAME">,
        </xsl:if>
       <xsl:value-of select="./CONTACTFIRSTNAME" /> (<xsl:value-of select="./CONTACTID" />)
           </option>
           </xsl:if>
          </xsl:for-each>
        </select> </th>
      </xsl:if>
    </td>

    </tr>

    <tr>
  <!--
    <td>
      <TH align="left">*Order Number:</TH>
      <TH align="left"><INPUT size="15" type="text" name="orderId" value="{Record/ORDERID}" readonly="true" /></TH>
    </td> -->
    <td>
      <TH align="left">*Order Date:</TH>
      <TH align="left"><INPUT size="10" type="text" name="orderDate" value="{Record/ORDERDATE}" onChange="javascript:setQFlagData(document.createForm)"/></TH>
    </td> <td>
    <TH align="left">*Postal Counts Wanted:</TH>
      <TH align="left"><INPUT size="10" type="text" name="wantedQty" value="{Record/WANTEDQTY}" onChange="javascript:setQFlagData(document.createForm)" onblur="isNumber(this, 'Counts Wanted'); isNotEmpty(this);"/></TH>
    </td></tr>

  <tr><td>
      <TH align="left">*Order Name:</TH>
      <TH align="left"><INPUT size="15" type="text" name="orderName" value="{Record/ORDERNAME}" onchange="setQFlagData(document.createForm)" onblur="isNotEmpty(this)"/></TH>
    </td>
    <!-- Req 2
    <td>
      <TH align="left">Search Id:</TH>
    <TH align="left"><select name="searchId"   onChange="javascript:setQFlagData(document.createForm)">
           <xsl:for-each select="Record">
           <xsl:if test="./SEARCHID">
           <option>
            <xsl:attribute name="value">
             <xsl:value-of select="./SEARCHID" />
            </xsl:attribute>
            <xsl:value-of select="./SEARCHID" />
           </option>
        </xsl:if>
        </xsl:for-each>
        </select>
      </TH>
    </td> -->
    </tr>

  <tr>
  <!-- Req 2
    <td></td>
        <th align="left">Required Date:</th>
        <th align="left">
          <input size="10" type="text" name="requiredByDate" value="{Record/REQUIREDBYDATE}" onChange="javascript:setQFlagData(document.createForm)"/></th>
        <td>
        <th align="left">Promised Date:</th>
        <th align="left">
          <input size="10" type="text" name="promisedByDate" value="{Record/PROMISEDBYDATE}" onChange="javascript:setQFlagData(document.createForm)"/> </th>
        </td> -->
  <td>
        <th align="left"></th>
        <th align="left">
      <xsl:if test="Record/QFLAG = 'Q'">
              <input type="button" value="PRINT VIEW" onclick="javascript:printPageView(document.createForm)"/>
      </xsl:if>
      <xsl:if test="Record/QFLAG != 'Q'">
              <input type="button" value="PRINT VIEW" onclick="javascript:printPageView(document.createForm)" disabled="true"/>
      </xsl:if>
        </th></td>
      </tr>
      <tr>
        <td colspan="9"> <font size="-1">* is a required field. </font>
          <hr noshade="true" size="1"></hr></td>
      </tr>

  <tr><td>
      <TH align="left"><font size="+2" color="#000099">Preferences:</font></TH>
  </td>
    </tr>

    <tr>
    <!-- Req 2
    <td>
      <TH align="left">Delivery Format:</TH>
  <xsl:variable name="dlvVal">
       <xsl:value-of select="Record/DELIVERYFORMAT"/>
    </xsl:variable>
      <TH align="left"><select name="deliveryFormat" onChange="javascript:setQFlagData(document.createForm)">
    <option> <xsl:attribute name="value">csv</xsl:attribute>
          <xsl:if test="starts-with($dlvVal, 'csv')">
            <xsl:attribute name="selected">true</xsl:attribute>
          </xsl:if>CSV</option>
    <option> <xsl:attribute name="value">Label</xsl:attribute>
          <xsl:if test="starts-with($dlvVal, 'Label')">
            <xsl:attribute name="selected">true</xsl:attribute>
          </xsl:if>Label</option>
    </select>
    </TH>

  </td><td>
      <TH align="left">Media:</TH>
  <xsl:variable name="medVal">
       <xsl:value-of select="Record/DELIVERYMEDIA"/>
    </xsl:variable>
    <th align="left"><select name="deliveryMedia" onChange="javascript:setQFlagData(document.createForm)" >
    <option> <xsl:attribute name="value">Email</xsl:attribute>
            <xsl:if test="starts-with($medVal, 'Email')">
            <xsl:attribute name="selected">true</xsl:attribute>
        </xsl:if>Email</option>
    <option> <xsl:attribute name="value">Cheshire</xsl:attribute>
            <xsl:if test="starts-with($medVal, 'Cheshire')">
            <xsl:attribute name="selected">true</xsl:attribute>
        </xsl:if>Cheshire</option>
    <option> <xsl:attribute name="value">Adhesive</xsl:attribute>
            <xsl:if test="starts-with($medVal, 'Adhesive')">
            <xsl:attribute name="selected">true</xsl:attribute>
        </xsl:if>Adhesive</option>
    </select>
      </th>
    </td> -->
    </tr>

  <tr><td>
      <TH align="left">Select Org: </TH>
      <th align="left"><select name="suppressOrg" onChange="javascript:setQFlagData(document.createForm)">
        <xsl:variable name="supVal">
          <xsl:value-of select="Record/SUPPRESSORG" />
          </xsl:variable>
        <option> <xsl:attribute name="value">0</xsl:attribute>
          <xsl:if test="'0' = $supVal">
            <xsl:attribute name="selected">true</xsl:attribute>
          </xsl:if>Both</option>
        <option> <xsl:attribute name="value">1</xsl:attribute>
          <xsl:if test="'1' = $supVal">
            <xsl:attribute name="selected">true</xsl:attribute>
          </xsl:if>Acad Only</option>
        <option> <xsl:attribute name="value">2</xsl:attribute>
          <xsl:if test="'2' = $supVal">
            <xsl:attribute name="selected">true</xsl:attribute>
          </xsl:if>Non Acad Only</option>
        <option> <xsl:attribute name="value">3</xsl:attribute>
          <xsl:if test="'3' = $supVal">
            <xsl:attribute name="selected">true</xsl:attribute>
          </xsl:if>None</option>
        </select>
        </th>
    </td>
  <td>
      <TH align="left">Country Breakout: </TH>
      <th align="left"><select name="countryBreakOut" onChange="javascript:setQFlagData(document.createForm)">
         <xsl:variable name="cntBrVal">
          <xsl:value-of select="Record/COUNTRYBREAKOUT" />
          </xsl:variable>
        <option> <xsl:attribute name="value">Y</xsl:attribute>
          <xsl:if test="'Y' = $cntBrVal">
            <xsl:attribute name="selected">true</xsl:attribute>
          </xsl:if>Yes</option>
        <option> <xsl:attribute name="value">N</xsl:attribute>
          <xsl:if test="'N' = $cntBrVal">
            <xsl:attribute name="selected">true</xsl:attribute>
          </xsl:if>No</option>
        </select>
        </th>
    </td></tr>
  <tr>
  <!-- Req 2
  <td>
      <TH align="left">Ship Method:</TH>
    <th align="left"><select name="shipMethod" onChange="javascript:setQFlagData(document.createForm)">
     <xsl:variable name="shipVal">
          <xsl:value-of select="Record/SHIPMETHOD" />
          </xsl:variable>
          <option> <xsl:attribute name="value">E-mail</xsl:attribute>
          <xsl:if test="'E-mail' = $shipVal">
            <xsl:attribute name="selected">true</xsl:attribute>
      <option> <xsl:attribute name="value">UPS</xsl:attribute>
          <xsl:if test="'UPS' = $shipVal">
            <xsl:attribute name="selected">true</xsl:attribute>
          </xsl:if>UPS</option>
          <option> <xsl:attribute name="value">FedEx</xsl:attribute>
          <xsl:if test="'FedEx' = $shipVal">
            <xsl:attribute name="selected">true</xsl:attribute>
          </xsl:if>FedEx</option>
          </xsl:if>E-mail</option>
        </select> </th>
  </td>-->

  <td>
      <TH align="left">Dedupe:</TH>
    <th align="left"><select name="dedupe" onChange="javascript:setQFlagData(document.createForm)">
    <xsl:variable name="dedupVal">
          <xsl:value-of select="Record/DEDUPE" />
          </xsl:variable>
        <option> <xsl:attribute name="value">Y</xsl:attribute>
          <xsl:if test="'Y' = $dedupVal">
            <xsl:attribute name="selected">true</xsl:attribute>
          </xsl:if>Yes</option>
        <option> <xsl:attribute name="value">N</xsl:attribute>
          <xsl:if test="'N' = $dedupVal">
            <xsl:attribute name="selected">true</xsl:attribute>
          </xsl:if>No</option>
        </select>
        </th>
    </td></tr>

  <tr><td>
      <TH align="left">Regions Include:</TH>
    <INPUT type="hidden" name='incReg' value="{Record/INCLUDEREGIONS}" />
      <TH align="left"><select name="includeRegions" multiple="true" size="3"  onChange="javascript:setQFlagData(document.createForm)">
           <xsl:for-each select="Record">
           <xsl:if test="./REGION">
           <option>
            <xsl:attribute name="value">
             <xsl:value-of select="./REGIONID" />
            </xsl:attribute>
            <xsl:value-of select="./REGION" />
           </option>
           </xsl:if>
        </xsl:for-each>
        </select>
      </TH>
    </td> <td>
      <TH align="left">Countries Include:</TH>
    <INPUT type="hidden" name='incCoun' value="{Record/INCLUDECOUNTRIES}" />
      <TH align="left"><select name="includeCountries" multiple="true" size="3"  onChange="javascript:setQFlagData(document.createForm)">
           <xsl:for-each select="Record">
           <xsl:if test="./COUNTRY">
           <option>
            <xsl:attribute name="value">
             <xsl:value-of select="./COUNTRYID" />
            </xsl:attribute>
            <xsl:value-of select="./COUNTRY" />
           </option>
           </xsl:if>
        </xsl:for-each>
        </select>
      </TH>
    </td> <td>
      <TH align="left">States Include:</TH>
    <INPUT type="hidden" name='incSt' value="{Record/INCLUDESTATES}" />
      <TH align="left"><select name="includeStates" multiple="true" size="3"  onChange="javascript:setQFlagData(document.createForm)">
           <xsl:for-each select="Record">
           <xsl:if test="./STATE">
           <option>
            <xsl:attribute name="value">
             <xsl:value-of select="./STATEID" />
            </xsl:attribute>
            <xsl:value-of select="./STATE" />
           </option>
           </xsl:if>
        </xsl:for-each>
        </select>
      </TH>
  </td></tr>


    <tr><td>
    <TH align="left">Regions Exclude:</TH>
    <INPUT type="hidden" name='excReg' value="{Record/EXCLUDEREGIONS}" />
      <TH align="left"><select name="excludeRegions" multiple="true" size="3"  onChange="javascript:setQFlagData(document.createForm)">
           <xsl:for-each select="Record">
           <xsl:if test="./REGION">
           <option>
            <xsl:attribute name="value">
             <xsl:value-of select="./REGIONID" />
            </xsl:attribute>
            <xsl:value-of select="./REGION" />
           </option>
           </xsl:if>
        </xsl:for-each>
        </select>
      </TH>
    </td> <td>
      <TH align="left">Countries Exclude:</TH>
    <INPUT type="hidden" name='excCoun' value="{Record/EXCLUDECOUNTRIES}" />
      <TH align="left"><select name="excludeCountries" multiple="true" size="3"  onChange="javascript:setQFlagData(document.createForm)">
           <xsl:for-each select="Record">
           <xsl:if test="./COUNTRY">
           <option>
            <xsl:attribute name="value">
             <xsl:value-of select="./COUNTRYID" />
            </xsl:attribute>
            <xsl:value-of select="./COUNTRY" />
           </option>
           </xsl:if>
        </xsl:for-each>
        </select>
      </TH>
    </td> <td>
      <TH align="left">States Exclude:</TH>
    <INPUT type="hidden" name='excSt' value="{Record/EXCLUDESTATES}" />
    <TH align="left"><select name="excludeStates" multiple="true" size="3"  onChange="javascript:setQFlagData(document.createForm)">
           <xsl:for-each select="Record">
           <xsl:if test="./STATE">
           <option>
            <xsl:attribute name="value">
             <xsl:value-of select="./STATEID" />
            </xsl:attribute>
            <xsl:value-of select="./STATE" />
           </option>
           </xsl:if>
        </xsl:for-each>
        </select>
      </TH>
    </td></tr>

  <tr><td>
        <th align="left" height="70">Zip Codes/<br></br> Range:</th>
        <th colspan="7" align="left" height="70">
          <textarea name="zipCodes" cols="65" onChange="javascript:setQFlagData(document.createForm)">  <xsl:value-of select="Record/ZIPCODES" /><xsl:value-of select="' '" /></textarea>
        </th>
    </td></tr>
  <tr><td>
      <TH align="left">Notes:</TH>
      <TH colspan="6" align="left"><textarea name="notes" rows="20" cols="80" onChange="javascript:setQFlagData(document.createForm)">
      <xsl:value-of select="Record/NOTES" />
      <xsl:value-of select="' '" />
    </textarea></TH>
   <!-- <TH align="left"><INPUT type="button" value="Print Notes" onclick="javascript:printNotes(document.createForm)"/></TH> -->
  </td></tr>

  <tr><td><br></br> </td></tr>

  <tr><td>
      <TH> </TH>
      <TH align="left"><INPUT type="submit" value="SUBMIT" onclick="return validateFields(document.createForm)" /></TH>
      </td>
      <td>
      <TH> </TH>
      <TH align="left"><INPUT type="button" value="Cancel"  /></TH>
    </td></tr>

</table>

<br></br>
<INPUT type="hidden" name='Menu' value="Create Order" />
<INPUT type="hidden" name='Page' value="Create Page" />
<INPUT type="hidden" name='co_showMenu' value="Y" />
<input type="hidden" name='qFlag' value="{Record/QFLAG}" />
</center>
 </form>

* is a required field.
    </xsl:template>

</xsl:stylesheet>

