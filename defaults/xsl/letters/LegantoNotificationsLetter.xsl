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
          <xsl:call-template name="bodyStyleCss" /><!-- style.xsl -->
        </xsl:attribute>

    <xsl:call-template name="head" /><!-- header.xsl -->
    <xsl:call-template name="senderReceiver" /> <!-- SenderReceiver.xsl -->

    <br />
    <xsl:call-template name="toWhomIsConcerned" /> <!-- mailReason.xsl -->

    <div class="messageArea">
     <div class="messageBody">

      <table cellspacing="0" cellpadding="5" border="0"
       style="width:100%; background-color: #f3f7f8; padding: 0px 25px 25px 25px; border-bottom: 2px solid #dce8eb; font-family: 'Source Sans Pro' !important;padding: 25px 0 15px 0;">

       <tr>
        <td style="font-size:18px;padding: 0px 0 5px 10px;">
         <b>
          You have
          <xsl:value-of select="notification_data/sum_of_notifications" />
          new notifications:
         </b>
         <br />
         <br />
        </td>
       </tr>

       <xsl:for-each select="notification_data/events/notifications_summary">
        <tr>
         <td style="padding:0 0 5px 10px;">
          <xsl:value-of select="num_of_events" />
          &#160;
          <xsl:value-of select="event_type_display" />
         </td>

        </tr>
       </xsl:for-each>
       
       <xsl:if test="notification_data/leganto_url  !=''">
       <span style="padding:0 0 5px 10px;">
       To see all your lists
       <xsl:element name="a">
        <xsl:attribute name="href">
         <xsl:value-of select="notification_data/leganto_url" />
        </xsl:attribute>

        <xsl:attribute name="style">
         <xsl:value-of select="'color:#337ab7;font-weight:bold;'"/>
        </xsl:attribute>
        go to Leganto
       </xsl:element>
       </span>
       </xsl:if>
      </table>

      <br />

     </div>
    </div>

    <!-- footer.xsl -->
    <xsl:call-template name="lastFooter" />
    <xsl:call-template name="myAccount" />
    <xsl:call-template name="contactUs" />
   </body>
  </html>
 </xsl:template>
</xsl:stylesheet>