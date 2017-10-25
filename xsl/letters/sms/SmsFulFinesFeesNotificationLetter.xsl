<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <xsl:template match="/">
  <xsl:value-of select="notification_data/receivers/sms_receiver/phone_list_str"/> : <xsl:value-of select="notification_data/organization_unit/name"/>
  @@hi@@ <xsl:value-of select="notification_data/user_for_printing/name"/>,
  @@we_would_like@@ <xsl:value-of select="notification_data/organization_unit/name"/> @@debt_of@@ <xsl:value-of select="notification_data/total_fines_amount"/>
  <xsl:value-of select="notification_data/total_fines_currency"/>.
  @@login@@.
 </xsl:template>
</xsl:stylesheet>