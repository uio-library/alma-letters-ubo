<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:variable name="counter" select="0"/>


<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />
<xsl:include href="recordTitle.xsl" />
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
   <xsl:call-template name="senderReceiver" /> <!-- SenderReceiver.xsl -->
     <xsl:call-template name="toWhomIsConcerned" />
   <div class="messageArea">
    <div class="messageBody">
      <table cellspacing="0" cellpadding="5" border="0">
               <xsl:if test="/notification_data/package_name  !=''">
       <tr><td>
       <br /><a>&#160;@@packageName@@ </a>
       <xsl:value-of select="/notification_data/package_name" />
       <a>&#160;@@packageNameSecondPart@@ </a>
       <br /><br />
       <xsl:value-of select="/notification_data/status" />
       <xsl:if test="/notification_data/rejection_reason  !=''">
        <xsl:value-of select="/notification_data/rejection_reason" />
       </xsl:if>
       </td></tr>
      </xsl:if>
      <xsl:if test="/notification_data/error  !=''">
       <tr><td>
       <br/><a>&#160;@@error@@ </a>
       <xsl:value-of select="/notification_data/error" />
       </td></tr>
      </xsl:if>
     </table>
    </div>
   </div>
   <table>
    <tr><td>@@sincerely@@</td></tr>
   </table>
   <xsl:call-template name="lastFooter" /> <!-- footer.xsl -->
 </body>
</html>
</xsl:template>
</xsl:stylesheet>