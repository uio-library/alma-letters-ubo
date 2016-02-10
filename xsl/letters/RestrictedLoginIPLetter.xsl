<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />

<xsl:template match="/">
 <html>
  <head>
  <xsl:call-template name="generalStyle" />
  </head>

  <body>
   <xsl:attribute name="style">
    <xsl:call-template name="bodyStyleCss" /> <!-- style.xsl -->
   </xsl:attribute>
   <xsl:call-template name="head" /> <!-- header.xsl -->
   <br/><br/>
   <div><strong>@@dear@@ <xsl:value-of select="notification_data/admin_name"/></strong></div>
   <br/>
   <div>
    @@the_user@@<strong><xsl:value-of select="notification_data/display_name"/> (@@user_name@@ <xsl:value-of select="notification_data/user_name"/>, @@email@@ <xsl:value-of select="notification_data/user_email"/> )</strong>, @@coming_from_ip@@<strong><xsl:value-of select="notification_data/ip"/></strong>, @@is_blocked@@
    <br/><br/>
    @@free_text@@
    <br/>
    <hr/>
    <xsl:value-of select="notification_data/free_text"/>
    <br/>
   </div>
   <br />
   <xsl:call-template name="lastFooter" /><!-- footer.xsl -->
  </body>
 </html>
</xsl:template>
</xsl:stylesheet>