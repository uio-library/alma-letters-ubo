<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="header.xsl" />
  <xsl:include href="senderReceiver.xsl" />
  <xsl:include href="mailReason.xsl" />
  <xsl:include href="footer.xsl" />
  <xsl:include href="style.xsl" />
  <xsl:include href="recordTitle.xsl" />
  <xsl:variable name="conta1">0</xsl:variable>
  <xsl:variable name="stepType" select="/notification_data/request/work_flow_entity/step_type" />
  <xsl:variable name="externalRequestId" select="/notification_data/external_request_id" />
  <xsl:variable name="externalSystem" select="/notification_data/external_system" />
  <xsl:variable name="isDeposit" select="/notification_data/request/deposit_indicator" />
  <xsl:variable name="isDigitalDocDelivery" select="/notification_data/digital_document_delivery" />

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
        <!-- SenderReceiver.xsl -->
        <div class="messageArea">
          <div class="messageBody">
            <table cellspacing="0" cellpadding="5" border="0">
    <tr>
     <td>@@your_request@@.</td>
    </tr>
    <xsl:if test="$isDeposit='true'">
    <tr>
     <td>@@material@@:</td>
    </tr>
    <tr>
     <td>
     <a>
                        <xsl:attribute name="href">
                          <xsl:value-of select="notification_data/item_url" />
                        </xsl:attribute>
      <xsl:value-of select="notification_data/phys_item_display/title"/>
     </a>
     </td>
    </tr>
    </xsl:if>

    <xsl:if test="$isDigitalDocDelivery='true' or $isDeposit='false'"> <!-- DOCUMENT DELIVERY -->
     <tr>
      <td>@@material@@:</td>
     </tr>
     <tr>
      <td>
       <xsl:value-of select="notification_data/phys_item_display/title"/>
      </td>
     </tr>
     <xsl:if test="$externalRequestId">
      <tr>
       <td>@@the_request_relates@@<xsl:value-of select="$externalRequestId"/> @@of@@ <xsl:value-of select="$externalSystem"/>.</td>
      </tr>
     </xsl:if>

     <xsl:if test="/notification_data/url_list[string]">
      <tr>
       <td>@@attached_are_the_urls@@:</td>
      </tr>

      <xsl:for-each select="/notification_data/attachments_list/attachments">
       <xsl:if test="url">
       <tr>
        <td>
         <a>
         <xsl:attribute name="href">
          <xsl:value-of select="url" />
         </xsl:attribute>
         <xsl:value-of select="url" />
         </a>
        </td>
       </tr>

       </xsl:if>
      </xsl:for-each>

     </xsl:if>
                </xsl:if>

    <tr>
    <td>@@request_type_digitization@@</td>
     </tr>
            <tr>
    <td>@@sincerely@@<br />@@department@@</td>
     </tr>
   </table>
          </div>
        </div>
        <xsl:call-template name="lastFooter" />
        <!-- footer.xsl -->
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>