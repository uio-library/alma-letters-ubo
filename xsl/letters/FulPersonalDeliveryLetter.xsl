<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="recordTitle.xsl" />

<xsl:template match="/">
  <xsl:call-template name="emailTemplate"/><!-- style.xsl -->
</xsl:template>

<!-- Using the string-replace method defined in header.xsl to remove the 'Home Address:' prefix from the address -->
<xsl:variable name="delivery_address">
  <xsl:call-template name="string-replace">
    <xsl:with-param name="string" select="/notification_data/delivery_address" />
    <xsl:with-param name="replace" select="'Home Address:'" />
    <xsl:with-param name="with" select="''" />
  </xsl:call-template>
</xsl:variable>

<xsl:template match="/notification_data">

  <xsl:call-template name="emailLogo"/><!-- mailReason.xsl -->
  <xsl:call-template name="toWhomIsConcerned"/><!-- mailReason.xsl -->

  <p>
    @@we_sent@@ <xsl:call-template name="stdDate"><!-- Defined in header.xsl -->
      <xsl:with-param name="value" select="/notification_data/request/create_date"/>
    </xsl:call-template>:
  </p>
  <p>
    <xsl:call-template name="recordTitle" />
    (holdings ID: <xsl:value-of select="/notification_data/request/selected_inventory_id" />)
  </p>

  <p>
    @@due_date@@: <xsl:call-template name="stdDate"><!-- Defined in header.xsl -->
      <xsl:with-param name="value" select="/notification_data/due_date"/>
    </xsl:call-template>
  </p>
  <p>
    @@delivered_to@@:
    <xsl:value-of select="/notification_data/receivers/receiver/user/first_name" />. <xsl:value-of select="$delivery_address" />
  </p>
  <p>
    Fra:
    <xsl:value-of select="/notification_data/phys_item_display/owning_library_name" />
  </p>

  <xsl:call-template name="email-footer"/><!-- footer.xsl -->

 </xsl:template>
</xsl:stylesheet>