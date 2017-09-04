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

   <table cellspacing="0" cellpadding="5" border="0">

    <tr>
     <td>
      <b>@@reminder_message@@</b>
      <br/>
      <br/>
     </td>
    </tr>
     <xsl:if test="count(notification_data/deposit_activity_display/new_deposit_displays/deposit_data_display) > 0">
       <tr>
      <td>
       <b>@@new_deposits@@</b>
       <xsl:if test="notification_data/deposit_activity_display/last_run">
       ( @@since@@ <xsl:value-of select="notification_data/deposit_activity_display/last_run"/> )
       </xsl:if>
      </td>
     </tr>
       <tr>
      <td>

      <table cellpadding="5" class="listing">
        <xsl:attribute name="style">
         <xsl:call-template name="mainTableStyleCss" />
        </xsl:attribute>
        <tr>
         <th><b>@@deposit_id@@</b></th>
         <th><b>@@status@@</b></th>
         <th><b>@@title@@</b></th>
         <th><b>@@date_created@@</b></th>
         <th><b>@@date_updated@@</b></th>
        </tr>

        <xsl:for-each select="notification_data/deposit_activity_display/new_deposit_displays/deposit_data_display">
        <tr>
         <td><xsl:value-of select="deposit_id"/></td>
         <td><xsl:value-of select="status"/></td>
         <td><xsl:value-of select="title"/></td>
         <td><xsl:value-of select="date_created"/></td>
         <td><xsl:value-of select="date_updated"/></td>
        </tr>
        </xsl:for-each>
      </table>
      </td>
     </tr>
     <tr><td><br/></td></tr>
     <tr><td><br/></td></tr>
     <tr><td><br/></td></tr>
     <tr><td><br/></td></tr>
    </xsl:if>



     <xsl:if test="notification_data/deposit_activity_display/active_deposit_displays">
       <tr>
      <td>
       <b>@@active_deposits@@</b>
      </td>
     </tr>
       <tr>
      <td>

      <table cellpadding="5" class="listing">
        <xsl:attribute name="style">
         <xsl:call-template name="mainTableStyleCss" />
        </xsl:attribute>
        <tr>
         <th><b>@@deposit_id@@</b></th>
         <th><b>@@status@@</b></th>
         <th><b>@@title@@</b></th>
         <th><b>@@date_created@@</b></th>
         <th><b>@@date_updated@@</b></th>
        </tr>

        <xsl:for-each select="notification_data/deposit_activity_display/active_deposit_displays/deposit_data_display">
        <tr>
         <td><xsl:value-of select="deposit_id"/></td>
         <td><xsl:value-of select="status"/></td>
         <td><xsl:value-of select="title"/></td>
         <td><xsl:value-of select="date_created"/></td>
         <td><xsl:value-of select="date_updated"/></td>
        </tr>
        </xsl:for-each>
      </table>
       </td>
     </tr>

    </xsl:if>

     <tr>
      <td>
      <br/>
      <xsl:variable name="depositUrl"><xsl:value-of select="notification_data/deposit_activity_display/deposit_access_url"/></xsl:variable>
       @@click@@ <b><a href="{$depositUrl}">
       @@here@@</a></b>&#160;@@access_deposits@@
       <br/>
       <br/>
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

        <!-- footer.xsl -->
        <xsl:call-template name="lastFooter" />
        <xsl:call-template name="myAccount" />
  <xsl:call-template name="contactUs" />
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>