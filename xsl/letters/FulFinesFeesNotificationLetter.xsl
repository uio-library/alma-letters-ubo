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
    <xsl:call-template name="senderReceiver" /> <!-- SenderReceiver.xsl -->

    <br />

  <table cellspacing="0" cellpadding="5" border="0">
    <tr>
    <td>
     <p>@@dear@@ </p> <br />
     <p>@@we_would_like@@ <xsl:value-of select="notification_data/organization_unit/name"/> @@debt_of@@ <b><xsl:value-of select="notification_data/total_fines_amount"/>
     &#160;<xsl:value-of select="notification_data/total_fines_currency"/></b></p>
    </td>
    </tr>
    </table>

    <table cellpadding="5" class="listing">
    <xsl:attribute name="style">
     <xsl:call-template name="mainTableStyleCss" /> <!-- style.xsl -->
    </xsl:attribute>

    <table cellpadding="5" class="listing">
    <xsl:attribute name="style">
     <xsl:call-template name="mainTableStyleCss" /> <!-- style.xsl -->
    </xsl:attribute>
     <tr>
      <th>@@fee_type@@</th>
      <th>@@fee_amount@@</th>
      <th>@@note@@</th>
     </tr>
     <xsl:for-each select="notification_data/fines_fees_list/user_fines_fees">
     <tr>
      <td><xsl:value-of select="fine_fee_type_display"/></td>
      <td><xsl:value-of select="fine_fee_ammount/sum"/>&#160;<xsl:value-of select="fine_fee_ammount/currency"/></td>
      <td><xsl:value-of select="fine_comment"/></td>
     </tr>
     </xsl:for-each>

    </table><br />
    <p><b>@@please_settle@@</b></p>

    </table>
    <br />

    <xsl:call-template name="lastFooter" /> <!-- footer.xsl -->

   </body>
 </html>
</xsl:template>

</xsl:stylesheet>