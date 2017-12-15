<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0"
    xmlns:xalan="http://xml.apache.org/xslt"
  xmlns:saxon="http://saxon.sf.net/" extension-element-prefixes="saxon">

    <xsl:template match="Records">
<!--    <xsl:apply-templates select="Record"/> -->

  <TITLE>D2W <xsl:value-of select="Title"/> </TITLE>

    <p><center><font color="#000099" size="4">Order Results </font></center></p>

    <form action='/ListSales/servlet/Driver' method="POST" name="resultsForm">

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



<!-- s1 -->

  <br></br><hr noshade="true"/>
     <input type="hidden" name="customerId" value="{Record/CUSTOMERID}" />
     <input type="hidden" name="contactId" value="{Record/CONTACTID}" />
    <table width="90%">
  <tr><td colspan="2">
    <font><b>Order Name :</b></font>
     <input type="hidden" name="orderId" value="{Record/ORDID}" />

 <!--   <INPUT size="15" type="text" name="orderName" value="{Record/ORDERNAME}+{Record/ORDID}"  onblur="isNotEmpty(this)"/></TH>-->
  <xsl:variable name="listVal">
          <xsl:value-of select="Record/ORDRID" />
    </xsl:variable>
        <td align="left"><font color="blue"><!--<select name="orderId" onchange="javascript:getOrderResults(document.resultsForm)" >
           <option name=""></option>-->
           <xsl:for-each select="Record">
           <xsl:if test="./ORDID">
<!--           <option>-->
            <xsl:attribute name="value">
             <xsl:value-of select="./ORDID" />
            </xsl:attribute>
            <xsl:if test="./ORDID = $listVal">
               <xsl:attribute name="selected">true</xsl:attribute>
            </xsl:if>
             <xsl:value-of select="./ORDERNAME" /> (<xsl:value-of select="./ORDID" />)
       <input type="hidden" name="ord_Name" value="{./ORDERNAME}({./ORDID})"/>
        <!--   </option>-->
           </xsl:if>
        </xsl:for-each>
    <!--  </select>-->
      </font></td>
    </td> <td colspan="2">
    <font><b>Search ID:</b></font>
     <input type="hidden" name="searchId" value="{Record/SRCID}" />
  <input type="hidden" name="searchIdList" value="{Record/SRCID}" />
    <!-- <TH align="left"><INPUT size="15"  type="text" name="searchId" value="{./SEARCHID}"   readonly="true" /></TH>-->

  <td align="left">
  <!--<select name="searchIdList" onchange="javascript:getSearchResults(document.resultsForm)">-->
<!--           <option name=""></option>-->
    <xsl:variable name="srchIdVal">
          <xsl:value-of select="Record/SRCID" />
  </xsl:variable>
    <font color="blue"><xsl:value-of select="$srchIdVal" /></font>
    <xsl:for-each select="Record">
    <xsl:if test="./SEARCHID">
          <!-- <option>-->
            <xsl:attribute name="value">
             <xsl:value-of select="./SEARCHID" />
            </xsl:attribute>
            <xsl:if test="./SEARCHID = $srchIdVal">
    <xsl:attribute name="selected">true</xsl:attribute>

       </xsl:if>

            <!-- <xsl:value-of select="./SEARCHID" />-->
           <!--</option>-->

           </xsl:if>

        </xsl:for-each>

    <!--</select>-->
      </td>


    </td> <td colspan="2">
    <font ><b>Customer List Name :</b></font>
     <input type="hidden" name="clnId" value="{Record/CLNID}" />
     <!--<input type="hidden" name="clnIdList" value="{Record/CLNID}" />-->

  <!--<INPUT size="15" type="text" name="clnId" value="{./CUSTLISTNAME}"  readonly="true" />  -->


<td align="left">
<!--<select name="clnIdList" onchange="getProfileResults(document.resultsForm)"> -->
<!--           <option name=""></option>-->
        <xsl:variable name="clnIdVal">
          <xsl:value-of select="Record/CLID" />
        </xsl:variable>
        <xsl:for-each select="Record">
        <xsl:if test="./CUSTLISTNAME">
    <!--       <option>-->
            <xsl:attribute name="value">
             <xsl:value-of select="./CLNID" />
            </xsl:attribute>
            <xsl:if test="./CLNID = $clnIdVal">
               <xsl:attribute name="selected">true</xsl:attribute>
    <font color="blue"><xsl:value-of select="./CUSTLISTNAME" />(<xsl:value-of select="./CLNID" />)</font>
    <input type="hidden" name="clnIdList" value="{./CLNID}" />
    <input type="hidden" name="cust_id_name" value="{./CUSTLISTNAME} ({./CLNID})" />
         <!--<INPUT  type="text" name="clnId" value="{./CUSTLISTNAME}"  readonly="true" />-->
            </xsl:if>
           <!--  <xsl:value-of select="./CUSTLISTNAME" />-->
<!--           </option>-->
           </xsl:if>
        </xsl:for-each>
    <!--    </select>-->
      </td>

    </td><td colspan="2">
    <TH align="left"><font  color="red">Extract:</font></TH>
    <input type="hidden" name="extractSrcId" value="{Record/CLID}" />
        <th align="left"><input type="checkbox" name="extract">
              <xsl:if test="Record/MARKTOEXTRACT = 'Y'">
        <xsl:attribute name="checked">true</xsl:attribute>
                <xsl:if test="Record/EXPRSTATUS = '5'">
          <xsl:attribute name="disabled">true</xsl:attribute>
                </xsl:if>
              </xsl:if>
    </input></th>
    </td></tr>

    </table>

   <br></br>
  <table>
  <tr>
    <th></th>
    <TD align="left"><font ><b> CompanyName :</b></font> </TD> <TD><font> <xsl:value-of select="Record/COMPANYNAME"/>(<xsl:value-of select="Record/CUSTOMERID" />)</font><input type="hidden" name="cmp_name" value="{Record/COMPANYNAME}({Record/CUSTOMERID})" /></TD>
    <TD align="left"><font ><b>Contact :</b></font> </TD> <TD><font> <xsl:value-of select="Record/CONTACTLASTNAME"/>
    <xsl:if test="Record/CONTACTLASTNAME">, </xsl:if> <xsl:value-of select="Record/CONTACTFIRSTNAME"/></font><input type="hidden" name="cnt_name" value="{Record/CONTACTLASTNAME},{Record/CONTACTFIRSTNAME}" /></TD>

  </tr>

    </table>
   <br></br>


<!-- r1 -->



    <table>
  <tr>
      <TH align="left"><font >Order Status:</font></TH>
      <TH align="left"><font >Order Date:</font></TH>
      <!--  <TH align="left"><font >Required Date:</font></TH>-->
  <!-- <TH align="left"><font >Promised Date:</font></TH>-->
        <TH align="left"><font >Counts Wanted:</font></TH>
        <TH align="left"><font >Ordered:</font></TH>
        <TH align="left"><font >Ship Date:</font></TH>
        <TH align="left"><font >Ship Method:</font></TH>
  </tr>

  <tr>
    <td align="left">
    <xsl:variable name="stsVal">
          <xsl:value-of select="Record/ORDERSTATUS" />
        </xsl:variable>
          <xsl:if test="'N' = $stsVal">
      New
          </xsl:if>
          <xsl:if test="'P' = $stsVal">
      Profile
          </xsl:if>
          <xsl:if test="'S' = $stsVal">
      Search
          </xsl:if>
          <xsl:if test="'C' = $stsVal">
      Extract
          </xsl:if>
      <xsl:if test="'R' = $stsVal">
        Ready to Search
      </xsl:if>
      <xsl:if test="'F' = $stsVal">
        Failed
      </xsl:if>
      <script type="text/javascript">putNbsp()</script></td>

      <td align="left"><xsl:value-of select="Record/ORDERDATE"/><script type="text/javascript">putNbsp()</script></td>
      <!--<td align="left"><xsl:value-of select="Record/REQUIREDBYDATE"/><script type="text/javascript">putNbsp()</script></td>-->
<!--      <td align="left"><xsl:value-of select="Record/PROMISEDBYDATE"/><script type="text/javascript">putNbsp()</script></td>-->
      <td align="left"><xsl:value-of select="Record/WANTEDQTY"/><script type="text/javascript">putNbsp()</script></td>
      <td align="left"><xsl:value-of select="Record/ADDRESSESSHIPPED"/><script type="text/javascript">putNbsp()</script></td>
      <td align="left"><xsl:value-of select="Record/SHIPDATE"/><script type="text/javascript">putNbsp()</script></td>
      <td align="left"><xsl:value-of select="Record/SHIPMETHOD"/><script type="text/javascript">putNbsp()</script></td>
   </tr>
  </table>

  <br></br><hr noshade="true"/>


<!-- r2 -->



  <table>
  <tr>
    <td class="titleClass"><b>Order Split List :</b></td>
    <th width="7%"></th>
        <TH align="left"><input type="checkbox" name="academic" value='A'>
      <xsl:variable name="acdVal">
              <xsl:value-of select="Record/ACADNONACAD" />
          </xsl:variable>
          <xsl:if test="'A' = $acdVal">
              <xsl:attribute name="checked">true</xsl:attribute>
          </xsl:if>
    </input></TH>
    <TH class="titleClass">Academic/Non Academic:</TH>
    <th width="7%"></th>
    <TH class="titleClass">Email to:</TH>
        <TH align="left"><input type="text" name="deliveryMail" size="25" value="{Record/DELIVERYEMAIL}"></input></TH>

      <TH class="titleClass">Keycode:</TH>
        <TH align="left"><input type="text" name="keycode" size="7" value="{Record/KEYCODE}"></input></TH>

  </tr>
  <tr>
    <th></th>
    <th width="7%"></th>
        <TH align="left"><input type="checkbox" name="domestic" value='D'>
      <xsl:variable name="dmsVal">
              <xsl:value-of select="Record/DOMROW" />
          </xsl:variable>
          <xsl:if test="'D' = $dmsVal">
              <xsl:attribute name="checked">true</xsl:attribute>
          </xsl:if>
    </input></TH>
    <Td class="titleClass"><b>Domestic/ROW:</b></Td>
  </tr>

  </table>



  <xsl:variable name="selOrg">
       <xsl:value-of select="Record/SUPPRESSORG" />
    </xsl:variable>

  <xsl:variable name="numOfColumns">
    <xsl:if test="$selOrg = '0'">9</xsl:if>
    <xsl:if test="$selOrg != '0'">1</xsl:if>
  </xsl:variable>

    <br></br>


  <div class="breakdownBox">
  <xsl:if test="Record/CNTTYPE='D' or Record/CNTTYPE='F' or Record/CNTTYPE='T' or Record/CNTTYPE='3' or Record/CNTTYPE='6' or Record/CNTTYPE='9' or Record/CNTTYPE='X' or Record/CNTTYPE='Y' or Record/CNTTYPE='W'">
 <TABLE class="summaryTable"  border="1" cellpadding="1" cellspacing="1">

  <tr>
    <th rowspan="3"> </th>
            <th class="titleClass" colspan="18">Postal (
            <input type="checkbox" name="includeEmail" value="I" onclick="selectIncludeEmail(document.resultsForm, this)">
            <xsl:variable name="inclVal">
                <xsl:value-of select="Record/INCEMAIL" />
            </xsl:variable>
            <xsl:if test="'I' = $inclVal">
                <xsl:attribute name="checked">true</xsl:attribute>
            </xsl:if>
            </input> Include Email)</th>
  </tr>

  <tr>
      <th align="center" colspan="{$numOfColumns}"> Results </th>
      <th align="center" colspan="{$numOfColumns}"> Ordered </th>
  </tr>

  <tr>
          <xsl:if test="$selOrg = '0' or $selOrg = '1'">
             <th class="titleClass">Academic</th>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '2'">
             <th class="titleClass">Non-Acad</th>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '3'">
             <th class="titleClass">All</th>
          </xsl:if>
          <xsl:if test="$selOrg = '0'">
             <th class="titleClass">3 Months</th>
             <th class="titleClass">6 Months</th>
             <th class="titleClass">9 Months</th>
             <th class="titleClass">12 Months</th>
             <th class="titleClass">18 Months</th>
             <th class="titleClass">24 Months</th>
          </xsl:if>
      <xsl:if test="$selOrg = '0' or $selOrg = '1'">
             <th class="titleClass">Academic</th>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '2'">
             <th class="titleClass">Non-Acad</th>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '3'">
             <th class="titleClass">All</th>
          </xsl:if>
          <xsl:if test="$selOrg = '0'">
             <th class="titleClass">3 Months</th>
             <th class="titleClass">6 Months</th>
             <th class="titleClass">9 Months</th>
             <th class="titleClass">12 Months</th>
             <th class="titleClass">18 Months</th>
             <th class="titleClass">24 Months</th>
          </xsl:if>
  </tr>

  <xsl:variable name="acadKey" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="nonAcadKey" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="allKey" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="threeKey" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="sixKey" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="nineKey" select="'0'" saxon:assignable="yes"/>
    <xsl:variable name="_12Key" select="'0'" saxon:assignable="yes"/>
    <xsl:variable name="_18Key" select="'0'" saxon:assignable="yes"/>
    <xsl:variable name="_24Key" select="'0'" saxon:assignable="yes"/>

  <xsl:variable name="acadKeyReq" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="nonAcadKeyReq" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="allKeyReq" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="threeKeyReq" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="sixKeyReq" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="nineKeyReq" select="'0'" saxon:assignable="yes"/>
    <xsl:variable name="_12KeyReq" select="'0'" saxon:assignable="yes"/>
    <xsl:variable name="_18KeyReq" select="'0'" saxon:assignable="yes"/>
    <xsl:variable name="_24KeyReq" select="'0'" saxon:assignable="yes"/>

  <xsl:variable name="acadKeyReqNm" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="nonAcadKeyReqNm" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="allKeyReqNm" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="threeKeyReqNm" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="sixKeyReqNm" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="nineKeyReqNm" select="'0'" saxon:assignable="yes"/>
    <xsl:variable name="_12KeyReqNm" select="'0'" saxon:assignable="yes"/>
    <xsl:variable name="_18KeyReqNm" select="'0'" saxon:assignable="yes"/>
    <xsl:variable name="_24KeyReqNm" select="'0'" saxon:assignable="yes"/>


  <xsl:variable name="firstTime" select="'1'" saxon:assignable="yes"/>
  <xsl:variable name="currCNT" select="''" saxon:assignable="yes"/>
  <xsl:variable name="prevCNT" select="''" saxon:assignable="yes"/>
     <xsl:variable name="prevCNTTYPE" select="''" saxon:assignable="yes"/>

  <xsl:variable name="recordKey" select="''" saxon:assignable="yes"/>
  <xsl:variable name="prefixKey" select="'DOMESFOREIGN'" saxon:assignable="yes"/>

<!-- p1 -->

<!-- This Block and loop is for the Domestic, Foriegn, etc for Postal -->

  <xsl:for-each select="Record">
  <xsl:if test="./CNTTYPE='D' or ./CNTTYPE='F' or ./CNTTYPE='T' or ./CNTTYPE='3' or ./CNTTYPE='6' or ./CNTTYPE='9' or ./CNTTYPE='X' or ./CNTTYPE='Y' or ./CNTTYPE='W'">

    <xsl:if test="$firstTime = '1'">
      <saxon:assign name="prevCNT" select="./CNTNAME"/>
            <saxon:assign name="prevCNTTYPE" select="./CNTTYPE"/>
      <saxon:assign name="firstTime" select="'2'"/>
    </xsl:if>

    <saxon:assign name="currCNT" select="./CNTNAME"/>

<!-- After I have read all the rows from the table, I put them here in 1 Row -->
    <xsl:if test="$currCNT != $prevCNT">

      <tr>
          <th class="titleClass"><xsl:value-of select="$prevCNT"/></th>

      <xsl:if test="$selOrg = '0' or $selOrg = '1'">
          <td class="sumClass"><xsl:value-of select="$acadKey"/></td>
      </xsl:if>

      <xsl:if test="$selOrg = '0' or $selOrg = '2'">
          <td class="sumClass"><xsl:value-of select="$nonAcadKey"/></td>
      </xsl:if>

      <xsl:if test="$selOrg = '0' or $selOrg = '3'">
          <td class="sumClass"><xsl:value-of select="$allKey"/></td>
      </xsl:if>

      <xsl:if test="$selOrg = '0'">
              <xsl:choose>
                  <xsl:when test="$prevCNTTYPE='D' or $prevCNTTYPE='F'">
          <td class="sumClass"><xsl:value-of select="$threeKey"/></td>
          <td class="sumClass"><xsl:value-of select="$sixKey"/></td>
          <td class="sumClass"><xsl:value-of select="$nineKey"/></td>
             <td class="sumClass"><xsl:value-of select="$_12Key"/></td>
             <td class="sumClass"><xsl:value-of select="$_18Key"/></td>
             <td class="sumClass"><xsl:value-of select="$_24Key"/></td>
              </xsl:when>
              <xsl:otherwise>
                  <td class="sumClass"><script type="text/javascript">putNbsp()</script></td>
                  <td class="sumClass"><script type="text/javascript">putNbsp()</script></td>
                  <td class="sumClass"><script type="text/javascript">putNbsp()</script></td>
                  <td class="sumClass"><script type="text/javascript">putNbsp()</script></td>
                  <td class="sumClass"><script type="text/javascript">putNbsp()</script></td>
                  <td class="sumClass"><script type="text/javascript">putNbsp()</script></td>
              </xsl:otherwise>
              </xsl:choose>
      </xsl:if>

      <xsl:if test="$selOrg = '0' or $selOrg = '1'">
        <xsl:choose>
        <xsl:when test="$acadKey != '0'">
              <td ><input size="5" type="text" name="{$acadKeyReqNm}"  value="{$acadKeyReq}"/></td>
           <input type="hidden" name='cntName' value="{$acadKeyReqNm}" />
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>

      </xsl:if>

      <xsl:if test="$selOrg = '0' or $selOrg = '2'">
        <xsl:choose>
        <xsl:when test="$nonAcadKey != '0'">
              <td><input size="5" type="text" name="{$nonAcadKeyReqNm}"  value="{$nonAcadKeyReq}"/></td>
           <input type="hidden" name='cntName' value="{$nonAcadKeyReqNm}" />
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
      </xsl:if>

      <xsl:if test="$selOrg = '0' or $selOrg = '3'">
        <xsl:choose>
        <xsl:when test="$allKey != '0'">
              <td ><input size="5" type="text" name="{$allKeyReqNm}"  value="{$allKeyReq}"/></td>
           <input type="hidden" name='cntName' value="{$allKeyReqNm}" />
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
      </xsl:if>

      <xsl:if test="$selOrg = '0'">
        <xsl:choose>
        <xsl:when test="$threeKey != '0'">
              <td ><input size="5" type="text" name="{$threeKeyReqNm}"  value="{$threeKeyReq}"/></td>
           <input type="hidden" name='cntName' value="{$threeKeyReqNm}" />
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
        <xsl:choose>
        <xsl:when test="$sixKey != '0'">
              <td ><input size="5" type="text" name="{$sixKeyReqNm}"  value="{$sixKeyReq}"/></td>
           <input type="hidden" name='cntName' value="{$sixKeyReqNm}" />
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
        <xsl:choose>
        <xsl:when test="$nineKey != '0'">
              <td ><input size="5" type="text" name="{$nineKeyReqNm}"  value="{$nineKeyReq}"/></td>
           <input type="hidden" name='cntName' value="{$nineKeyReqNm}" />
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
              <xsl:choose>
              <xsl:when test="$_12Key != '0'">
                      <td ><input size="5" type="text" name="{$_12KeyReqNm}"  value="{$_12KeyReq}"/></td>
                   <input type="hidden" name='cntName' value="{$_12KeyReqNm}" />
              </xsl:when>
              <xsl:otherwise>
                  <td><script type="text/javascript">putNbsp()</script> </td>
              </xsl:otherwise>
              </xsl:choose>
              <xsl:choose>
              <xsl:when test="$_18Key != '0'">
                      <td ><input size="5" type="text" name="{$_18KeyReqNm}"  value="{$_18KeyReq}"/></td>
                   <input type="hidden" name='cntName' value="{$_18KeyReqNm}" />
              </xsl:when>
              <xsl:otherwise>
                  <td><script type="text/javascript">putNbsp()</script> </td>
              </xsl:otherwise>
              </xsl:choose>
              <xsl:choose>
              <xsl:when test="$_24Key != '0'">
                      <td ><input size="5" type="text" name="{$_24KeyReqNm}"  value="{$_24KeyReq}"/></td>
                   <input type="hidden" name='cntName' value="{$_24KeyReqNm}" />
              </xsl:when>
              <xsl:otherwise>
                  <td><script type="text/javascript">putNbsp()</script> </td>
              </xsl:otherwise>
              </xsl:choose>
      </xsl:if>

      </tr>

      <!-- Re Initialize all Values -->
      <saxon:assign name="acadKey" select="'0'"/>
      <saxon:assign name="nonAcadKey" select="'0'"/>
      <saxon:assign name="allKey" select="'0'"/>
      <saxon:assign name="threeKey" select="'0'"/>
      <saxon:assign name="sixKey" select="'0'"/>
      <saxon:assign name="nineKey" select="'0'"/>
            <saxon:assign name="_12Key" select="'0'"/>
            <saxon:assign name="_18Key" select="'0'"/>
            <saxon:assign name="_24Key" select="'0'"/>

      <saxon:assign name="acadKeyReqNm" select="'0'"/>
      <saxon:assign name="nonAcadKeyReqNm" select="'0'"/>
      <saxon:assign name="allKeyReqNm" select="'0'"/>
      <saxon:assign name="threeKeyReqNm" select="'0'"/>
      <saxon:assign name="sixKeyReqNm" select="'0'"/>
      <saxon:assign name="nineKeyReqNm" select="'0'"/>
            <saxon:assign name="_12KeyReqNm" select="'0'"/>
            <saxon:assign name="_18KeyReqNm" select="'0'"/>
            <saxon:assign name="_24KeyReqNm" select="'0'"/>

      <saxon:assign name="acadKeyReq" select="'0'"/>
      <saxon:assign name="nonAcadKeyReq" select="'0'"/>
      <saxon:assign name="allKeyReq" select="'0'"/>
      <saxon:assign name="threeKeyReq" select="'0'"/>
      <saxon:assign name="sixKeyReq" select="'0'"/>
      <saxon:assign name="nineKeyReq" select="'0'"/>
            <saxon:assign name="_12KeyReq" select="'0'"/>
            <saxon:assign name="_18KeyReq" select="'0'"/>
            <saxon:assign name="_24KeyReq" select="'0'"/>

      <saxon:assign name="recordKey" select="''"/>

      <saxon:assign name="prevCNT" select="./CNTNAME"/>
            <saxon:assign name="prevCNTTYPE" select="./CNTTYPE"/>
    </xsl:if>

