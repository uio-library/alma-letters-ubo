<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="smsRecordTitle.xsl" />
 <xsl:template match="/">

<xsl:value-of select="notification_data/receivers/receiver/user_phone/phone"/> : <xsl:value-of select="notification_data/organization_unit/name"/>.: <xsl:if test = "notification_data/receivers/receiver/user/user_name"> <xsl:value-of select="notification_data/receivers/receiver/user/user_name"/></xsl:if>
@@can_picked_at@@  <xsl:choose>
  <xsl:when test="/notification_data/outgoing/format = 'PHYSICAL_NON_RETURNABLE'">

    <xsl:value-of select="/notification_data/phys_item_display/owning_library_name"/>:
  </xsl:when>
<xsl:otherwise>
<xsl:value-of select="notification_data/request/delivery_address"/>:
</xsl:otherwise>
</xsl:choose><xsl:value-of select="notification_data/phys_item_display/title" />
<xsl:choose>
<xsl:when test= "/notification_data/request/work_flow_entity/expiration_date !=''">
@@note_item_held_until@@: <xsl:value-of select="/notification_data/request/work_flow_entity/expiration_date"/>.</xsl:when>
<!-- <xsl:otherwise>
@@note_item_held_until@@: 7 Dager / Days.
</xsl:otherwise>
-->
</xsl:choose>
 </xsl:template>
</xsl:stylesheet>