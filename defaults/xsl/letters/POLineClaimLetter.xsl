<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="header.xsl" />
  <xsl:include href="senderReceiver.xsl" />
  <xsl:include href="mailReason.xsl" />
  <xsl:include href="footer.xsl" />
  <xsl:include href="style.xsl" />

  <xsl:variable name="conta1">0</xsl:variable>
  <xsl:variable name="stepType" select="/notification_data/request/work_flow_entity/step_type" />
  <xsl:variable name="externalRequestId" select="/notification_data/external_request_id" />
  <xsl:variable name="externalSystem" select="/notification_data/external_system" />

  <xsl:template match="/">
    <html>
      <head>
        <xsl:call-template name="generalStyle" />
      </head>
      <body>
        <xsl:attribute name="style">
          <xsl:call-template name="bodyStyleCss" />
          <!-- style.xsl -->
        </xsl:attribute>
        <xsl:call-template name="head" />
        <!-- header.xsl -->
        <xsl:call-template name="senderReceiver" />
         <xsl:call-template name="toWhomIsConcerned" /> <!-- mailReason.xsl -->
        <div class="messageArea">
          <div class="messageBody">
            <table cellspacing="0" cellpadding="5" border="0">
    <tr>
     <td>@@attached_information_regarding@@.<br />
     @@please_supply@@.
     </td>
    </tr>
    <tr>
     <td>
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
       <strong>@@currency@@:</strong>&#160;<xsl:value-of select="currency" />
       <br />
       <strong>@@unit_price@@:</strong>&#160;<xsl:value-of select="price" />
       <br />
       <strong>@@total_price@@:</strong>&#160;<xsl:value-of select="total_price" />
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
    </td>
   </tr>

   </table>
   <br />
    <table>

      <tr><td>@@sincerely@@</td></tr>
      <tr><td>@@department@@</td></tr>

    </table>
          </div>
        </div>
        <xsl:call-template name="lastFooter" />
        <!-- footer.xsl -->
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>