<!-- Read the values of the 6 or 3 or 1 row from the table and save it in the variables -->

    <xsl:if test="./CNTCATG = 'A'">
      <saxon:assign name="acadKey" select="./PCNTVALUE" />
      <saxon:assign name="acadKeyReq" select="./PCNTSREQUIRED" />
      <saxon:assign name="acadKeyReqNm" select="concat ($prefixKey, ';', 'DMFR', ';', 'ACAD', ';', 'PSTKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
    </xsl:if>
    <xsl:if test="./CNTCATG = 'N'">
      <saxon:assign name="nonAcadKey" select="./PCNTVALUE" />
      <saxon:assign name="nonAcadKeyReq" select="./PCNTSREQUIRED" />
      <saxon:assign name="nonAcadKeyReqNm" select="concat ($prefixKey, ';', 'DMFR', ';', 'NONACD', ';', 'PSTKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
    </xsl:if>
    <xsl:if test="./CNTCATG = 'T'">
      <saxon:assign name="allKey" select="./PCNTVALUE" />
      <saxon:assign name="allKeyReq" select="./PCNTSREQUIRED" />
      <saxon:assign name="allKeyReqNm" select="concat ($prefixKey, ';', 'DMFR', ';', 'ALLTOTAL', ';', 'PSTKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
    </xsl:if>
    <xsl:if test="./CNTCATG = '3'">
      <saxon:assign name="threeKey" select="./PCNTVALUE" />
      <saxon:assign name="threeKeyReq" select="./PCNTSREQUIRED" />
      <saxon:assign name="threeKeyReqNm" select="concat ($prefixKey, ';', 'DMFR', ';', '3TOTAL', ';', 'PSTKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
    </xsl:if>
    <xsl:if test="./CNTCATG = '6'">
      <saxon:assign name="sixKey" select="./PCNTVALUE" />
      <saxon:assign name="sixKeyReq" select="./PCNTSREQUIRED" />
      <saxon:assign name="sixKeyReqNm" select="concat ($prefixKey, ';', 'DMFR', ';', '6TOTAL', ';', 'PSTKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
    </xsl:if>
    <xsl:if test="./CNTCATG = '9'">
      <saxon:assign name="nineKey" select="./PCNTVALUE" />
      <saxon:assign name="nineKeyReq" select="./PCNTSREQUIRED" />
      <saxon:assign name="nineKeyReqNm" select="concat ($prefixKey, ';', 'DMFR', ';', '9TOTAL', ';', 'PSTKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
    </xsl:if>
        <xsl:if test="./CNTCATG = 'X'">
            <saxon:assign name="_12Key" select="./PCNTVALUE" />
            <saxon:assign name="_12KeyReq" select="./PCNTSREQUIRED" />
            <saxon:assign name="_12KeyReqNm" select="concat ($prefixKey, ';', 'DMFR', ';', '12TOTAL', ';', 'PSTKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
        </xsl:if>
        <xsl:if test="./CNTCATG = 'Y'">
            <saxon:assign name="_18Key" select="./PCNTVALUE" />
            <saxon:assign name="_18KeyReq" select="./PCNTSREQUIRED" />
            <saxon:assign name="_18KeyReqNm" select="concat ($prefixKey, ';', 'DMFR', ';', '18TOTAL', ';', 'PSTKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
        </xsl:if>
        <xsl:if test="./CNTCATG = 'W'">
            <saxon:assign name="_24Key" select="./PCNTVALUE" />
            <saxon:assign name="_24KeyReq" select="./PCNTSREQUIRED" />
            <saxon:assign name="_24KeyReqNm" select="concat ($prefixKey, ';', 'DMFR', ';', '24TOTAL', ';', 'PSTKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
    </xsl:if>

  </xsl:if>
  </xsl:for-each>


      <tr>
          <th class="titleClass"><xsl:value-of select="$prevCNT"/></th>

      <xsl:if test="$selOrg = '0' or $selOrg = '1'">
          <td class="sumClass"><xsl:value-of select="$acadKey"/></td>
      </xsl:if>

      <xsl:if test="$selOrg = '0' or $selOrg = '2'">
          <td class="sumClass"><xsl:value-of select="$nonAcadKey"/></td>
      </xsl:if>

      <xsl:if test="$selOrg = '0' or $selOrg = '3'">
          <td class="sumClass"><xsl:value-of select="$allKey"/></td>
      </xsl:if>

      <xsl:if test="$selOrg = '0'">
              <xsl:choose>
              <xsl:when test="$prevCNTTYPE='D' or $prevCNTTYPE='F'">
          <td class="sumClass"><xsl:value-of select="$threeKey"/></td>
          <td class="sumClass"><xsl:value-of select="$sixKey"/></td>
          <td class="sumClass"><xsl:value-of select="$nineKey"/></td>
              <td class="sumClass"><xsl:value-of select="$_12Key"/></td>
              <td class="sumClass"><xsl:value-of select="$_18Key"/></td>
              <td class="sumClass"><xsl:value-of select="$_24Key"/></td>
              </xsl:when>
              <xsl:otherwise>
                  <td class="sumClass"><script type="text/javascript">putNbsp()</script></td>
                  <td class="sumClass"><script type="text/javascript">putNbsp()</script></td>
                  <td class="sumClass"><script type="text/javascript">putNbsp()</script></td>
                  <td class="sumClass"><script type="text/javascript">putNbsp()</script></td>
                  <td class="sumClass"><script type="text/javascript">putNbsp()</script></td>
                  <td class="sumClass"><script type="text/javascript">putNbsp()</script></td>
              </xsl:otherwise>
              </xsl:choose>
      </xsl:if>

      <xsl:if test="$selOrg = '0' or $selOrg = '1'">
        <xsl:choose>
        <xsl:when test="$acadKey != '0'">
              <td ><input size="5" type="text" name="{$acadKeyReqNm}"  value="{$acadKeyReq}"/></td>
           <input type="hidden" name='cntName' value="{$acadKeyReqNm}" />
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
      </xsl:if>

      <xsl:if test="$selOrg = '0' or $selOrg = '2'">
        <xsl:choose>
        <xsl:when test="$nonAcadKey != '0'">
              <td ><input size="5" type="text" name="{$nonAcadKeyReqNm}"  value="{$nonAcadKeyReq}"/></td>
           <input type="hidden" name='cntName' value="{$nonAcadKeyReqNm}" />
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
      </xsl:if>

      <xsl:if test="$selOrg = '0' or $selOrg = '3'">
        <xsl:choose>
        <xsl:when test="$allKey != '0'">
              <td ><input size="5" type="text" name="{$allKeyReqNm}"  value="{$allKeyReq}"/></td>
           <input type="hidden" name='cntName' value="{$allKeyReqNm}" />
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
      </xsl:if>

      <xsl:if test="$selOrg = '0'">
        <xsl:choose>
        <xsl:when test="$threeKey != '0'">
              <td ><input size="5" type="text" name="{$threeKeyReqNm}"  value="{$threeKeyReq}"/></td>
           <input type="hidden" name='cntName' value="{$threeKeyReqNm}" />
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
        <xsl:choose>
        <xsl:when test="$sixKey != '0'">
              <td ><input size="5" type="text" name="{$sixKeyReqNm}"  value="{$sixKeyReq}"/></td>
           <input type="hidden" name='cntName' value="{$sixKeyReqNm}" />
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
        <xsl:choose>
        <xsl:when test="$nineKey != '0'">
              <td ><input size="5" type="text" name="{$nineKeyReqNm}"  value="{$nineKeyReq}"/></td>
           <input type="hidden" name='cntName' value="{$nineKeyReqNm}" />
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
              <xsl:choose>
              <xsl:when test="$_12Key != '0'">
                      <td ><input size="5" type="text" name="{$_12KeyReqNm}"  value="{$_12KeyReq}"/></td>
                   <input type="hidden" name='cntName' value="{$_12KeyReqNm}" />
              </xsl:when>
              <xsl:otherwise>
                  <td><script type="text/javascript">putNbsp()</script> </td>
              </xsl:otherwise>
              </xsl:choose>
              <xsl:choose>
              <xsl:when test="$_18Key != '0'">
                      <td ><input size="5" type="text" name="{$_18KeyReqNm}"  value="{$_18KeyReq}"/></td>
                   <input type="hidden" name='cntName' value="{$_18KeyReqNm}" />
              </xsl:when>
              <xsl:otherwise>
                  <td><script type="text/javascript">putNbsp()</script> </td>
              </xsl:otherwise>
              </xsl:choose>
              <xsl:choose>
              <xsl:when test="$_24Key != '0'">
                      <td ><input size="5" type="text" name="{$_24KeyReqNm}"  value="{$_24KeyReq}"/></td>
                   <input type="hidden" name='cntName' value="{$_24KeyReqNm}" />
              </xsl:when>
              <xsl:otherwise>
                  <td><script type="text/javascript">putNbsp()</script> </td>
              </xsl:otherwise>
              </xsl:choose>
      </xsl:if>

      </tr>


    </TABLE>
  </xsl:if>

    <br></br><br></br>


<!-- Unknown countries loop must produce some hidden inputs -->
        <xsl:if test="Record/CNTTYPE='U'">

            <xsl:variable name="acadKey" select="'0'" saxon:assignable="yes"/>
            <xsl:variable name="nonAcadKey" select="'0'" saxon:assignable="yes"/>
            <xsl:variable name="allKey" select="'0'" saxon:assignable="yes"/>
            <xsl:variable name="threeKey" select="'0'" saxon:assignable="yes"/>
            <xsl:variable name="sixKey" select="'0'" saxon:assignable="yes"/>
            <xsl:variable name="nineKey" select="'0'" saxon:assignable="yes"/>
            <xsl:variable name="_12Key" select="'0'" saxon:assignable="yes"/>
            <xsl:variable name="_18Key" select="'0'" saxon:assignable="yes"/>
            <xsl:variable name="_24Key" select="'0'" saxon:assignable="yes"/>

            <xsl:variable name="acadKeyReq" select="'0'" saxon:assignable="yes"/>
            <xsl:variable name="nonAcadKeyReq" select="'0'" saxon:assignable="yes"/>
            <xsl:variable name="allKeyReq" select="'0'" saxon:assignable="yes"/>
            <xsl:variable name="threeKeyReq" select="'0'" saxon:assignable="yes"/>
            <xsl:variable name="sixKeyReq" select="'0'" saxon:assignable="yes"/>
            <xsl:variable name="nineKeyReq" select="'0'" saxon:assignable="yes"/>
            <xsl:variable name="_12KeyReq" select="'0'" saxon:assignable="yes"/>
            <xsl:variable name="_18KeyReq" select="'0'" saxon:assignable="yes"/>
            <xsl:variable name="_24KeyReq" select="'0'" saxon:assignable="yes"/>

            <xsl:variable name="acadKeyReqNm" select="'0'" saxon:assignable="yes"/>
            <xsl:variable name="nonAcadKeyReqNm" select="'0'" saxon:assignable="yes"/>
            <xsl:variable name="allKeyReqNm" select="'0'" saxon:assignable="yes"/>
            <xsl:variable name="threeKeyReqNm" select="'0'" saxon:assignable="yes"/>
            <xsl:variable name="sixKeyReqNm" select="'0'" saxon:assignable="yes"/>
            <xsl:variable name="nineKeyReqNm" select="'0'" saxon:assignable="yes"/>
            <xsl:variable name="_12KeyReqNm" select="'0'" saxon:assignable="yes"/>
            <xsl:variable name="_18KeyReqNm" select="'0'" saxon:assignable="yes"/>
            <xsl:variable name="_24KeyReqNm" select="'0'" saxon:assignable="yes"/>


            <xsl:variable name="firstTime" select="'1'" saxon:assignable="yes"/>
            <xsl:variable name="currCNT" select="''" saxon:assignable="yes"/>
            <xsl:variable name="prevCNT" select="''" saxon:assignable="yes"/>

            <xsl:variable name="recordKey" select="''" saxon:assignable="yes"/>
            <xsl:variable name="prefixKey" select="'DOMESFOREIGN'" saxon:assignable="yes"/>

        <xsl:for-each select="Record">
        <xsl:if test="./CNTTYPE='U'">

            <xsl:if test="./CNTCATG = 'A'">
                <saxon:assign name="acadKey" select="./PCNTVALUE" />
                <saxon:assign name="acadKeyReq" select="./PCNTSREQUIRED" />
                <saxon:assign name="acadKeyReqNm" select="concat ($prefixKey, ';', 'DMFR', ';', 'ACAD', ';', 'PSTKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
            </xsl:if>
            <xsl:if test="./CNTCATG = 'N'">
                <saxon:assign name="nonAcadKey" select="./PCNTVALUE" />
                <saxon:assign name="nonAcadKeyReq" select="./PCNTSREQUIRED" />
                <saxon:assign name="nonAcadKeyReqNm" select="concat ($prefixKey, ';', 'DMFR', ';', 'NONACD', ';', 'PSTKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
            </xsl:if>
            <xsl:if test="./CNTCATG = 'T'">
                <saxon:assign name="allKey" select="./PCNTVALUE" />
                <saxon:assign name="allKeyReq" select="./PCNTSREQUIRED" />
                <saxon:assign name="allKeyReqNm" select="concat ($prefixKey, ';', 'DMFR', ';', 'ALLTOTAL', ';', 'PSTKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
            </xsl:if>
            <xsl:if test="./CNTCATG = '3'">
                <saxon:assign name="threeKey" select="./PCNTVALUE" />
                <saxon:assign name="threeKeyReq" select="./PCNTSREQUIRED" />
                <saxon:assign name="threeKeyReqNm" select="concat ($prefixKey, ';', 'DMFR', ';', '3TOTAL', ';', 'PSTKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
            </xsl:if>
            <xsl:if test="./CNTCATG = '6'">
                <saxon:assign name="sixKey" select="./PCNTVALUE" />
                <saxon:assign name="sixKeyReq" select="./PCNTSREQUIRED" />
                <saxon:assign name="sixKeyReqNm" select="concat ($prefixKey, ';', 'DMFR', ';', '6TOTAL', ';', 'PSTKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
            </xsl:if>
            <xsl:if test="./CNTCATG = '9'">
                <saxon:assign name="nineKey" select="./PCNTVALUE" />
                <saxon:assign name="nineKeyReq" select="./PCNTSREQUIRED" />
                <saxon:assign name="nineKeyReqNm" select="concat ($prefixKey, ';', 'DMFR', ';', '9TOTAL', ';', 'PSTKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
            </xsl:if>
            <xsl:if test="./CNTCATG = 'X'">
                <saxon:assign name="_12Key" select="./PCNTVALUE" />
                <saxon:assign name="_12KeyReq" select="./PCNTSREQUIRED" />
                <saxon:assign name="_12KeyReqNm" select="concat ($prefixKey, ';', 'DMFR', ';', '12TOTAL', ';', 'PSTKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
            </xsl:if>
            <xsl:if test="./CNTCATG = 'Y'">
                <saxon:assign name="_18Key" select="./PCNTVALUE" />
                <saxon:assign name="_18KeyReq" select="./PCNTSREQUIRED" />
                <saxon:assign name="_18KeyReqNm" select="concat ($prefixKey, ';', 'DMFR', ';', '18TOTAL', ';', 'PSTKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
            </xsl:if>
            <xsl:if test="./CNTCATG = 'W'">
                <saxon:assign name="_24Key" select="./PCNTVALUE" />
                <saxon:assign name="_24KeyReq" select="./PCNTSREQUIRED" />
                <saxon:assign name="_24KeyReqNm" select="concat ($prefixKey, ';', 'DMFR', ';', '24TOTAL', ';', 'PSTKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
            </xsl:if>
        </xsl:if>
        </xsl:for-each>

            <input type="hidden" name="{$acadKeyReqNm}"  value="{$acadKeyReq}"/>
            <input type="hidden" name='cntName' value="{$acadKeyReqNm}"/>
            <input type="hidden" name="{$nonAcadKeyReqNm}"  value="{$nonAcadKeyReq}"/>
            <input type="hidden" name='cntName' value="{$nonAcadKeyReqNm}"/>
            <input type="hidden" name="{$allKeyReqNm}"  value="{$allKeyReq}"/>
             <input type="hidden" name='cntName' value="{$allKeyReqNm}"/>
            <input type="hidden" name="{$threeKeyReqNm}"  value="{$threeKeyReq}"/>
             <input type="hidden" name='cntName' value="{$threeKeyReqNm}"/>
            <input type="hidden" name="{$sixKeyReqNm}"  value="{$sixKeyReq}"/>
             <input type="hidden" name='cntName' value="{$sixKeyReqNm}"/>
            <input type="hidden" name="{$nineKeyReqNm}"  value="{$nineKeyReq}"/>
             <input type="hidden" name='cntName' value="{$nineKeyReqNm}"/>
            <input type="hidden" name="{$_12KeyReqNm}"  value="{$_12KeyReq}"/>
             <input type="hidden" name='cntName' value="{$_12KeyReqNm}"/>
            <input type="hidden" name="{$_18KeyReqNm}"  value="{$_18KeyReq}"/>
             <input type="hidden" name='cntName' value="{$_18KeyReqNm}"/>
            <input type="hidden" name="{$_24KeyReqNm}"  value="{$_24KeyReq}"/>
             <input type="hidden" name='cntName' value="{$_24KeyReqNm}"/>

        </xsl:if>

<!--   p2  -->


  <xsl:if test="Record/CNTTYPE='D' or Record/CNTTYPE='F' or Record/CNTTYPE='T' or Record/CNTTYPE='3' or Record/CNTTYPE='6' or Record/CNTTYPE='9' or Record/CNTTYPE='X' or Record/CNTTYPE='Y' or Record/CNTTYPE='W'">
    <TABLE class="summaryTable" border="1" cellpadding="1" cellspacing="1">

  <tr>
    <th rowspan="3"> </th>
            <th class="titleClass" colspan="18">Email </th>
  </tr>

  <tr>
      <th align="center" colspan="{$numOfColumns}"> Results </th>
      <th align="center" colspan="{$numOfColumns}"> Ordered </th>
  </tr>

  <tr>
          <xsl:if test="$selOrg = '0' or $selOrg = '1'">
             <th class="titleClass">Academic</th>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '2'">
             <th class="titleClass">Non-Acad</th>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '3'">
             <th class="titleClass">All</th>
          </xsl:if>
          <xsl:if test="$selOrg = '0'">
             <th class="titleClass">3 Months</th>
             <th class="titleClass">6 Months</th>
             <th class="titleClass">9 Months</th>
              <th class="titleClass">12 Months</th>
              <th class="titleClass">18 Months</th>
              <th class="titleClass">24 Months</th>
          </xsl:if>
      <xsl:if test="$selOrg = '0' or $selOrg = '1'">
             <th class="titleClass">Academic</th>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '2'">
             <th class="titleClass">Non-Acad</th>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '3'">
             <th class="titleClass">All</th>
          </xsl:if>
          <xsl:if test="$selOrg = '0'">
             <th class="titleClass">3 Months</th>
             <th class="titleClass">6 Months</th>
             <th class="titleClass">9 Months</th>
              <th class="titleClass">12 Months</th>
              <th class="titleClass">18 Months</th>
              <th class="titleClass">24 Months</th>
          </xsl:if>
  </tr>

  <xsl:variable name="acadKey" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="nonAcadKey" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="allKey" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="threeKey" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="sixKey" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="nineKey" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="_12Key" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="_18Key" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="_24Key" select="'0'" saxon:assignable="yes"/>

  <xsl:variable name="acadKeyReq" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="nonAcadKeyReq" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="allKeyReq" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="threeKeyReq" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="sixKeyReq" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="nineKeyReq" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="_12KeyReq" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="_18KeyReq" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="_24KeyReq" select="'0'" saxon:assignable="yes"/>

  <xsl:variable name="acadKeyReqNm" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="nonAcadKeyReqNm" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="allKeyReqNm" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="threeKeyReqNm" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="sixKeyReqNm" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="nineKeyReqNm" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="_12KeyReqNm" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="_18KeyReqNm" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="_24KeyReqNm" select="'0'" saxon:assignable="yes"/>


  <xsl:variable name="firstTime" select="'1'" saxon:assignable="yes"/>
  <xsl:variable name="currCNT" select="''" saxon:assignable="yes"/>
  <xsl:variable name="prevCNT" select="''" saxon:assignable="yes"/>
        <xsl:variable name="prevCNTTYPE" select="''" saxon:assignable="yes"/>

  <xsl:variable name="prefixKey" select="'DOMESFOREIGN'" saxon:assignable="yes"/>

