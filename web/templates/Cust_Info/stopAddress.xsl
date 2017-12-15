<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0"
    xmlns:xalan="http://xml.apache.org/xslt">

    <xsl:template match="Records">
<!--     <xsl:apply-templates select="Record"/> --> 

  <TITLE>D2W <xsl:value-of select="Title"/> </TITLE>

    <p><center><font color="#000099" size="4">Stop Address </font></center></p>

    <form action='/ListSales/servlet/Driver' method="POST" name="viewForm">
    <table>
  <tr><td>
    <TH align="left"><input type="checkbox" name="authorBox" /></TH>
        <TH align="left">Author Name:</TH>
    <TH align="left"><input type="text" name="authorName" /></TH>
    </td><td>
    </td><td>
    </td> <td>
    <TH align="left"><input type="checkbox" name="mainBox" /></TH>
      <TH align="left">Org :</TH>
      <TH align="left"><INPUT size="10" type="text" name="mainOrg" /></TH>
    </td> <td>
    </td><td>
    </td> <td>

    <TH align="left"><input type="checkbox" name="countryBox" /></TH>
    <TH align="left">Country :</TH> 
    <th align="left"><select name="countryId">
           <xsl:for-each select="Record">
           <xsl:if test="./COUNTRY">
           <option>
            <xsl:attribute name="value">
             <xsl:value-of select="./CNTRID" />
            </xsl:attribute>
            <xsl:value-of select="./COUNTRY" />
           </option>
           </xsl:if>
        </xsl:for-each>
      </select>
      </th>
    </td> <td>
    <TH align="left"><input type="checkbox" name="postalBox" /></TH>
      <TH align="left">Zip :</TH>
      <TH align="left"><INPUT size="10" type="text" name="postalCode" /></TH>
    </td></tr>
  </table>
  <center>
  <br></br>
    <input type="submit" value="Search" />
  </center>

  <xsl:if test="Record/ISSUENO">
    <br></br> 
    <table border="1">
  <tr><td>
     <TH align="left"><input type="checkbox" name="selectAll"/></TH> 
       <th><font size="-1">Author</font></th>
       <th><font size="-1">Org</font></th>
       <th><font size="-1">Sub Org</font></th>
       <th><font size="-1">Sub Org1</font></th>
       <th><font size="-1">Sub Org2</font></th>
       <th><font size="-1">Street</font></th>
       <th><font size="-1">City</font></th>
       <th><font size="-1">State</font></th>
       <th><font size="-1">Country</font></th>
       <th><font size="-1">Zip</font></th>

  </td></tr>


    <xsl:for-each select="Record">
    <xsl:if test="./ISSUENO">
        <xsl:variable name="rowIndexVal">
              <xsl:value-of select="./ISSUENO" />;<xsl:value-of select="./ITEMNO" />;<xsl:value-of select="./AUTHSEQ" />
            </xsl:variable>

  <tr><td>
       <TD align="left"><input type="checkbox" name="rowValueBox;{$rowIndexVal}"/> 
      </TD>
       <td><font size="-1"><xsl:value-of select="./AUTHORNAME"/></font><script type="text/javascript">putNbsp()</script></td>
       <td><font size="-1"><xsl:value-of select="./MAINORG"/></font><script type="text/javascript">putNbsp()</script></td>
       <td><font size="-1"><xsl:value-of select="./SUBORG"/></font><script type="text/javascript">putNbsp()</script></td>
       <td><font size="-1"><xsl:value-of select="./SUBORG1"/></font><script type="text/javascript">putNbsp()</script></td>
       <td><font size="-1"><xsl:value-of select="./SUBORG2"/></font><script type="text/javascript">putNbsp()</script></td>
       <td><font size="-1"><xsl:value-of select="./STREET"/></font><script type="text/javascript">putNbsp()</script></td>
       <td><font size="-1"><xsl:value-of select="./CITY"/></font><script type="text/javascript">putNbsp()</script></td>
       <td><font size="-1"><xsl:value-of select="./STATE"/></font><script type="text/javascript">putNbsp()</script></td>
       <td><font size="-1"><xsl:value-of select="./COUNTRY"/></font><script type="text/javascript">putNbsp()</script></td>
       <td><font size="-1"><xsl:value-of select="./POSTALCODE"/></font><script type="text/javascript">putNbsp()</script></td>

    </td></tr>
    </xsl:if>
    </xsl:for-each>
    </table>

    <br></br>
    <center>
    <input type="submit" value="Stop Address" />
  </center>
    </xsl:if>


    <input type="hidden" name='Menu' value="Stop Address Info" />
    <input type="hidden" name='Page' value="Stop Address Page" />
  <input type="hidden" name='qFlag' value="{Record/QFLAG}" />
    </form>

    </xsl:template>

</xsl:stylesheet>
