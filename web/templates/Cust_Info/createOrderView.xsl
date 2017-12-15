<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0"
    xmlns:xalan="http://xml.apache.org/xslt">


  <xsl:template name="checkSelection">
        <xsl:param name="s"/>
        <xsl:param name="rgId"/>
        <xsl:choose>
            <xsl:when test="contains($s, ',')">
        <xsl:choose>
           <xsl:when test="substring-before($s,',') = $rgId">
                      <xsl:text>true</xsl:text>
           </xsl:when>
           <xsl:otherwise>
                     <xsl:call-template name="checkSelection">
                       <xsl:with-param name="s" select="substring-after($s,',')"/>
                     <xsl:with-param name="rgId" select="$rgId"/>
                   </xsl:call-template>
           </xsl:otherwise>
        </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
        <xsl:if test="$s = $rgId">
                     <xsl:text>true</xsl:text>
        </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
        </xsl:template>


    <xsl:template match="Records">
<!--     <xsl:apply-templates select="Record"/> -->

  <TITLE>D2W <xsl:value-of select="Title"/> </TITLE>

    <p><center><font color="#000099" size="4"> View Order details </font></center></p>

    <form action='/ListSales/servlet/Driver' method="POST"  name='createFormView'>

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
      <TH align="left">Existing Order Name:</TH>
          <td align="left"><xsl:value-of select="Record/ORDERNAME" /></td>

      <TH align="left">*Company Name:</TH>
      <xsl:variable name="cstVal">
             <xsl:value-of select="Record/CUSTOMERID" />
      </xsl:variable>

      <xsl:variable name="qVal">
            <xsl:value-of select="Record/QFLAG" />
          </xsl:variable>

     <xsl:if test="'Q' = $qVal">
        <INPUT type="hidden" name='customerId' value="{$cstVal}" />
       <td align="left"><font>
           <xsl:for-each select="Record">
    <!--Bug Fixing for order 174 <input type="text" value="{./CID}" />-->
            <xsl:if test="./CID = $cstVal">
               <xsl:value-of select="./CNAME" /> (<xsl:value-of select="./CID" />)

            </xsl:if>
          </xsl:for-each>
      </font></td>
        </xsl:if>

    <td></td>
  </tr>

  <tr>
    <th align="left">*Contact:</th>

        <INPUT type="hidden" name='contactId' value="{Record/CONTACTID}" />
        <td align="left"><font>
           <xsl:value-of select="Record/CONTACTFIRSTNAME" />, <xsl:value-of select="Record/CONTACTLASTNAME" /> (<xsl:value-of select="Record/CONTACTID" />)
        </font></td>
    <TH align="left">*Order Number:</TH>
        <td align="left"><xsl:value-of select="Record/ORDERID" /></td>

    <td></td>
  </tr>


  <INPUT type="hidden" name="orderId" value="{Record/ORDERID}" />
    <tr>
      <TH align="left">*Order Date:</TH>
      <td align="left"><xsl:value-of select="Record/ORDERDATE" /></td>
    <TH align="left">*Counts Wanted:</TH>
      <td align="left"><xsl:value-of select="Record/WANTEDQTY" /></td>
      <td></td>
    </tr>

  <tr>
      <TH align="left">Order Name:</TH>
      <td align="left"><xsl:value-of select="Record/ORDERNAME" /></td>
      <TH align="left">Search Id:</TH>
    <td align="left">
           <xsl:for-each select="Record">
           <xsl:if test="./SEARCHID">
            <xsl:value-of select="./SEARCHID" />,
          </xsl:if>
        </xsl:for-each>
      </td>
    <td></td>
    </tr>

  <tr>
  <!-- Req 3
  <TH align="left">Required Date:</TH>
      <td align="left"><xsl:value-of select="Record/REQUIREDBYDATE" /></td>
    <TH align="left">Promised Date:</TH>
      <td align="left"><xsl:value-of select="Record/PROMISEDBYDATE" /></td>-->
      <TH align="left"><input type="submit" value="EDIT VIEW"/></TH>
  </tr>

  <tr>
  <TH colspan="5" align="left"><hr noshade="true" size="1"/></TH>
  </tr>

    <tr>
      <th align="left" colspan="5"><font size="+2" color="#000099">Preferences:</font></th>
  </tr>

    <tr>
      <TH align="left">Delivery Format:</TH>
      <td align="left"><xsl:value-of select="Record/DELIVERYFORMAT" /></td>
      <TH align="left">Media:</TH>
      <td align="left"><xsl:value-of select="Record/DELIVERYMEDIA" /></td>
      <td></td>
    </tr>

    <tr>
      <TH align="left">Country Breakout: </TH>
      <td align="left"><xsl:value-of select="Record/COUNTRYBREAKOUT" /></td>
      <TH align="left">Select Org: </TH>
    <td align="left">
    <xsl:variable name="supVal">
          <xsl:value-of select="Record/SUPPRESSORG" />
          </xsl:variable>
          <xsl:if test="'0' = $supVal"> Both </xsl:if>
          <xsl:if test="'1' = $supVal"> Acad Only </xsl:if>
          <xsl:if test="'2' = $supVal"> Non Acad Only </xsl:if>
          <xsl:if test="'3' = $supVal"> None </xsl:if>
        </td>
      <td></td>
    </tr>

  <tr>
      <TH align="left">Ship Method:</TH>
      <td align="left"><xsl:value-of select="Record/SHIPMETHOD" /></td>
      <TH align="left">Dedupe:</TH>
      <td align="left"><xsl:value-of select="Record/DEDUPE" /></td>
      <td></td>
    </tr>

    <xsl:variable name="incReg">
          <xsl:value-of select="Record/INCLUDEREGIONS" />
      </xsl:variable>

  <tr>
    <TH align="left">Regions Include:</TH>
    <td align="left" colspan="4">
      <xsl:for-each select="Record">
      <xsl:if test="./REGIONID">
        <xsl:variable name="isSelect">
                <xsl:call-template name="checkSelection">
                <xsl:with-param name="s" select="$incReg"/>
                <xsl:with-param name="rgId" select="./REGIONID"/>
                </xsl:call-template>
                </xsl:variable>

        <xsl:if test="$isSelect = 'true'">
          <xsl:value-of select="./REGION"/>,
        </xsl:if>
            </xsl:if>
           </xsl:for-each>
    </td>
   </tr>

   <xsl:variable name="excReg">
          <xsl:value-of select="Record/EXCLUDEREGIONS" />
        </xsl:variable>

    <tr>
        <TH align="left">Regions Exclude:</TH>
        <td align="left" colspan="4">
            <xsl:for-each select="Record">
            <xsl:if test="./REGION">
                <xsl:variable name="isSelect">
                <xsl:call-template name="checkSelection">
                <xsl:with-param name="s" select="$excReg"/>
                <xsl:with-param name="rgId" select="./REGIONID"/>
                </xsl:call-template>
                </xsl:variable>

                <xsl:if test="$isSelect = 'true'">
                    <xsl:value-of select="./REGION"/>,
                </xsl:if>
            </xsl:if>
           </xsl:for-each>
        </td>
  </tr>


  <xsl:variable name="incCoun">
          <xsl:value-of select="Record/INCLUDECOUNTRIES" />
        </xsl:variable>
    <tr>
        <TH align="left">Countries Include:</TH>
        <td align="left" colspan="4">
            <xsl:for-each select="Record">
            <xsl:if test="./COUNTRYID">
                <xsl:variable name="isSelect">
                <xsl:call-template name="checkSelection">
                <xsl:with-param name="s" select="$incCoun"/>
                <xsl:with-param name="rgId" select="./COUNTRYID"/>
                </xsl:call-template>
                </xsl:variable>
                <xsl:if test="$isSelect = 'true'">
                    <xsl:value-of select="./COUNTRY"/>,
                </xsl:if>
            </xsl:if>
           </xsl:for-each>
        </td>
     </tr>

  <xsl:variable name="excCoun">
          <xsl:value-of select="Record/EXCLUDECOUNTRIES" />
        </xsl:variable>
    <tr>
        <TH align="left">Countries Exclude:</TH>
        <td align="left" colspan="4">
            <xsl:for-each select="Record">
            <xsl:if test="./COUNTRYID">
                <xsl:variable name="isSelect">
                <xsl:call-template name="checkSelection">
                <xsl:with-param name="s" select="$excCoun"/>
                <xsl:with-param name="rgId" select="./COUNTRYID"/>
                </xsl:call-template>
                </xsl:variable>
                <xsl:if test="$isSelect = 'true'">
                    <xsl:value-of select="./COUNTRY"/>,
                </xsl:if>
            </xsl:if>
           </xsl:for-each>
        </td>
     </tr>

  <xsl:variable name="incSt">
          <xsl:value-of select="Record/INCLUDESTATES" />
        </xsl:variable>
    <tr>
        <TH align="left">States Include:</TH>
        <td align="left" colspan="4">
            <xsl:for-each select="Record">
            <xsl:if test="./STATE">
                <xsl:variable name="isSelect">
                <xsl:call-template name="checkSelection">
                <xsl:with-param name="s" select="$incSt"/>
                <xsl:with-param name="rgId" select="./STATEID"/>
                </xsl:call-template>
                </xsl:variable>
                <xsl:if test="$isSelect = 'true'">
                    <xsl:value-of select="./STATE"/>,
                </xsl:if>
            </xsl:if>
           </xsl:for-each>
        </td>
     </tr>


  <xsl:variable name="excSt">
          <xsl:value-of select="Record/EXCLUDESTATES" />
        </xsl:variable>
    <tr>
        <TH align="left">States Exclude:</TH>
        <td align="left" colspan="4">
            <xsl:for-each select="Record">
            <xsl:if test="./STATE">
                <xsl:variable name="isSelect">
                <xsl:call-template name="checkSelection">
                <xsl:with-param name="s" select="$excSt"/>
                <xsl:with-param name="rgId" select="./STATEID"/>
                </xsl:call-template>
                </xsl:variable>
                <xsl:if test="$isSelect = 'true'">
                    <xsl:value-of select="./STATE"/>,
                </xsl:if>
            </xsl:if>
           </xsl:for-each>
        </td>
     </tr>

  <tr>
      <TH align="left">Zip Codes:</TH>
    <TH colspan="5" align="left"><xsl:value-of select="Record/ZIPCODES" /></TH>
  </tr>

  <tr>
  <TH colspan="5" align="left"><hr noshade="true" size="1"/></TH>
  </tr>

  <tr>
      <TH align="left">Notes:</TH>
      <TD colspan="6" align="left"><textarea name="notes" rows="20" cols="80" readonly="true">
      <xsl:value-of select="Record/NOTES" />
      <xsl:value-of select="' '" />
    </textarea></TD>
    <!--  <TD colspan="5" align="left"> <xsl:value-of select="Record/NOTES" /><xsl:value-of select="' '" /></TD>-->
  </tr>

    </table>

<br></br>
<INPUT type="hidden" name='Menu' value="Create Order" />
<INPUT type="hidden" name='editviewflag' value="Y" />
<INPUT type="hidden" name='Page' value="Create Page" />
<input type="hidden" name='qFlag' value="{Record/QFLAG}" />
</center>
 </form>

* is a required field.
    </xsl:template>

</xsl:stylesheet>

