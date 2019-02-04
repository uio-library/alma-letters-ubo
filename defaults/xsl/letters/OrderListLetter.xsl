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

    <xsl:for-each select="notification_data/letter_texts">
    <table cellspacing="0" cellpadding="5" border="0">
     <tr>
      <td>@@place_order_introduction@@:</td>
     </tr>
    </table>
    <br />

    </xsl:for-each>
    <xsl:for-each select="notification_data">
    <table>
     <tr>
      <td><b>@@order_date@@: </b> <xsl:value-of select="/notification_data/po/create_date"/></td>
     </tr>
     <tr>
      <td><b>@@vendor_account@@: </b><xsl:value-of select="/notification_data/po/vendor_account/description"/></td>
     </tr>
     <tr>
      <td><b>@@shipping_address@@: </b><xsl:value-of select="/notification_data/po/ship_to_address/line1"/>&#160;<xsl:value-of select="/notification_data/po/ship_to_address/line2"/>&#160;<xsl:value-of select="/notification_data/po/ship_to_address/city"/>&#160;<xsl:value-of select="/notification_data/po/ship_to_address/country"/></td>
     </tr>
     <tr>
      <td><b>@@shipping_method@@: </b><xsl:value-of select="/notification_data/po/shipping_method"/></td>
     </tr>
     <tr>
      <td><b>@@billing_address@@: </b><xsl:value-of select="/notification_data/po/bill_to_address/line1"/>&#160;<xsl:value-of select="/notification_data/po/bill_to_address/line2"/>&#160;<xsl:value-of select="/notification_data/po/bill_to_address/city"/>&#160;<xsl:value-of select="/notification_data/po/bill_to_address/country"/></td>
     </tr>
     <xsl:if test="/notification_data/po/erp_number != ''">
      <tr>
       <td><b>@@erp_number@@: </b><xsl:value-of select="/notification_data/po/erp_number"/></td>
      </tr>
     </xsl:if>
    </table>
    </xsl:for-each>
    <br />


    <table cellpadding="5" class="listing">
    <xsl:attribute name="style">
     <xsl:call-template name="mainTableStyleCss" /> <!-- style.xsl -->
    </xsl:attribute>
     <tr>
      <th>@@po_line_number@@</th>
      <th>@@date@@</th>
      <th>@@issn_isbn@@</th>
      <th>@@title@@</th>
      <th>@@quantity@@</th>
      <th align="right">@@price@@</th>
      <th>@@note@@</th>
     </tr>
     <xsl:for-each select="notification_data/po/po_line_list/po_line">
     <tr>
      <td><xsl:value-of select="line_reference"/></td>
      <td><xsl:value-of select="create_date"/></td>
      <td><xsl:value-of select="identifier_type"/>&#160;<xsl:value-of select="identifier"/></td>
      <td><xsl:value-of select="meta_data_values/title"/></td>
      <td><xsl:value-of select="total_quantity"/></td>
      <td align="right"><xsl:value-of select="total_price_compose/currency"/>&#160;<xsl:value-of select="total_price_compose_with_normalized_sum/normalized_sum"/></td>
      <td><xsl:value-of select="vendor_note"/></td>
     </tr>
     </xsl:for-each>
    </table>
    <br />
    <table>

      <tr><td>@@sincerely@@</td></tr>
      <tr><td>@@department@@</td></tr>

    </table>


    <xsl:call-template name="lastFooter" /> <!-- footer.xsl -->
   </body>
 </html>
</xsl:template>

</xsl:stylesheet>