<!-- This Block and loop is for the Domestic, Foriegn, etc for Email -->

  <xsl:for-each select="Record">
  <xsl:if test="./CNTTYPE='D' or ./CNTTYPE='F' or ./CNTTYPE='T' or ./CNTTYPE='3' or ./CNTTYPE='6' or ./CNTTYPE='9' or ./CNTTYPE='X' or ./CNTTYPE='Y' or ./CNTTYPE='W'">

    <xsl:if test="$firstTime = '1'">
      <saxon:assign name="prevCNT" select="./CNTNAME"/>
            <saxon:assign name="prevCNTTYPE" select="./CNTTYPE"/>
      <saxon:assign name="firstTime" select="'2'"/>
    </xsl:if>

    <saxon:assign name="currCNT" select="./CNTNAME"/>

<!-- After I have read all the rows from the table, I put them here in 1 Row -->
    <xsl:if test="$currCNT != $prevCNT">

      <tr>
          <th class="titleClass"><xsl:value-of select="$prevCNT"/></th>
      <xsl:if test="$selOrg = '0' or $selOrg = '1'">
          <td class="sumClass"><xsl:value-of select="$acadKey"/></td>
      </xsl:if>
      <xsl:if test="$selOrg = '0' or $selOrg = '2'">
          <td class="sumClass"><xsl:value-of select="$nonAcadKey"/></td>
      </xsl:if>
      <xsl:if test="$selOrg = '0' or $selOrg = '3'">
          <td class="sumClass"><xsl:value-of select="$allKey"/></td>
      </xsl:if>
      <xsl:if test="$selOrg = '0'">
              <xsl:choose>
                  <xsl:when test="$prevCNTTYPE='D' or $prevCNTTYPE='F'">
          <td class="sumClass"><xsl:value-of select="$threeKey"/></td>
          <td class="sumClass"><xsl:value-of select="$sixKey"/></td>
          <td class="sumClass"><xsl:value-of select="$nineKey"/></td>
              <td class="sumClass"><xsl:value-of select="$_12Key"/></td>
              <td class="sumClass"><xsl:value-of select="$_18Key"/></td>
              <td class="sumClass"><xsl:value-of select="$_24Key"/></td>
              </xsl:when>
              <xsl:otherwise>
                  <td class="sumClass"><script type="text/javascript">putNbsp()</script></td>
                  <td class="sumClass"><script type="text/javascript">putNbsp()</script></td>
                  <td class="sumClass"><script type="text/javascript">putNbsp()</script></td>
                  <td class="sumClass"><script type="text/javascript">putNbsp()</script></td>
                  <td class="sumClass"><script type="text/javascript">putNbsp()</script></td>
                  <td class="sumClass"><script type="text/javascript">putNbsp()</script></td>
              </xsl:otherwise>
              </xsl:choose>
      </xsl:if>

      <xsl:if test="$selOrg = '0' or $selOrg = '1'">
        <xsl:choose>
        <xsl:when test="$acadKey != '0'">
              <td ><input size="5" type="text" name="{$acadKeyReqNm}"  value="{$acadKeyReq}"/></td>
<!--          <input type="hidden" name='cntName' value="{$acadKeyReqNm}" /> -->
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>

      </xsl:if>

      <xsl:if test="$selOrg = '0' or $selOrg = '2'">
        <xsl:choose>
        <xsl:when test="$nonAcadKey != '0'">
              <td ><input size="5" type="text" name="{$nonAcadKeyReqNm}"  value="{$nonAcadKeyReq}"/></td>
<!--          <input type="hidden" name='cntName' value="{$nonAcadKeyReqNm}" /> -->
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
      </xsl:if>

      <xsl:if test="$selOrg = '0' or $selOrg = '3'">
        <xsl:choose>
        <xsl:when test="$allKey != '0'">
              <td ><input size="5" type="text" name="{$allKeyReqNm}"  value="{$allKeyReq}"/></td>
<!--          <input type="hidden" name='cntName' value="{$allKeyReqNm}" /> -->
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
      </xsl:if>

      <xsl:if test="$selOrg = '0'">
        <xsl:choose>
        <xsl:when test="$threeKey != '0'">
              <td ><input size="5" type="text" name="{$threeKeyReqNm}"  value="{$threeKeyReq}"/></td>
<!--          <input type="hidden" name='cntName' value="{$threeKeyReqNm}" /> -->
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
        <xsl:choose>
        <xsl:when test="$sixKey != '0'">
              <td ><input size="5" type="text" name="{$sixKeyReqNm}"  value="{$sixKeyReq}"/></td>
<!--          <input type="hidden" name='cntName' value="{$sixKeyReqNm}" /> -->
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
        <xsl:choose>
        <xsl:when test="$nineKey != '0'">
              <td ><input size="5" type="text" name="{$nineKeyReqNm}"  value="{$nineKeyReq}"/></td>
<!--          <input type="hidden" name='cntName' value="{$nineKeyReqNm}" /> -->
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
              <xsl:choose>
              <xsl:when test="$_12Key != '0'">
                      <td ><input size="5" type="text" name="{$_12KeyReqNm}"  value="{$_12KeyReq}"/></td>
<!--          <input type="hidden" name='cntName' value="{$_12KeyReqNm}" /> -->
              </xsl:when>
              <xsl:otherwise>
                  <td><script type="text/javascript">putNbsp()</script> </td>
              </xsl:otherwise>
              </xsl:choose>
              <xsl:choose>
              <xsl:when test="$_18Key != '0'">
                      <td ><input size="5" type="text" name="{$_18KeyReqNm}"  value="{$_18KeyReq}"/></td>
<!--          <input type="hidden" name='cntName' value="{$_18KeyReqNm}" /> -->
              </xsl:when>
              <xsl:otherwise>
                  <td><script type="text/javascript">putNbsp()</script> </td>
              </xsl:otherwise>
              </xsl:choose>
              <xsl:choose>
              <xsl:when test="$_24Key != '0'">
                      <td ><input size="5" type="text" name="{$_24KeyReqNm}"  value="{$_24KeyReq}"/></td>
<!--          <input type="hidden" name='cntName' value="{$_24KeyReqNm}" /> -->
              </xsl:when>
              <xsl:otherwise>
                  <td><script type="text/javascript">putNbsp()</script> </td>
              </xsl:otherwise>
              </xsl:choose>
      </xsl:if>




      </tr>

      <!-- Re Initialize all Values -->
      <saxon:assign name="acadKey" select="'0'"/>
      <saxon:assign name="nonAcadKey" select="'0'"/>
      <saxon:assign name="allKey" select="'0'"/>
      <saxon:assign name="threeKey" select="'0'"/>
      <saxon:assign name="sixKey" select="'0'"/>
      <saxon:assign name="nineKey" select="'0'"/>
            <saxon:assign name="_12Key" select="'0'"/>
            <saxon:assign name="_18Key" select="'0'"/>
            <saxon:assign name="_24Key" select="'0'"/>

      <saxon:assign name="acadKeyReqNm" select="'0'"/>
      <saxon:assign name="nonAcadKeyReqNm" select="'0'"/>
      <saxon:assign name="allKeyReqNm" select="'0'"/>
      <saxon:assign name="threeKeyReqNm" select="'0'"/>
      <saxon:assign name="sixKeyReqNm" select="'0'"/>
      <saxon:assign name="nineKeyReqNm" select="'0'"/>
            <saxon:assign name="_12KeyReqNm" select="'0'"/>
            <saxon:assign name="_18KeyReqNm" select="'0'"/>
            <saxon:assign name="_24KeyReqNm" select="'0'"/>

      <saxon:assign name="acadKeyReq" select="'0'"/>
      <saxon:assign name="nonAcadKeyReq" select="'0'"/>
      <saxon:assign name="allKeyReq" select="'0'"/>
      <saxon:assign name="threeKeyReq" select="'0'"/>
      <saxon:assign name="sixKeyReq" select="'0'"/>
      <saxon:assign name="nineKeyReq" select="'0'"/>
            <saxon:assign name="_12KeyReq" select="'0'"/>
            <saxon:assign name="_18KeyReq" select="'0'"/>
            <saxon:assign name="_24KeyReq" select="'0'"/>

      <saxon:assign name="prevCNT" select="./CNTNAME"/>
            <saxon:assign name="prevCNTTYPE" select="./CNTTYPE"/>
    </xsl:if>

<!-- Read the values of the 6 or 3 or 1 row from the table and save it in the variables -->

    <xsl:if test="./CNTCATG = 'A'">
      <saxon:assign name="acadKey" select="./ECNTVALUE" />
      <saxon:assign name="acadKeyReq" select="./ECNTSREQUIRED" />
      <saxon:assign name="acadKeyReqNm" select="concat ($prefixKey, ';', 'DMFR', ';', 'ACAD', ';', 'EMLKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
    </xsl:if>
    <xsl:if test="./CNTCATG = 'N'">
      <saxon:assign name="nonAcadKey" select="./ECNTVALUE" />
      <saxon:assign name="nonAcadKeyReq" select="./ECNTSREQUIRED" />
      <saxon:assign name="nonAcadKeyReqNm" select="concat ($prefixKey, ';', 'DMFR', ';', 'NONACD', ';', 'EMLKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
    </xsl:if>
    <xsl:if test="./CNTCATG = 'T'">
      <saxon:assign name="allKey" select="./ECNTVALUE" />
      <saxon:assign name="allKeyReq" select="./ECNTSREQUIRED" />
      <saxon:assign name="allKeyReqNm" select="concat ($prefixKey, ';', 'DMFR', ';', 'ALLTOTAL', ';', 'EMLKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
    </xsl:if>
    <xsl:if test="./CNTCATG = '3'">
      <saxon:assign name="threeKey" select="./ECNTVALUE" />
      <saxon:assign name="threeKeyReq" select="./ECNTSREQUIRED" />
      <saxon:assign name="threeKeyReqNm" select="concat ($prefixKey, ';', 'DMFR', ';', '3TOTAL', ';', 'EMLKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
    </xsl:if>
    <xsl:if test="./CNTCATG = '6'">
      <saxon:assign name="sixKey" select="./ECNTVALUE" />
      <saxon:assign name="sixKeyReq" select="./ECNTSREQUIRED" />
      <saxon:assign name="sixKeyReqNm" select="concat ($prefixKey, ';', 'DMFR', ';', '6TOTAL', ';', 'EMLKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
    </xsl:if>
    <xsl:if test="./CNTCATG = '9'">
      <saxon:assign name="nineKey" select="./ECNTVALUE" />
      <saxon:assign name="nineKeyReq" select="./ECNTSREQUIRED" />
      <saxon:assign name="nineKeyReqNm" select="concat ($prefixKey, ';', 'DMFR', ';', '9TOTAL', ';', 'EMLKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
    </xsl:if>
        <xsl:if test="./CNTCATG = 'X'">
            <saxon:assign name="_12Key" select="./ECNTVALUE" />
            <saxon:assign name="_12KeyReq" select="./ECNTSREQUIRED" />
            <saxon:assign name="_12KeyReqNm" select="concat ($prefixKey, ';', 'DMFR', ';', '12TOTAL', ';', 'EMLKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
        </xsl:if>
        <xsl:if test="./CNTCATG = 'Y'">
            <saxon:assign name="_18Key" select="./ECNTVALUE" />
            <saxon:assign name="_18KeyReq" select="./ECNTSREQUIRED" />
            <saxon:assign name="_18KeyReqNm" select="concat ($prefixKey, ';', 'DMFR', ';', '18TOTAL', ';', 'EMLKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
        </xsl:if>
        <xsl:if test="./CNTCATG = 'W'">
            <saxon:assign name="_24Key" select="./ECNTVALUE" />
            <saxon:assign name="_24KeyReq" select="./ECNTSREQUIRED" />
            <saxon:assign name="_24KeyReqNm" select="concat ($prefixKey, ';', 'DMFR', ';', '24TOTAL', ';', 'EMLKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
        </xsl:if>

  </xsl:if>
  </xsl:for-each>

      <tr>
          <th class="titleClass"><xsl:value-of select="$prevCNT"/></th>
      <xsl:if test="$selOrg = '0' or $selOrg = '1'">
          <td class="sumClass"><xsl:value-of select="$acadKey"/></td>
      </xsl:if>
      <xsl:if test="$selOrg = '0' or $selOrg = '2'">
          <td class="sumClass"><xsl:value-of select="$nonAcadKey"/></td>
      </xsl:if>
      <xsl:if test="$selOrg = '0' or $selOrg = '3'">
          <td class="sumClass"><xsl:value-of select="$allKey"/></td>
      </xsl:if>
      <xsl:if test="$selOrg = '0'">
              <xsl:choose>
                  <xsl:when test="$prevCNTTYPE='D' or $prevCNTTYPE='F'">
          <td class="sumClass"><xsl:value-of select="$threeKey"/></td>
          <td class="sumClass"><xsl:value-of select="$sixKey"/></td>
          <td class="sumClass"><xsl:value-of select="$nineKey"/></td>
              <td class="sumClass"><xsl:value-of select="$_12Key"/></td>
              <td class="sumClass"><xsl:value-of select="$_18Key"/></td>
              <td class="sumClass"><xsl:value-of select="$_24Key"/></td>
              </xsl:when>
              <xsl:otherwise>
                  <td class="sumClass"><script type="text/javascript">putNbsp()</script></td>
                  <td class="sumClass"><script type="text/javascript">putNbsp()</script></td>
                  <td class="sumClass"><script type="text/javascript">putNbsp()</script></td>
                  <td class="sumClass"><script type="text/javascript">putNbsp()</script></td>
                  <td class="sumClass"><script type="text/javascript">putNbsp()</script></td>
                  <td class="sumClass"><script type="text/javascript">putNbsp()</script></td>
              </xsl:otherwise>
              </xsl:choose>
      </xsl:if>


      <xsl:if test="$selOrg = '0' or $selOrg = '1'">
        <xsl:choose>
        <xsl:when test="$acadKey != '0'">
              <td ><input size="5" type="text" name="{$acadKeyReqNm}"  value="{$acadKeyReq}"/></td>
<!--          <input type="hidden" name='cntName' value="{$acadKeyReqNm}" /> -->
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>

      </xsl:if>

      <xsl:if test="$selOrg = '0' or $selOrg = '2'">
        <xsl:choose>
        <xsl:when test="$nonAcadKey != '0'">
              <td ><input size="5" type="text" name="{$nonAcadKeyReqNm}"  value="{$nonAcadKeyReq}"/></td>
<!--          <input type="hidden" name='cntName' value="{$nonAcadKeyReqNm}" /> -->
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
      </xsl:if>

      <xsl:if test="$selOrg = '0' or $selOrg = '3'">
        <xsl:choose>
        <xsl:when test="$allKey != '0'">
              <td ><input size="5" type="text" name="{$allKeyReqNm}"  value="{$allKeyReq}"/></td>
<!--          <input type="hidden" name='cntName' value="{$allKeyReqNm}" /> -->
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
      </xsl:if>

      <xsl:if test="$selOrg = '0'">
        <xsl:choose>
        <xsl:when test="$threeKey != '0'">
              <td ><input size="5" type="text" name="{$threeKeyReqNm}"  value="{$threeKeyReq}"/></td>
<!--          <input type="hidden" name='cntName' value="{$threeKeyReqNm}" /> -->
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
        <xsl:choose>
        <xsl:when test="$sixKey != '0'">
              <td ><input size="5" type="text" name="{$sixKeyReqNm}"  value="{$sixKeyReq}"/></td>
<!--          <input type="hidden" name='cntName' value="{$sixKeyReqNm}" /> -->
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
        <xsl:choose>
        <xsl:when test="$nineKey != '0'">
              <td ><input size="5" type="text" name="{$nineKeyReqNm}"  value="{$nineKeyReq}"/></td>
<!--          <input type="hidden" name='cntName' value="{$nineKeyReqNm}" /> -->
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
              <xsl:choose>
              <xsl:when test="$_12Key != '0'">
                      <td ><input size="5" type="text" name="{$_12KeyReqNm}"  value="{$_12KeyReq}"/></td>
<!--          <input type="hidden" name='cntName' value="{$_12KeyReqNm}" /> -->
              </xsl:when>
              <xsl:otherwise>
                  <td><script type="text/javascript">putNbsp()</script> </td>
              </xsl:otherwise>
              </xsl:choose>
              <xsl:choose>
              <xsl:when test="$_18Key != '0'">
                      <td ><input size="5" type="text" name="{$_18KeyReqNm}"  value="{$_18KeyReq}"/></td>
<!--          <input type="hidden" name='cntName' value="{$_18KeyReqNm}" /> -->
              </xsl:when>
              <xsl:otherwise>
                  <td><script type="text/javascript">putNbsp()</script> </td>
              </xsl:otherwise>
              </xsl:choose>
              <xsl:choose>
              <xsl:when test="$_24Key != '0'">
                      <td ><input size="5" type="text" name="{$_24KeyReqNm}"  value="{$_24KeyReq}"/></td>
