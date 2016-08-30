<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
 <xsl:include href="header.xsl"/>
 <xsl:include href="senderReceiver.xsl"/>
 <xsl:include href="mailReason.xsl"/>
 <xsl:include href="footer.xsl"/>
 <xsl:include href="style.xsl"/>
 <xsl:include href="recordTitle.xsl"/>
 <xsl:template match="/">
  <html>
   <head>
    <xsl:call-template name="generalStyle"/>
   </head>
   <body>
    <xsl:attribute name="style">
     <xsl:call-template name="bodyStyleCss"/>
     <!-- style.xsl -->
    </xsl:attribute>
    <xsl:call-template name="head"/>

    <div class="messageArea">
     <div class="messageBody">
      <table cellspacing="0" cellpadding="5" border="0">
       <xsl:attribute name="style">
        <xsl:call-template name="listStyleCss"/>
        <!-- style.xsl -->
       </xsl:attribute>
       <tr>
        <td>
         <b>@@returned@@</b>
        </td>
       </tr>
       <tr>
        <td>
        <br/>
         <b> @@returned_to@@: </b>
         <xsl:value-of select="notification_data/partner_name"/>
        </td>
       </tr>
       <tr>
        <td>
         <b> @@address@@: </b>
        </td>
       </tr>
       <xsl:if test="notification_data/partner_address/line1 !=''">
        <tr>
         <td>
          <xsl:value-of select="notification_data/partner_address/line1"/>
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/partner_address/line2 !=''">
        <tr>
         <td>
          <xsl:value-of select="notification_data/partner_address/line2"/>
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/partner_address/line3 !=''">
        <tr>
         <td>
          <xsl:value-of select="notification_data/partner_address/line3"/>
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/partner_address/line4 !=''">
        <tr>
         <td>
          <xsl:value-of select="notification_data/partner_address/line4"/>
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/partner_address/line5 !=''">
        <tr>
         <td>
          <xsl:value-of select="notification_data/partner_address/line5"/>
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/partner_address/city !=''">
        <tr>
         <td>
          <xsl:value-of select="notification_data/partner_address/city"/>
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/partner_address/country !=''">
        <tr>
         <td>
          <xsl:value-of select="notification_data/partner_address/country"/>
         </td>
        </tr>
       </xsl:if>
       <tr>
        <td>
         <b> @@email@@: </b>
         <xsl:value-of select="notification_data/partner_email/email"/>
        </td>
       </tr>
       <tr>
        <td>
         <b> @@phone@@: </b>
         <xsl:value-of select="notification_data/partner_phone/phone"/>
        </td>
       </tr>
       <tr>
        <td><b> @@request_id@@: </b><img src="externalId.png" alt="externalId"/></td>
       </tr>
       <tr><td><br/></td></tr>
       <xsl:if test="notification_data/request/display/title !=''">
        <tr>
         <td>
          <b> @@title@@: </b>
          <xsl:value-of select="notification_data/request/display/title"/>
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/request/display/journal_title !=''">
        <tr>
         <td>
          <b> @@journal_title@@: </b>
          <xsl:value-of select="notification_data/request/display/journal_title"/>
         </td>
        </tr>
       </xsl:if>
       <tr>
        <td>
         <b> @@author@@: </b>
         <xsl:value-of select="notification_data/request/display/author"/>
        </td>
       </tr>
       <tr>
        <td>
         <b> @@volume@@: </b>
         <xsl:value-of select="notification_data/request/display/volume"/>
        </td>
       </tr>
       <tr>
        <td>
         <b> @@issue@@: </b>
         <xsl:value-of select="notification_data/request/display/issue"/>
        </td>
       </tr>
       <tr>
        <td>
         <br/>
         <b> @@arrival_date@@: </b>
         <xsl:value-of select="notification_data/request/item_arrival_date"/>
        </td>
       </tr>
       <tr>
        <td>
         <b> @@required_return_date@@: </b>
         <xsl:value-of select="notification_data/request/due_date"/>
        </td>
       </tr>
       <tr>
        <td>
         <br/>
         <b> @@note_to_partner@@: </b>
         <xsl:value-of select="notification_data/note_to_partner"/>
        </td>
       </tr>
      </table>

      <br/><br/>

      <table>
       <tr>
        <td>@@signature@@</td>
       </tr>
       <tr>
        <td>
         <xsl:value-of select="notification_data/library/name"/>
        </td>
       </tr>
       <xsl:if test="notification_data/library/address/line1 !=''">
        <tr>
         <td>
          <xsl:value-of select="notification_data/library/address/line1"/>
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/library/address/line2 !=''">
        <tr>
         <td>
          <xsl:value-of select="notification_data/library/address/line2"/>
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/library/address/line3 !=''">
        <tr>
         <td>
          <xsl:value-of select="notification_data/library/address/line3"/>
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/library/address/line4 !=''">
        <tr>
         <td>
          <xsl:value-of select="notification_data/library/address/line4"/>
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/library/address/line5 !=''">
        <tr>
         <td>
          <xsl:value-of select="notification_data/library/address/line5"/>
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/library/address/city !=''">
        <tr>
         <td>
          <xsl:value-of select="notification_data/library/address/city"/>
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/library/address/country !=''">
        <tr>
         <td>
          <xsl:value-of select="notification_data/library/address/country"/>
         </td>
        </tr>

       </xsl:if>
      </table>
     </div>
    </div>
    <xsl:call-template name="lastFooter"/>
    <!-- footer.xsl -->
   </body>
  </html>
 </xsl:template>
</xsl:stylesheet>