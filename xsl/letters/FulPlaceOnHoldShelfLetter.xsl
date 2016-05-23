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

        <!-- Merk: Innlånte bøker ved HumSam-biblioteket-Innlån stilles opp på navn, ikke på hentenummer -->
        <p>
          <b>
            <xsl:choose>

              <xsl:when test="notification_data/request/calculated_destination_name = 'UiO HumSam-biblioteket - HumSam-biblioteket-Innlån' or notification_data/request/calculated_destination_name = 'UiO Informatikkbiblioteket - Utlånet Inf' or contains(notification_data/phys_item_display/available_items/available_item/location_name, 'Fjernlån')">
                <xsl:if test="notification_data/receivers/receiver/preferred_language = 'no'">Hentes i skranken</xsl:if>
                <xsl:if test="notification_data/receivers/receiver/preferred_language = 'nb'">Hentes i skranken</xsl:if>
                <xsl:if test="notification_data/receivers/receiver/preferred_language = 'en'">Pick-up at the counter</xsl:if>:
              </xsl:when>

              <!-- Hentenummer konstruert av hentefrist, siste tre siffer i LTID og to siffer fra selected_inventory_id -->
              <xsl:otherwise>
                <xsl:if test="notification_data/receivers/receiver/preferred_language = 'no'">Hentenummer</xsl:if>
                <xsl:if test="notification_data/receivers/receiver/preferred_language = 'nb'">Hentenummer</xsl:if>
                <xsl:if test="notification_data/receivers/receiver/preferred_language = 'en'">Pick-up number</xsl:if>:
                <xsl:value-of select="substring-before(notification_data/request/work_flow_entity/expiration_date,'/')"/>-<xsl:value-of select="substring(notification_data/user_for_printing/identifiers/code_value/value, string-length(notification_data/user_for_printing/identifiers/code_value/value)-2)"/><xsl:if test="notification_data/request/selected_inventory_id"><xsl:value-of select="substring(notification_data/request/selected_inventory_id, string-length(notification_data/request/selected_inventory_id)-8, 2)"/></xsl:if>
              </xsl:otherwise>

            </xsl:choose>
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