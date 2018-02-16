<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="smsRecordTitle.xsl" />
 <xsl:template match="/">

<xsl:value-of select="notification_data/receivers/sms_receiver/phone_list_str"/> : <xsl:value-of select="notification_data/organization_unit/name"/>.
<xsl:call-template name="multilingual"><!-- header.xsl -->
  <xsl:with-param name="nb" select="'Hei, har du glemt oss?

Du har materiale som skulle vært levert.

Se mail eller uio.oria.no for mer info.

Hilsen biblioteket'"/>
  <xsl:with-param name="nn" select="'Hei, har du gløymt oss?

Du har materiale som skulle vært levert.

Se mail eller uio.oria.no for mer info.

Hilsen biblioteket'"/>
  <xsl:with-param name="en" select="'Hi, have you forgotten us?

You have borrowed materials that should have been returned.

Check your mail or uio.oria.no for more info.

Regards Library'"/>
</xsl:call-template>
 </xsl:template>
</xsl:stylesheet>