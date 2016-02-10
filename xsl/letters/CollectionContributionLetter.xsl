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
       </td></tr>
      </xsl:if>
      <tr><td>&#160;@@jobCompletion@@</td></tr>
      <xsl:if test="/notification_data/bib  !=''">
       <tr><td>
       <br /><xsl:value-of select="/notification_data/bib" /><a>&#160;@@bib@@ </a>
       </td></tr>
      </xsl:if>
      <xsl:if test="/notification_data/port  !=''">
       <tr><td>
       <br /><xsl:value-of select="/notification_data/port" /><a>&#160;@@port@@ </a>
       </td></tr>
      </xsl:if>
      <xsl:if test="/notification_data/multi_match  !=''">
       <tr><td>
       <br /><a>&#160;@@multiMatch@@ </a>
       <xsl:value-of select="/notification_data/multi_match" />
       </td></tr>
      </xsl:if>
      <br />
      <tr><td>&#160;@@mailMessage@@</td></tr>
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