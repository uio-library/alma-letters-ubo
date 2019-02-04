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

       <xsl:if test="notification_data/barcode !=''">
        <tr>
          <td>
           <br/>
           <b>@@item_barcode@@: </b> <img src="Barcode.png" alt="Barcode" />
          </td>
        </tr>
       </xsl:if>

       <tr>
         <td>
          <br/>
          <b>@@request_id@@: </b> <img src="externalId.png" alt="externalId" />
         </td>
          </tr>

       <tr>
        <td>
         <br/>
         <b> @@title@@: </b>
         <xsl:value-of select="notification_data/request/display/normalized_title"/>
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
         <br/>
         <b> @@patron_name@@: </b>
         <xsl:value-of select="notification_data/patron_name"/>
        </td>
       </tr>

       <tr>
        <td>
         <br/>
         <b> @@request_date@@: </b>
         <xsl:value-of select="notification_data/request/create_date_str"/>
        </td>
       </tr>
       <tr>
        <td>
         <b> @@arrival_date@@: </b>
         <xsl:value-of select="notification_data/request/item_arrival_date"/>
        </td>
       </tr>
       <tr>
        <td>
         <br/>
         <b> @@pickup_location@@: </b>
         <xsl:value-of select="notification_data/request/pickup_location_str"/>
        </td>
       </tr>
       <tr>
        <td>
         <b> @@circulation_note@@: </b>
         <xsl:value-of select="notification_data/circulation_note"/>
        </td>
       </tr>
       <tr>
        <td>
         <b> @@shipping_cost@@: </b>
         <xsl:value-of select="notification_data/request/shipping_cost/normalized_sum"/>&#160;<xsl:value-of select="notification_data/request/shipping_cost/currency"/>
        </td>
       </tr>
       <xsl:if test="notification_data/citation_id !=''">

       <tr>
        <td>
         <br/>
         <b> @@reading_list@@: </b>
         <xsl:value-of select="notification_data/reading_list_name" /> (<xsl:value-of select="notification_data/reading_list_code" />)
        </td>
       </tr>
       <tr>
        <td>
         <b> @@citation_id@@: </b>
         <xsl:value-of select="notification_data/citation_id" />
        </td>
       </tr>
       </xsl:if>

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