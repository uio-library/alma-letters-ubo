<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl"/>
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />

<xsl:template match="/">
  <xsl:call-template name="email-template"/><!-- header.xsl -->
</xsl:template>

<xsl:template match="/notification_data">

  <xsl:call-template name="email-logo"/><!-- header.xsl -->

  <xsl:call-template name="toWhomIsConcerned"/><!-- mailReason.xsl -->

  <p>
     @@inform_you_item_below@@.
  </p>

  <div style="margin: 0.8em 1.2em;">
    <em><xsl:value-of select="phys_item_display/title_abcnph"/></em><br />
    @@description@@: <xsl:value-of select="item_loan/description"/>
    <br />
    @@library@@: <xsl:value-of select="organization_unit/name"/>
    <br />
    @@loan_date@@: <xsl:value-of select="item_loan/loan_date"/>
    <br />
    @@due_date@@: <xsl:value-of select="item_loan/due_date"/>
    <br />
    @@barcode@@: <xsl:value-of select="item_loan/barcode"/>
  </div>

  <p>
    @@charged_with_fines_fees@@
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
        <td><xsl:value-of select="ff"/></td>
      </tr>
    </xsl:for-each>
  </table>

  <p>
    <xsl:choose>
      <xsl:when test="receivers/receiver/preferred_language = 'no'">
        Du kan betale i biblioteket eller med
      </xsl:when>
      <xsl:when test="receivers/receiver/preferred_language = 'nn'">
        Du kan betale i biblioteket eller med
      </xsl:when>
      <xsl:otherwise>
        You can pay at the library or with
      </xsl:otherwise>
    </xsl:choose>
    <a><xsl:attribute name="href">https://epay.uio.no/pay/shop/order-create.html?projectStepId=5203685</xsl:attribute>E-pay</a>.
  </p>

  <xsl:call-template name="email-footer"/><!-- footer.xsl -->
  <xsl:call-template name="contactUs" /> <!-- footer.xsl -->

</xsl:template>

</xsl:stylesheet>