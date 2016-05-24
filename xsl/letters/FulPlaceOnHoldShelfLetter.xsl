<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet exclude-result-prefixes="java" version="1.0" xmlns:java="http://xml.apache.org/xslt/java" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
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
    <!-- header.xsl -->
    <!--<xsl:call-template name="senderReceiver" />-->
    <!-- SenderReceiver.xsl -->

    <div class="messageArea">
     <div class="messageBody">

      <xsl:call-template name="toWhomIsConcerned"/>
      <!-- mailReason.xsl -->


      <!-- Materialet du bestilte (dato) kan nå hentes i (ditt bibliotek) -->
      <p>
       @@following_item_requested_on@@
       <xsl:value-of select="notification_data/request/create_date"/>,
       @@can_picked_at@@

       <xsl:choose>
        <xsl:when test="notification_data/request/delivery_address != ''">
         <xsl:value-of select="notification_data/request/delivery_address"/>
        </xsl:when>
        <xsl:otherwise>
         <!-- Physical non-returnable -->
         <xsl:value-of select="notification_data/phys_item_display/owning_library_name"/>
        </xsl:otherwise>
       </xsl:choose>.
      </p>


      <!-- ===========================================================
           START: Hentehylle
           =========================================================== -->
      <xsl:if test="notification_data/request/work_flow_entity/expiration_date">
        <p>
          <b>
            <xsl:call-template name="pickupNumberWithLabel"/><!-- mailReason.xsl -->
          </b>
        </p>
      </xsl:if>
      <!-- ===========================================================
           SLUTT: Hentehylle
           =========================================================== -->



<!--      <p>
  <xsl:when test="notification_data/outgoing/format_display = 'Physical non-returnable'">

      </p>




      <xsl:choose>
       <xsl:when test="notification_data/outgoing/format_display = 'Physical non-returnable'">
        <p>@@following_item_requested_on@@
         <xsl:value-of select="notification_data/request/create_date"/>
         , @@can_picked_at@@
         <xsl:value-of select="notification_data/outgoing/pickup_location_str"/>
         @@circulation_desk@@.</p>
       </xsl:when>
       <xsl:otherwise>
        <p>@@following_item_requested_on@@
         <xsl:value-of select="notification_data/request/create_date"/>, @@can_picked_at@@
         <xsl:value-of select="notification_data/phys_item_display/owning_library_name"/>.
        </p>

       </xsl:otherwise>
      </xsl:choose>
-->
      <div style="padding-left:1em;">
       <xsl:call-template name="recordTitle"/>
       <!-- recordTitle.xsl -->
      </div>

      <xsl:if test="notification_data/request/work_flow_entity/expiration_date != ''">
       <p>
        @@note_item_held_until@@
        <xsl:value-of select="notification_data/request/work_flow_entity/expiration_date"/>.
       </p>
      </xsl:if>
      <xsl:if test="notification_data/request/system_notes != ''">
       <p>
        <b>@@notes_affect_loan@@:</b>
       </p>
       <p>
        <xsl:value-of select="notification_data/request/system_notes"/>
       </p>
      </xsl:if>
     </div>
    </div>

    <xsl:call-template name="lastFooter"/>
    <!-- footer.xsl -->

   </body>
  </html>
 </xsl:template>
</xsl:stylesheet>