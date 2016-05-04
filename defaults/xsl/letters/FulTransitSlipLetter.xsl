<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="header.xsl" />
  <xsl:include href="senderReceiver.xsl" />
  <xsl:include href="mailReason.xsl" />
  <xsl:include href="footer.xsl" />
  <xsl:include href="style.xsl" />
  <xsl:include href="recordTitle.xsl" />
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
        <div class="messageArea">
          <div class="messageBody">
            <table cellspacing="0" cellpadding="5" border="0">
              <tr>
                <td><b>@@print_date@@: </b>
                <xsl:value-of select="notification_data/request/create_date" />-

                <xsl:value-of select="notification_data/request/create_time" /></td>
              </tr>
              <tr>
                <td>
                  <b>@@request_id@@: </b>
                  <img src="cid:request_id_barcode.png"
                  alt="Request Barcode" />
                </td>
              </tr>
              <tr>
                <td>
                  <b>@@item_barcode@@: </b>
                  <img src="cid:item_id_barcode.png"
                  alt="Item Barcode" />
                </td>
              </tr>
              <tr>
                <td>@@we_are_transferring_item_below@@</td>
              </tr>
              <tr>
                <td><b>@@from@@: </b>
                <xsl:value-of select="notification_data/request/assigned_unit_name" /></td>
              </tr>
              <tr>
                <td><b>@@to@@: </b>
                <xsl:value-of select="notification_data/request/calculated_destination_name" /></td>
              </tr>
              <tr>
                <td><b>@@transfer_date@@: </b>
                <xsl:value-of select="notification_data/request/create_date" /></td>
              </tr>
              <tr>
                <td><b>@@transfer_time@@: </b>
                <xsl:value-of select="notification_data/request/create_time" /></td>
              </tr>
     <xsl:if test="notification_data/request/material_type_display">
      <tr>
     <td><b>@@material_type@@: </b>
     <xsl:value-of select="notification_data/request/material_type_display" /></td>
      </tr>
     </xsl:if>
              <xsl:if test="notification_data/user_for_printing/note">
                <tr>
                  <td>
                    <b>@@user_note@@:</b>
                  </td>
                </tr>
                <tr>
                  <td>
                    <xsl:value-of select="notification_data/user_for_printing/note" />
                  </td>
                </tr>
              </xsl:if>
              <xsl:if test="notification_data/request/system_notes">
                <tr>
                  <td>
                    <b>@@system_notes@@:</b>
                  </td>
                </tr>
                <tr>
                  <td>
                    <xsl:value-of select="notification_data/request/system_notes" />
                  </td>
                </tr>
              </xsl:if>
              <xsl:if test="notification_data/request/note">
    <tr>
     <td>
      <b>@@request_note@@:</b>
     </td>
    </tr>
    <tr>
     <td>
      <xsl:value-of select="notification_data/request/note" />
     </td>
    </tr>
     </xsl:if>
              <xsl:if test="notification_data/user_for_printing/name">
                <tr>
                  <td>
                    <b>@@requested_for@@:</b>
                  </td>
                </tr>
                <tr>
                  <td>
                    <xsl:value-of select="notification_data/user_for_printing/name" />
                  </td>
                </tr>
                <xsl:if test="notification_data/user_for_printing/email">
                  <tr>
                    <td><b>@@email@@: </b>
                    <xsl:value-of select="notification_data/user_for_printing/email" /></td>
                  </tr>
                </xsl:if>
                <xsl:if test="notification_data/user_for_printing/phone">
                  <tr>
                    <td><b>@@tel@@: </b>
                    <xsl:value-of select="notification_data/user_for_printing/phone" /></td>
                  </tr>
                </xsl:if>
                <tr>
                  <td><b>@@request_date@@: </b>
                  <xsl:value-of select="notification_data/request/create_date" /></td>
                </tr>
                <xsl:if test="notification_data/request/lastInterestDate">
                  <tr>
                    <td><b>@@expiration_date@@: </b>
                    <xsl:value-of select="notification_data/request/lastInterestDate" /></td>
                  </tr>
                </xsl:if>
              </xsl:if>
     <tr>
    <td><xsl:call-template name="recordTitle" /></td>
     </tr>
     <xsl:if test="notification_data/phys_item_display/owning_library_name">
                  <tr>
                    <td><b>@@owning_library@@: </b>
                    <xsl:value-of select="notification_data/phys_item_display/owning_library_name" /></td>
                  </tr>
                </xsl:if>
            </table>
          </div>
        </div>
        <!-- recordTitle.xsl -->
        <xsl:call-template name="lastFooter" />
        <!-- footer.xsl -->
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>