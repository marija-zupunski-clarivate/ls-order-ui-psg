<?xml version="1.0"?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0"
    xmlns:xalan="http://xml.apache.org/xslt">

    <xsl:template match="Record">
      <xsl:for-each select="child::*">
      <tr><th align='left'><xsl:value-of select="local-name(.)"/></th><td><xsl:apply-templates/></td></tr>
      </xsl:for-each>
      <tr><td height='20'/></tr>
    </xsl:template>

</xsl:transform>
