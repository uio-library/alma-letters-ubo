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
        <xsl:when test="notification_data/outgoing/pickup_location_str != ''">
         <xsl:value-of select="notification_data/outgoing/pickup_location_str"/>
        </xsl:when>
        <xsl:when test="notification_data/request/assigned_unit_name != ''">
         <xsl:value-of select="notification_data/request/assigned_unit_name"/>
        </xsl:when>
        <xsl:otherwise>
         <em>(Unknown pickup location. This bug is tracked)</em>
        </xsl:otherwise>
       </xsl:choose>.
      </p>


      <!-- Hentenummer -->
      <xsl:if test="notification_data/request/work_flow_entity/expiration_date">
       <p>

        <!-- Fredriks tillegg: Hentenr, konstruert av hentefrist og siste tre siffer i LTID -->
        <xsl:if test="notification_data/request/calculated_destination_name != 'UiO HumSam-biblioteket - HumSam-biblioteket-Innlån'">
         <p>
          <b>
           <xsl:if test="notification_data/receivers/receiver/preferred_language = 'no'">Hentenummer</xsl:if>
           <xsl:if test="notification_data/receivers/receiver/preferred_language = 'en'">Pick-up number</xsl:if>:

           <xsl:value-of select="substring-before(notification_data/request/work_flow_entity/expiration_date,'/')"/>-<xsl:value-of select="substring(notification_data/user_for_printing/identifiers/code_value/value, string-length(notification_data/user_for_printing/identifiers/code_value/value)-2)"/></b>
         </p>
        </xsl:if>
        <!-- Fredriks tillegg slutt -->

       </p>
      </xsl:if>

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

       <xsl:if test="notification_data/outgoing/note != ''">
        <div>
         Note: <em><xsl:value-of select="notification_data/outgoing/note"/></em>
        </div>
       </xsl:if>
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