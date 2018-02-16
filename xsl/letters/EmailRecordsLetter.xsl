<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:date="http://exslt.org/dates-and-times"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="date ext">
 <xsl:template match="/">
  <xsl:value-of select="/notification_data/metadata/node()" disable-output-escaping="yes"/>
 </xsl:template>
</xsl:stylesheet>