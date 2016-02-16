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
    <xsl:call-template name="bodyStyleCss" /> <!-- style.xsl -->
   </xsl:attribute>
    <xsl:call-template name="head" /> <!-- header.xsl -->
   <!-- <xsl:call-template name="senderReceiver" />--> <!-- SenderReceiver.xsl -->

  <div class="messageArea">
    <div class="messageBody">

      <xsl:call-template name="toWhomIsConcerned" /> <!-- mailReason.xsl -->

      <p>
        <xsl:choose>
          <xsl:when test="notification_data/success='true'">
            <!--<td>@@on@@ <xsl:value-of select="notification_data/general_data/current_date"/> @@we_renewed_y_req_from@@ <xsl:value-of select="notification_data/outgoing/create_date"/> @@detailed_below@@ :</td>-->
            @@renewed_loan@@:
          </xsl:when>
          <xsl:otherwise>
            @@not_renewed_loan@@:
          </xsl:otherwise>
        </xsl:choose>
      </p>

      <xsl:call-template name="recordTitle" /> <!-- recordTitle.xsl -->

      <p>
        <xsl:choose>
          <xsl:when test="notification_data/success='true'">
            @@new_due_date@@:
            <xsl:value-of select="notification_data/item_loan_due_date"/><br/>
            @@success_reason@@
          </xsl:when>
          <xsl:otherwise>
           @@contact_dep@@
          </xsl:otherwise>
        </xsl:choose>
      </p>

    </div>
   </div>

   <xsl:call-template name="lastFooter" /> <!-- footer.xsl -->

  </body>
 </html>
 </xsl:template>
</xsl:stylesheet>