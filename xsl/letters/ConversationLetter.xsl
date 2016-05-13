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

    <div class="messageArea">
      <div class="messageBody">

        <xsl:call-template name="toWhomIsConcerned"/>
    
        <xsl:for-each select="notification_data/conversation_messages/message">
          <p>
            <xsl:value-of select="message_subject"/>
          </p>
          <p>
            <xsl:value-of select="message_body" disable-output-escaping="yes"/>
          </p>

        <p>
          @@sincerely@@,<br />
          <xsl:value-of select="author/first_name" />&#160;<xsl:value-of select="author/last_name" /><br />
          <xsl:value-of select="/notification_data/organization_unit/name" />
        </p>             </xsl:for-each>
 

      </div>
    </div>
     
   </body>
 </html>
</xsl:template>

</xsl:stylesheet>