<!--          <input type="hidden" name='cntName' value="{$_24KeyReqNm}" /> -->
              </xsl:when>
              <xsl:otherwise>
                  <td><script type="text/javascript">putNbsp()</script> </td>
              </xsl:otherwise>
              </xsl:choose>
      </xsl:if>
      </tr>

    </TABLE>
    </xsl:if>

    <br></br> <br></br>

        <!-- p2.5 third block -->

        <xsl:if test="Record/CNTTYPE='D' or Record/CNTTYPE='F' or Record/CNTTYPE='U' or Record/CNTTYPE='T' or Record/CNTTYPE='3' or Record/CNTTYPE='6' or Record/CNTTYPE='9' or Record/CNTTYPE='X' or Record/CNTTYPE='Y' or Record/CNTTYPE='W'">
        <TABLE class="summaryTable" border="1" cellpadding="1" cellspacing="1">

        <tr>
            <th rowspan="3"> </th>
                <th class="titleClass" colspan="18">Emails with Invalid Postal </th>
        </tr>

        <tr>
                <th align="center" colspan="{$numOfColumns}"> Results </th>
                <th align="center" colspan="{$numOfColumns}"> Ordered </th>
        </tr>

        <tr>
              <xsl:if test="$selOrg = '0' or $selOrg = '1'">
                 <th class="titleClass">Academic</th>
              </xsl:if>
              <xsl:if test="$selOrg = '0' or $selOrg = '2'">
                 <th class="titleClass">Non-Acad</th>
              </xsl:if>
              <xsl:if test="$selOrg = '0' or $selOrg = '3'">
                 <th class="titleClass">All</th>
              </xsl:if>
              <xsl:if test="$selOrg = '0'">
                 <th class="titleClass">3 Months</th>
                 <th class="titleClass">6 Months</th>
                 <th class="titleClass">9 Months</th>
                  <th class="titleClass">12 Months</th>
                  <th class="titleClass">18 Months</th>
                  <th class="titleClass">24 Months</th>
              </xsl:if>
              <xsl:if test="$selOrg = '0' or $selOrg = '1'">
                 <th class="titleClass">Academic</th>
              </xsl:if>
              <xsl:if test="$selOrg = '0' or $selOrg = '2'">
                 <th class="titleClass">Non-Acad</th>
              </xsl:if>
              <xsl:if test="$selOrg = '0' or $selOrg = '3'">
                 <th class="titleClass">All</th>
              </xsl:if>
              <xsl:if test="$selOrg = '0'">
                 <th class="titleClass">3 Months</th>
                 <th class="titleClass">6 Months</th>
                 <th class="titleClass">9 Months</th>
                  <th class="titleClass">12 Months</th>
                  <th class="titleClass">18 Months</th>
                  <th class="titleClass">24 Months</th>
              </xsl:if>
        </tr>

        <xsl:variable name="acadKey" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="nonAcadKey" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="allKey" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="threeKey" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="sixKey" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="nineKey" select="'0'" saxon:assignable="yes"/>
            <xsl:variable name="_12Key" select="'0'" saxon:assignable="yes"/>
            <xsl:variable name="_18Key" select="'0'" saxon:assignable="yes"/>
            <xsl:variable name="_24Key" select="'0'" saxon:assignable="yes"/>

        <xsl:variable name="acadKeyReq" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="nonAcadKeyReq" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="allKeyReq" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="threeKeyReq" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="sixKeyReq" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="nineKeyReq" select="'0'" saxon:assignable="yes"/>
            <xsl:variable name="_12KeyReq" select="'0'" saxon:assignable="yes"/>
            <xsl:variable name="_18KeyReq" select="'0'" saxon:assignable="yes"/>
            <xsl:variable name="_24KeyReq" select="'0'" saxon:assignable="yes"/>

        <xsl:variable name="acadKeyReqNm" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="nonAcadKeyReqNm" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="allKeyReqNm" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="threeKeyReqNm" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="sixKeyReqNm" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="nineKeyReqNm" select="'0'" saxon:assignable="yes"/>
            <xsl:variable name="_12KeyReqNm" select="'0'" saxon:assignable="yes"/>
            <xsl:variable name="_18KeyReqNm" select="'0'" saxon:assignable="yes"/>
            <xsl:variable name="_24KeyReqNm" select="'0'" saxon:assignable="yes"/>


        <xsl:variable name="firstTime" select="'1'" saxon:assignable="yes"/>
        <xsl:variable name="currCNT" select="''" saxon:assignable="yes"/>
        <xsl:variable name="prevCNT" select="''" saxon:assignable="yes"/>
            <xsl:variable name="prevCNTTYPE" select="''" saxon:assignable="yes"/>

        <xsl:variable name="prefixKey" select="'DOMESFOREIGN'" saxon:assignable="yes"/>

    <!-- This Block and loop is for the Domestic, Foriegn, etc for Email -->

        <xsl:for-each select="Record">
        <xsl:if test="./CNTTYPE='D' or ./CNTTYPE='F' or ./CNTTYPE='U' or ./CNTTYPE='T' or ./CNTTYPE='3' or ./CNTTYPE='6' or ./CNTTYPE='9' or ./CNTTYPE='X' or ./CNTTYPE='Y' or ./CNTTYPE='W'">

            <xsl:if test="$firstTime = '1'">
                <saxon:assign name="prevCNT" select="./CNTNAME"/>
                <saxon:assign name="prevCNTTYPE" select="./CNTTYPE"/>
                <saxon:assign name="firstTime" select="'2'"/>
            </xsl:if>

            <saxon:assign name="currCNT" select="./CNTNAME"/>

    <!-- After I have read all the rows from the table, I put them here in 1 Row -->
            <xsl:if test="$currCNT != $prevCNT">

              <tr>
                    <th class="titleClass"><xsl:value-of select="$prevCNT"/></th>
              <xsl:if test="$selOrg = '0' or $selOrg = '1'">
                    <td class="sumClass"><xsl:value-of select="$acadKey"/></td>
              </xsl:if>
              <xsl:if test="$selOrg = '0' or $selOrg = '2'">
                    <td class="sumClass"><xsl:value-of select="$nonAcadKey"/></td>
              </xsl:if>
              <xsl:if test="$selOrg = '0' or $selOrg = '3'">
                    <td class="sumClass"><xsl:value-of select="$allKey"/></td>
              </xsl:if>
              <xsl:if test="$selOrg = '0'">
                  <xsl:choose>
                      <xsl:when test="$prevCNTTYPE='D' or $prevCNTTYPE='F' or $prevCNTTYPE='U'">
                    <td class="sumClass"><xsl:value-of select="$threeKey"/></td>
                    <td class="sumClass"><xsl:value-of select="$sixKey"/></td>
                    <td class="sumClass"><xsl:value-of select="$nineKey"/></td>
                  <td class="sumClass"><xsl:value-of select="$_12Key"/></td>
                  <td class="sumClass"><xsl:value-of select="$_18Key"/></td>
                  <td class="sumClass"><xsl:value-of select="$_24Key"/></td>
                  </xsl:when>
                  <xsl:otherwise>
                      <td class="sumClass"><script type="text/javascript">putNbsp()</script></td>
                      <td class="sumClass"><script type="text/javascript">putNbsp()</script></td>
                      <td class="sumClass"><script type="text/javascript">putNbsp()</script></td>
                      <td class="sumClass"><script type="text/javascript">putNbsp()</script></td>
                      <td class="sumClass"><script type="text/javascript">putNbsp()</script></td>
                      <td class="sumClass"><script type="text/javascript">putNbsp()</script></td>
                  </xsl:otherwise>
                  </xsl:choose>
              </xsl:if>

              <xsl:if test="$selOrg = '0' or $selOrg = '1'">
                    <xsl:choose>
                    <xsl:when test="$acadKey != '0'">
                            <td ><input size="5" type="text" name="{$acadKeyReqNm}"  value="{$acadKeyReq}"/></td>
    <!--          <input type="hidden" name='cntName' value="{$acadKeyReqNm}" /> -->
                    </xsl:when>
                    <xsl:otherwise>
                        <td><script type="text/javascript">putNbsp()</script> </td>
                    </xsl:otherwise>
                    </xsl:choose>

              </xsl:if>

              <xsl:if test="$selOrg = '0' or $selOrg = '2'">
                    <xsl:choose>
                    <xsl:when test="$nonAcadKey != '0'">
                            <td ><input size="5" type="text" name="{$nonAcadKeyReqNm}"  value="{$nonAcadKeyReq}"/></td>
    <!--          <input type="hidden" name='cntName' value="{$nonAcadKeyReqNm}" /> -->
                    </xsl:when>
                    <xsl:otherwise>
                        <td><script type="text/javascript">putNbsp()</script> </td>
                    </xsl:otherwise>
                    </xsl:choose>
              </xsl:if>

              <xsl:if test="$selOrg = '0' or $selOrg = '3'">
                    <xsl:choose>
                    <xsl:when test="$allKey != '0'">
                            <td ><input size="5" type="text" name="{$allKeyReqNm}"  value="{$allKeyReq}"/></td>
    <!--          <input type="hidden" name='cntName' value="{$allKeyReqNm}" /> -->
                    </xsl:when>
                    <xsl:otherwise>
                        <td><script type="text/javascript">putNbsp()</script> </td>
                    </xsl:otherwise>
                    </xsl:choose>
              </xsl:if>

              <xsl:if test="$selOrg = '0'">
                    <xsl:choose>
                    <xsl:when test="$threeKey != '0'">
                            <td ><input size="5" type="text" name="{$threeKeyReqNm}"  value="{$threeKeyReq}"/></td>
    <!--          <input type="hidden" name='cntName' value="{$threeKeyReqNm}" /> -->
                    </xsl:when>
                    <xsl:otherwise>
                        <td><script type="text/javascript">putNbsp()</script> </td>
                    </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                    <xsl:when test="$sixKey != '0'">
                            <td ><input size="5" type="text" name="{$sixKeyReqNm}"  value="{$sixKeyReq}"/></td>
    <!--          <input type="hidden" name='cntName' value="{$sixKeyReqNm}" /> -->
                    </xsl:when>
                    <xsl:otherwise>
                        <td><script type="text/javascript">putNbsp()</script> </td>
                    </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                    <xsl:when test="$nineKey != '0'">
                            <td ><input size="5" type="text" name="{$nineKeyReqNm}"  value="{$nineKeyReq}"/></td>
    <!--          <input type="hidden" name='cntName' value="{$nineKeyReqNm}" /> -->
                    </xsl:when>
                    <xsl:otherwise>
                        <td><script type="text/javascript">putNbsp()</script> </td>
                    </xsl:otherwise>
                    </xsl:choose>
                  <xsl:choose>
                  <xsl:when test="$_12Key != '0'">
                          <td ><input size="5" type="text" name="{$_12KeyReqNm}"  value="{$_12KeyReq}"/></td>
    <!--          <input type="hidden" name='cntName' value="{$_12KeyReqNm}" /> -->
                  </xsl:when>
                  <xsl:otherwise>
                      <td><script type="text/javascript">putNbsp()</script> </td>
                  </xsl:otherwise>
                  </xsl:choose>
                  <xsl:choose>
                  <xsl:when test="$_18Key != '0'">
                          <td ><input size="5" type="text" name="{$_18KeyReqNm}"  value="{$_18KeyReq}"/></td>
    <!--          <input type="hidden" name='cntName' value="{$_18KeyReqNm}" /> -->
                  </xsl:when>
                  <xsl:otherwise>
                      <td><script type="text/javascript">putNbsp()</script> </td>
                  </xsl:otherwise>
                  </xsl:choose>
                  <xsl:choose>
                  <xsl:when test="$_24Key != '0'">
                          <td ><input size="5" type="text" name="{$_24KeyReqNm}"  value="{$_24KeyReq}"/></td>
    <!--          <input type="hidden" name='cntName' value="{$_24KeyReqNm}" /> -->
                  </xsl:when>
                  <xsl:otherwise>
                      <td><script type="text/javascript">putNbsp()</script> </td>
                  </xsl:otherwise>
                  </xsl:choose>
              </xsl:if>




              </tr>

                <!-- Re Initialize all Values -->
                <saxon:assign name="acadKey" select="'0'"/>
                <saxon:assign name="nonAcadKey" select="'0'"/>
                <saxon:assign name="allKey" select="'0'"/>
                <saxon:assign name="threeKey" select="'0'"/>
                <saxon:assign name="sixKey" select="'0'"/>
                <saxon:assign name="nineKey" select="'0'"/>
                <saxon:assign name="_12Key" select="'0'"/>
                <saxon:assign name="_18Key" select="'0'"/>
                <saxon:assign name="_24Key" select="'0'"/>

                <saxon:assign name="acadKeyReqNm" select="'0'"/>
                <saxon:assign name="nonAcadKeyReqNm" select="'0'"/>
                <saxon:assign name="allKeyReqNm" select="'0'"/>
                <saxon:assign name="threeKeyReqNm" select="'0'"/>
                <saxon:assign name="sixKeyReqNm" select="'0'"/>
                <saxon:assign name="nineKeyReqNm" select="'0'"/>
                <saxon:assign name="_12KeyReqNm" select="'0'"/>
                <saxon:assign name="_18KeyReqNm" select="'0'"/>
                <saxon:assign name="_24KeyReqNm" select="'0'"/>

                <saxon:assign name="acadKeyReq" select="'0'"/>
                <saxon:assign name="nonAcadKeyReq" select="'0'"/>
                <saxon:assign name="allKeyReq" select="'0'"/>
                <saxon:assign name="threeKeyReq" select="'0'"/>
                <saxon:assign name="sixKeyReq" select="'0'"/>
                <saxon:assign name="nineKeyReq" select="'0'"/>
                <saxon:assign name="_12KeyReq" select="'0'"/>
                <saxon:assign name="_18KeyReq" select="'0'"/>
                <saxon:assign name="_24KeyReq" select="'0'"/>

                <saxon:assign name="prevCNT" select="./CNTNAME"/>
                <saxon:assign name="prevCNTTYPE" select="./CNTTYPE"/>
            </xsl:if>

    <!-- Read the values of the 6 or 3 or 1 row from the table and save it in the variables -->

            <xsl:if test="./CNTCATG = 'A'">
                <saxon:assign name="acadKey" select="./ICNTVALUE" />
                <saxon:assign name="acadKeyReq" select="./ICNTSREQUIRED" />
                <saxon:assign name="acadKeyReqNm" select="concat ($prefixKey, ';', 'DMFR', ';', 'ACAD', ';', 'IMLKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
            </xsl:if>
            <xsl:if test="./CNTCATG = 'N'">
                <saxon:assign name="nonAcadKey" select="./ICNTVALUE" />
                <saxon:assign name="nonAcadKeyReq" select="./ICNTSREQUIRED" />
                <saxon:assign name="nonAcadKeyReqNm" select="concat ($prefixKey, ';', 'DMFR', ';', 'NONACD', ';', 'IMLKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
            </xsl:if>
            <xsl:if test="./CNTCATG = 'T'">
                <saxon:assign name="allKey" select="./ICNTVALUE" />
                <saxon:assign name="allKeyReq" select="./ICNTSREQUIRED" />
                <saxon:assign name="allKeyReqNm" select="concat ($prefixKey, ';', 'DMFR', ';', 'ALLTOTAL', ';', 'IMLKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
            </xsl:if>
            <xsl:if test="./CNTCATG = '3'">
                <saxon:assign name="threeKey" select="./ICNTVALUE" />
                <saxon:assign name="threeKeyReq" select="./ICNTSREQUIRED" />
                <saxon:assign name="threeKeyReqNm" select="concat ($prefixKey, ';', 'DMFR', ';', '3TOTAL', ';', 'IMLKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
            </xsl:if>
            <xsl:if test="./CNTCATG = '6'">
                <saxon:assign name="sixKey" select="./ICNTVALUE" />
                <saxon:assign name="sixKeyReq" select="./ICNTSREQUIRED" />
                <saxon:assign name="sixKeyReqNm" select="concat ($prefixKey, ';', 'DMFR', ';', '6TOTAL', ';', 'IMLKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
            </xsl:if>
            <xsl:if test="./CNTCATG = '9'">
                <saxon:assign name="nineKey" select="./ICNTVALUE" />
                <saxon:assign name="nineKeyReq" select="./ICNTSREQUIRED" />
                <saxon:assign name="nineKeyReqNm" select="concat ($prefixKey, ';', 'DMFR', ';', '9TOTAL', ';', 'IMLKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
            </xsl:if>
            <xsl:if test="./CNTCATG = 'X'">
                <saxon:assign name="_12Key" select="./ICNTVALUE" />
                <saxon:assign name="_12KeyReq" select="./ICNTSREQUIRED" />
                <saxon:assign name="_12KeyReqNm" select="concat ($prefixKey, ';', 'DMFR', ';', '12TOTAL', ';', 'IMLKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
            </xsl:if>
            <xsl:if test="./CNTCATG = 'Y'">
                <saxon:assign name="_18Key" select="./ICNTVALUE" />
                <saxon:assign name="_18KeyReq" select="./ICNTSREQUIRED" />
                <saxon:assign name="_18KeyReqNm" select="concat ($prefixKey, ';', 'DMFR', ';', '18TOTAL', ';', 'IMLKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
            </xsl:if>
            <xsl:if test="./CNTCATG = 'W'">
                <saxon:assign name="_24Key" select="./ICNTVALUE" />
                <saxon:assign name="_24KeyReq" select="./ICNTSREQUIRED" />
                <saxon:assign name="_24KeyReqNm" select="concat ($prefixKey, ';', 'DMFR', ';', '24TOTAL', ';', 'IMLKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
            </xsl:if>

        </xsl:if>
        </xsl:for-each>

              <tr>
                    <th class="titleClass"><xsl:value-of select="$prevCNT"/></th>
              <xsl:if test="$selOrg = '0' or $selOrg = '1'">
                    <td class="sumClass"><xsl:value-of select="$acadKey"/></td>
              </xsl:if>
              <xsl:if test="$selOrg = '0' or $selOrg = '2'">
                    <td class="sumClass"><xsl:value-of select="$nonAcadKey"/></td>
              </xsl:if>
              <xsl:if test="$selOrg = '0' or $selOrg = '3'">
                    <td class="sumClass"><xsl:value-of select="$allKey"/></td>
              </xsl:if>
              <xsl:if test="$selOrg = '0'">
                  <xsl:choose>
                      <xsl:when test="$prevCNTTYPE='D' or $prevCNTTYPE='F' or $prevCNTTYPE='F'">
                    <td class="sumClass"><xsl:value-of select="$threeKey"/></td>
                    <td class="sumClass"><xsl:value-of select="$sixKey"/></td>
                    <td class="sumClass"><xsl:value-of select="$nineKey"/></td>
                  <td class="sumClass"><xsl:value-of select="$_12Key"/></td>
                  <td class="sumClass"><xsl:value-of select="$_18Key"/></td>
                  <td class="sumClass"><xsl:value-of select="$_24Key"/></td>
                  </xsl:when>
                  <xsl:otherwise>
                      <td class="sumClass"><script type="text/javascript">putNbsp()</script></td>
                      <td class="sumClass"><script type="text/javascript">putNbsp()</script></td>
                      <td class="sumClass"><script type="text/javascript">putNbsp()</script></td>
                      <td class="sumClass"><script type="text/javascript">putNbsp()</script></td>
                      <td class="sumClass"><script type="text/javascript">putNbsp()</script></td>
                      <td class="sumClass"><script type="text/javascript">putNbsp()</script></td>
                  </xsl:otherwise>
                  </xsl:choose>
              </xsl:if>


              <xsl:if test="$selOrg = '0' or $selOrg = '1'">
                    <xsl:choose>
                    <xsl:when test="$acadKey != '0'">
                            <td ><input size="5" type="text" name="{$acadKeyReqNm}"  value="{$acadKeyReq}"/></td>
    <!--          <input type="hidden" name='cntName' value="{$acadKeyReqNm}" /> -->
                    </xsl:when>
                    <xsl:otherwise>
                        <td><script type="text/javascript">putNbsp()</script> </td>
                    </xsl:otherwise>
                    </xsl:choose>

              </xsl:if>

              <xsl:if test="$selOrg = '0' or $selOrg = '2'">
                    <xsl:choose>
                    <xsl:when test="$nonAcadKey != '0'">
                            <td ><input size="5" type="text" name="{$nonAcadKeyReqNm}"  value="{$nonAcadKeyReq}"/></td>
    <!--          <input type="hidden" name='cntName' value="{$nonAcadKeyReqNm}" /> -->
                    </xsl:when>
                    <xsl:otherwise>
                        <td><script type="text/javascript">putNbsp()</script> </td>
                    </xsl:otherwise>
                    </xsl:choose>
              </xsl:if>

              <xsl:if test="$selOrg = '0' or $selOrg = '3'">
                    <xsl:choose>
                    <xsl:when test="$allKey != '0'">
                            <td ><input size="5" type="text" name="{$allKeyReqNm}"  value="{$allKeyReq}"/></td>
    <!--          <input type="hidden" name='cntName' value="{$allKeyReqNm}" /> -->
                    </xsl:when>
                    <xsl:otherwise>
                        <td><script type="text/javascript">putNbsp()</script> </td>
                    </xsl:otherwise>
                    </xsl:choose>
              </xsl:if>

              <xsl:if test="$selOrg = '0'">
                    <xsl:choose>
                    <xsl:when test="$threeKey != '0'">
                            <td ><input size="5" type="text" name="{$threeKeyReqNm}"  value="{$threeKeyReq}"/></td>
    <!--          <input type="hidden" name='cntName' value="{$threeKeyReqNm}" /> -->
                    </xsl:when>
                    <xsl:otherwise>
                        <td><script type="text/javascript">putNbsp()</script> </td>
                    </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                    <xsl:when test="$sixKey != '0'">
                            <td ><input size="5" type="text" name="{$sixKeyReqNm}"  value="{$sixKeyReq}"/></td>
    <!--          <input type="hidden" name='cntName' value="{$sixKeyReqNm}" /> -->
                    </xsl:when>
                    <xsl:otherwise>
                        <td><script type="text/javascript">putNbsp()</script> </td>
                    </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                    <xsl:when test="$nineKey != '0'">
                            <td ><input size="5" type="text" name="{$nineKeyReqNm}"  value="{$nineKeyReq}"/></td>
    <!--          <input type="hidden" name='cntName' value="{$nineKeyReqNm}" /> -->
                    </xsl:when>
                    <xsl:otherwise>
                        <td><script type="text/javascript">putNbsp()</script> </td>
                    </xsl:otherwise>
                    </xsl:choose>
                  <xsl:choose>
                  <xsl:when test="$_12Key != '0'">
                          <td ><input size="5" type="text" name="{$_12KeyReqNm}"  value="{$_12KeyReq}"/></td>
    <!--          <input type="hidden" name='cntName' value="{$_12KeyReqNm}" /> -->
                  </xsl:when>
                  <xsl:otherwise>
                      <td><script type="text/javascript">putNbsp()</script> </td>
                  </xsl:otherwise>
                  </xsl:choose>
                  <xsl:choose>
                  <xsl:when test="$_18Key != '0'">
                          <td ><input size="5" type="text" name="{$_18KeyReqNm}"  value="{$_18KeyReq}"/></td>
    <!--          <input type="hidden" name='cntName' value="{$_18KeyReqNm}" /> -->
                  </xsl:when>
                  <xsl:otherwise>
                      <td><script type="text/javascript">putNbsp()</script> </td>
                  </xsl:otherwise>
                  </xsl:choose>
                  <xsl:choose>
                  <xsl:when test="$_24Key != '0'">
                          <td ><input size="5" type="text" name="{$_24KeyReqNm}"  value="{$_24KeyReq}"/></td>
    <!--          <input type="hidden" name='cntName' value="{$_24KeyReqNm}" /> -->
                  </xsl:when>
                  <xsl:otherwise>
                      <td><script type="text/javascript">putNbsp()</script> </td>
                  </xsl:otherwise>
                  </xsl:choose>
              </xsl:if>
              </tr>

        </TABLE>
        </xsl:if>

            <br></br> <br></br>
  </div>

