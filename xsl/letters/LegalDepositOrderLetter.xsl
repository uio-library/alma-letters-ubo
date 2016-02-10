<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="style.xsl" />
<xsl:include href="footer.xsl" />

<xsl:template name="letterBodyMon">
 <table cellspacing="0" cellpadding="5" border="0">
  <tr>
   <td>
    <xsl:for-each select="notification_data">
     <h3><strong>@@Dear_Publisher@@</strong> <br />



       @@additional_info_OT_line1@@<br />
      <br />
      @@additional_info_OT_line2@@ <br />
      @@additional_info_OT_line3@@ <br />
      @@additional_info_OT_line4@@<br />
      <br />
      @@additional_info_OT_line5@@<br />
      @@additional_info_OT_line6@@  <br />
      <br />
      @@additional_info_OT_line7@@ <br />
      @@additional_info_OT_line8@@ <br />
      @@additional_info_OT_line9@@ <br />
      @@additional_info_OT_line10@@ <br />

     </h3>
    </xsl:for-each>
   </td>
  </tr>
 </table>
</xsl:template>
<xsl:template name="letterBodySer">
 <table cellspacing="0" cellpadding="5" border="0">
  <tr>
   <td>
    <xsl:for-each select="notification_data">
     <h3><strong>@@Dear_Publisher@@</strong> <br />
      <div>@@additional_info_CO_line1@@</div>
      <br />
      <div>@@additional_info_CO_line2@@ </div>
      <div>@@additional_info_CO_line3@@ </div>
      <div>@@additional_info_CO_line4@@</div>
      <br />
      <div>@@additional_info_CO_line5@@</div>
      <div>@@additional_info_CO_line6@@  </div>
      <br />
      <div>@@additional_info_CO_line7@@ </div>
      <div>@@additional_info_CO_line8@@ </div>
      <div>@@additional_info_CO_line9@@ </div>
      <div>@@additional_info_CO_line10@@ </div>
      <br />
      <div>@@additional_info_CO_line11@@  </div>
      <div>@@additional_info_CO_line12@@  </div>
      <div>@@additional_info_CO_line13@@  </div>
      <div>@@additional_info_CO_line14@@  </div>
      <div>@@additional_info_CO_line15@@  </div>

     </h3>
      <br />

     <h3>
      <div>@@additional_info_CO_line16@@  </div>
      <div>@@additional_info_CO_line17@@  </div>
      <div>@@additional_info_CO_line18@@  </div>
      <div>@@additional_info_CO_line19@@ </div>
      <div>@@additional_info_CO_line20@@</div>
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

    <table cellspacing="0" cellpadding="5" border="0">
 <xsl:attribute name="style">
  <xsl:call-template name="headerTableStyleCss" /> <!-- style.xsl -->
 </xsl:attribute>
<!-- LOGO INSERT -->
 <tr>
 <xsl:attribute name="style">
  <xsl:call-template name="headerLogoStyleCss" /> <!-- style.xsl -->
 </xsl:attribute>
  <td colspan="2">
  <div id="mailHeader">
              <div id="logoContainer" class="alignLeft">
                    <img src="cid:logo.jpg" alt="logo"/>
               </div>
  </div>
  </td>
 </tr>
<!-- END OF LOGO INSERT -->
 <tr>

  <xsl:for-each select="notification_data/general_data">
  <td>
  <h1><xsl:value-of select="subject"/></h1>
 </td>
 <td align="right">
  <xsl:value-of select="current_date"/>
 </td>
  </xsl:for-each>

</tr>
</table>

    <br />

    <!-- SLQ - State Library of - LEGAL DEPOSIT Notification
    CONTINUOUS, ONETIME, STANDINGORDER
    -->

     <xsl:choose>
       <xsl:when test="notification_data/po/po_line_list/po_line/continuity='CONTINUOUS' or notification_data/po/po_line_list/po_line/continuity='STANDINGORDER' ">

        <xsl:call-template name="letterBodySer" />
      </xsl:when>
      <xsl:when test="notification_data/po/po_line_list/po_line/continuity='ONETIME'">
       <xsl:call-template name="letterBodyMon" />

      </xsl:when>
      <xsl:otherwise>

      </xsl:otherwise>
     </xsl:choose>

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
     <xsl:for-each select="notification_data/po/po_line_list/po_line">
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