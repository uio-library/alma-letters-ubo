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

        <div class="messageArea">
          <div class="messageBody">

            <xsl:call-template name="toWhomIsConcerned" /> <!-- mailReason.xsl -->

            <div>
              @@your_request@@.
            </div>

            <xsl:if test="$isDeposit='true'">
              <div>
                @@material@@:
              </div>
              <div>
                <a>
                  <xsl:attribute name="href">
                    <xsl:value-of select="notification_data/item_url" />
                  </xsl:attribute>
                  <xsl:value-of select="notification_data/phys_item_display/title"/>
                </a>
              </div>
            </xsl:if>

            <xsl:if test="$isDigitalDocDelivery='true' or $isDeposit='false'"> <!-- DOCUMENT DELIVERY -->
              <div>
                <xsl:value-of select="notification_data/phys_item_display/title"/>
              </div>

              <xsl:if test="/notification_data/url_list[string]">
                <div>
                  @@attached_are_the_urls@@:
                </div>
                <ul>
                  <xsl:for-each select="/notification_data/attachments_list/attachments">
                   <xsl:if test="url">
                   <li>
                     <a>
                     <xsl:attribute name="href">
                      <xsl:value-of select="url" />
                     </xsl:attribute>
                     <xsl:value-of select="url" />
                     </a>
                    </li>
                   </xsl:if>
                  </xsl:for-each>
                </ul>
              </xsl:if>
            </xsl:if>

          </div>
        </div>

        <xsl:call-template name="lastFooter" /> <!-- footer.xsl -->

      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>