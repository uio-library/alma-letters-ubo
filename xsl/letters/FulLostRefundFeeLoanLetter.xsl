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
  <xsl:call-template name="toWhomIsConcerned"/><!-- mailReason.xsl -->

  <p>@@following_loaned_item_which_has@@</p>

  <p>
    <em><xsl:value-of select="item_loan/title"/></em>
  </p>

  <table cellpadding="5" cellspacing="0" class="listing" width="100%">
    <tr>
      <th align="left">@@fee_type@@</th>
      <th align="right">@@fee_amount@@</th>
      <th align="left"></th>
    </tr>
    <xsl:for-each select="fines_fees_list/user_fines_fees">
      <tr>
        <td><xsl:value-of select="fine_fee_type_display"/></td>
        <td align="right"><xsl:value-of select="fine_fee_ammount/sum"/>&#160;<xsl:value-of select="fine_fee_ammount/currency"/></td>
        <td><xsl:value-of select="finecomment"/></td>
      </tr>
    </xsl:for-each>
    <tr>
      <td align="right"><b>@@total@@:</b></td>
      <td align="right"><xsl:value-of select="total_fines_amount"/>&#160;<xsl:value-of select="notification_data/fines_fees_list/user_fines_fees/fine_fee_ammount/currency"/></td>
      <td></td>
    </tr>
  </table>
   
  <xsl:call-template name="email-footer"/><!-- footer.xsl -->
  <xsl:call-template name="contactUs" /><!-- footer.xsl -->

</xsl:template>

</xsl:stylesheet>