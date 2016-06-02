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

  <xsl:call-template name="email-logo"/><!-- header.xsl -->
  <xsl:call-template name="senderReceiver" /> <!-- senderReceiver.xsl -->
  <!--<xsl:call-template name="toWhomIsConcerned"/>--><!-- mailReason.xsl -->

  <xsl:if  test="transaction_id != ''" >
    <h4>@@transaction_id@@: <xsl:value-of select="transaction_id"/></h4>
  </xsl:if>

  <xsl:for-each select="labels_list">
    <p>
      <xsl:value-of select="letter.fineFeePaymentReceiptLetter.message"/>
    </p>
  </xsl:for-each>

  <table cellpadding="5" cellspacing="0" class="listing" width="100%">
    <tr>
      <th align="left">@@fee_type@@</th>
      <th align="left">@@payment_date@@</th>
      <th align="right">@@paid_amount@@</th>
      <th align="left">@@payment_method@@</th>
    </tr>
    <xsl:for-each select="user_fines_fees_list/user_fines_fees">
      <tr>
        <td valign="top">
          <xsl:value-of select="fine_fee_type_display"/>
          <xsl:if test="fines_fee_transactions/fines_fee_transaction/transaction_note != ''">
            <br />(<xsl:value-of select="fines_fee_transactions/fines_fee_transaction/transaction_note"/>)
          </xsl:if>
        </td>
        <td valign="top" style="white-space: nowrap;">
          <xsl:call-template name="normalizedDate"><!-- header.xsl -->
            <xsl:with-param name="value" select="create_date"/>
          </xsl:call-template>
        </td>
        <td align="right" valign="top">
          <xsl:value-of select="fines_fee_transactions/fines_fee_transaction/transaction_ammount/currency"/>&#160;<xsl:value-of select="fines_fee_transactions/fines_fee_transaction/transaction_amount_display"/>
        </td>
        <td valign="top">
          <xsl:value-of select="fines_fee_transactions/fines_fee_transaction/transaction_method"/>
        </td>
      </tr>
    </xsl:for-each>
    <tr>
      <td> </td>
      <td align="right"><b>@@total@@:</b></td>
      <td align="right"><xsl:value-of select="total_amount_paid"/></td>
      <td> </td>
     </tr>
  </table>

  <xsl:call-template name="email-footer" /> <!-- footer.xsl -->
  <xsl:call-template name="contactUs" /> <!-- footer.xsl -->

</xsl:template>
</xsl:stylesheet>