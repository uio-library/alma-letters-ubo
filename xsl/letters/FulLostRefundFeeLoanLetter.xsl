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

  <p>
    @@following_loaned_item_which_has@@
  </p>

  <p style="margin: 0.8em 1.2em;">
    <em>
      <xsl:value-of select="item_loan/title"/>
    </em>
    <br />
    <xsl:choose>
      <xsl:when test="receivers/receiver/preferred_language = 'en'">
        DocumentID:
      </xsl:when>
      <xsl:otherwise>
        DokumentID:
      </xsl:otherwise>
    </xsl:choose><xsl:text> </xsl:text>
    <xsl:value-of select="item_loan/barcode"/>
  </p>

  <xsl:if test="total_fines_amount = '0.00'">
    <xsl:choose>
      <xsl:when test="receivers/receiver/preferred_language = 'nb'">
        Det gjenstår ingen krav eller gebyr å betale.
      </xsl:when>
      <xsl:when test="receivers/receiver/preferred_language = 'no'">
        Det gjenstår ingen gebyr eller krav å betale.
      </xsl:when>
      <xsl:when test="receivers/receiver/preferred_language = 'nn'">
        Det står ikkje nokon gebyr eller krav att å betale.
      </xsl:when>
      <xsl:otherwise>
        There's no remaining fines or fees to be paid.
      </xsl:otherwise>
    </xsl:choose>
  </xsl:if>

  <xsl:if test="total_fines_amount != '0.00'">
    <p>
      <xsl:choose>
        <xsl:when test="receivers/receiver/preferred_language = 'nb'">
          <strong>Merk: </strong>
          Det gjenstår et gebyr eller krav på <xsl:value-of select="total_fines_amount"/> kr,
          som kan betales i biblioteket eller online med
        </xsl:when>
        <xsl:when test="receivers/receiver/preferred_language = 'no'">
          <strong>Merk: </strong>
          Det gjenstår et gebyr eller krav på <xsl:value-of select="total_fines_amount"/> kr,
          som kan betales i biblioteket eller online med
        </xsl:when>
        <xsl:when test="receivers/receiver/preferred_language = 'nn'">
          <strong>Merk: </strong>
          Det står att eit gebyr eller krav på <xsl:value-of select="total_fines_amount"/> kr,
          som kan betalast i biblioteket eller online med
        </xsl:when>
        <xsl:otherwise>
          <strong>Note: </strong>
          There remains a fine or fee of <xsl:value-of select="total_fines_amount"/> kr,
          to be paid at the library or online with
        </xsl:otherwise>
      </xsl:choose>
      <a><xsl:attribute name="href">https://epay.uio.no/pay/shop/order-create.html?projectStepId=5203685</xsl:attribute>E-pay</a>.
    </p>

  </xsl:if>

  <!--
  <table cellpadding="5" cellspacing="0" class="listing" width="100%" style="margin: 0.8em 0;">
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
  -->

  <xsl:call-template name="email-footer"/><!-- footer.xsl -->
  <xsl:call-template name="myAccount" /><!-- footer.xsl -->

</xsl:template>

</xsl:stylesheet>
