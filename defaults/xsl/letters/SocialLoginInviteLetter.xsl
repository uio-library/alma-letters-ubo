<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

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
   <xsl:call-template name="head" /> <!-- header.xsl -->
   <xsl:call-template name="senderReceiver" /> <!-- SenderReceiver.xsl -->
   <br />
   <xsl:call-template name="toWhomIsConcerned" /> <!-- mailReason.xsl -->
   <div class="messageArea">
    <div class="messageBody">
     <table cellspacing="0" cellpadding="5" border="0">
                <tr>
                 <td>
       @@bodyTextBeforeLink@@
       <a>
                          <xsl:attribute name="href">
                            <xsl:value-of select="notification_data/attach_social_account_url" />
                          </xsl:attribute>
        @@linkLabel@@</a>
       @@bodyTextAfterLink@@
                  </td>
                </tr>
                <tr>
                 <td>
       @@line2@@
                  </td>
                </tr>
              </table>
     <table>
      <tr>
       <td>@@signature@@</td>
      </tr>
      <tr>
       <td>
        <xsl:value-of select="notification_data/institution/name" />
       </td>
      </tr>
      <xsl:if test="notification_data/institution/address/line1 !=''">
       <tr>
        <td>
         <xsl:value-of select="notification_data/institution/address/line1" />
        </td>
       </tr>
      </xsl:if>
      <xsl:if test="notification_data/institution/address/line2 !=''">
       <tr>
        <td>
         <xsl:value-of select="notification_data/institution/address/line2" />
        </td>
       </tr>
      </xsl:if>
      <xsl:if test="notification_data/institution/address/line3 !=''">
       <tr>
        <td>
         <xsl:value-of select="notification_data/institution/address/line3" />
        </td>
       </tr>
      </xsl:if>
      <xsl:if test="notification_data/institution/address/line4 !=''">
       <tr>
        <td>
         <xsl:value-of select="notification_data/institution/address/line4" />
        </td>
       </tr>
      </xsl:if>
      <xsl:if test="notification_data/institution/address/line5 !=''">
       <tr>
        <td>
         <xsl:value-of select="notification_data/institution/address/line5" />
        </td>
       </tr>
      </xsl:if>
      <xsl:if test="notification_data/institution/address/city !=''">
       <tr>
        <td>
         <xsl:value-of select="notification_data/institution/address/city" />
        </td>
       </tr>
      </xsl:if>
      <xsl:if test="notification_data/institution/address/country !=''">
       <tr>
        <td>
         <xsl:value-of select="notification_data/institution/address/country" />
        </td>
       </tr>
      </xsl:if>
     </table>
            </div>
    </div>
   <xsl:call-template name="lastFooter" /> <!-- footer.xsl -->
  </body>
 </html>
</xsl:template>
</xsl:stylesheet>