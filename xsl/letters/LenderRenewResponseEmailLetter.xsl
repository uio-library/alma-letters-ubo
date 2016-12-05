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

       <table cellspacing="0" cellpadding="5" border="0">
     <tr>
      <td>

       <h3>@@header@@</h3>

      </td>
     </tr>
    </table>

    <div class="messageArea">
     <div class="messageBody">
      <table cellspacing="0" cellpadding="5" border="0">

       <tr>
        <td>
         <b>@@request@@</b>
        </td>
       </tr>

      </table>

                        <br/>
      <table cellspacing="0" cellpadding="5" border="0">
       <xsl:attribute name="style">
        <xsl:call-template name="listStyleCss"/>
        <!-- style.xsl -->
       </xsl:attribute>
       <tr>
        <td>
         <b> @@requestId@@: </b>
         <xsl:value-of select="notification_data/request/external_request_id"/>
        </td>
       </tr>
       <tr>
        <td>
         <b> @@title@@: </b>
         <xsl:value-of select="notification_data/request/display/title"/>
        </td>
       </tr>
       <tr>
        <td>
         <b> @@author@@: </b>
         <xsl:value-of select="notification_data/request/display/author"/>
        </td>
       </tr>
       <tr>
        <td>
         <b> @@requestDate@@: </b>
         <xsl:value-of select="notification_data/request/create_date_str"/>
        </td>
       </tr>
       <tr>
        <td>
         <b> @@supplyDate@@: </b>
         <xsl:value-of select="notification_data/request/item_sent_date"/>
        </td>
       </tr>

       <tr>
        <td>
         <br/>
         <b> @@renewAnswer@@: </b>
         <xsl:value-of select="notification_data/renew_answer"/>
        </td>
       </tr>
       <tr>
        <td>
         <b> @@dueDate@@: </b>
         <xsl:value-of select="notification_data/due_date"/>
        </td>
       </tr>
       <tr>
        <td>
         <b> @@note@@: </b>
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
         <xsl:value-of select="notification_data/library/name" />
        </td>
       </tr>
       <xsl:if test="notification_data/library/address/line1 !=''">
        <tr>
         <td>
          <xsl:value-of select="notification_data/library/address/line1" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/library/address/line2 !=''">
        <tr>
         <td>
          <xsl:value-of select="notification_data/library/address/line2" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/library/address/line3 !=''">
        <tr>
         <td>
          <xsl:value-of select="notification_data/library/address/line3" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/library/address/line4 !=''">
        <tr>
         <td>
          <xsl:value-of select="notification_data/library/address/line4" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/library/address/line5 !=''">
        <tr>
         <td>
          <xsl:value-of select="notification_data/library/address/line5" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/library/address/city !=''">
        <tr>
         <td>
          <xsl:value-of select="notification_data/library/address/city" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/library/address/country !=''">
        <tr>
         <td>
          <xsl:value-of select="notification_data/library/address/country" />
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