<!-- p3 -->


  <xsl:if test="Record/CNTTYPE = 'C'">
  <div class="countryBox">
    <table class="summaryTable"  border="1" cellpadding="1" cellspacing="1">

  <tr>

        <!-- old -->
    <!--<xsl:variable name="numOfColumnsNew">-->
      <!--<xsl:if test="$numOfColumns = 1">2</xsl:if>-->
      <!--<xsl:if test="$numOfColumns != 1"><xsl:value-of select="$numOfColumns"/></xsl:if>-->
    <!--</xsl:variable>-->
        <!-- new. in new code $numOfColumns(9) != numOfColumnsNew(6) if $numOfColumns != 1-->
    <xsl:variable name="numOfColumnsNew">
      <xsl:if test="$numOfColumns = 1">2</xsl:if>
            <xsl:if test="$numOfColumns != 1">6</xsl:if>
    </xsl:variable>


    <th rowspan="3"> </th>

            <th class="titleClass" colspan="{$numOfColumnsNew}">Postal (
            <input type="checkbox" name="includeEmail2" value="I" onclick="selectIncludeEmail(document.resultsForm, this)">
            <xsl:variable name="inclVal">
                <xsl:value-of select="Record/INCEMAIL" />
            </xsl:variable>
            <xsl:if test="'I' = $inclVal">
                <xsl:attribute name="checked">true</xsl:attribute>
            </xsl:if>
            </input> Include Email)
      <br></br> Select All :
            <xsl:if test="$selOrg = '0' or $selOrg = '1'">
                 <input type="radio" name="selectAll" value="acadVal" onclick="javascript:selectAllAndCopy(document.resultsForm, 'pstCount', 'ACAD', 'CTT')"/> Acad
            </xsl:if>
            <xsl:if test="$selOrg = '0' or $selOrg = '2'">
               <input type="radio" name="selectAll" value="nonAcadVal" onclick="javascript:selectAllAndCopy(document.resultsForm, 'pstCount', 'NONACD', 'CTT')"/> Non-Acad
            </xsl:if>
            <xsl:if test="$selOrg = '0' or $selOrg = '3'">
               <input type="radio" name="selectAll" value="totalVal" onclick="javascript:selectAllAndCopy(document.resultsForm, 'pstCount', 'ALLTOTAL', 'CTT')"/> Total
            </xsl:if>

      </th>

            <th class="titleClass" colspan="{$numOfColumnsNew}">Email
      <br></br> Select All :
            <xsl:if test="$selOrg = '0' or $selOrg = '1'">
               <input type="radio" name="selectAll" value="acadVal" onclick="javascript:selectAllAndCopy(document.resultsForm, 'emlCount', 'ACAD', 'CTT')"/> Acad
            </xsl:if>
            <xsl:if test="$selOrg = '0' or $selOrg = '2'">
               <input type="radio" name="selectAll" value="nonAcadVal" onclick="javascript:selectAllAndCopy(document.resultsForm, 'emlCount', 'NONACD', 'CTT')"/> Non-Acad
            </xsl:if>
            <xsl:if test="$selOrg = '0' or $selOrg = '3'">
               <input type="radio" name="selectAll" value="totalVal" onclick="javascript:selectAllAndCopy(document.resultsForm, 'emlCount', 'ALLTOTAL', 'CTT')"/> Total
            </xsl:if>
      </th>
        <th class="titleClass" colspan="{$numOfColumnsNew}">Emails with Invalid Postal
        <br></br> Select All :
        <xsl:if test="$selOrg = '0' or $selOrg = '1'">
           <input type="radio" name="selectAll" value="acadVal" onclick="javascript:selectAllAndCopy(document.resultsForm, 'imlCount', 'ACAD', 'CTT')"/> Acad
        </xsl:if>
        <xsl:if test="$selOrg = '0' or $selOrg = '2'">
           <input type="radio" name="selectAll" value="nonAcadVal" onclick="javascript:selectAllAndCopy(document.resultsForm, 'imlCount', 'NONACD', 'CTT')"/> Non-Acad
        </xsl:if>
        <xsl:if test="$selOrg = '0' or $selOrg = '3'">
           <input type="radio" name="selectAll" value="totalVal" onclick="javascript:selectAllAndCopy(document.resultsForm, 'imlCount', 'ALLTOTAL', 'CTT')"/> Total
        </xsl:if>
        </th>
  </tr>

  <tr>
    <xsl:variable name="numOfColumnsNew2">
      <xsl:if test="$numOfColumns = 1">1</xsl:if>
      <xsl:if test="$numOfColumns != 1">3</xsl:if>
    </xsl:variable>

      <th align="center" colspan="{$numOfColumnsNew2}"> Results </th>
      <th align="center" colspan="{$numOfColumnsNew2}"> Ordered </th>
      <th align="center" colspan="{$numOfColumnsNew2}"> Results </th>
      <th align="center" colspan="{$numOfColumnsNew2}"> Ordered </th>
        <th align="center" colspan="{$numOfColumnsNew2}"> Results </th>
        <th align="center" colspan="{$numOfColumnsNew2}"> Ordered </th>
  </tr>

  <tr>
          <xsl:if test="$selOrg = '0' or $selOrg = '1'">
             <th class="titleClass">Academic</th>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '2'">
             <th class="titleClass">Non-Acad</th>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '3'">
             <th class="titleClass">All</th>
          </xsl:if>

      <xsl:if test="$selOrg = '0' or $selOrg = '1'">
             <th class="titleClass">Academic</th>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '2'">
             <th class="titleClass">Non-Acad</th>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '3'">
             <th class="titleClass">Total</th>
          </xsl:if>

      <xsl:if test="$selOrg = '0' or $selOrg = '1'">
             <th class="titleClass">Academic</th>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '2'">
             <th class="titleClass">Non-Acad</th>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '3'">
             <th class="titleClass">Total</th>
          </xsl:if>

          <xsl:if test="$selOrg = '0' or $selOrg = '1'">
             <th class="titleClass">Academic</th>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '2'">
             <th class="titleClass">Non-Acad</th>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '3'">
             <th class="titleClass">Total</th>
          </xsl:if>

        <xsl:if test="$selOrg = '0' or $selOrg = '1'">
           <th class="titleClass">Academic</th>
        </xsl:if>
        <xsl:if test="$selOrg = '0' or $selOrg = '2'">
           <th class="titleClass">Non-Acad</th>
        </xsl:if>
        <xsl:if test="$selOrg = '0' or $selOrg = '3'">
           <th class="titleClass">Total</th>
        </xsl:if>

        <xsl:if test="$selOrg = '0' or $selOrg = '1'">
           <th class="titleClass">Academic</th>
        </xsl:if>
        <xsl:if test="$selOrg = '0' or $selOrg = '2'">
           <th class="titleClass">Non-Acad</th>
        </xsl:if>
        <xsl:if test="$selOrg = '0' or $selOrg = '3'">
           <th class="titleClass">Total</th>
        </xsl:if>
  </tr>

  <xsl:variable name="acadKeyPst" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="nonAcadKeyPst" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="allKeyPst" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="acadKeyEml" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="nonAcadKeyEml" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="allKeyEml" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="acadKeyIml" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="nonAcadKeyIml" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="allKeyIml" select="'0'" saxon:assignable="yes"/>


  <xsl:variable name="acadKeyReqPst" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="nonAcadKeyReqPst" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="allKeyReqPst" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="acadKeyReqEml" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="nonAcadKeyReqEml" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="allKeyReqEml" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="acadKeyReqIml" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="nonAcadKeyReqIml" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="allKeyReqIml" select="'0'" saxon:assignable="yes"/>

  <xsl:variable name="acadKeyReqNmPst" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="nonAcadKeyReqNmPst" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="allKeyReqNmPst" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="acadKeyReqNmEml" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="nonAcadKeyReqNmEml" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="allKeyReqNmEml" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="acadKeyReqNmIml" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="nonAcadKeyReqNmIml" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="allKeyReqNmIml" select="'0'" saxon:assignable="yes"/>


  <xsl:variable name="firstTime" select="'1'" saxon:assignable="yes"/>
  <xsl:variable name="currCNT" select="''" saxon:assignable="yes"/>
  <xsl:variable name="prevCNT" select="''" saxon:assignable="yes"/>

  <xsl:variable name="prefixKey" select="'ALLCOUN'" saxon:assignable="yes"/>


  <xsl:for-each select="Record">
  <xsl:if test="./CNTTYPE = 'C'">

    <xsl:if test="$firstTime = '1'">
      <saxon:assign name="prevCNT" select="./CNTNAME"/>
      <saxon:assign name="firstTime" select="'2'"/>
    </xsl:if>

    <saxon:assign name="currCNT" select="./CNTNAME"/>

<!-- After I have read all the rows from the table, I put them here in 1 Row -->
    <xsl:if test="$currCNT != $prevCNT">

      <tr>
          <th class="titleClass"><xsl:value-of select="$prevCNT"/></th>
      <xsl:if test="$selOrg = '0' or $selOrg = '1'">
          <td class="sumClass"><xsl:value-of select="$acadKeyPst"/></td>
       <input type="hidden" name='pstCount|{$acadKeyReqNmPst}' value="{$acadKeyPst}" />
      </xsl:if>
      <xsl:if test="$selOrg = '0' or $selOrg = '2'">
          <td class="sumClass"><xsl:value-of select="$nonAcadKeyPst"/></td>
       <input type="hidden" name='pstCount|{$nonAcadKeyReqNmPst}' value="{$nonAcadKeyPst}" />
      </xsl:if>
      <xsl:if test="$selOrg = '0' or $selOrg = '3'">
          <td class="sumClass"><xsl:value-of select="$allKeyPst"/></td>
       <input type="hidden" name='pstCount|{$allKeyReqNmPst}' value="{$allKeyPst}" />
      </xsl:if>

      <xsl:if test="$selOrg = '0' or $selOrg = '1'">
        <xsl:choose>
        <xsl:when test="$acadKeyPst != '0'">
              <td ><input size="5" type="text" name="{$acadKeyReqNmPst}"  value="{$acadKeyReqPst}"/></td>
           <input type="hidden" name='cntName' value="{$acadKeyReqNmPst}" />
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
      <xsl:if test="$selOrg = '0' or $selOrg = '2'">
        <xsl:choose>
        <xsl:when test="$nonAcadKeyPst != '0'">
              <td ><input size="5" type="text" name="{$nonAcadKeyReqNmPst}"  value="{$nonAcadKeyReqPst}"/></td>
           <input type="hidden" name='cntName' value="{$nonAcadKeyReqNmPst}" />
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
      <xsl:if test="$selOrg = '0' or $selOrg = '3'">
        <xsl:choose>
        <xsl:when test="$allKeyPst != '0'">
            <td ><input size="5" type="text" name="{$allKeyReqNmPst}"  value="{$allKeyReqPst}"/></td>
           <input type="hidden" name='cntName' value="{$allKeyReqNmPst}" />
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
      </xsl:if>

          <xsl:if test="$selOrg = '0' or $selOrg = '1'">
               <td class="sumClass"><xsl:value-of select="$acadKeyEml"/></td>
         <input type="hidden" name='emlCount|{$acadKeyReqNmEml}' value="{$acadKeyEml}" />
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '2'">
             <td class="sumClass"><xsl:value-of select="$nonAcadKeyEml"/></td>
       <input type="hidden" name='emlCount|{$nonAcadKeyReqNmEml}' value="{$nonAcadKeyEml}" />
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '3'">
             <td class="sumClass"><xsl:value-of select="$allKeyEml"/></td>
       <input type="hidden" name='emlCount|{$allKeyReqNmEml}' value="{$allKeyEml}" />
          </xsl:if>

          <xsl:if test="$selOrg = '0' or $selOrg = '1'">
        <xsl:choose>
        <xsl:when test="$acadKeyEml != '0'">
                 <td ><input size="5" type="text" name="{$acadKeyReqNmEml}"  value="{$acadKeyReqEml}"/></td>
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '2'">
        <xsl:choose>
        <xsl:when test="$nonAcadKeyEml != '0'">
                 <td ><input size="5" type="text" name="{$nonAcadKeyReqNmEml}"  value="{$nonAcadKeyReqEml}"/></td>
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '3'">
        <xsl:choose>
        <xsl:when test="$allKeyEml != '0'">
                 <td ><input size="5" type="text" name="{$allKeyReqNmEml}"  value="{$allKeyReqEml}"/></td>
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
          </xsl:if>

              <xsl:if test="$selOrg = '0' or $selOrg = '1'">
                       <td class="sumClass"><xsl:value-of select="$acadKeyIml"/></td>
                     <input type="hidden" name='imlCount|{$acadKeyReqNmIml}' value="{$acadKeyIml}" />
              </xsl:if>
              <xsl:if test="$selOrg = '0' or $selOrg = '2'">
                 <td class="sumClass"><xsl:value-of select="$nonAcadKeyIml"/></td>
                 <input type="hidden" name='imlCount|{$nonAcadKeyReqNmIml}' value="{$nonAcadKeyIml}" />
              </xsl:if>
              <xsl:if test="$selOrg = '0' or $selOrg = '3'">
                 <td class="sumClass"><xsl:value-of select="$allKeyIml"/></td>
                 <input type="hidden" name='imlCount|{$allKeyReqNmIml}' value="{$allKeyIml}" />
              </xsl:if>

              <xsl:if test="$selOrg = '0' or $selOrg = '1'">
                    <xsl:choose>
                    <xsl:when test="$acadKeyIml != '0'">
                         <td ><input size="5" type="text" name="{$acadKeyReqNmIml}"  value="{$acadKeyReqIml}"/></td>
                    </xsl:when>
                    <xsl:otherwise>
                        <td><script type="text/javascript">putNbsp()</script> </td>
                    </xsl:otherwise>
                    </xsl:choose>
              </xsl:if>
              <xsl:if test="$selOrg = '0' or $selOrg = '2'">
                    <xsl:choose>
                    <xsl:when test="$nonAcadKeyIml != '0'">
                         <td ><input size="5" type="text" name="{$nonAcadKeyReqNmIml}"  value="{$nonAcadKeyReqIml}"/></td>
                    </xsl:when>
                    <xsl:otherwise>
                        <td><script type="text/javascript">putNbsp()</script> </td>
                    </xsl:otherwise>
                    </xsl:choose>
              </xsl:if>
              <xsl:if test="$selOrg = '0' or $selOrg = '3'">
                    <xsl:choose>
                    <xsl:when test="$allKeyIml != '0'">
                         <td ><input size="5" type="text" name="{$allKeyReqNmIml}"  value="{$allKeyReqIml}"/></td>
                    </xsl:when>
                    <xsl:otherwise>
                        <td><script type="text/javascript">putNbsp()</script> </td>
                    </xsl:otherwise>
                    </xsl:choose>
              </xsl:if>

      </tr>

      <!-- Re Initialize all Values -->
      <saxon:assign name="acadKeyPst" select="'0'"/>
      <saxon:assign name="nonAcadKeyPst" select="'0'"/>
      <saxon:assign name="allKeyPst" select="'0'"/>
      <saxon:assign name="acadKeyEml" select="'0'"/>
      <saxon:assign name="nonAcadKeyEml" select="'0'"/>
      <saxon:assign name="allKeyEml" select="'0'"/>
            <saxon:assign name="acadKeyIml" select="'0'"/>
            <saxon:assign name="nonAcadKeyIml" select="'0'"/>
            <saxon:assign name="allKeyIml" select="'0'"/>

      <saxon:assign name="acadKeyReqNmPst" select="'0'"/>
      <saxon:assign name="nonAcadKeyReqNmPst" select="'0'"/>
      <saxon:assign name="allKeyReqNmPst" select="'0'"/>
      <saxon:assign name="acadKeyReqNmEml" select="'0'"/>
      <saxon:assign name="nonAcadKeyReqNmEml" select="'0'"/>
      <saxon:assign name="allKeyReqNmEml" select="'0'"/>
            <saxon:assign name="acadKeyReqNmIml" select="'0'"/>
            <saxon:assign name="nonAcadKeyReqNmIml" select="'0'"/>
            <saxon:assign name="allKeyReqNmIml" select="'0'"/>

      <saxon:assign name="acadKeyReqPst" select="'0'"/>
      <saxon:assign name="nonAcadKeyReqPst" select="'0'"/>
      <saxon:assign name="allKeyReqPst" select="'0'"/>
      <saxon:assign name="acadKeyReqEml" select="'0'"/>
      <saxon:assign name="nonAcadKeyReqEml" select="'0'"/>
      <saxon:assign name="allKeyReqEml" select="'0'"/>
            <saxon:assign name="acadKeyReqIml" select="'0'"/>
            <saxon:assign name="nonAcadKeyReqIml" select="'0'"/>
            <saxon:assign name="allKeyReqIml" select="'0'"/>

      <saxon:assign name="prevCNT" select="./CNTNAME"/>
    </xsl:if>

<!-- Read tde values of the 6 or 3 or 1 row from the table and save it in the variables -->

    <xsl:if test="./CNTCATG = 'A'">
      <saxon:assign name="acadKeyPst" select="./PCNTVALUE" />
      <saxon:assign name="acadKeyReqPst" select="./PCNTSREQUIRED" />
      <saxon:assign name="acadKeyReqNmPst" select="concat ($prefixKey, ';', 'CTT', ';', 'ACAD', ';', 'PSTKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
      <saxon:assign name="acadKeyEml" select="./ECNTVALUE" />
      <saxon:assign name="acadKeyReqEml" select="./ECNTSREQUIRED" />
      <saxon:assign name="acadKeyReqNmEml" select="concat ($prefixKey, ';', 'CTT', ';', 'ACAD', ';', 'EMLKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
            <saxon:assign name="acadKeyIml" select="./ICNTVALUE" />
            <saxon:assign name="acadKeyReqIml" select="./ICNTSREQUIRED" />
            <saxon:assign name="acadKeyReqNmIml" select="concat ($prefixKey, ';', 'CTT', ';', 'ACAD', ';', 'IMLKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
    </xsl:if>

    <xsl:if test="./CNTCATG = 'N'">
      <saxon:assign name="nonAcadKeyPst" select="./PCNTVALUE" />
      <saxon:assign name="nonAcadKeyReqPst" select="./PCNTSREQUIRED" />
      <saxon:assign name="nonAcadKeyReqNmPst" select="concat ($prefixKey, ';', 'CTT', ';', 'NONACD', ';', 'PSTKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
      <saxon:assign name="nonAcadKeyEml" select="./ECNTVALUE" />
      <saxon:assign name="nonAcadKeyReqEml" select="./ECNTSREQUIRED" />
      <saxon:assign name="nonAcadKeyReqNmEml" select="concat ($prefixKey, ';', 'CTT', ';', 'NONACD', ';', 'EMLKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
            <saxon:assign name="nonAcadKeyIml" select="./ICNTVALUE" />
            <saxon:assign name="nonAcadKeyReqIml" select="./ICNTSREQUIRED" />
            <saxon:assign name="nonAcadKeyReqNmIml" select="concat ($prefixKey, ';', 'CTT', ';', 'NONACD', ';', 'IMLKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
    </xsl:if>

    <xsl:if test="./CNTCATG = 'T'">
      <saxon:assign name="allKeyPst" select="./PCNTVALUE" />
      <saxon:assign name="allKeyReqPst" select="./PCNTSREQUIRED" />
      <saxon:assign name="allKeyReqNmPst" select="concat ($prefixKey, ';', 'CTT', ';', 'ALLTOTAL', ';', 'PSTKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
      <saxon:assign name="allKeyEml" select="./ECNTVALUE" />
      <saxon:assign name="allKeyReqEml" select="./ECNTSREQUIRED" />
      <saxon:assign name="allKeyReqNmEml" select="concat ($prefixKey, ';', 'CTT', ';', 'ALLTOTAL', ';', 'EMLKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
            <saxon:assign name="allKeyIml" select="./ICNTVALUE" />
            <saxon:assign name="allKeyReqIml" select="./ICNTSREQUIRED" />
            <saxon:assign name="allKeyReqNmIml" select="concat ($prefixKey, ';', 'CTT', ';', 'ALLTOTAL', ';', 'IMLKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
    </xsl:if>

  </xsl:if>
  </xsl:for-each>
      <tr>
          <th class="titleClass"><xsl:value-of select="$prevCNT"/></th>
      <xsl:if test="$selOrg = '0' or $selOrg = '1'">
          <td class="sumClass"><xsl:value-of select="$acadKeyPst"/></td>
       <input type="hidden" name='pstCount|{$acadKeyReqNmPst}' value="{$acadKeyPst}" />
      </xsl:if>
      <xsl:if test="$selOrg = '0' or $selOrg = '2'">
          <td class="sumClass"><xsl:value-of select="$nonAcadKeyPst"/></td>
       <input type="hidden" name='pstCount|{$nonAcadKeyReqNmPst}' value="{$nonAcadKeyPst}" />
      </xsl:if>
      <xsl:if test="$selOrg = '0' or $selOrg = '3'">
          <td class="sumClass"><xsl:value-of select="$allKeyPst"/></td>
       <input type="hidden" name='pstCount|{$allKeyReqNmPst}' value="{$allKeyPst}" />
      </xsl:if>

      <xsl:if test="$selOrg = '0' or $selOrg = '1'">
        <xsl:choose>
        <xsl:when test="$acadKeyPst != '0'">
              <td ><input size="5" type="text" name="{$acadKeyReqNmPst}"  value="{$acadKeyReqPst}"/></td>
           <input type="hidden" name='cntName' value="{$acadKeyReqNmPst}" />
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
      <xsl:if test="$selOrg = '0' or $selOrg = '2'">
        <xsl:choose>
        <xsl:when test="$nonAcadKeyPst != '0'">
              <td ><input size="5" type="text" name="{$nonAcadKeyReqNmPst}"  value="{$nonAcadKeyReqPst}"/></td>
           <input type="hidden" name='cntName' value="{$nonAcadKeyReqNmPst}" />
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
      <xsl:if test="$selOrg = '0' or $selOrg = '3'">
        <xsl:choose>
        <xsl:when test="$allKeyPst != '0'">
            <td ><input size="5" type="text" name="{$allKeyReqNmPst}"  value="{$allKeyReqPst}"/></td>
           <input type="hidden" name='cntName' value="{$allKeyReqNmPst}" />
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
      </xsl:if>

          <xsl:if test="$selOrg = '0' or $selOrg = '1'">
               <td class="sumClass"><xsl:value-of select="$acadKeyEml"/></td>
         <input type="hidden" name='emlCount|{$acadKeyReqNmEml}' value="{$acadKeyEml}" />
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '2'">
             <td class="sumClass"><xsl:value-of select="$nonAcadKeyEml"/></td>
       <input type="hidden" name='emlCount|{$nonAcadKeyReqNmEml}' value="{$nonAcadKeyEml}" />
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '3'">
             <td class="sumClass"><xsl:value-of select="$allKeyEml"/></td>
       <input type="hidden" name='emlCount|{$allKeyReqNmEml}' value="{$allKeyEml}" />
          </xsl:if>

          <xsl:if test="$selOrg = '0' or $selOrg = '1'">
        <xsl:choose>
        <xsl:when test="$acadKeyEml != '0'">
                 <td ><input size="5" type="text" name="{$acadKeyReqNmEml}"  value="{$acadKeyReqEml}"/></td>
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '2'">
        <xsl:choose>
        <xsl:when test="$nonAcadKeyEml != '0'">
                 <td ><input size="5" type="text" name="{$nonAcadKeyReqNmEml}"  value="{$nonAcadKeyReqEml}"/></td>
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '3'">
        <xsl:choose>
        <xsl:when test="$allKeyEml != '0'">
                 <td ><input size="5" type="text" name="{$allKeyReqNmEml}"  value="{$allKeyReqEml}"/></td>
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
          </xsl:if>

              <xsl:if test="$selOrg = '0' or $selOrg = '1'">
                       <td class="sumClass"><xsl:value-of select="$acadKeyIml"/></td>
                     <input type="hidden" name='imlCount|{$acadKeyReqNmIml}' value="{$acadKeyIml}" />
              </xsl:if>
              <xsl:if test="$selOrg = '0' or $selOrg = '2'">
                 <td class="sumClass"><xsl:value-of select="$nonAcadKeyIml"/></td>
                 <input type="hidden" name='imlCount|{$nonAcadKeyReqNmIml}' value="{$nonAcadKeyIml}" />
              </xsl:if>
              <xsl:if test="$selOrg = '0' or $selOrg = '3'">
                 <td class="sumClass"><xsl:value-of select="$allKeyIml"/></td>
                 <input type="hidden" name='imlCount|{$allKeyReqNmIml}' value="{$allKeyIml}" />
              </xsl:if>

              <xsl:if test="$selOrg = '0' or $selOrg = '1'">
                    <xsl:choose>
                    <xsl:when test="$acadKeyIml != '0'">
                         <td ><input size="5" type="text" name="{$acadKeyReqNmIml}"  value="{$acadKeyReqIml}"/></td>
                    </xsl:when>
                    <xsl:otherwise>
                        <td><script type="text/javascript">putNbsp()</script> </td>
                    </xsl:otherwise>
                    </xsl:choose>
              </xsl:if>
              <xsl:if test="$selOrg = '0' or $selOrg = '2'">
                    <xsl:choose>
                    <xsl:when test="$nonAcadKeyIml != '0'">
                         <td ><input size="5" type="text" name="{$nonAcadKeyReqNmIml}"  value="{$nonAcadKeyReqIml}"/></td>
                    </xsl:when>
                    <xsl:otherwise>
                        <td><script type="text/javascript">putNbsp()</script> </td>
                    </xsl:otherwise>
                    </xsl:choose>
              </xsl:if>
              <xsl:if test="$selOrg = '0' or $selOrg = '3'">
                    <xsl:choose>
                    <xsl:when test="$allKeyIml != '0'">
                         <td ><input size="5" type="text" name="{$allKeyReqNmIml}"  value="{$allKeyReqIml}"/></td>
                    </xsl:when>
                    <xsl:otherwise>
                        <td><script type="text/javascript">putNbsp()</script> </td>
                    </xsl:otherwise>
                    </xsl:choose>
              </xsl:if>


      </tr>

    <th> TOTAL </th>
    <xsl:if test="$selOrg = '0' or $selOrg = '1'">
       <th><script type="text/javascript">putNbsp()</script> </th>
    </xsl:if>
    <xsl:if test="$selOrg = '0' or $selOrg = '2'">
       <th><script type="text/javascript">putNbsp()</script> </th>
    </xsl:if>
    <xsl:if test="$selOrg = '0' or $selOrg = '3'">
       <th><script type="text/javascript">putNbsp()</script> </th>
    </xsl:if>
    <xsl:if test="$selOrg = '0' or $selOrg = '1'">
          <th class="titleClass"><input size="5" type="text" name="acadTotalPostalCTT"  value=""/></th>
    </xsl:if>
    <xsl:if test="$selOrg = '0' or $selOrg = '2'">
          <th class="titleClass"><input size="5" type="text" name="nonAcadTotalPostalCTT"  value=""/></th>
    </xsl:if>
    <xsl:if test="$selOrg = '0' or $selOrg = '3'">
          <th class="titleClass"><input size="5" type="text" name="allTotalPostalCTT"  value=""/></th>
    </xsl:if>
    <xsl:if test="$selOrg = '0' or $selOrg = '1'">
       <th><script type="text/javascript">putNbsp()</script></th>
    </xsl:if>
    <xsl:if test="$selOrg = '0' or $selOrg = '2'">
    <th><script type="text/javascript">putNbsp()</script></th>
       </xsl:if>
    <xsl:if test="$selOrg = '0' or $selOrg = '3'">
       <th><script type="text/javascript">putNbsp()</script></th>
    </xsl:if>
    <xsl:if test="$selOrg = '0' or $selOrg = '1'">
          <th class="titleClass"><input size="5" type="text" name="acadTotalEmailCTT"  value=""/></th>
    </xsl:if>
    <xsl:if test="$selOrg = '0' or $selOrg = '2'">
          <th class="titleClass"><input size="5" type="text" name="nonAcadTotalEmailCTT"  value=""/></th>
    </xsl:if>
    <xsl:if test="$selOrg = '0' or $selOrg = '3'">
          <th class="titleClass"><input size="5" type="text" name="allTotalEmailCTT"  value=""/></th>
    </xsl:if>
        <xsl:if test="$selOrg = '0' or $selOrg = '1'">
           <th><script type="text/javascript">putNbsp()</script></th>
        </xsl:if>
        <xsl:if test="$selOrg = '0' or $selOrg = '2'">
        <th><script type="text/javascript">putNbsp()</script></th>
           </xsl:if>
        <xsl:if test="$selOrg = '0' or $selOrg = '3'">
           <th><script type="text/javascript">putNbsp()</script></th>
        </xsl:if>
        <xsl:if test="$selOrg = '0' or $selOrg = '1'">
                <th class="titleClass"><input size="5" type="text" name="acadTotalImailCTT"  value=""/></th>
        </xsl:if>
        <xsl:if test="$selOrg = '0' or $selOrg = '2'">
                <th class="titleClass"><input size="5" type="text" name="nonAcadTotalImailCTT"  value=""/></th>
        </xsl:if>
        <xsl:if test="$selOrg = '0' or $selOrg = '3'">
                <th class="titleClass"><input size="5" type="text" name="allTotalImailCTT"  value=""/></th>
        </xsl:if>

    </table>
  </div>
    </xsl:if>


  <br></br> <br></br>

