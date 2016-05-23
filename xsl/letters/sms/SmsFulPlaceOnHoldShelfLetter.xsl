<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="smsRecordTitle.xsl" />
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
<!-- Bøker for HumSam-biblioteket-Innlån stilles opp på navn, ikke på hentenummer -->
<xsl:if test="notification_data/request/calculated_destination_name != 'UiO HumSam-biblioteket - HumSam-biblioteket-Innlån' or notification_data/request/calculated_destination_name = 'UiO Informatikkbiblioteket - Utlånet Inf' or contains(notification_data/phys_item_display/available_items/available_item/location_name, 'Fjernlån')"><xsl:if test="notification_data/receivers/receiver/preferred_language = 'no'">Hentenummer</xsl:if><xsl:if test="notification_data/receivers/receiver/preferred_language = 'nb'">Hentenummer</xsl:if><xsl:if test="notification_data/receivers/receiver/preferred_language = 'en'">Pick-up number</xsl:if>: <xsl:value-of select="substring-before(notification_data/request/work_flow_entity/expiration_date,'/')"/>-<xsl:value-of select="substring(notification_data/user_for_printing/identifiers/code_value/value, string-length(notification_data/user_for_printing/identifiers/code_value/value)-2)"/><xsl:value-of select="substring(notification_data/request/selected_inventory_id, string-length(notification_data/request/selected_inventory_id)-8, 2)"/></xsl:if>.

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