<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="hi">
@@dear@@
</xsl:template>

<!--
    Hentenummer
    Added by: DMOH 2016-05-24
-->
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

</xsl:stylesheet>