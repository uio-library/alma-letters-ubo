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
    <xsl:call-template name="toWhomIsConcerned" /> <!-- mailReason.xsl -->

    <xsl:if  test="notification_data/transaction_id != ''" >
     <h4>@@transaction_id@@: <xsl:value-of select="/notification_data/transaction_id"/></h4>
    </xsl:if>

    <xsl:for-each select="notification_data/labels_list">
    <table cellspacing="0" cellpadding="5" border="0">
     <tr>
      <td><xsl:value-of select="letter.fineFeePaymentReceiptLetter.message"/></td>
     </tr>
    </table>
    <br />

    </xsl:for-each>
    <table cellpadding="5" class="listing">
    <xsl:attribute name="style">
     <xsl:call-template name="mainTableStyleCss" /> <!-- style.xsl -->
    </xsl:attribute>
     <tr>
      <th>@@fee_type@@</th>
      <th>@@payment_date@@</th>
      <th align="right">@@paid_amount@@</th>
      <th>@@payment_method@@</th>
      <th>@@note@@</th>
     </tr>
     <xsl:for-each select="notification_data/user_fines_fees_list/user_fines_fees">
     <tr>
      <td><xsl:value-of select="fine_fee_type_display"/></td>
      <td><xsl:value-of select="create_date"/></td>
      <td align="right"><xsl:value-of select="fines_fee_transactions/fines_fee_transaction/transaction_ammount/currency"/>&#160;<xsl:value-of select="fines_fee_transactions/fines_fee_transaction/transaction_amount_display"/></td>
      <td><xsl:value-of select="fines_fee_transactions/fines_fee_transaction/transaction_method"/></td>
      <td><xsl:value-of select="fines_fee_transactions/fines_fee_transaction/transaction_note"/></td>
     </tr>
     </xsl:for-each>

     <tr>
      <td> </td>
      <td align="right"><b>@@total@@:</b></td>
      <td align="right"><xsl:value-of select="notification_data/total_amount_paid"/></td>
     </tr>

    </table>
    <br />
    <table>

      <tr><td>@@sincerely@@</td></tr>
      <tr><td>@@department@@</td></tr>

    </table>

    <xsl:call-template name="lastFooter" /> <!-- footer.xsl -->
    <xsl:call-template name="contactUs" />
   </body>
 </html>
</xsl:template>

</xsl:stylesheet>