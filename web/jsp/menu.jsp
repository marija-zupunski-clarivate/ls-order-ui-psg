<HTML>
  <HEAD>
<!--  <meta HTTP-EQUIV="Expires" CONTENT="0">
  <meta HTTP-EQUIV="Pragma" CONTENT="No-cache">
  <meta HTTP-EQUIV="Cache-Control",private>
-->
  <link rel="stylesheet" type="text/css" href="/ListSales/theme/Master.css" />
  <script language='JavaScript' src='/ListSales/javascripts/d2w.js'></script>
  </HEAD>

  <BODY onload="highlightSelections(document.resultsForm, document.createForm, document.RegionData, document.custForm)">
    <TABLE width="100%">
          <TR>
        <TD><center>
         <TABLE>
         <TR>
            <TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
                  <TD><A href="/ListSales/servlet/Driver?Menu=Customer+Information">Customer Information</A></TD>
            <TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
                  <TD><A href="/ListSales/servlet/Driver?Menu=Create+Order" onClick="processFormData(this.document, '/ListSales/servlet/Driver?Menu=Create+Order'); return false">Create Order</A></TD>
            <TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
                  <TD><A href="/ListSales/servlet/Driver?Menu=View+Order+Info" onClick="processFormData(this.document, '/ListSales/servlet/Driver?Menu=View+Order+Info'); return false">View Order Summary</A></TD>
            <TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
            <!--      <TD><A href="/ListSales/servlet/Driver?Menu=View+Results+Info">Order Results</A></TD>
            <TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>-->
                  <TD><A href="/ListSales/servlet/Driver?Menu=Stop+Address+Info" onClick="processFormData(this.document, '/ListSales/servlet/Driver?Menu=Stop+Address+Info'); return false">Stop Address </A></TD>

            <TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
                  <TD><A href="/ListSales/servlet/Driver?Menu=Regions" onClick="processFormData(this.document, '/ListSales/servlet/Driver?Menu=Regions'); return false">Regions</A></TD>
           </TR>
         </TABLE>
      </CENTER></TD>
          <TD width="5%" align="right"><A href="/ListSales/servlet/Driver">Logout</A></TD>
        </TR>
    </TABLE>
  </BODY>
</HTML>
