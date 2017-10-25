<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
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
    <xsl:call-template name="salutation" /> <!-- footer.xsl -->
    <xsl:call-template name="toWhomIsConcerned" /> <!-- mailReason.xsl -->


    <div class="messageArea">
     <div class="messageBody">
      <table cellspacing="0" cellpadding="5" border="0">
       <tr>
        <td>
         @@letterText@@
         &#160;
         <b>
          <xsl:value-of select="/notification_data/report_name" />
         </b>
        </td>
       </tr>
      </table>
     </div>
    </div>

    <table>

      <tr><td>@@sincerely@@</td></tr>
      <tr><td>@@department@@</td></tr>

    </table>

    <xsl:call-template name="lastFooter" /> <!-- footer.xsl -->
   </body>
  </html>
 </xsl:template>
</xsl:stylesheet>