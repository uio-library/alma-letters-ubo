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

    <table>

       <tr>
        <td>
         <h3>@@Dear@@</h3>
        </td>
       </tr>

    </table>

    <div class="messageArea">
     <div class="messageBody">



      <table cellspacing="0" cellpadding="5" border="0">
       <xsl:choose>
        <xsl:when test="notification_data/notification_type = 'NOTIFY_PASSWORD_CHANGE' ">
         <tr>
          <td>
           <h3>@@Line_1@@</h3>
           <xsl:value-of select="notification_data/temp_password" />
          </td>

         </tr>
         <tr>

          <td>
           <h3>@@Line_2@@</h3>
          </td>
         </tr>
        </xsl:when>

       </xsl:choose>
      </table>
      <br />
      <table>

       <tr>
        <td>@@Sincerely@@</td>
       </tr>
       <tr>
        <td>
         <xsl:value-of select="notification_data/organization_unit/name" />
        </td>
       </tr>
       <xsl:if test="notification_data/organization_unit/address/line1 !=''">
        <tr>
         <td>
          <xsl:value-of select="notification_data/organization_unit/address/line1" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/organization_unit/address/line2 !=''">
        <tr>
         <td>
          <xsl:value-of select="notification_data/organization_unit/address/line2" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/organization_unit/address/line3 !=''">
        <tr>
         <td>
          <xsl:value-of select="notification_data/organization_unit/address/line3" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/organization_unit/address/line4 !=''">
        <tr>
         <td>
          <xsl:value-of select="notification_data/organization_unit/address/line4" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/organization_unit/address/line5 !=''">
        <tr>
         <td>
          <xsl:value-of select="notification_data/organization_unit/address/line5" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/organization_unit/address/city !=''">
        <tr>
         <td>
          <xsl:value-of select="notification_data/organization_unit/address/city" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/organization_unit/address/country !=''">
        <tr>
         <td>
          <xsl:value-of select="notification_data/organization_unit/address/country" />
         </td>
        </tr>

       </xsl:if>

      </table>
     </div>
    </div>
    <xsl:call-template name="lastFooter" />
    <!-- footer.xsl -->
   </body>
  </html>
 </xsl:template>
</xsl:stylesheet>