<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />

<xsl:template match="/">
  <xsl:call-template name="email-template"/><!-- header.xsl -->
</xsl:template>

<xsl:template match="/notification_data">

  <xsl:call-template name="emailLogo"/><!-- mailReason.xsl -->
  <!--<xsl:call-template name="toWhomIsConcerned"/>--><!-- mailReason.xsl -->

  <xsl:for-each select="conversation_messages/message">

    <p>
      <xsl:value-of select="message_subject"/>
    </p>

    <p style="font-size:85%; border-top:1px solid #ccc; border-bottom:1px solid #ccc">
      <xsl:value-of select="message_body" disable-output-escaping="yes"/>
    </p>

    <p class="sincerely">
      @@sincerely@@,<br />
      <!-- Can we use @@department@@ ? Dunno -->
      <xsl:value-of select="author/first_name" />&#160;<xsl:value-of select="author/last_name" /><br />
      <xsl:value-of select="/notification_data/organization_unit/name" />
    </p>
  </xsl:for-each>

</xsl:template>

</xsl:stylesheet>