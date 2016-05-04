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

      <div>@@additional_info_OT_line1@@</div>
      <br />
      <div>@@additional_info_OT_line2@@ </div>
      <div>@@additional_info_OT_line3@@ </div>
      <div>@@additional_info_OT_line4@@</div>
      <br />
      <div>@@additional_info_OT_line5@@</div>
      <div>@@additional_info_OT_line6@@ </div>
      <br />
      <div>@@additional_info_OT_line7@@ </div>
      <div>@@additional_info_OT_line8@@</div>
      <div>@@additional_info_OT_line9@@ </div>
      <div>@@additional_info_OT_line10@@ </div>

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
  <xsl:call-template name="head" /> <!-- header.xsl -->


     <xsl:choose>
       <xsl:when test="notification_data/line_details/continuity='CONTINUOUS' or notification_data/po/po_line_list/po_line/continuity='STANDINGORDER' ">

        <xsl:call-template name="letterBodySer" />
      </xsl:when>
      <xsl:when test="notification_data/line_details/continuity='ONETIME'">
       <xsl:call-template name="letterBodyMon" />

      </xsl:when>
      <xsl:otherwise>

      </xsl:otherwise>
     </xsl:choose>
     <xsl:for-each select="notification_data/line_details">
     <table cellspacing="0" cellpadding="5" border="0">
      <tr>
       <td>
       <strong>@@claim@@:</strong>&#160;@@not_yet_arrived@@
       <br />
       <strong>@@order_line_ref_num@@:</strong>&#160;<xsl:value-of select="poline_reference_number" />
       <br />
       <strong>@@order_date@@:</strong>&#160;<xsl:value-of select="poline_date" />
       <br />
       <strong>@@vendor_ref_num@@:</strong>&#160;<xsl:value-of select="vendor_refernce_number" />
       <br />
       <strong>@@delivery_type@@:</strong>&#160;<xsl:value-of select="shipping_method" />
       <br />
       <strong>@@vendor_note@@:</strong>&#160;<xsl:value-of select="vendor_note" />
       <br />
       <strong>@@num_units_arrived@@:</strong>&#160;<xsl:value-of select="items_received" />
       <br />
       <strong>@@num_units_ordered@@:</strong>&#160;<xsl:value-of select="items_oredered" />
       <br />
       <strong>@@vendor_contact@@:</strong>&#160;<xsl:value-of select="vendor_contact_persons" />
       <br />
       <strong>@@title@@:</strong>&#160;<xsl:value-of select="title" />
       <br />
       <strong>@@author@@:</strong>&#160;<xsl:value-of select="author" />
       <br />
       <strong>@@publication_date@@:</strong>&#160;<xsl:value-of select="publication_date" />
       <br />
       <strong>@@publication_place@@:</strong>&#160;<xsl:value-of select="publication_place" />
       <br />
       <strong>@@publisher@@:</strong>&#160;<xsl:value-of select="publisher" />

       </td>

      </tr>

    </table>
    </xsl:for-each>
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