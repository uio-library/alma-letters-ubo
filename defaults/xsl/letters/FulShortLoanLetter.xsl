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
          <xsl:call-template name="bodyStyleCss" /><!-- style.xsl -->
        </xsl:attribute>

        <xsl:call-template name="head" /><!-- header.xsl -->
        <xsl:call-template name="senderReceiver" /> <!-- SenderReceiver.xsl -->


  <br />
  <xsl:call-template name="toWhomIsConcerned" /> <!-- mailReason.xsl -->


        <div class="messageArea">
          <div class="messageBody">
   <table cellspacing="0" cellpadding="5" border="0">
              <tr>
               <td>
     @@title@@ &#160;<xsl:value-of select="notification_data/item_loan/title"/>
     @@due_back@@ &#160;<xsl:value-of select="notification_data/due_date"/>
     <xsl:if test="notification_data/has_fine_value='TRUE'">
     @@fine_policy@@ &#160;<xsl:value-of select="notification_data/amount"/>&#160;
     <xsl:value-of select="notification_data/currency_symbol"/>
     @@per@@ &#160;<xsl:value-of select="notification_data/uom"/>&#46;
     </xsl:if>
     <br/><br/>
                </td>
              </tr>


             </table>
    <br />
   <table>
    <tr><td>@@sincerely@@</td></tr>
    <tr><td>@@department@@</td></tr>
   </table>

          </div>
        </div>

        <!-- footer.xsl -->
        <xsl:call-template name="lastFooter" />
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>