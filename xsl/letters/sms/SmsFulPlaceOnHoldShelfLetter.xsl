<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="smsRecordTitle.xsl" />
<xsl:include href="mailReason.xsl" />

<xsl:template match="/">
<xsl:value-of select="/notification_data/receivers/receiver/user_phone/phone"/> : <xsl:value-of select="/notification_data/organization_unit/name"/>.
@@can_picked_at@@ <xsl:choose>
  <xsl:when test="/notification_data/request/delivery_address != ''">
   <xsl:value-of select="/notification_data/request/delivery_address"/>
  </xsl:when>
  <xsl:otherwise>
   <!-- Physical non-returnable -->
   <xsl:value-of select="/notification_data/phys_item_display/owning_library_name"/>
  </xsl:otherwise>
</xsl:choose>.
<!-- ===========================================================
     START: Hentehylle
     =========================================================== -->
<!--
    Hentenummer
    Added by: DMOH 2016-05-24
-->
<xsl:if test="/notification_data/request/work_flow_entity/expiration_date">
<xsl:call-template name="pickupNumberWithLabel"/><!-- header.xsl -->
</xsl:if><!-- ===========================================================
     SLUTT: Hentehylle
     =========================================================== -->.

 <xsl:value-of select="/notification_data/phys_item_display/title" />. <xsl:if test="/notification_data/receivers/receiver/preferred_language = 'en'">By</xsl:if><xsl:if test="/notification_data/receivers/receiver/preferred_language = 'no'">Av</xsl:if>: <xsl:value-of select="/notification_data/phys_item_display/author"/>.
<xsl:choose>
<xsl:when test="/notification_data/outgoing/format_display = 'Physical non-returnable'">
</xsl:when>
<xsl:otherwise>
@@note_item_held_until@@: <xsl:value-of select="/notification_data/request/work_flow_entity/expiration_date"/>. 
</xsl:otherwise>
</xsl:choose>
</xsl:template>
</xsl:stylesheet>