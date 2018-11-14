<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:date="http://exslt.org/dates-and-times"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="date ext">
<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />


<xsl:template match="/">
  <xsl:call-template name="emailTemplate"/><!-- style.xsl -->
</xsl:template>

<xsl:template match="/notification_data">

  <xsl:call-template name="emailLogo"/><!-- mailReason.xsl -->
  <xsl:call-template name="senderReceiver" /> <!-- senderReceiver.xsl -->
  <!--<xsl:call-template name="toWhomIsConcerned"/>--><!-- mailReason.xsl -->

  <p>
    <strong>
      <xsl:call-template name="multilingual"><!-- header.xsl -->
        <xsl:with-param name="nb" select="'Takk for innbetalingen.'"/>
        <xsl:with-param name="nn" select="'Takk for innbetalinga.'"/>
        <xsl:with-param name="en" select="'Thank you for your payment.'"/>
      </xsl:call-template>
    </strong>
  </p>

  <xsl:if  test="transaction_id != ''" >
    <p>
      <xsl:call-template name="multilingual"><!-- header.xsl -->
        <xsl:with-param name="nb" select="'Dette er din kvittering for transaksjon '"/>
        <xsl:with-param name="nn" select="'Dette er din kvittering for transaksjon '"/>
        <xsl:with-param name="en" select="'This is your receipt for transaction '"/>
      </xsl:call-template>
      <xsl:value-of select="transaction_id"/>.
    </p>
  </xsl:if>

  <xsl:for-each select="labels_list">
    <p>
      <xsl:value-of select="letter.fineFeePaymentReceiptLetter.message"/>
    </p>
  </xsl:for-each>

  <table cellpadding="5" cellspacing="0" class="listing" width="100%">
    <tr>
      <th align="left">@@fee_type@@</th>
      <th align="left"></th>
      <th align="left">@@payment_date@@</th>
      <th align="right">@@paid_amount@@</th>
    </tr>
    <xsl:for-each select="user_fines_fees_list/user_fines_fees">
      <tr>
        <td valign="top">
          <xsl:value-of select="fine_fee_type_display"/>
          <xsl:if test="fines_fee_transactions/fines_fee_transaction/transaction_note != ''">
            <br />(<xsl:value-of select="fines_fee_transactions/fines_fee_transaction/transaction_note"/>)
          </xsl:if>
        </td>
        <td valign="top">
          <xsl:value-of select="item_title"/>
          <xsl:if test="item_barcode != ''">
            <tt>&#32;(<xsl:value-of select="item_barcode"/>)</tt>
          </xsl:if>
        </td>
        <td valign="top" style="white-space: nowrap;">
          <xsl:call-template name="isoDate"><!-- header.xsl -->
            <xsl:with-param name="value" select="create_date"/>
          </xsl:call-template>
        </td>
        <td align="right" valign="top">
          <xsl:value-of select="fines_fee_transactions/fines_fee_transaction/transaction_ammount/currency"/>&#160;<xsl:value-of select="fines_fee_transactions/fines_fee_transaction/transaction_amount_display"/>
        </td>
      </tr>
    </xsl:for-each>
    <tr>
      <td> </td>
      <td> </td>
      <td align="right"><b>@@total@@:</b></td>
      <td align="right"><xsl:value-of select="total_amount_paid"/></td>
      <td> </td>
     </tr>
  </table>

  <xsl:call-template name="email-footer">
    <xsl:with-param name="show_my_account" select="true()"/>
  </xsl:call-template>

   <!-- footer.xsl -->
  <xsl:call-template name="contactUs" /> <!-- footer.xsl -->

</xsl:template>
</xsl:stylesheet>