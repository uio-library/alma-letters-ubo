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
  <xsl:call-template name="email-template"/><!-- header.xsl -->
</xsl:template>

<xsl:template match="/notification_data">

  <xsl:call-template name="emailLogo"/><!-- mailReason.xsl -->
  <xsl:call-template name="toWhomIsConcerned"/><!-- mailReason.xsl -->

  <p>
    @@we_sent@@ <xsl:call-template name="stdDate"><!-- Defined in header.xsl -->
      <xsl:with-param name="value" select="/notification_data/request/create_date"/>
    </xsl:call-template>:
  </p>
  <p>
    <xsl:value-of select="/notification_data/optional_barcodes/string" />: <xsl:call-template name="recordTitle" />
  </p>
  <p>
    @@due_date@@: <xsl:call-template name="stdDate"><!-- Defined in header.xsl -->
      <xsl:with-param name="value" select="/notification_data/due_date"/>
    </xsl:call-template>
  </p>
  <p>
    @@delivered_to@@:
    <xsl:value-of select="/notification_data/user_for_printing/name" />. <xsl:value-of select="/notification_data/delivery_address" />
  </p>
  <p>
    Sent from:
    <xsl:value-of select="/phys_item_display/owning_library_name" />
  </p>

  <xsl:call-template name="email-footer"/><!-- footer.xsl -->

 </xsl:template>
</xsl:stylesheet>