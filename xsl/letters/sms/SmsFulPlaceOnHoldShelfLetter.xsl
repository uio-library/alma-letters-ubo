<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="smsRecordTitle.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:template match="/">

<!-- Header -->

<xsl:value-of select="/notification_data/receivers/receiver/user_phone/phone"/>
<xsl:text> : </xsl:text>
<xsl:value-of select="/notification_data/organization_unit/name"/><xsl:text>.&#10;</xsl:text>

<!-- Klar til henting ved ... -->

<xsl:text>@@can_picked_at@@ </xsl:text>
<xsl:choose>
  <xsl:when test="/notification_data/request/delivery_address != ''">
    <xsl:value-of select="/notification_data/request/delivery_address"/>
  </xsl:when>
  <xsl:otherwise>
    <!-- Physical non-returnable -->
    <xsl:value-of select="/notification_data/phys_item_display/owning_library_name"/>
  </xsl:otherwise>
</xsl:choose>
<xsl:text>, </xsl:text>

<!-- Hentenummer eller "Hentes i skranken" -->

<xsl:if test="/notification_data/request/work_flow_entity/expiration_date">
  <xsl:call-template name="pickupNumberWithLabel">
    <xsl:with-param name="lcfirst" select="true()" />
  </xsl:call-template><!-- Defined in mailReason.xsl -->
</xsl:if>

<xsl:text>:&#10;&#10; </xsl:text><!-- Line breaks and indent -->

<!-- Bibliographic description -->

<xsl:text>"</xsl:text>
<xsl:value-of select="/notification_data/phys_item_display/title" />
<xsl:text>". </xsl:text>
<xsl:value-of select="/notification_data/phys_item_display/author"/>
<xsl:text>.</xsl:text>

<!-- Hentefrist -->

<xsl:if test="/notification_data/request/work_flow_entity/expiration_date != ''">
  <xsl:text>&#10;&#10;@@note_item_held_until@@: </xsl:text>
  <xsl:call-template name="stdDate"><!-- Defined in mailReason.xsl -->
    <xsl:with-param name="value" select="/notification_data/request/work_flow_entity/expiration_date"/>
  </xsl:call-template>
  <xsl:text>.</xsl:text>
</xsl:if>

</xsl:template>
</xsl:stylesheet>