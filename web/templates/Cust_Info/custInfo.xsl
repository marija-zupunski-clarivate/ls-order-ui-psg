<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0"
    xmlns:xalan="http://xml.apache.org/xslt"
  xmlns:saxon="http://saxon.sf.net/" extension-element-prefixes="saxon">

   <xsl:template match="Records">
<!--   <xsl:apply-templates select="Record"/>  -->


   <TITLE>D2W <xsl:value-of select="Title"/> </TITLE>
  <br></br>
    <center><font color="#000099" size="+2"><b> Customer Information</b> </font></center>



  <form action='/ListSales/servlet/Driver' method="POST"  name='custForm'>

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

    <table align='center'>
     <xsl:variable name="cstVal">
          <xsl:value-of select="Record/CUSTOMERID" />
        </xsl:variable>
    <tr><td>
      <TH align="left">Existing Customer Id:</TH>
      <th align="left"><select name="customerIdPrev" onchange="javascript:setCustomerId(document.custForm, document.custForm.customerIdPrev)">
       <option name=""></option>
           <xsl:for-each select="Record">
           <xsl:if test="./CID">
           <option>
            <xsl:attribute name="value">
             <xsl:value-of select="./CID" />
            </xsl:attribute>
      <xsl:if test="./CID = $cstVal">
         <xsl:attribute name="selected">true</xsl:attribute>
      </xsl:if>
             <xsl:value-of select="./CID" />
           </option>
           </xsl:if>
        </xsl:for-each>
      </select>
      </th>
    </td><td>
    <th align="left">*Customer ID: </th>
      <th align="left"><input size="8" type="text" name="customerId" value="{Record/CUSTOMERID}" readonly="true" /></th>
    </td></tr>

   <xsl:variable name="tempVal">
          <xsl:value-of select="'8'" />
        </xsl:variable>

    <tr><td>
    <TH align="left">Existing <br></br>Company Name:</TH>
        <th align="left"><select name="companyNameOld" onchange="javascript:setCustomerId(document.custForm, document.custForm.companyNameOld)">
       <option name=""></option>
           <xsl:for-each select="Record">
           <xsl:if test="./CNAME">
           <option>
            <xsl:attribute name="value">
             <xsl:value-of select="./CID" />
            </xsl:attribute>
      <xsl:if test="./CID = $cstVal and $tempVal = 8">
         <xsl:attribute name="selected">true</xsl:attribute>
      </xsl:if>
             <xsl:value-of select="./CNAME" /> (<xsl:value-of select="./CID" />)
           </option>
           </xsl:if>
        </xsl:for-each>
      </select>

      </th>
    </td><td>
      <th align="left">*Company Name: </th>
      <th align="left"><input size="15" type="text" name="companyName" value="{Record/COMPANYNAME}" onChange="javascript:setQFlagData(document.custForm)"/></th>

      </td>
    </tr>

    <tr>
         <td colspan="9"><font size="-1">* is a required field</font></td>
    </tr>
    <tr>
    <td colspan="9">
        <hr size="1" noshade="true" align="center"></hr>
      </td>
    </tr>

    <tr><td>
    <TH align="left">Organization:</TH>
      <TH align="left"><input size="25" type="text" name="department" value="{Record/DEPARTMENT}" onChange="javascript:setQFlagData(document.custForm)"/></TH>
    </td><td>
      <TH align="left">Billing Address:</TH>
    <TH align="left"><input type="checkbox" name="billingAddress" onClick="javascript:setQFlagData(document.custForm)">
    <xsl:variable name="bilVal">
            <xsl:value-of select="Record/BILLINGADDRESS" />
        </xsl:variable>
        <xsl:if test="'Y' = $bilVal">
            <xsl:attribute name="checked">true</xsl:attribute>
        </xsl:if>
        </input>
    </TH>
    </td><td>
    <th align="left">Status: </th>
      <th align="left"><select name="status"  onChange="javascript:setQFlagData(document.custForm)">
          <xsl:variable name="stsVal">
          <xsl:value-of select="Record/STATUS" />
          </xsl:variable>
        <option> <xsl:attribute name="value">Y</xsl:attribute>
          <xsl:if test="'Y' = $stsVal">
            <xsl:attribute name="selected">true</xsl:attribute>
          </xsl:if>Active</option>
        <option> <xsl:attribute name="value">N</xsl:attribute>
          <xsl:if test="'N' = $stsVal">
            <xsl:attribute name="selected">true</xsl:attribute>
          </xsl:if>Inactive</option>
        </select>
        </th>
      </td></tr>

      <tr><td>
      <TH align="left">Street:</TH>
      <TH align="left"><input size="25" type="text" name="street" value="{Record/STREET}" onChange="javascript:setQFlagData(document.custForm)"/></TH>
    </td><td>
     <th align="left">Phone: </th>
        <th align="left"><input size="15" type="text" name="phone" value="{Record/PHONE}" onChange="javascript:setQFlagData(document.custForm)"/></th>
      </td><td>
      </td></tr>

      <tr><td>
      <TH align="left">City:</TH>
      <TH align="left"><input size="15" type="text" name="city" value="{Record/CITY}" onChange="javascript:setQFlagData(document.custForm)"/></TH>
      </td>
      <td>
      <TH align="left">Fax:</TH>
      <TH align="left"><input size="15" type="text" name="fax" value="{Record/FAX}" onChange="javascript:setQFlagData(document.custForm)"/></TH>
    </td></tr>

      <tr><td>
      <TH align="left">State:</TH>
      <TH align="left"><input size="15" type="text" name="state" value="{Record/STATE}" onChange="javascript:setQFlagData(document.custForm)"/></TH>
      </td>
    </tr>
      <tr><td>

    <xsl:variable name="countryVal">
          <xsl:value-of select="Record/CUSTCOUNTRYID" />
      </xsl:variable>

      <TH align="left">Country:</TH>
    <th align="left"><select name="countryId" onChange="javascript:setQFlagData(document.custForm)">
           <xsl:for-each select="Record">
       <xsl:if test="./COUNTRY">
           <option>
            <xsl:attribute name="value">
             <xsl:value-of select="./COUNTRYID" />
            </xsl:attribute>
      <xsl:if test="./COUNTRYID = $countryVal">
         <xsl:attribute name="selected">true</xsl:attribute>
      </xsl:if>
            <xsl:value-of select="./COUNTRY" />
           </option>
       </xsl:if>
        </xsl:for-each>
      </select>
      </th>
      </td></tr>
      <tr><td>
      <TH align="left">Zip:</TH>
      <TH align="left"><input size="10" type="text" name="postalCode" value="{Record/POSTALCODE}" onChange="javascript:setQFlagData(document.custForm)"/></TH>
    </td></tr>


    <tr><td>
      <TH align="left">Notes:</TH>
      <TH align="left" colspan="4">
       <textarea  name="notes" rows="3" cols="50" onChange="javascript:setQFlagData(document.custForm)"><xsl:value-of select="Record/NOTES"/><xsl:value-of select="' '" /></textarea> </TH>
      </td></tr>

    </table>
    <hr size="1" noshade="true" align="center" />



  <table align='center'>
    <tr>

      <th colspan="5">Contact Information</th>
    <td colspan="3"><img src="../images/contacts.gif" width="70" height="25" alt="Add more contacts" name="contacts"/></td>
    </tr>


  <xsl:variable name="rowVal" select="'startOver'" saxon:assignable="yes"/>
  <xsl:variable name="cntId" select="''" saxon:assignable="yes"/>
    <xsl:variable name="fname" select="''" saxon:assignable="yes"/>
    <xsl:variable name="lname" select="''" saxon:assignable="yes"/>
    <xsl:variable name="phoneInfo" select="''" saxon:assignable="yes"/>
    <xsl:variable name="emailInfo" select="''" saxon:assignable="yes"/>

  <xsl:for-each select="Record">
    <xsl:if test="./CONTACTID">
    <xsl:choose>

          <xsl:when test="$rowVal = 'startOver'">

        <!-- Re Initialize all Values -->
              <saxon:assign name="cntId" select="''"/>
              <saxon:assign name="fname" select="''"/>
              <saxon:assign name="lname" select="''"/>
              <saxon:assign name="phoneInfo" select="''"/>
              <saxon:assign name="emailInfo" select="''"/>

              <saxon:assign name="cntId" select="./CONTACTID"/>
              <saxon:assign name="fname" select="CONTACTFIRSTNAME"/>
              <saxon:assign name="lname" select="CONTACTLASTNAME"/>
              <saxon:assign name="phoneInfo" select="./PHONE"/>
              <saxon:assign name="emailInfo" select="./EMAILADDRESS"/>

        <saxon:assign name="rowVal" select="'2'"/>

      </xsl:when>
          <xsl:otherwise>

        <input type="hidden" name="CNTID{$cntId}" value="{$cntId}" />
        <input type="hidden" name="CNTID{./CONTACTID}" value="{./CONTACTID}" />
        <tr>
            <th><div align="left">First Name:</div> </th>
            <th align="left"><input size="25" type="text" name="contactFirstname{$cntId}" value="{$fname}" onChange="javascript:setQFlagData(document.custForm)"/></th>
            <td> </td>
            <th> <div align="left">First Name: </div></th>
            <th align="left"><input size="25" type="text" name="contactFirstname{./CONTACTID}" value="{./CONTACTFIRSTNAME}" onChange="javascript:setQFlagData(document.custForm)"/></th>
            </tr>
            <tr>
            <th><div align="left">Last Name:</div> </th>
            <th align="left"><input size="25" type="text" name="contactLastname{$cntId}" value="{$lname}" onChange="javascript:setQFlagData(document.custForm)"/></th>
            <td> </td>
            <th> <div align="left">Last Name: </div></th>
            <th align="left"><input size="25" type="text" name="contactLastname{./CONTACTID}" value="{./CONTACTLASTNAME}" onChange="javascript:setQFlagData(document.custForm)"/></th>
              </tr>
              <tr>
             <th align="left">Phone: </th>
            <th align="left"><input size="25" type="text" name="phone{$cntId}" value="{$phoneInfo}" onChange="javascript:setQFlagData(document.custForm)"/></th>
            <td> </td>
              <th align="left">Phone: </th>
            <th align="left"><input size="25" type="text" name="phone{./CONTACTID}" value="{./PHONE}" onChange="javascript:setQFlagData(document.custForm)"/></th>
              </tr>
              <tr>
            <TH align="left">Email:</TH>
            <TH align="left"><input size="25" type="text" name="emailAddress{$cntId}" value="{$emailInfo}" onChange="javascript:setQFlagData(document.custForm)"/></TH>
            <td> </td>
            <TH align="left">Email:</TH>
            <TH align="left"><input size="25" type="text" name="emailAddress{./CONTACTID}" value="{./EMAILADDRESS}" onChange="javascript:setQFlagData(document.custForm)"/></TH>
              </tr>

        <tr> <TH align="left"><font color="blue">*** </font></TH> </tr>
        <saxon:assign name="rowVal" select="'startOver'"/>

      </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:for-each>
    <xsl:if test="$rowVal = '2'">

        <input type="hidden" name="CNTID;{$cntId}" value="{$cntId}" />
        <input type="hidden" name="CNTID;{./CONTACTID}" value="{./CONTACTID}" />
        <tr>
            <th><div align="left">First Name:</div> </th>
            <th align="left"><input size="25" type="text" name="contactFirstname{$cntId}" value="{$fname}" onChange="javascript:setQFlagData(document.custForm)" /></th>
            <td> </td>
            <th> <div align="left">First Name: </div></th>
            <th align="left"><input size="25" type="text" name="contactFirstnameNew1" value="" onChange="javascript:setQFlagData(document.custForm)"/></th>
            </tr>
            <tr>
            <th><div align="left">Last Name:</div> </th>
            <th align="left"><input size="25" type="text" name="contactLastname{$cntId}" value="{$lname}" onChange="javascript:setQFlagData(document.custForm)"/></th>
            <td> </td>
            <th> <div align="left">Last Name: </div></th>
            <th align="left"><input size="25" type="text" name="contactLastnameNew1" value="" onChange="javascript:setQFlagData(document.custForm)"/></th>
              </tr>
              <tr>
             <th align="left">Phone: </th>
            <th align="left"><input size="25" type="text" name="phone{$cntId}" value="{$phoneInfo}" onChange="javascript:setQFlagData(document.custForm)"/></th>
            <td> </td>
        <th align="left">Phone: </th>
            <th align="left"><input size="25" type="text" name="phoneNew1" value="" onChange="javascript:setQFlagData(document.custForm)"/></th>
              </tr>
              <tr>
            <TH align="left">Email:</TH>
            <TH align="left"><input size="25" type="text" name="emailAddress{$cntId}" value="{$emailInfo}" onChange="javascript:setQFlagData(document.custForm)"/></TH>
            <td> </td>
            <TH align="left">Email:</TH>
            <TH align="left"><input size="25" type="text" name="emailAddressNew1" value="" onChange="javascript:setQFlagData(document.custForm)"/></TH>
              </tr>

  </xsl:if>


    <xsl:if test="$rowVal != '2'">
    <tr> <TH align="left"><font color="blue">Add New Contacts </font></TH> </tr>
    <tr>
        <th><div align="left">First Name:</div> </th>
        <th align="left"><input size="25" type="text" name="contactFirstnameNew1" value="" onChange="javascript:setQFlagData(document.custForm)"/></th>
    <td> </td>
        <th> <div align="left">First Name: </div></th>
        <th align="left"><input size="25" type="text" name="contactFirstnameNew2" value="" onChange="javascript:setQFlagData(document.custForm)"/></th>
      </tr>
    <tr>
        <th><div align="left">Last Name:</div> </th>
        <th align="left"><input size="25" type="text" name="contactLastnameNew1" value="" onChange="javascript:setQFlagData(document.custForm)"/></th>
    <td> </td>
        <th> <div align="left">Last Name: </div></th>
        <th align="left"><input size="25" type="text" name="contactLastnameNew2" value="" onChange="javascript:setQFlagData(document.custForm)"/></th>
      </tr>
    <tr>
     <th align="left">Phone: </th>
        <th align="left"><input size="25" type="text" name="phoneNew1" value="" onChange="javascript:setQFlagData(document.custForm)"/></th>
    <td> </td>
     <th align="left">Phone: </th>
        <th align="left"><input size="25" type="text" name="phoneNew2" value="" onChange="javascript:setQFlagData(document.custForm)"/></th>
      </tr>
    <tr>
        <TH align="left">Email:</TH>
        <TH align="left"><input size="25" type="text" name="emailAddressNew1" value="" onChange="javascript:setQFlagData(document.custForm)"/></TH>
    <td> </td>
        <TH align="left">Email:</TH>
        <TH align="left"><input size="25" type="text" name="emailAddressNew2" value="" onChange="javascript:setQFlagData(document.custForm)"/></TH>
      </tr>
  </xsl:if>

    </table>
    <hr size="1" noshade="true" align="center" />
      <center><input type="submit" value="SUBMIT" /></center>

    <center>
  <input type="hidden" name='Menu' value="Customer Information" />
    <input type="hidden" name='Page' value="Cust Info Page" />
    <input type="hidden" name='qFlag' value="{Record/QFLAG}" />
    </center>
    </form>

    </xsl:template>

</xsl:stylesheet>
