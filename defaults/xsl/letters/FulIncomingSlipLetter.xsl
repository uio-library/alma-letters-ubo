<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:variable name="counter" select="0"/>


<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />
<xsl:include href="recordTitle.xsl" />

<xsl:template name="id-info">
   <xsl:param name="line"/>
   <xsl:variable name="first" select="substring-before($line,'//')"/>
   <xsl:variable name="rest" select="substring-after($line,'//')"/>
    <xsl:if test="$first = '' and $rest = '' ">
          <!--br/-->
      </xsl:if>
   <xsl:if test="$rest != ''">
       <xsl:value-of select="$rest"/><br/>
   </xsl:if>
   <xsl:if test="$rest = ''">
       <xsl:value-of select="$line"/><br/>
   </xsl:if>

</xsl:template>

  <xsl:template name="id-info-hdr">
        <xsl:call-template name="id-info">
            <xsl:with-param name="line" select="notification_data/incoming_request/external_request_id"/>
            <xsl:with-param name="label" select="'Bibliographic Information:'"/>
         </xsl:call-template>
</xsl:template>

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



   <div class="messageArea">
    <div class="messageBody">
      <table cellspacing="0" cellpadding="5" border="0">


      <tr>
       <td>
        <b>@@supplied_to@@: </b>
        <xsl:value-of select="notification_data/partner_name"/>
       </td>
      </tr>


      <tr>
                   <td>
                     <b>@@borrower_reference@@: </b>
                      <xsl:call-template name="id-info-hdr"/>
                   </td>
                 </tr>



             <tr>
         <td><b>@@my_id@@: </b><img src="externalId.png" alt="externalId" /></td>
          </tr>

      <tr>
       <td>
        <b>@@format@@: </b>
        <xsl:value-of select="notification_data/incoming_request/format"/>
       </td>
      </tr>

      <xsl:if  test="notification_data/incoming_request/needed_by_dummy/full_date" >
       <tr>
        <td>
         <b>@@date_needed_by@@: </b>
         <xsl:value-of select="notification_data/incoming_request/needed_by"/>
        </td>
       </tr>
      </xsl:if>

      <xsl:if  test="notification_data/incoming_request/note" >
       <tr>
        <td>
         <b>@@request_note@@: </b>
         <xsl:value-of select="notification_data/incoming_request/note"/>
        </td>
       </tr>
      </xsl:if>

      <xsl:if  test="notification_data/incoming_request/requester_email" >
       <tr>
        <td>
         <b>@@requester_email@@: </b>
         <xsl:value-of select="notification_data/incoming_request/requester_email"/>
        </td>
       </tr>
      </xsl:if>

      <xsl:if  test="notification_data/assignee != ''" >
       <tr>
        <td>
         <b>@@assignee@@: </b>
         <xsl:value-of select="notification_data/assignee"/>
        </td>
       </tr>
      </xsl:if>

        <xsl:if test="notification_data/level_of_service !=''">
         <tr>
          <td>
           <b>@@level_of_service@@: </b>
           <xsl:value-of select="notification_data/level_of_service"/>
          </td>

         </tr>
        </xsl:if>

      <xsl:for-each select="notification_data/items/physical_item_display_for_printing">
       <br></br>

       <tr>
         <td><b>@@item_barcode@@: </b><img src="cid:{concat(concat('Barcode',position()),'.png')}" alt="{concat('Barcode',position())}" /></td>
       </tr>

       <tr>
        <td><xsl:value-of select="title"/></td>
       </tr>

       <tr>
        <td>
         <b>@@library@@: </b>
         <xsl:value-of select="library_name"/>
        </td>
       </tr>

       <tr>
        <td><b>@@location@@: </b><xsl:value-of select="location_name"/></td>
       </tr>

       <xsl:if  test="call_number" >
        <tr>
         <td><b>@@call_number@@: </b><xsl:value-of select="call_number"/></td>
        </tr>
       </xsl:if>

       <xsl:if  test="shelving_location/string" >
        <tr>
         <td><b>@@shelving_location_for_item@@: </b>
          <xsl:for-each select="shelving_location/string">
          <xsl:value-of select="."/>
          &#160;
          </xsl:for-each>
         </td>
        </tr>
       </xsl:if>
      </xsl:for-each>
     </table>
    </div>
   </div>




 <xsl:call-template name="lastFooter" /> <!-- footer.xsl -->





</body>
</html>


 </xsl:template>
</xsl:stylesheet>