<!-- p4 -->

  <xsl:if test="Record/CNTTYPE = 'S'">
  <div class="countryBox">
    <table class="summaryTable"  border="1" cellpadding="1" cellspacing="1">

  <tr>

        <!-- old -->
    <!--<xsl:variable name="numOfColumnsNew">-->
      <!--<xsl:if test="$numOfColumns = 1">2</xsl:if>-->
      <!--<xsl:if test="$numOfColumns != 1"><xsl:value-of select="$numOfColumns"/></xsl:if>-->
    <!--</xsl:variable>-->
        <!-- new -->
    <xsl:variable name="numOfColumnsNew">
      <xsl:if test="$numOfColumns = 1">2</xsl:if>
      <xsl:if test="$numOfColumns != 1">6</xsl:if>
    </xsl:variable>


    <th rowspan="3"> </th>

            <th class="titleClass" colspan="{$numOfColumnsNew}">Postal (
            <input type="checkbox" name="includeEmail3" value="I" onclick="selectIncludeEmail(document.resultsForm, this)">
            <xsl:variable name="inclVal">
                <xsl:value-of select="Record/INCEMAIL" />
            </xsl:variable>
            <xsl:if test="'I' = $inclVal">
                <xsl:attribute name="checked">true</xsl:attribute>
            </xsl:if>
            </input> Include Email)
      <br></br> Select All :
            <xsl:if test="$selOrg = '0' or $selOrg = '1'">
               <input type="radio" name="selectAll" value="acadVal" onclick="javascript:selectAllAndCopy(document.resultsForm, 'pstCount', 'ACAD', 'STT')"/> Acad
            </xsl:if>
            <xsl:if test="$selOrg = '0' or $selOrg = '2'">
               <input type="radio" name="selectAll" value="nonAcadVal" onclick="javascript:selectAllAndCopy(document.resultsForm, 'pstCount', 'NONACD', 'STT')"/> Non-Acad
            </xsl:if>
            <xsl:if test="$selOrg = '0' or $selOrg = '3'">
               <input type="radio" name="selectAll" value="totalVal" onclick="javascript:selectAllAndCopy(document.resultsForm, 'pstCount', 'ALLTOTAL', 'STT')"/> Total
            </xsl:if>

      </th>

            <th class="titleClass" colspan="{$numOfColumnsNew}">Email
      <br></br> Select All :
            <xsl:if test="$selOrg = '0' or $selOrg = '1'">
               <input type="radio" name="selectAll" value="acadVal" onclick="javascript:selectAllAndCopy(document.resultsForm, 'emlCount', 'ACAD', 'STT')"/> Acad
            </xsl:if>
            <xsl:if test="$selOrg = '0' or $selOrg = '2'">
               <input type="radio" name="selectAll" value="nonAcadVal" onclick="javascript:selectAllAndCopy(document.resultsForm, 'emlCount', 'NONACD', 'STT')"/> Non-Acad
            </xsl:if>
            <xsl:if test="$selOrg = '0' or $selOrg = '3'">
               <input type="radio" name="selectAll" value="totalVal" onclick="javascript:selectAllAndCopy(document.resultsForm, 'emlCount', 'ALLTOTAL', 'STT')"/> Total
            </xsl:if>
      </th>
        <th class="titleClass" colspan="{$numOfColumnsNew}">Emails with Invalid Postal
        <br></br> Select All :
        <xsl:if test="$selOrg = '0' or $selOrg = '1'">
           <input type="radio" name="selectAll" value="acadVal" onclick="javascript:selectAllAndCopy(document.resultsForm, 'imlCount', 'ACAD', 'STT')"/> Acad
        </xsl:if>
        <xsl:if test="$selOrg = '0' or $selOrg = '2'">
           <input type="radio" name="selectAll" value="nonAcadVal" onclick="javascript:selectAllAndCopy(document.resultsForm, 'imlCount', 'NONACD', 'STT')"/> Non-Acad
        </xsl:if>
        <xsl:if test="$selOrg = '0' or $selOrg = '3'">
           <input type="radio" name="selectAll" value="totalVal" onclick="javascript:selectAllAndCopy(document.resultsForm, 'imlCount', 'ALLTOTAL', 'STT')"/> Total
        </xsl:if>
        </th>
  </tr>

  <tr>
    <xsl:variable name="numOfColumnsNew2">
      <xsl:if test="$numOfColumns = 1">1</xsl:if>
      <xsl:if test="$numOfColumns != 1">3</xsl:if>
    </xsl:variable>

      <th align="center" colspan="{$numOfColumnsNew2}"> Results </th>
      <th align="center" colspan="{$numOfColumnsNew2}"> Ordered </th>
      <th align="center" colspan="{$numOfColumnsNew2}"> Results </th>
      <th align="center" colspan="{$numOfColumnsNew2}"> Ordered </th>
        <th align="center" colspan="{$numOfColumnsNew2}"> Results </th>
        <th align="center" colspan="{$numOfColumnsNew2}"> Ordered </th>
  </tr>

  <tr>
          <xsl:if test="$selOrg = '0' or $selOrg = '1'">
             <th class="titleClass">Academic</th>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '2'">
             <th class="titleClass">Non-Acad</th>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '3'">
             <th class="titleClass">All</th>
          </xsl:if>

      <xsl:if test="$selOrg = '0' or $selOrg = '1'">
             <th class="titleClass">Academic</th>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '2'">
             <th class="titleClass">Non-Acad</th>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '3'">
             <th class="titleClass">Total</th>
          </xsl:if>

      <xsl:if test="$selOrg = '0' or $selOrg = '1'">
             <th class="titleClass">Academic</th>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '2'">
             <th class="titleClass">Non-Acad</th>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '3'">
             <th class="titleClass">Total</th>
          </xsl:if>

          <xsl:if test="$selOrg = '0' or $selOrg = '1'">
             <th class="titleClass">Academic</th>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '2'">
             <th class="titleClass">Non-Acad</th>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '3'">
             <th class="titleClass">Total</th>
          </xsl:if>

        <xsl:if test="$selOrg = '0' or $selOrg = '1'">
           <th class="titleClass">Academic</th>
        </xsl:if>
        <xsl:if test="$selOrg = '0' or $selOrg = '2'">
           <th class="titleClass">Non-Acad</th>
        </xsl:if>
        <xsl:if test="$selOrg = '0' or $selOrg = '3'">
           <th class="titleClass">Total</th>
        </xsl:if>

        <xsl:if test="$selOrg = '0' or $selOrg = '1'">
           <th class="titleClass">Academic</th>
        </xsl:if>
        <xsl:if test="$selOrg = '0' or $selOrg = '2'">
           <th class="titleClass">Non-Acad</th>
        </xsl:if>
        <xsl:if test="$selOrg = '0' or $selOrg = '3'">
           <th class="titleClass">Total</th>
        </xsl:if>
  </tr>

  <xsl:variable name="acadKeyPst" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="nonAcadKeyPst" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="allKeyPst" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="acadKeyEml" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="nonAcadKeyEml" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="allKeyEml" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="acadKeyIml" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="nonAcadKeyIml" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="allKeyIml" select="'0'" saxon:assignable="yes"/>


  <xsl:variable name="acadKeyReqPst" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="nonAcadKeyReqPst" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="allKeyReqPst" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="acadKeyReqEml" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="nonAcadKeyReqEml" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="allKeyReqEml" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="acadKeyReqIml" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="nonAcadKeyReqIml" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="allKeyReqIml" select="'0'" saxon:assignable="yes"/>

  <xsl:variable name="acadKeyReqNmPst" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="nonAcadKeyReqNmPst" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="allKeyReqNmPst" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="acadKeyReqNmEml" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="nonAcadKeyReqNmEml" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="allKeyReqNmEml" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="acadKeyReqNmIml" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="nonAcadKeyReqNmIml" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="allKeyReqNmIml" select="'0'" saxon:assignable="yes"/>


  <xsl:variable name="firstTime" select="'1'" saxon:assignable="yes"/>
  <xsl:variable name="currCNT" select="''" saxon:assignable="yes"/>
  <xsl:variable name="prevCNT" select="''" saxon:assignable="yes"/>

  <xsl:variable name="prefixKey" select="'ALLCOUN'" saxon:assignable="yes"/>


  <xsl:for-each select="Record">
  <xsl:if test="./CNTTYPE = 'S'">

    <xsl:if test="$firstTime = '1'">
      <saxon:assign name="prevCNT" select="./CNTNAME"/>
      <saxon:assign name="firstTime" select="'2'"/>
    </xsl:if>

    <saxon:assign name="currCNT" select="./CNTNAME"/>

<!-- After I have read all the rows from the table, I put them here in 1 Row -->
    <xsl:if test="$currCNT != $prevCNT">

      <tr>
          <th class="titleClass"><xsl:value-of select="$prevCNT"/></th>
      <xsl:if test="$selOrg = '0' or $selOrg = '1'">
          <td class="sumClass"><xsl:value-of select="$acadKeyPst"/></td>
       <input type="hidden" name='pstCount|{$acadKeyReqNmPst}' value="{$acadKeyPst}" />
      </xsl:if>
      <xsl:if test="$selOrg = '0' or $selOrg = '2'">
          <td class="sumClass"><xsl:value-of select="$nonAcadKeyPst"/></td>
       <input type="hidden" name='pstCount|{$nonAcadKeyReqNmPst}' value="{$nonAcadKeyPst}" />
      </xsl:if>
      <xsl:if test="$selOrg = '0' or $selOrg = '3'">
          <td class="sumClass"><xsl:value-of select="$allKeyPst"/></td>
       <input type="hidden" name='pstCount|{$allKeyReqNmPst}' value="{$allKeyPst}" />
      </xsl:if>

      <xsl:if test="$selOrg = '0' or $selOrg = '1'">
        <xsl:choose>
        <xsl:when test="$acadKeyPst != '0'">
              <td ><input size="5" type="text" name="{$acadKeyReqNmPst}"  value="{$acadKeyReqPst}"/></td>
           <input type="hidden" name='cntName' value="{$acadKeyReqNmPst}" />
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
      <xsl:if test="$selOrg = '0' or $selOrg = '2'">
        <xsl:choose>
        <xsl:when test="$nonAcadKeyPst != '0'">
              <td ><input size="5" type="text" name="{$nonAcadKeyReqNmPst}"  value="{$nonAcadKeyReqPst}"/></td>
           <input type="hidden" name='cntName' value="{$nonAcadKeyReqNmPst}" />
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
      <xsl:if test="$selOrg = '0' or $selOrg = '3'">
        <xsl:choose>
        <xsl:when test="$allKeyPst != '0'">
            <td ><input size="5" type="text" name="{$allKeyReqNmPst}"  value="{$allKeyReqPst}"/></td>
           <input type="hidden" name='cntName' value="{$allKeyReqNmPst}" />
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
      </xsl:if>

          <xsl:if test="$selOrg = '0' or $selOrg = '1'">
               <td class="sumClass"><xsl:value-of select="$acadKeyEml"/></td>
         <input type="hidden" name='emlCount|{$acadKeyReqNmEml}' value="{$acadKeyEml}" />
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '2'">
             <td class="sumClass"><xsl:value-of select="$nonAcadKeyEml"/></td>
       <input type="hidden" name='emlCount|{$nonAcadKeyReqNmEml}' value="{$nonAcadKeyEml}" />
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '3'">
             <td class="sumClass"><xsl:value-of select="$allKeyEml"/></td>
       <input type="hidden" name='emlCount|{$allKeyReqNmEml}' value="{$allKeyEml}" />
          </xsl:if>

          <xsl:if test="$selOrg = '0' or $selOrg = '1'">
        <xsl:choose>
        <xsl:when test="$acadKeyEml != '0'">
                 <td ><input size="5" type="text" name="{$acadKeyReqNmEml}"  value="{$acadKeyReqEml}"/></td>
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '2'">
        <xsl:choose>
        <xsl:when test="$nonAcadKeyEml != '0'">
                 <td ><input size="5" type="text" name="{$nonAcadKeyReqNmEml}"  value="{$nonAcadKeyReqEml}"/></td>
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '3'">
        <xsl:choose>
        <xsl:when test="$allKeyEml != '0'">
                 <td ><input size="5" type="text" name="{$allKeyReqNmEml}"  value="{$allKeyReqEml}"/></td>
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
          </xsl:if>
              <xsl:if test="$selOrg = '0' or $selOrg = '1'">
                       <td class="sumClass"><xsl:value-of select="$acadKeyIml"/></td>
                     <input type="hidden" name='imlCount|{$acadKeyReqNmIml}' value="{$acadKeyIml}" />
              </xsl:if>
              <xsl:if test="$selOrg = '0' or $selOrg = '2'">
                 <td class="sumClass"><xsl:value-of select="$nonAcadKeyIml"/></td>
                 <input type="hidden" name='imlCount|{$nonAcadKeyReqNmIml}' value="{$nonAcadKeyIml}" />
              </xsl:if>
              <xsl:if test="$selOrg = '0' or $selOrg = '3'">
                 <td class="sumClass"><xsl:value-of select="$allKeyIml"/></td>
                 <input type="hidden" name='imlCount|{$allKeyReqNmIml}' value="{$allKeyIml}" />
              </xsl:if>

              <xsl:if test="$selOrg = '0' or $selOrg = '1'">
                    <xsl:choose>
                    <xsl:when test="$acadKeyIml != '0'">
                         <td ><input size="5" type="text" name="{$acadKeyReqNmIml}"  value="{$acadKeyReqIml}"/></td>
                    </xsl:when>
                    <xsl:otherwise>
                        <td><script type="text/javascript">putNbsp()</script> </td>
                    </xsl:otherwise>
                    </xsl:choose>
              </xsl:if>
              <xsl:if test="$selOrg = '0' or $selOrg = '2'">
                    <xsl:choose>
                    <xsl:when test="$nonAcadKeyIml != '0'">
                         <td ><input size="5" type="text" name="{$nonAcadKeyReqNmIml}"  value="{$nonAcadKeyReqIml}"/></td>
                    </xsl:when>
                    <xsl:otherwise>
                        <td><script type="text/javascript">putNbsp()</script> </td>
                    </xsl:otherwise>
                    </xsl:choose>
              </xsl:if>
              <xsl:if test="$selOrg = '0' or $selOrg = '3'">
                    <xsl:choose>
                    <xsl:when test="$allKeyIml != '0'">
                         <td ><input size="5" type="text" name="{$allKeyReqNmIml}"  value="{$allKeyReqIml}"/></td>
                    </xsl:when>
                    <xsl:otherwise>
                        <td><script type="text/javascript">putNbsp()</script> </td>
                    </xsl:otherwise>
                    </xsl:choose>
              </xsl:if>

      </tr>

      <!-- Re Initialize all Values -->
      <saxon:assign name="acadKeyPst" select="'0'"/>
      <saxon:assign name="nonAcadKeyPst" select="'0'"/>
      <saxon:assign name="allKeyPst" select="'0'"/>
      <saxon:assign name="acadKeyEml" select="'0'"/>
      <saxon:assign name="nonAcadKeyEml" select="'0'"/>
      <saxon:assign name="allKeyEml" select="'0'"/>
            <saxon:assign name="acadKeyIml" select="'0'"/>
            <saxon:assign name="nonAcadKeyIml" select="'0'"/>
            <saxon:assign name="allKeyIml" select="'0'"/>

      <saxon:assign name="acadKeyReqNmPst" select="'0'"/>
      <saxon:assign name="nonAcadKeyReqNmPst" select="'0'"/>
      <saxon:assign name="allKeyReqNmPst" select="'0'"/>
      <saxon:assign name="acadKeyReqNmEml" select="'0'"/>
      <saxon:assign name="nonAcadKeyReqNmEml" select="'0'"/>
      <saxon:assign name="allKeyReqNmEml" select="'0'"/>
            <saxon:assign name="acadKeyReqNmIml" select="'0'"/>
            <saxon:assign name="nonAcadKeyReqNmIml" select="'0'"/>
            <saxon:assign name="allKeyReqNmIml" select="'0'"/>

      <saxon:assign name="acadKeyReqPst" select="'0'"/>
      <saxon:assign name="nonAcadKeyReqPst" select="'0'"/>
      <saxon:assign name="allKeyReqPst" select="'0'"/>
      <saxon:assign name="acadKeyReqEml" select="'0'"/>
      <saxon:assign name="nonAcadKeyReqEml" select="'0'"/>
      <saxon:assign name="allKeyReqEml" select="'0'"/>
            <saxon:assign name="acadKeyReqIml" select="'0'"/>
            <saxon:assign name="nonAcadKeyReqIml" select="'0'"/>
            <saxon:assign name="allKeyReqIml" select="'0'"/>

      <saxon:assign name="prevCNT" select="./CNTNAME"/>
    </xsl:if>

