<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0"
    xmlns:xalan="http://xml.apache.org/xslt"
  xmlns:saxon="http://saxon.sf.net/" extension-element-prefixes="saxon">

  <xsl:param name="customerId"></xsl:param>
  <xsl:param name="orderDate"></xsl:param>
  <xsl:param name="orderDateEnd"></xsl:param>
  <xsl:param name="orderStatus"></xsl:param>
  <xsl:param name="exprStatus"></xsl:param>

<xsl:strip-space elements="COMPANYNAME"/>
<xsl:preserve-space elements="SEARCHID SEARCHDATE ADDRESSESFOUND EXTRACTEDTIME" />

    <xsl:template match="Records">

<!--     <xsl:apply-templates select="Record"/> -->

  <TITLE>D2W <xsl:value-of select="Title"/> </TITLE>

    <p><center><font color="#000099" size="4">Orders Summaries</font></center></p>

    <form action='/ListSales/servlet/Driver' method="POST" name="viewForm">


    <table>
  <xsl:variable name="cstVal">
          <xsl:value-of select="Record/CUSTOMERID" />
    </xsl:variable>
  <tr><td>
        <TH align="left">Company Name:</TH>
        <th align="left"><select name="customerId">
           <option name=""></option>
           <xsl:for-each select="Record">
           <xsl:if test="./CNAME">
           <option>
            <xsl:attribute name="value">
             <xsl:value-of select="./CID" />
            </xsl:attribute>
            <xsl:if test="./CID = $customerId">
               <xsl:attribute name="selected">true</xsl:attribute>
            </xsl:if>
             <xsl:value-of select="./CNAME" /> (<xsl:value-of select="./CID" />)
           </option>
           </xsl:if>
        </xsl:for-each>
      </select>
      </th>
    </td> <td>
      <TH align="left">Order Date(blank for today) -- From: </TH>
      <TH align="left">
        <INPUT size="10" type="text" id="orderDate" name="orderDate" value="{$orderDate}" /><br></br>ccyy-mm-dd</TH>

      <TH align="left">To: </TH>
      <TH align="left">
        <INPUT size="10" type="text" id="orderDateEnd" name="orderDateEnd" value="{$orderDateEnd}" /><br></br>ccyy-mm-dd</TH>

    </td> </tr>

  <tr> <td>
  </td><td>
  </td> </tr>


    <tr> <td>
    <TH align="left">Order Status:</TH>
    <th align="left"><select name="orderStatus">
      <option name=""></option>
    <xsl:variable name="stsVal">
          <xsl:value-of select="Record/ORDERSTATUS" />
        </xsl:variable>
    <option> <xsl:attribute name="value">N</xsl:attribute>
          <xsl:if test="'N' = $orderStatus">
            <xsl:attribute name="selected">true</xsl:attribute>
          </xsl:if>New</option>
        <option> <xsl:attribute name="value">P</xsl:attribute>
          <xsl:if test="'P' = $orderStatus">
            <xsl:attribute name="selected">true</xsl:attribute>
          </xsl:if>Profile</option>
    <option> <xsl:attribute name="value">S</xsl:attribute>
          <xsl:if test="'S' = $orderStatus">
            <xsl:attribute name="selected">true</xsl:attribute>
          </xsl:if>Search</option>
        <option> <xsl:attribute name="value">C</xsl:attribute>
          <xsl:if test="'C' = $orderStatus">
            <xsl:attribute name="selected">true</xsl:attribute>
          </xsl:if>Extracted</option>
    <option> <xsl:attribute name="value">F</xsl:attribute>
        <xsl:if test="'F' = $orderStatus">
          <xsl:attribute name="selected">true</xsl:attribute>
        </xsl:if>Failed</option>
    <option> <xsl:attribute name="value">R</xsl:attribute>
        <xsl:if test="'R' = $orderStatus">
          <xsl:attribute name="selected">true</xsl:attribute>
        </xsl:if>Ready to Search</option>
    </select>
      </th>
  </td><td>
      <TH align="left">Profile Status:</TH>
      <th align="left"><select name="exprStatus">
        <option name=""></option>
        <xsl:variable name="exprVal">
          <xsl:value-of select="Record/EXPRSTATUS" />
        </xsl:variable>
        <option> <xsl:attribute name="value">1</xsl:attribute>
          <xsl:if test="'1' = $exprStatus">
            <xsl:attribute name="selected">true</xsl:attribute>
          </xsl:if>Partial</option>
        <option> <xsl:attribute name="value">2</xsl:attribute>
          <xsl:if test="'2' = $exprStatus">
            <xsl:attribute name="selected">true</xsl:attribute>
          </xsl:if>Complete</option>
        <option> <xsl:attribute name="value">3</xsl:attribute>
          <xsl:if test="'3' = $exprStatus">
            <xsl:attribute name="selected">true</xsl:attribute>
          </xsl:if>Searched</option>
        <option> <xsl:attribute name="value">4</xsl:attribute>
          <xsl:if test="'4' = $exprStatus">
            <xsl:attribute name="selected">true</xsl:attribute>
          </xsl:if>Ordered</option>
        <option> <xsl:attribute name="value">5</xsl:attribute>
          <xsl:if test="'5' = $exprStatus">
            <xsl:attribute name="selected">true</xsl:attribute>
          </xsl:if>Extracted</option>
        </select>
      </th>

    </td></tr>
    <tr><td colspan="6"></td></tr>
  <tr><td>
    <TH colspan="3" align="left"><input type="button" value="Clear" onclick="javascript:clearViewOrderForm(document.viewForm);" /></TH>
    <TH colspan="3" align="left"><input type="submit" value="SUBMIT" onclick="javascript:return validateSubmission(document.viewForm);" /></TH>
   </td></tr>
  </table>

    <br></br>

  <xsl:if test="Record/ORDERID">
    <table border="2" cellspacing="2" cellpadding="2" >
  <tr>
       <th rowspan="2"><font size="-1">Company </font></th>
       <th rowspan="2"><font size="-1">Order Name/Number</font></th>
       <th><font size="-1">Contact</font></th>
       <th><font size="-1">Order Date</font></th>
       <th><font size="-1">Counts Wanted</font></th>
       <th rowspan="2"><font size="-1">Search Date</font></th>
       <th rowspan="2"><font size="-1">Search ID</font></th>
       <th rowspan="2"><font size="-1">12 Month Postal</font></th>
         <th rowspan="2"><font size="-1">3yr Email Count</font></th>
       <th rowspan="2"><font size="-1">Extraction Total</font></th>
       <th rowspan="2"><font size="-1">Extraction Date</font></th>
       <th rowspan="2"><font size="-1">Status</font></th>
       <th rowspan="2"><font size="-1">Create User</font></th>

  </tr>
  <tr>
      <th colspan="3"><font size="-1">Customer List Name</font></th>
  </tr>

  <xsl:variable name="prevOrder" select="''" saxon:assignable="yes"/>
  <xsl:variable name="newOrder" select="''" saxon:assignable="yes"/>
  <xsl:for-each select="Record">
        <xsl:if test="./ORDERID">

      <saxon:assign name="newOrder" select="./ORDERID"/>
      <xsl:if test="$newOrder != $prevOrder">
        <tr>
          <td align="left"> <font size="-1"><xsl:value-of select="./COMPANYNAME"/><br></br>(<xsl:value-of select="./CUSTOMERID"/>)</font><script type="text/javascript">putNbsp()</script></td>
          <td align="left"> <font size="-1"> <xsl:value-of select="./ORDERNAME"/> <br></br><A href="" onClick="goToOrderPage('{./ORDERID}'); return false"> <xsl:value-of select="./ORDERID"/></A></font><script type="text/javascript">putNbsp()</script></td>
          <td align="left" nowrap="true"> <font size="-1"><xsl:value-of select="./CONTACTLASTNAME"/>, <xsl:value-of select="./CONTACTFIRSTNAME"/></font><script type="text/javascript">putNbsp()</script></td>
          <td align="left" nowrap="true"> <font size="-1"><xsl:value-of select="./ORDERDATE"/></font><script type="text/javascript">putNbsp()</script></td>
          <td align="left"> <font size="-1"><xsl:value-of select="./WANTEDQTY"/></font><script type="text/javascript">putNbsp()</script></td>
          <td><script type="text/javascript">putNbsp()</script></td>
          <td><script type="text/javascript">putNbsp()</script></td>
          <td><script type="text/javascript">putNbsp()</script></td>
          <td><script type="text/javascript">putNbsp()</script></td>
          <td><script type="text/javascript">putNbsp()</script></td>
                    <td><script type="text/javascript">putNbsp()</script></td>
             <xsl:variable name="statusVal">
                   <xsl:value-of select="./ORDERSTATUS" />
                 </xsl:variable>
             <td align="left"><font size="-1">
              <xsl:if test="'N' = $statusVal">New</xsl:if>
              <xsl:if test="'P' = $statusVal">Profile</xsl:if>
              <xsl:if test="'S' = $statusVal">Search</xsl:if>
              <xsl:if test="'C' = $statusVal">Extracted</xsl:if>
              <xsl:if test="'R' = $statusVal">Ready to Search</xsl:if>
              <xsl:if test="'F' = $statusVal">Failed</xsl:if>
             </font><script type="text/javascript">putNbsp()</script></td>
                    <td align="left" nowrap="true"> <font size="-1">
                        <xsl:value-of select="./CREATE_USER"/></font>
                        <script type="text/javascript">putNbsp()</script>
                    </td>
        </tr>
          <saxon:assign name="prevOrder" select="./ORDERID"/>
      </xsl:if>
          <xsl:if test="./CLNID != ''">
        <tr>
        <td><script type="text/javascript">putNbsp()</script></td>
        <td><script type="text/javascript">putNbsp()</script></td>

        <xsl:choose>
          <xsl:when test="./EXPRSTATUS > 2">
            <td align="left" colspan="3" bgcolor="#FFFFCC" nowrap="true"> <font size="-1"><xsl:value-of select="./CUSTLISTNAME"/> <A href="" onClick="goToOrderResultsPage('{./ORDERID}', '{./SEARCHID}', '{./CLNID}'); return false"><br></br><xsl:value-of select="./CLNID"/></A></font><script type="text/javascript">putNbsp()</script></td>
          </xsl:when>

          <xsl:otherwise>
            <td align="left" colspan="3" bgcolor="#FFFFCC" nowrap="true"> <font size="-1"><xsl:value-of select="./CUSTLISTNAME"/> <br></br><xsl:value-of select="./CLNID"/></font><script type="text/javascript">putNbsp()</script></td>
          </xsl:otherwise>
                </xsl:choose>

        <td align="left" bgcolor="#FFFFCC" nowrap="true"> <font size="-1"><xsl:value-of select="./SEARCHDATE"/></font><script type="text/javascript">putNbsp()</script></td>
        <td align="left" bgcolor="#FFFFCC" nowrap="true"> <font size="-1"><xsl:value-of select="./SEARCHID"/></font><script type="text/javascript">putNbsp()</script></td>
        <td align="left" bgcolor="#FFFFCC" nowrap="true"> <font size="-1"><xsl:value-of select="./ADDRESSESFOUND"/></font><script type="text/javascript">putNbsp()</script></td>
                <td align="left" bgcolor="#FFFFCC" nowrap="true"> <font size="-1"><xsl:value-of select="./THREEYEARADDRESSES"/></font><script type="text/javascript">putNbsp()</script></td>
        <td align="left" bgcolor="#FFFFCC" nowrap="true"> <font size="-1"><xsl:value-of select="./ADDRESSESSHIPPED"/></font><script type="text/javascript">putNbsp()</script></td>
        <td align="left" bgcolor="#FFFFCC" nowrap="true"> <font size="-1"><xsl:value-of select="./EXTRACTDATE"/></font><script type="text/javascript">putNbsp()</script></td>
           <xsl:variable name="exprStatusVal">
                 <xsl:value-of select="./EXPRSTATUS" />
               </xsl:variable>
           <td align="left" bgcolor="#FFFFCC" nowrap="true">
          <font size="-1">
            <xsl:if test="'1' = $exprStatusVal">Partial</xsl:if>
            <xsl:if test="'2' = $exprStatusVal">Complete</xsl:if>
            <xsl:if test="'3' = $exprStatusVal">Searched</xsl:if>
            <xsl:if test="'4' = $exprStatusVal">Ordered</xsl:if>
            <xsl:if test="'5' = $exprStatusVal">Extracted</xsl:if>
             </font>
          <script type="text/javascript">putNbsp()</script>
        </td>
        <td align="left" bgcolor="#FFFFCC" nowrap="true"> <font size="-1">
          <xsl:value-of select="./CREATE_USER"/></font>
          <script type="text/javascript">putNbsp()</script>
        </td>
        </tr>
      </xsl:if>
    </xsl:if>
   </xsl:for-each>
  </table>

  </xsl:if>
    <br></br>
    <center>
    <input type="hidden" name='Menu' value="View Order Info" />
    <input type="hidden" name='Page' value="Orders Page" />
  <input type="hidden" name='qFlag' value="{Record/QFLAG}" />
  </center>
    </form>

   <script>
    $(function() {
      $( "#orderDate" ).datepicker({ dateFormat: "yy-mm-dd", changeMonth: true,  changeYear: true });
      $( "#orderDateEnd").datepicker({ dateFormat: "yy-mm-dd", changeMonth: true,  changeYear: true });
    });
  </script>

    </xsl:template>

</xsl:stylesheet>
