<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:date="http://exslt.org/dates-and-times"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="date ext">
<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />
<xsl:include href="recordTitle.xsl" />

<xsl:template match="/">
  <xsl:call-template name="emailTemplate"/><!-- style.xsl -->
</xsl:template>

<xsl:template match="/notification_data">

  <!-- mailReason.xsl -->
  <!--<xsl:call-template name="emailLogo"/><xsl:call-template name="toWhomIsConcerned"/>--><!-- mailReason.xsl -->

  <p>
    <xsl:value-of select="message_body" disable-output-escaping="yes"/>
  </p>

  <!--<xsl:call-template name="email-footer">
    <xsl:with-param name="show_help" select="false()"/>
  </xsl:call-template>--><!-- footer.xsl -->

</xsl:template>
</xsl:stylesheet>