<!-- Read the values of the 6 or 3 or 1 row from the table and save it in the variables -->

    <xsl:if test="./CNTCATG = 'A'">
      <saxon:assign name="acadKeyPst" select="./PCNTVALUE" />
      <saxon:assign name="acadKeyReqPst" select="./PCNTSREQUIRED" />
      <saxon:assign name="acadKeyReqNmPst" select="concat ($prefixKey, ';', 'STT', ';', 'ACAD', ';', 'PSTKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
      <saxon:assign name="acadKeyEml" select="./ECNTVALUE" />
      <saxon:assign name="acadKeyReqEml" select="./ECNTSREQUIRED" />
      <saxon:assign name="acadKeyReqNmEml" select="concat ($prefixKey, ';', 'STT', ';', 'ACAD', ';', 'EMLKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
            <saxon:assign name="acadKeyIml" select="./ICNTVALUE" />
            <saxon:assign name="acadKeyReqIml" select="./ICNTSREQUIRED" />
            <saxon:assign name="acadKeyReqNmIml" select="concat ($prefixKey, ';', 'STT', ';', 'ACAD', ';', 'IMLKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
    </xsl:if>

    <xsl:if test="./CNTCATG = 'N'">
      <saxon:assign name="nonAcadKeyPst" select="./PCNTVALUE" />
      <saxon:assign name="nonAcadKeyReqPst" select="./PCNTSREQUIRED" />
      <saxon:assign name="nonAcadKeyReqNmPst" select="concat ($prefixKey, ';', 'STT', ';', 'NONACD', ';', 'PSTKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
      <saxon:assign name="nonAcadKeyEml" select="./ECNTVALUE" />
      <saxon:assign name="nonAcadKeyReqEml" select="./ECNTSREQUIRED" />
      <saxon:assign name="nonAcadKeyReqNmEml" select="concat ($prefixKey, ';', 'STT', ';', 'NONACD', ';', 'EMLKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
            <saxon:assign name="nonAcadKeyIml" select="./ICNTVALUE" />
            <saxon:assign name="nonAcadKeyReqIml" select="./ICNTSREQUIRED" />
            <saxon:assign name="nonAcadKeyReqNmIml" select="concat ($prefixKey, ';', 'STT', ';', 'NONACD', ';', 'IMLKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
    </xsl:if>

    <xsl:if test="./CNTCATG = 'T'">
      <saxon:assign name="allKeyPst" select="./PCNTVALUE" />
      <saxon:assign name="allKeyReqPst" select="./PCNTSREQUIRED" />
      <saxon:assign name="allKeyReqNmPst" select="concat ($prefixKey, ';', 'STT', ';', 'ALLTOTAL', ';', 'PSTKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
      <saxon:assign name="allKeyEml" select="./ECNTVALUE" />
      <saxon:assign name="allKeyReqEml" select="./ECNTSREQUIRED" />
      <saxon:assign name="allKeyReqNmEml" select="concat ($prefixKey, ';', 'STT', ';', 'ALLTOTAL', ';', 'EMLKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
            <saxon:assign name="allKeyIml" select="./ICNTVALUE" />
            <saxon:assign name="allKeyReqIml" select="./ICNTSREQUIRED" />
            <saxon:assign name="allKeyReqNmIml" select="concat ($prefixKey, ';', 'STT', ';', 'ALLTOTAL', ';', 'IMLKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
    </xsl:if>

  </xsl:if>
  </xsl:for-each>
      <tr>
          <th class="titleClass"><xsl:value-of select="$prevCNT"/></th>
      <xsl:if test="$selOrg = '0' or $selOrg = '1'">
          <td class="sumClass"><xsl:value-of select="$acadKeyPst"/></td>
       <input type="hidden" name='pstCount|{$acadKeyReqNmPst}' value="{$acadKeyPst}" />
      </xsl:if>
      <xsl:if test="$selOrg = '0' or $selOrg = '2'">
          <td class="sumClass"><xsl:value-of select="$nonAcadKeyPst"/></td>
       <input type="hidden" name='pstCount|{$nonAcadKeyReqNmPst}' value="{$nonAcadKeyPst}" />
      </xsl:if>
      <xsl:if test="$selOrg = '0' or $selOrg = '3'">
          <td class="sumClass"><xsl:value-of select="$allKeyPst"/></td>
       <input type="hidden" name='pstCount|{$allKeyReqNmPst}' value="{$allKeyPst}" />
      </xsl:if>

      <xsl:if test="$selOrg = '0' or $selOrg = '1'">
        <xsl:choose>
        <xsl:when test="$acadKeyPst != '0'">
              <td ><input size="5" type="text" name="{$acadKeyReqNmPst}"  value="{$acadKeyReqPst}"/></td>
           <input type="hidden" name='cntName' value="{$acadKeyReqNmPst}" />
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
      <xsl:if test="$selOrg = '0' or $selOrg = '2'">
        <xsl:choose>
        <xsl:when test="$nonAcadKeyPst != '0'">
              <td ><input size="5" type="text" name="{$nonAcadKeyReqNmPst}"  value="{$nonAcadKeyReqPst}"/></td>
           <input type="hidden" name='cntName' value="{$nonAcadKeyReqNmPst}" />
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
      <xsl:if test="$selOrg = '0' or $selOrg = '3'">
        <xsl:choose>
        <xsl:when test="$allKeyPst != '0'">
            <td ><input size="5" type="text" name="{$allKeyReqNmPst}"  value="{$allKeyReqPst}"/></td>
           <input type="hidden" name='cntName' value="{$allKeyReqNmPst}" />
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
      </xsl:if>

          <xsl:if test="$selOrg = '0' or $selOrg = '1'">
               <td class="sumClass"><xsl:value-of select="$acadKeyEml"/></td>
         <input type="hidden" name='emlCount|{$acadKeyReqNmEml}' value="{$acadKeyEml}" />
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '2'">
             <td class="sumClass"><xsl:value-of select="$nonAcadKeyEml"/></td>
       <input type="hidden" name='emlCount|{$nonAcadKeyReqNmEml}' value="{$nonAcadKeyEml}" />
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '3'">
             <td class="sumClass"><xsl:value-of select="$allKeyEml"/></td>
       <input type="hidden" name='emlCount|{$allKeyReqNmEml}' value="{$allKeyEml}" />
          </xsl:if>

          <xsl:if test="$selOrg = '0' or $selOrg = '1'">
        <xsl:choose>
        <xsl:when test="$acadKeyEml != '0'">
                 <td ><input size="5" type="text" name="{$acadKeyReqNmEml}"  value="{$acadKeyReqEml}"/></td>
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '2'">
        <xsl:choose>
        <xsl:when test="$nonAcadKeyEml != '0'">
                 <td ><input size="5" type="text" name="{$nonAcadKeyReqNmEml}"  value="{$nonAcadKeyReqEml}"/></td>
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '3'">
        <xsl:choose>
        <xsl:when test="$allKeyEml != '0'">
                 <td ><input size="5" type="text" name="{$allKeyReqNmEml}"  value="{$allKeyReqEml}"/></td>
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
          </xsl:if>
              <xsl:if test="$selOrg = '0' or $selOrg = '1'">
                       <td class="sumClass"><xsl:value-of select="$acadKeyIml"/></td>
                     <input type="hidden" name='imlCount|{$acadKeyReqNmIml}' value="{$acadKeyIml}" />
              </xsl:if>
              <xsl:if test="$selOrg = '0' or $selOrg = '2'">
                 <td class="sumClass"><xsl:value-of select="$nonAcadKeyIml"/></td>
                 <input type="hidden" name='imlCount|{$nonAcadKeyReqNmIml}' value="{$nonAcadKeyIml}" />
              </xsl:if>
              <xsl:if test="$selOrg = '0' or $selOrg = '3'">
                 <td class="sumClass"><xsl:value-of select="$allKeyIml"/></td>
                 <input type="hidden" name='imlCount|{$allKeyReqNmIml}' value="{$allKeyIml}" />
              </xsl:if>

              <xsl:if test="$selOrg = '0' or $selOrg = '1'">
                    <xsl:choose>
                    <xsl:when test="$acadKeyIml != '0'">
                         <td ><input size="5" type="text" name="{$acadKeyReqNmIml}"  value="{$acadKeyReqIml}"/></td>
                    </xsl:when>
                    <xsl:otherwise>
                        <td><script type="text/javascript">putNbsp()</script> </td>
                    </xsl:otherwise>
                    </xsl:choose>
              </xsl:if>
              <xsl:if test="$selOrg = '0' or $selOrg = '2'">
                    <xsl:choose>
                    <xsl:when test="$nonAcadKeyIml != '0'">
                         <td ><input size="5" type="text" name="{$nonAcadKeyReqNmIml}"  value="{$nonAcadKeyReqIml}"/></td>
                    </xsl:when>
                    <xsl:otherwise>
                        <td><script type="text/javascript">putNbsp()</script> </td>
                    </xsl:otherwise>
                    </xsl:choose>
              </xsl:if>
              <xsl:if test="$selOrg = '0' or $selOrg = '3'">
                    <xsl:choose>
                    <xsl:when test="$allKeyIml != '0'">
                         <td ><input size="5" type="text" name="{$allKeyReqNmIml}"  value="{$allKeyReqIml}"/></td>
                    </xsl:when>
                    <xsl:otherwise>
                        <td><script type="text/javascript">putNbsp()</script> </td>
                    </xsl:otherwise>
                    </xsl:choose>
              </xsl:if>

      </tr>

    <th> TOTAL </th>
    <xsl:if test="$selOrg = '0' or $selOrg = '1'">
       <th><script type="text/javascript">putNbsp()</script> </th>
    </xsl:if>
    <xsl:if test="$selOrg = '0' or $selOrg = '2'">
       <th><script type="text/javascript">putNbsp()</script> </th>
    </xsl:if>
    <xsl:if test="$selOrg = '0' or $selOrg = '3'">
       <th><script type="text/javascript">putNbsp()</script> </th>
    </xsl:if>
    <xsl:if test="$selOrg = '0' or $selOrg = '1'">
          <th class="titleClass"><input size="5" type="text" name="acadTotalPostalSTT"  value=""/></th>
    </xsl:if>
    <xsl:if test="$selOrg = '0' or $selOrg = '2'">
          <th class="titleClass"><input size="5" type="text" name="nonAcadTotalPostalSTT"  value=""/></th>
    </xsl:if>
    <xsl:if test="$selOrg = '0' or $selOrg = '3'">
          <th class="titleClass"><input size="5" type="text" name="allTotalPostalSTT"  value=""/></th>
    </xsl:if>
    <xsl:if test="$selOrg = '0' or $selOrg = '1'">
       <th><script type="text/javascript">putNbsp()</script></th>
    </xsl:if>
    <xsl:if test="$selOrg = '0' or $selOrg = '2'">
    <th><script type="text/javascript">putNbsp()</script></th>
       </xsl:if>
    <xsl:if test="$selOrg = '0' or $selOrg = '3'">
       <th><script type="text/javascript">putNbsp()</script></th>
    </xsl:if>
    <xsl:if test="$selOrg = '0' or $selOrg = '1'">
          <th class="titleClass"><input size="5" type="text" name="acadTotalEmailSTT"  value=""/></th>
    </xsl:if>
    <xsl:if test="$selOrg = '0' or $selOrg = '2'">
          <th class="titleClass"><input size="5" type="text" name="nonAcadTotalEmailSTT"  value=""/></th>
    </xsl:if>
    <xsl:if test="$selOrg = '0' or $selOrg = '3'">
          <th class="titleClass"><input size="5" type="text" name="allTotalEmailSTT"  value=""/></th>
    </xsl:if>
        <xsl:if test="$selOrg = '0' or $selOrg = '1'">
           <th><script type="text/javascript">putNbsp()</script></th>
        </xsl:if>
        <xsl:if test="$selOrg = '0' or $selOrg = '2'">
        <th><script type="text/javascript">putNbsp()</script></th>
           </xsl:if>
        <xsl:if test="$selOrg = '0' or $selOrg = '3'">
           <th><script type="text/javascript">putNbsp()</script></th>
        </xsl:if>
        <xsl:if test="$selOrg = '0' or $selOrg = '1'">
                <th class="titleClass"><input size="5" type="text" name="acadTotalImailSTT"  value=""/></th>
        </xsl:if>
        <xsl:if test="$selOrg = '0' or $selOrg = '2'">
                <th class="titleClass"><input size="5" type="text" name="nonAcadTotalImailSTT"  value=""/></th>
        </xsl:if>
        <xsl:if test="$selOrg = '0' or $selOrg = '3'">
                <th class="titleClass"><input size="5" type="text" name="allTotalImailSTT"  value=""/></th>
        </xsl:if>

    </table>
  </div>
  </xsl:if>


  <br></br> <br></br>

<!-- p5 -->

  <xsl:if test="Record/CNTTYPE = 'Z'">
  <div class="countryBox">
    <table class="summaryTable" border="1" cellpadding="1" cellspacing="1">

  <tr>

        <!-- old -->
    <!--<xsl:variable name="numOfColumnsNew">-->
      <!--<xsl:if test="$numOfColumns = 1">2</xsl:if>-->
      <!--<xsl:if test="$numOfColumns != 1"><xsl:value-of select="$numOfColumns"/></xsl:if>-->
    <!--</xsl:variable>-->
        <!-- new -->
    <xsl:variable name="numOfColumnsNew">
      <xsl:if test="$numOfColumns = 1">2</xsl:if>
      <xsl:if test="$numOfColumns != 1">6</xsl:if>
    </xsl:variable>


    <th rowspan="3"> </th>

            <th class="titleClass" colspan="{$numOfColumnsNew}">Postal (
            <input type="checkbox" name="includeEmail4" value="I" onclick="selectIncludeEmail(document.resultsForm, this)">
       <xsl:variable name="inclVal">
                <xsl:value-of select="Record/INCEMAIL" />
            </xsl:variable>
            <xsl:if test="'I' = $inclVal">
                <xsl:attribute name="checked">true</xsl:attribute>
            </xsl:if>
            </input> Include Email)
      <br></br> Select All :
            <xsl:if test="$selOrg = '0' or $selOrg = '1'">
               <input type="radio" name="selectAll" value="acadVal" onclick="javascript:selectAllAndCopy(document.resultsForm, 'pstCount', 'ACAD', 'ZIP')"/> Acad
            </xsl:if>
            <xsl:if test="$selOrg = '0' or $selOrg = '2'">
               <input type="radio" name="selectAll" value="nonAcadVal" onclick="javascript:selectAllAndCopy(document.resultsForm, 'pstCount', 'NONACD', 'ZIP')"/> Non-Acad
            </xsl:if>
            <xsl:if test="$selOrg = '0' or $selOrg = '3'">
               <input type="radio" name="selectAll" value="totalVal" onclick="javascript:selectAllAndCopy(document.resultsForm, 'pstCount', 'ALLTOTAL', 'ZIP')"/> Total
            </xsl:if>

      </th>

            <th class="titleClass" colspan="{$numOfColumnsNew}">Email
      <br></br> Select All :
            <xsl:if test="$selOrg = '0' or $selOrg = '1'">
               <input type="radio" name="selectAll" value="acadVal" onclick="javascript:selectAllAndCopy(document.resultsForm, 'emlCount', 'ACAD', 'ZIP')"/> Acad
            </xsl:if>
            <xsl:if test="$selOrg = '0' or $selOrg = '2'">
               <input type="radio" name="selectAll" value="nonAcadVal" onclick="javascript:selectAllAndCopy(document.resultsForm, 'emlCount', 'NONACD', 'ZIP')"/> Non-Acad
            </xsl:if>
            <xsl:if test="$selOrg = '0' or $selOrg = '3'">
               <input type="radio" name="selectAll" value="totalVal" onclick="javascript:selectAllAndCopy(document.resultsForm, 'emlCount', 'ALLTOTAL', 'ZIP')"/> Total
            </xsl:if>
      </th>
        <th class="titleClass" colspan="{$numOfColumnsNew}">Emails with Invalid Postal
        <br></br> Select All :
        <xsl:if test="$selOrg = '0' or $selOrg = '1'">
           <input type="radio" name="selectAll" value="acadVal" onclick="javascript:selectAllAndCopy(document.resultsForm, 'imlCount', 'ACAD', 'ZIP')"/> Acad
        </xsl:if>
        <xsl:if test="$selOrg = '0' or $selOrg = '2'">
           <input type="radio" name="selectAll" value="nonAcadVal" onclick="javascript:selectAllAndCopy(document.resultsForm, 'imlCount', 'NONACD', 'ZIP')"/> Non-Acad
        </xsl:if>
        <xsl:if test="$selOrg = '0' or $selOrg = '3'">
           <input type="radio" name="selectAll" value="totalVal" onclick="javascript:selectAllAndCopy(document.resultsForm, 'imlCount', 'ALLTOTAL', 'ZIP')"/> Total
        </xsl:if>
        </th>
  </tr>

  <tr>
    <xsl:variable name="numOfColumnsNew2">
      <xsl:if test="$numOfColumns = 1">1</xsl:if>
      <xsl:if test="$numOfColumns != 1">3</xsl:if>
    </xsl:variable>

      <th align="center" colspan="{$numOfColumnsNew2}"> Results </th>
      <th align="center" colspan="{$numOfColumnsNew2}"> Ordered </th>
      <th align="center" colspan="{$numOfColumnsNew2}"> Results </th>
      <th align="center" colspan="{$numOfColumnsNew2}"> Ordered </th>
        <th align="center" colspan="{$numOfColumnsNew2}"> Results </th>
        <th align="center" colspan="{$numOfColumnsNew2}"> Ordered </th>
  </tr>

  <tr>
          <xsl:if test="$selOrg = '0' or $selOrg = '1'">
             <th class="titleClass">Academic</th>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '2'">
             <th class="titleClass">Non-Acad</th>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '3'">
             <th class="titleClass">All</th>
          </xsl:if>

      <xsl:if test="$selOrg = '0' or $selOrg = '1'">
             <th class="titleClass">Academic</th>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '2'">
             <th class="titleClass">Non-Acad</th>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '3'">
             <th class="titleClass">Total</th>
          </xsl:if>

      <xsl:if test="$selOrg = '0' or $selOrg = '1'">
             <th class="titleClass">Academic</th>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '2'">
             <th class="titleClass">Non-Acad</th>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '3'">
             <th class="titleClass">Total</th>
          </xsl:if>

          <xsl:if test="$selOrg = '0' or $selOrg = '1'">
             <th class="titleClass">Academic</th>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '2'">
             <th class="titleClass">Non-Acad</th>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '3'">
             <th class="titleClass">Total</th>
          </xsl:if>

        <xsl:if test="$selOrg = '0' or $selOrg = '1'">
           <th class="titleClass">Academic</th>
        </xsl:if>
        <xsl:if test="$selOrg = '0' or $selOrg = '2'">
           <th class="titleClass">Non-Acad</th>
        </xsl:if>
        <xsl:if test="$selOrg = '0' or $selOrg = '3'">
           <th class="titleClass">Total</th>
        </xsl:if>

        <xsl:if test="$selOrg = '0' or $selOrg = '1'">
           <th class="titleClass">Academic</th>
        </xsl:if>
        <xsl:if test="$selOrg = '0' or $selOrg = '2'">
           <th class="titleClass">Non-Acad</th>
        </xsl:if>
        <xsl:if test="$selOrg = '0' or $selOrg = '3'">
           <th class="titleClass">Total</th>
        </xsl:if>
  </tr>

  <xsl:variable name="acadKeyPst" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="nonAcadKeyPst" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="allKeyPst" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="acadKeyEml" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="nonAcadKeyEml" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="allKeyEml" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="acadKeyIml" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="nonAcadKeyIml" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="allKeyIml" select="'0'" saxon:assignable="yes"/>


  <xsl:variable name="acadKeyReqPst" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="nonAcadKeyReqPst" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="allKeyReqPst" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="acadKeyReqEml" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="nonAcadKeyReqEml" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="allKeyReqEml" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="acadKeyReqIml" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="nonAcadKeyReqIml" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="allKeyReqIml" select="'0'" saxon:assignable="yes"/>

  <xsl:variable name="acadKeyReqNmPst" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="nonAcadKeyReqNmPst" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="allKeyReqNmPst" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="acadKeyReqNmEml" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="nonAcadKeyReqNmEml" select="'0'" saxon:assignable="yes"/>
  <xsl:variable name="allKeyReqNmEml" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="acadKeyReqNmIml" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="nonAcadKeyReqNmIml" select="'0'" saxon:assignable="yes"/>
        <xsl:variable name="allKeyReqNmIml" select="'0'" saxon:assignable="yes"/>


  <xsl:variable name="firstTime" select="'1'" saxon:assignable="yes"/>
  <xsl:variable name="currCNT" select="''" saxon:assignable="yes"/>
  <xsl:variable name="prevCNT" select="''" saxon:assignable="yes"/>

  <xsl:variable name="prefixKey" select="'ALLCOUN'" saxon:assignable="yes"/>


  <xsl:for-each select="Record">
  <xsl:if test="./CNTTYPE = 'Z'">

    <xsl:if test="$firstTime = '1'">
      <saxon:assign name="prevCNT" select="./CNTNAME"/>
      <saxon:assign name="firstTime" select="'2'"/>
    </xsl:if>

    <saxon:assign name="currCNT" select="./CNTNAME"/>

