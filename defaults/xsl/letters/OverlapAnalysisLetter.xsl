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
    <div class="messageArea">
            <div class="messageBody">
             <xsl:attribute name="style">
      <xsl:call-template name="bodyStyleCss" /> <!-- style.xsl -->
     </xsl:attribute>
     <xsl:call-template name="head" /> <!-- header.xsl -->
     <xsl:call-template name="senderReceiver" /> <!-- SenderReceiver.xsl -->
     <xsl:call-template name="toWhomIsConcerned" />
              <table cellspacing="0" cellpadding="5" border="0">
              <tr><td>&#160;@@jobCompletion@@</td></tr>
              <xsl:if test="/notification_data/report_type  !=''">
      <tr><td>
       <br /><a>&#160;@@reportType@@ </a>
       <xsl:value-of select="/notification_data/report_type" />
      </td></tr>
     </xsl:if>
     <xsl:if test="/notification_data/report_name  !=''">
      <tr><td>
       <br /><a>&#160;@@reportName@@ </a>
       <xsl:value-of select="/notification_data/report_name" />
      </td></tr>
     </xsl:if>
     <xsl:if test="/notification_data/report_description  !=''">
      <tr><td>
       <a>&#160;@@reportDescription@@ </a>
       <xsl:value-of select="/notification_data/report_description" />
      </td></tr>
     </xsl:if>
      <tr>
       <td>
        <xsl:choose >
         <xsl:when test="/notification_data/file  !=''">
          <br /><a>&#160;@@reportsAttached@@</a>
         </xsl:when>
         <xsl:otherwise>
          <br /><a>&#160;@@reportsNotAttached@@</a>
         </xsl:otherwise>
        </xsl:choose>
       </td>
      </tr>
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