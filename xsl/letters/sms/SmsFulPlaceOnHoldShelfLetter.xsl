<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="smsRecordTitle.xsl" />

<!-- START: Klipp-og-lim fra header.xsl fordi jeg ikke får inkludert den -->
<xsl:template name="pickupNumber">
  <xsl:value-of select="substring-before(/notification_data/request/work_flow_entity/expiration_date,'/')"/>-<xsl:value-of select="substring(/notification_data/user_for_printing/identifiers/code_value/value, string-length(/notification_data/user_for_printing/identifiers/code_value/value)-2)"/><xsl:if test="/notification_data/request/selected_inventory_id"><xsl:value-of select="substring(/notification_data/request/selected_inventory_id, string-length(/notification_data/request/selected_inventory_id)-8, 2)"/></xsl:if>
</xsl:template>

<xsl:template name="pickupNumberWithLabel">
  <xsl:choose>

    <!-- Merk: Artikkelkopier (uten expiration_date) og innlånte bøker stilles opp på navn, ikke på hentenummer -->
    <xsl:when test="/notification_data/request/work_flow_entity/expiration_date = '' or /notification_data/request/calculated_destination_name = 'UiO HumSam-biblioteket - HumSam-biblioteket-Innlån' or /notification_data/request/calculated_destination_name = 'UiO Informatikkbiblioteket - Utlånet Inf' or contains(/notification_data/phys_item_display/available_items/available_item/location_name, 'Fjernlån')">
      <xsl:if test="/notification_data/receivers/receiver/preferred_language = 'no'">Hentes i skranken</xsl:if>
      <xsl:if test="/notification_data/receivers/receiver/preferred_language = 'nb'">Hentes i skranken</xsl:if>
      <xsl:if test="/notification_data/receivers/receiver/preferred_language = 'en'">Pick-up at the counter</xsl:if>
    </xsl:when>

    <!-- Hentenummer konstruert av hentefrist, siste tre siffer i LTID og to siffer fra selected_inventory_id -->
    <xsl:otherwise>
      <xsl:if test="/notification_data/receivers/receiver/preferred_language = 'no'">Hentenummer</xsl:if>
      <xsl:if test="/notification_data/receivers/receiver/preferred_language = 'nb'">Hentenummer</xsl:if>
      <xsl:if test="/notification_data/receivers/receiver/preferred_language = 'en'">Pick-up number</xsl:if>
      <xsl:text>: </xsl:text>
      <xsl:call-template name="pickupNumber"/>
    </xsl:otherwise>

  </xsl:choose>
</xsl:template>
<!-- SLUTT: Klipp-og-lim fra header.xsl fordi jeg ikke får inkludert den -->

<xsl:template match="/">
<xsl:value-of select="notification_data/receivers/receiver/user_phone/phone"/> : <xsl:value-of select="notification_data/organization_unit/name"/>.
@@can_picked_at@@ <xsl:choose>
  <xsl:when test="notification_data/request/delivery_address != ''">
   <xsl:value-of select="notification_data/request/delivery_address"/>
  </xsl:when>
  <xsl:otherwise>
   <!-- Physical non-returnable -->
   <xsl:value-of select="notification_data/phys_item_display/owning_library_name"/>
  </xsl:otherwise>
</xsl:choose>.
<!-- ===========================================================
     START: Hentehylle
     =========================================================== -->
<!--
    Hentenummer
    Added by: DMOH 2016-05-24
-->
<xsl:if test="notification_data/request/work_flow_entity/expiration_date">
<xsl:call-template name="pickupNumberWithLabel"/><!-- header.xsl -->
</xsl:if><!-- ===========================================================
     SLUTT: Hentehylle
     =========================================================== -->.

 <xsl:value-of select="notification_data/phys_item_display/title" />. <xsl:if test="notification_data/receivers/receiver/preferred_language = 'en'">By</xsl:if><xsl:if test="notification_data/receivers/receiver/preferred_language = 'no'">Av</xsl:if>: <xsl:value-of select="notification_data/phys_item_display/author"/>.
<xsl:choose>
<xsl:when test="notification_data/outgoing/format_display = 'Physical non-returnable'">
</xsl:when>
<xsl:otherwise>
@@note_item_held_until@@: <xsl:value-of select="notification_data/request/work_flow_entity/expiration_date"/>. 
</xsl:otherwise>
</xsl:choose>
</xsl:template>
</xsl:stylesheet>