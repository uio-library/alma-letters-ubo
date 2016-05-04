<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="smsRecordTitle.xsl" />
 <xsl:template match="/">

<xsl:value-of select="notification_data/receivers/receiver/user_phone/phone"/> : <xsl:value-of select="notification_data/organization_unit/name"/>.
@@hi@@ <xsl:value-of select="notification_data/user_for_printing/name"/>,
@@yourRequest@@ "<xsl:value-of select="notification_data/phys_item_display/title" />" @@beenCancelled@@.
@@pleaseContact@@.

 </xsl:template>
</xsl:stylesheet>