<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0"
    xmlns:xalan="http://xml.apache.org/xslt">


  <xsl:template match="Records">
     <!-- xsl:apply-templates select="Record" -->

  <TITLE>D2W <xsl:value-of select="Title"/> </TITLE>

    <p><center><font color="#000099" size="4"> Region Information </font></center></p>

   <form action='/ListSales/servlet/UpdateRegion' method="POST" name="RegionData">
<center>
<table>
  <tr><td>
      <TH>Region :</TH>
      <TH align="left"><select name="region" onchange="javascript:setCountriesInfo(document.RegionData)">
       <option name=""></option>
       <xsl:for-each select="Record">
         <xsl:if test="./REGIONID">
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

   </td><td>
   </td><td>
    <TH>Add a Region:</TH>
        <TH align="left"><input size="15" type="text" name="addRegion" /></TH>
     </td></tr>

   <tr><td>
     </td><td>
     </td><td>
    <TH><input type="button" onclick="javascript:addRegionInfo(document.RegionData)" value="&lt;&lt; Add Region &lt;&lt;" /></TH>
     </td><td>
     </td></tr>

   <tr><td>
     </td><td>
     </td><td>
    <TH><input type="button" onclick="javascript:addCountryInfo(document.RegionData)" value="&lt;&lt; Add Country &lt;&lt;" /></TH>
     </td><td>
     </td></tr>

     <tr>
     <td>
      <TH>Countries:</TH>
  <div id="cntLyr" style="visibility:hidden;position:relative;top:10;">
    <th align="left"><select name="country" MULTIPLE="true" size="8" >
      <xsl:for-each select="Record">
      <xsl:if test="./CNTID">
           <option>
            <xsl:attribute name="value">
             <xsl:value-of select="./CNTID" />|<xsl:value-of select="./REGID" />
            </xsl:attribute>
            <xsl:value-of select="./CNTR" />
           </option>
      </xsl:if>
        </xsl:for-each>
    </select>
    </th>
  </div>
   </td>
   <td>

  <input type="hidden" name="allCountriesInfo">
       <xsl:attribute name="value">
          <xsl:for-each select="Record">
      <xsl:if test="./CNTID">
             <xsl:value-of select="./CNTID" />^<xsl:value-of select="./CNTR" />|<xsl:value-of select="./REGID" />,
            </xsl:if>
          </xsl:for-each>
       </xsl:attribute>
  </input>

  <xsl:variable name="regCountry">
    <xsl:for-each select="Record">
        <xsl:if test="./REGIONID">
        <xsl:value-of select="./REGIONID" />|<xsl:value-of select="./COUNTRYID" />:
        </xsl:if>
    </xsl:for-each>
     </xsl:variable>
   <input type="hidden" name="regionCountry" value="{$regCountry}"/>


     </td><td>
    <TH>Add a Country:</TH>
        <TH align="left"><input size="15" type="text" name="addCountry" /></TH>
     </td></tr>

     <tr><td colspan="9" align="left">
  <div id="d1" style="position:relative; top:10; z-index: 10;"> </div>
     </td></tr>
</table>
<br></br>
<input type="reset" /> <input type="submit" value="SUBMIT" />
<input type="hidden" name='Menu' value="Regions" />
<input type="hidden" name='Page' value="Region Page" />
</center>
</form>

  </xsl:template>

</xsl:stylesheet>
