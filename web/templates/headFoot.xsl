<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0"
    xmlns:xalan="http://xml.apache.org/xslt">

    <xsl:template match="Records">

    <form method="POST" action="/ListSales/servlet/Driver" name='NevForm'>
    <input type="hidden" name='Menu' value="{Menu}"/>
    <input type="hidden" name='Page' value="{Page}"/>
    <input type="hidden" name='Pageno'/>
  </form>

  <!-- header -->
  <H1><xsl:value-of select="Title"/></H1>

  <h4>Total Records Retrived: <xsl:value-of select="Size"/></h4>
  <xsl:if test="number(Size)&gt;'0'">
    <h4>Record From: <xsl:value-of select="Start"/> To: <xsl:value-of select="End"/></h4>
    <table>
    <xsl:if test='boolean($header)'>
      <xsl:copy-of select="$header" />
    </xsl:if>
    <xsl:apply-templates select="Record"/>
    </table>
  </xsl:if>

  <TABLE align="right">
      <TR>
          <TD width="100">
        <xsl:if test="number(Pageno)&gt;'1'">
          <a href="javascript:document.NevForm.Pageno.value={Pageno} - 1; document.NevForm.submit()">Previous</a>
        </xsl:if>
          </TD>
          <TD width="100">
        <xsl:if test="number(End)&lt;number(Size)">
          <a href="javascript:document.NevForm.Pageno.value={Pageno} + 1; document.NevForm.submit()">Next</a>
        </xsl:if>
      </TD>
      <TD>
        <a href="javascript:document.NevForm.Page.value='{Parent}'; document.NevForm.submit()">Back to <xsl:value-of select="Parent"/></a>
      </TD>
       </TR>
  </TABLE>

  </xsl:template>
</xsl:stylesheet>

