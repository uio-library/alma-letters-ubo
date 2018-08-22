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
    <xsl:call-template name="senderReceiver" /> <!-- SenderReceiver.xsl -->
    <xsl:call-template name="toWhomIsConcerned" /> <!-- mailReason.xsl -->

  <div class="messageArea">
    <div class="messageBody">
      <table cellspacing="0" cellpadding="5" border="0">
       
      <xsl:choose>
       <xsl:when test="notification_data/success='true'">
        <!--<td>@@on@@ <xsl:value-of select="notification_data/general_data/current_date"/> @@we_renewed_y_req_from@@ <xsl:value-of select="notification_data/outgoing/create_date"/> @@detailed_below@@ :</td>-->
        <tr><td>@@renewed_loan@@:</td></tr>
       </xsl:when>

       <xsl:otherwise>
        <td>@@not_renewed_loan@@:</td>
       </xsl:otherwise>
      </xsl:choose>

      <tr>
       <td><xsl:call-template name="recordTitle" /> <!-- recordTitle.xsl --></td>
      </tr>

      <xsl:choose>

       <xsl:when test="notification_data/success='true'">
        <tr>
         <td>@@new_due_date@@: <xsl:value-of select="notification_data/item_loan_due_date"/></td>
        </tr>

        <tr>
         <td><b>@@success_reason@@</b></td>
        </tr>
       </xsl:when>

       <xsl:otherwise>
        <xsl:choose>
         <xsl:when test="notification_data/note != ''">
          <tr>
           <td><b>@@failure_reason@@: <xsl:value-of select="notification_data/note"/></b></td>
          </tr>
         </xsl:when>
        </xsl:choose>
        <tr>
         <td><b>@@contact_dep@@</b></td>
        </tr>
       </xsl:otherwise>

      </xsl:choose>
     </table>
  
     <br />
  
     <table>
      <tr><td>@@sincerely@@</td></tr>
      <tr><td>@@department@@</td></tr>
     </table>
    </div>
   </div>
   <xsl:call-template name="lastFooter" /> <!-- footer.xsl -->
  </body>
 </html>
 </xsl:template>
</xsl:stylesheet>