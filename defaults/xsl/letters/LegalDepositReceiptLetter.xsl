<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="style.xsl" />
<xsl:include href="footer.xsl" />

<xsl:template name="letterBody">
 <table cellspacing="0" cellpadding="5" border="0">
  <tr>
   <td>
    <xsl:for-each select="notification_data">


     <h3><strong>@@Dear_Publisher@@</strong> <br />
      @@additional_info_line1@@<br />
      <br />
      @@additional_info_line2@@ <br />
      @@additional_info_line3@@ <br />
      @@additional_info_line4@@<br />
      <br />
      @@additional_info_line5@@<br />
      @@additional_info_line6@@  <br />
      <br />
      @@additional_info_line7@@ <br />
      @@additional_info_line8@@ <br />
      @@additional_info_line9@@ <br />
      @@additional_info_line10@@ <br />
      <br />
      @@additional_info_line11@@  <br />
      @@additional_info_line12@@  <br />
      @@additional_info_line13@@  <br />
      @@additional_info_line14@@  <br />
      @@additional_info_line15@@  <br />
      @@additional_info_line16@@  <br />
      @@additional_info_line17@@  <br />
      @@additional_info_line18@@  <br />
      @@additional_info_line19@@ <br />
      @@additional_info_line20@@<br />
     </h3>
   </xsl:for-each>
   </td>
  </tr>
 </table>
</xsl:template>
<xsl:template match="/">
 <html>
  <head>
  <xsl:call-template name="generalStyle" />
  </head>

   <body>
   <xsl:attribute name="style">
    <xsl:call-template name="bodyStyleCss" /> <!-- style.xsl -->
   </xsl:attribute>

     <xsl:call-template name="head" />
        <!-- header.xsl -->

    <br />

      <xsl:call-template name="letterBody" />


    <br />
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
    </table>
    </xsl:for-each>
    <br />
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
      <th>@@note@@</th>
     </tr>
     <xsl:for-each select="notification_data/line">
     <tr>
      <td><xsl:value-of select="line_reference"/></td>
      <td><xsl:value-of select="create_date"/></td>
      <td><xsl:value-of select="identifier_type"/>&#160;<xsl:value-of select="identifier"/></td>
      <td><xsl:value-of select="meta_data_values/title"/></td>
      <td><xsl:value-of select="total_quantity"/></td>
      <td><xsl:value-of select="vendor_note"/></td>
     </tr>
     </xsl:for-each>
    </table>
    <br />

    <xsl:call-template name="senderReceiver" /> <!-- SenderReceiver.xsl -->
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