<!-- After I have read all the rows from the table, I put them here in 1 Row -->
    <xsl:if test="$currCNT != $prevCNT">

      <tr>
          <th class="titleClass"><xsl:value-of select="$prevCNT"/></th>
      <xsl:if test="$selOrg = '0' or $selOrg = '1'">
          <td class="sumClass"><xsl:value-of select="$acadKeyPst"/></td>
       <input type="hidden" name='pstCount|{$acadKeyReqNmPst}' value="{$acadKeyPst}" />
      </xsl:if>
      <xsl:if test="$selOrg = '0' or $selOrg = '2'">
          <td class="sumClass"><xsl:value-of select="$nonAcadKeyPst"/></td>
       <input type="hidden" name='pstCount|{$nonAcadKeyReqNmPst}' value="{$nonAcadKeyPst}" />
      </xsl:if>
      <xsl:if test="$selOrg = '0' or $selOrg = '3'">
          <td class="sumClass"><xsl:value-of select="$allKeyPst"/></td>
       <input type="hidden" name='pstCount|{$allKeyReqNmPst}' value="{$allKeyPst}" />
      </xsl:if>

      <xsl:if test="$selOrg = '0' or $selOrg = '1'">
        <xsl:choose>
        <xsl:when test="$acadKeyPst != '0'">
              <td ><input size="5" type="text" name="{$acadKeyReqNmPst}"  value="{$acadKeyReqPst}"/></td>
           <input type="hidden" name='cntName' value="{$acadKeyReqNmPst}" />
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
      <xsl:if test="$selOrg = '0' or $selOrg = '2'">
        <xsl:choose>
        <xsl:when test="$nonAcadKeyPst != '0'">
              <td ><input size="5" type="text" name="{$nonAcadKeyReqNmPst}"  value="{$nonAcadKeyReqPst}"/></td>
           <input type="hidden" name='cntName' value="{$nonAcadKeyReqNmPst}" />
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
      <xsl:if test="$selOrg = '0' or $selOrg = '3'">
        <xsl:choose>
        <xsl:when test="$allKeyPst != '0'">
            <td ><input size="5" type="text" name="{$allKeyReqNmPst}"  value="{$allKeyReqPst}"/></td>
           <input type="hidden" name='cntName' value="{$allKeyReqNmPst}" />
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
      </xsl:if>

          <xsl:if test="$selOrg = '0' or $selOrg = '1'">
               <td class="sumClass"><xsl:value-of select="$acadKeyEml"/></td>
         <input type="hidden" name='emlCount|{$acadKeyReqNmEml}' value="{$acadKeyEml}" />
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '2'">
             <td class="sumClass"><xsl:value-of select="$nonAcadKeyEml"/></td>
       <input type="hidden" name='emlCount|{$nonAcadKeyReqNmEml}' value="{$nonAcadKeyEml}" />
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '3'">
             <td class="sumClass"><xsl:value-of select="$allKeyEml"/></td>
       <input type="hidden" name='emlCount|{$allKeyReqNmEml}' value="{$allKeyEml}" />
          </xsl:if>

          <xsl:if test="$selOrg = '0' or $selOrg = '1'">
        <xsl:choose>
        <xsl:when test="$acadKeyEml != '0'">
                 <td ><input size="5" type="text" name="{$acadKeyReqNmEml}"  value="{$acadKeyReqEml}"/></td>
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '2'">
        <xsl:choose>
        <xsl:when test="$nonAcadKeyEml != '0'">
                 <td ><input size="5" type="text" name="{$nonAcadKeyReqNmEml}"  value="{$nonAcadKeyReqEml}"/></td>
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '3'">
        <xsl:choose>
        <xsl:when test="$allKeyEml != '0'">
                 <td ><input size="5" type="text" name="{$allKeyReqNmEml}"  value="{$allKeyReqEml}"/></td>
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
          </xsl:if>

              <xsl:if test="$selOrg = '0' or $selOrg = '1'">
                       <td class="sumClass"><xsl:value-of select="$acadKeyIml"/></td>
                     <input type="hidden" name='imlCount|{$acadKeyReqNmIml}' value="{$acadKeyIml}" />
              </xsl:if>
              <xsl:if test="$selOrg = '0' or $selOrg = '2'">
                 <td class="sumClass"><xsl:value-of select="$nonAcadKeyIml"/></td>
                 <input type="hidden" name='imlCount|{$nonAcadKeyReqNmIml}' value="{$nonAcadKeyIml}" />
              </xsl:if>
              <xsl:if test="$selOrg = '0' or $selOrg = '3'">
                 <td class="sumClass"><xsl:value-of select="$allKeyIml"/></td>
                 <input type="hidden" name='imlCount|{$allKeyReqNmIml}' value="{$allKeyIml}" />
              </xsl:if>

              <xsl:if test="$selOrg = '0' or $selOrg = '1'">
                    <xsl:choose>
                    <xsl:when test="$acadKeyIml != '0'">
                         <td ><input size="5" type="text" name="{$acadKeyReqNmIml}"  value="{$acadKeyReqIml}"/></td>
                    </xsl:when>
                    <xsl:otherwise>
                        <td><script type="text/javascript">putNbsp()</script> </td>
                    </xsl:otherwise>
                    </xsl:choose>
              </xsl:if>
              <xsl:if test="$selOrg = '0' or $selOrg = '2'">
                    <xsl:choose>
                    <xsl:when test="$nonAcadKeyIml != '0'">
                         <td ><input size="5" type="text" name="{$nonAcadKeyReqNmIml}"  value="{$nonAcadKeyReqIml}"/></td>
                    </xsl:when>
                    <xsl:otherwise>
                        <td><script type="text/javascript">putNbsp()</script> </td>
                    </xsl:otherwise>
                    </xsl:choose>
              </xsl:if>
              <xsl:if test="$selOrg = '0' or $selOrg = '3'">
                    <xsl:choose>
                    <xsl:when test="$allKeyIml != '0'">
                         <td ><input size="5" type="text" name="{$allKeyReqNmIml}"  value="{$allKeyReqIml}"/></td>
                    </xsl:when>
                    <xsl:otherwise>
                        <td><script type="text/javascript">putNbsp()</script> </td>
                    </xsl:otherwise>
                    </xsl:choose>
              </xsl:if>
      </tr>

      <!-- Re Initialize all Values -->
      <saxon:assign name="acadKeyPst" select="'0'"/>
      <saxon:assign name="nonAcadKeyPst" select="'0'"/>
      <saxon:assign name="allKeyPst" select="'0'"/>
      <saxon:assign name="acadKeyEml" select="'0'"/>
      <saxon:assign name="nonAcadKeyEml" select="'0'"/>
      <saxon:assign name="allKeyEml" select="'0'"/>
            <saxon:assign name="acadKeyIml" select="'0'"/>
            <saxon:assign name="nonAcadKeyIml" select="'0'"/>
            <saxon:assign name="allKeyIml" select="'0'"/>

      <saxon:assign name="acadKeyReqNmPst" select="'0'"/>
      <saxon:assign name="nonAcadKeyReqNmPst" select="'0'"/>
      <saxon:assign name="allKeyReqNmPst" select="'0'"/>
      <saxon:assign name="acadKeyReqNmEml" select="'0'"/>
      <saxon:assign name="nonAcadKeyReqNmEml" select="'0'"/>
      <saxon:assign name="allKeyReqNmEml" select="'0'"/>
            <saxon:assign name="acadKeyReqNmIml" select="'0'"/>
            <saxon:assign name="nonAcadKeyReqNmIml" select="'0'"/>
            <saxon:assign name="allKeyReqNmIml" select="'0'"/>

      <saxon:assign name="acadKeyReqPst" select="'0'"/>
      <saxon:assign name="nonAcadKeyReqPst" select="'0'"/>
      <saxon:assign name="allKeyReqPst" select="'0'"/>
      <saxon:assign name="acadKeyReqEml" select="'0'"/>
      <saxon:assign name="nonAcadKeyReqEml" select="'0'"/>
      <saxon:assign name="allKeyReqEml" select="'0'"/>
            <saxon:assign name="acadKeyReqIml" select="'0'"/>
            <saxon:assign name="nonAcadKeyReqIml" select="'0'"/>
            <saxon:assign name="allKeyReqIml" select="'0'"/>

      <saxon:assign name="prevCNT" select="./CNTNAME"/>
    </xsl:if>

<!-- Read the values of the 6 or 3 or 1 row from the table and save it in the variables -->

    <xsl:if test="./CNTCATG = 'A'">
      <saxon:assign name="acadKeyPst" select="./PCNTVALUE" />
      <saxon:assign name="acadKeyReqPst" select="./PCNTSREQUIRED" />
      <saxon:assign name="acadKeyReqNmPst" select="concat ($prefixKey, ';', 'ZIP', ';', 'ACAD', ';', 'PSTKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
      <saxon:assign name="acadKeyEml" select="./ECNTVALUE" />
      <saxon:assign name="acadKeyReqEml" select="./ECNTSREQUIRED" />
      <saxon:assign name="acadKeyReqNmEml" select="concat ($prefixKey, ';', 'ZIP', ';', 'ACAD', ';', 'EMLKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
            <saxon:assign name="acadKeyIml" select="./ICNTVALUE" />
            <saxon:assign name="acadKeyReqIml" select="./ICNTSREQUIRED" />
            <saxon:assign name="acadKeyReqNmIml" select="concat ($prefixKey, ';', 'ZIP', ';', 'ACAD', ';', 'IMLKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
    </xsl:if>

    <xsl:if test="./CNTCATG = 'N'">
      <saxon:assign name="nonAcadKeyPst" select="./PCNTVALUE" />
      <saxon:assign name="nonAcadKeyReqPst" select="./PCNTSREQUIRED" />
      <saxon:assign name="nonAcadKeyReqNmPst" select="concat ($prefixKey, ';', 'ZIP', ';', 'NONACD', ';', 'PSTKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
      <saxon:assign name="nonAcadKeyEml" select="./ECNTVALUE" />
      <saxon:assign name="nonAcadKeyReqEml" select="./ECNTSREQUIRED" />
      <saxon:assign name="nonAcadKeyReqNmEml" select="concat ($prefixKey, ';', 'ZIP', ';', 'NONACD', ';', 'EMLKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
            <saxon:assign name="nonAcadKeyIml" select="./ICNTVALUE" />
            <saxon:assign name="nonAcadKeyReqIml" select="./ICNTSREQUIRED" />
            <saxon:assign name="nonAcadKeyReqNmIml" select="concat ($prefixKey, ';', 'ZIP', ';', 'NONACD', ';', 'IMLKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
    </xsl:if>

    <xsl:if test="./CNTCATG = 'T'">
      <saxon:assign name="allKeyPst" select="./PCNTVALUE" />
      <saxon:assign name="allKeyReqPst" select="./PCNTSREQUIRED" />
      <saxon:assign name="allKeyReqNmPst" select="concat ($prefixKey, ';', 'ZIP', ';', 'ALLTOTAL', ';', 'PSTKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
      <saxon:assign name="allKeyEml" select="./ECNTVALUE" />
      <saxon:assign name="allKeyReqEml" select="./ECNTSREQUIRED" />
      <saxon:assign name="allKeyReqNmEml" select="concat ($prefixKey, ';', 'ZIP', ';', 'ALLTOTAL', ';', 'EMLKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
            <saxon:assign name="allKeyIml" select="./ICNTVALUE" />
            <saxon:assign name="allKeyReqIml" select="./ICNTSREQUIRED" />
            <saxon:assign name="allKeyReqNmIml" select="concat ($prefixKey, ';', 'ZIP', ';', 'ALLTOTAL', ';', 'IMLKEY', ';',./ORDRID, ';', ./SRCID, ';', ./CLID, ';', ./CNTSEQ)" />
    </xsl:if>

  </xsl:if>
  </xsl:for-each>
      <tr>
          <th class="titleClass"><xsl:value-of select="$prevCNT"/></th>
      <xsl:if test="$selOrg = '0' or $selOrg = '1'">
          <td class="sumClass"><xsl:value-of select="$acadKeyPst"/></td>
       <input type="hidden" name='pstCount|{$acadKeyReqNmPst}' value="{$acadKeyPst}" />
      </xsl:if>
      <xsl:if test="$selOrg = '0' or $selOrg = '2'">
          <td class="sumClass"><xsl:value-of select="$nonAcadKeyPst"/></td>
       <input type="hidden" name='pstCount|{$nonAcadKeyReqNmPst}' value="{$nonAcadKeyPst}" />
      </xsl:if>
      <xsl:if test="$selOrg = '0' or $selOrg = '3'">
          <td class="sumClass"><xsl:value-of select="$allKeyPst"/></td>
       <input type="hidden" name='pstCount|{$allKeyReqNmPst}' value="{$allKeyPst}" />
      </xsl:if>

      <xsl:if test="$selOrg = '0' or $selOrg = '1'">
        <xsl:choose>
        <xsl:when test="$acadKeyPst != '0'">
              <td ><input size="5" type="text" name="{$acadKeyReqNmPst}"  value="{$acadKeyReqPst}"/></td>
           <input type="hidden" name='cntName' value="{$acadKeyReqNmPst}" />
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
      <xsl:if test="$selOrg = '0' or $selOrg = '2'">
        <xsl:choose>
        <xsl:when test="$nonAcadKeyPst != '0'">
              <td ><input size="5" type="text" name="{$nonAcadKeyReqNmPst}"  value="{$nonAcadKeyReqPst}"/></td>
           <input type="hidden" name='cntName' value="{$nonAcadKeyReqNmPst}" />
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
      <xsl:if test="$selOrg = '0' or $selOrg = '3'">
        <xsl:choose>
        <xsl:when test="$allKeyPst != '0'">
            <td ><input size="5" type="text" name="{$allKeyReqNmPst}"  value="{$allKeyReqPst}"/></td>
           <input type="hidden" name='cntName' value="{$allKeyReqNmPst}" />
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
      </xsl:if>

          <xsl:if test="$selOrg = '0' or $selOrg = '1'">
               <td class="sumClass"><xsl:value-of select="$acadKeyEml"/></td>
         <input type="hidden" name='emlCount|{$acadKeyReqNmEml}' value="{$acadKeyEml}" />
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '2'">
             <td class="sumClass"><xsl:value-of select="$nonAcadKeyEml"/></td>
       <input type="hidden" name='emlCount|{$nonAcadKeyReqNmEml}' value="{$nonAcadKeyEml}" />
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '3'">
             <td class="sumClass"><xsl:value-of select="$allKeyEml"/></td>
       <input type="hidden" name='emlCount|{$allKeyReqNmEml}' value="{$allKeyEml}" />
          </xsl:if>

          <xsl:if test="$selOrg = '0' or $selOrg = '1'">
        <xsl:choose>
        <xsl:when test="$acadKeyEml != '0'">
                 <td ><input size="5" type="text" name="{$acadKeyReqNmEml}"  value="{$acadKeyReqEml}"/></td>
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '2'">
        <xsl:choose>
        <xsl:when test="$nonAcadKeyEml != '0'">
                 <td ><input size="5" type="text" name="{$nonAcadKeyReqNmEml}"  value="{$nonAcadKeyReqEml}"/></td>
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
          </xsl:if>
          <xsl:if test="$selOrg = '0' or $selOrg = '3'">
        <xsl:choose>
        <xsl:when test="$allKeyEml != '0'">
                 <td ><input size="5" type="text" name="{$allKeyReqNmEml}"  value="{$allKeyReqEml}"/></td>
        </xsl:when>
        <xsl:otherwise>
          <td><script type="text/javascript">putNbsp()</script> </td>
        </xsl:otherwise>
        </xsl:choose>
          </xsl:if>
              <xsl:if test="$selOrg = '0' or $selOrg = '1'">
                       <td class="sumClass"><xsl:value-of select="$acadKeyIml"/></td>
                     <input type="hidden" name='imlCount|{$acadKeyReqNmIml}' value="{$acadKeyIml}" />
              </xsl:if>
              <xsl:if test="$selOrg = '0' or $selOrg = '2'">
                 <td class="sumClass"><xsl:value-of select="$nonAcadKeyIml"/></td>
                 <input type="hidden" name='imlCount|{$nonAcadKeyReqNmIml}' value="{$nonAcadKeyIml}" />
              </xsl:if>
              <xsl:if test="$selOrg = '0' or $selOrg = '3'">
                 <td class="sumClass"><xsl:value-of select="$allKeyIml"/></td>
                 <input type="hidden" name='imlCount|{$allKeyReqNmIml}' value="{$allKeyIml}" />
              </xsl:if>

              <xsl:if test="$selOrg = '0' or $selOrg = '1'">
                    <xsl:choose>
                    <xsl:when test="$acadKeyIml != '0'">
                         <td ><input size="5" type="text" name="{$acadKeyReqNmIml}"  value="{$acadKeyReqIml}"/></td>
                    </xsl:when>
                    <xsl:otherwise>
                        <td><script type="text/javascript">putNbsp()</script> </td>
                    </xsl:otherwise>
                    </xsl:choose>
              </xsl:if>
              <xsl:if test="$selOrg = '0' or $selOrg = '2'">
                    <xsl:choose>
                    <xsl:when test="$nonAcadKeyIml != '0'">
                         <td ><input size="5" type="text" name="{$nonAcadKeyReqNmIml}"  value="{$nonAcadKeyReqIml}"/></td>
                    </xsl:when>
                    <xsl:otherwise>
                        <td><script type="text/javascript">putNbsp()</script> </td>
                    </xsl:otherwise>
                    </xsl:choose>
              </xsl:if>
              <xsl:if test="$selOrg = '0' or $selOrg = '3'">
                    <xsl:choose>
                    <xsl:when test="$allKeyIml != '0'">
                         <td ><input size="5" type="text" name="{$allKeyReqNmIml}"  value="{$allKeyReqIml}"/></td>
                    </xsl:when>
                    <xsl:otherwise>
                        <td><script type="text/javascript">putNbsp()</script> </td>
                    </xsl:otherwise>
                    </xsl:choose>
              </xsl:if>

      </tr>
    <th> TOTAL </th>
    <xsl:if test="$selOrg = '0' or $selOrg = '1'">
       <th><script type="text/javascript">putNbsp()</script> </th>
    </xsl:if>
    <xsl:if test="$selOrg = '0' or $selOrg = '2'">
       <th><script type="text/javascript">putNbsp()</script> </th>
    </xsl:if>
    <xsl:if test="$selOrg = '0' or $selOrg = '3'">
       <th><script type="text/javascript">putNbsp()</script> </th>
    </xsl:if>
    <xsl:if test="$selOrg = '0' or $selOrg = '1'">
          <th class="titleClass"><input size="5" type="text" name="acadTotalPostalZIP"  value=""/></th>
    </xsl:if>
    <xsl:if test="$selOrg = '0' or $selOrg = '2'">
          <th class="titleClass"><input size="5" type="text" name="nonAcadTotalPostalZIP"  value=""/></th>
    </xsl:if>
    <xsl:if test="$selOrg = '0' or $selOrg = '3'">
          <th class="titleClass"><input size="5" type="text" name="allTotalPostalZIP"  value=""/></th>
    </xsl:if>
    <xsl:if test="$selOrg = '0' or $selOrg = '1'">
       <th><script type="text/javascript">putNbsp()</script></th>
    </xsl:if>
    <xsl:if test="$selOrg = '0' or $selOrg = '2'">
    <th><script type="text/javascript">putNbsp()</script></th>
       </xsl:if>
    <xsl:if test="$selOrg = '0' or $selOrg = '3'">
       <th><script type="text/javascript">putNbsp()</script></th>
    </xsl:if>
    <xsl:if test="$selOrg = '0' or $selOrg = '1'">
          <th class="titleClass"><input size="5" type="text" name="acadTotalEmailZIP"  value=""/></th>
    </xsl:if>
    <xsl:if test="$selOrg = '0' or $selOrg = '2'">
          <th class="titleClass"><input size="5" type="text" name="nonAcadTotalEmailZIP"  value=""/></th>
    </xsl:if>
    <xsl:if test="$selOrg = '0' or $selOrg = '3'">
          <th class="titleClass"><input size="5" type="text" name="allTotalEmailZIP"  value=""/></th>
    </xsl:if>
        <xsl:if test="$selOrg = '0' or $selOrg = '1'">
           <th><script type="text/javascript">putNbsp()</script></th>
        </xsl:if>
        <xsl:if test="$selOrg = '0' or $selOrg = '2'">
        <th><script type="text/javascript">putNbsp()</script></th>
           </xsl:if>
        <xsl:if test="$selOrg = '0' or $selOrg = '3'">
           <th><script type="text/javascript">putNbsp()</script></th>
        </xsl:if>
        <xsl:if test="$selOrg = '0' or $selOrg = '1'">
                <th class="titleClass"><input size="5" type="text" name="acadTotalImailZIP"  value=""/></th>
        </xsl:if>
        <xsl:if test="$selOrg = '0' or $selOrg = '2'">
                <th class="titleClass"><input size="5" type="text" name="nonAcadTotalImailZIP"  value=""/></th>
        </xsl:if>
        <xsl:if test="$selOrg = '0' or $selOrg = '3'">
                <th class="titleClass"><input size="5" type="text" name="allTotalImailZIP"  value=""/></th>
        </xsl:if>

    </table>
  </div>
  </xsl:if>

<!-- For all the countries other than DOMESTIC, FOREIGN -->


  <br></br>
  <center><input type="button" value="ExportToExcel" onclick="javascript:test2Export(orderId,searchId,clnIdList,ord_Name,cust_id_name,cmp_name,cnt_name)" />
<!--<input type="button" value="ExportToExcel" onclick="javascript:ToExcel()" />-->
<input type="button" value="REFRESH" onclick="javascript:setRsltTotalValues(document.resultsForm)"/>
  <input type="submit" value="SUBMIT" onclick="return getResults(document.resultsForm)"/></center>

    <br></br>
    <center>

    <input type="hidden" name='Menu' value="View Results Info" />
    <INPUT type="hidden" name='editviewflag' value="Y" />
    <input type="hidden" name='Page' value="Results Page" />
  <input type="hidden" name='qFlag' value="Q" />
  </center>
    </form>

    </xsl:template>

</xsl:stylesheet>
