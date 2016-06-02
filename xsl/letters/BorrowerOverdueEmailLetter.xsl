<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />
<xsl:include href="recordTitle.xsl" />


<xsl:template match="/">
  <xsl:call-template name="email-template"/><!-- header.xsl -->
</xsl:template>

<xsl:template match="/notification_data">

  <xsl:call-template name="email-logo"/><!-- header.xsl -->
  <xsl:call-template name="toWhomIsConcerned"/><!-- mailReason.xsl -->

  <p>
    @@overdue_message@@
    @@orignal_due_date@@: <xsl:value-of select="request/due_date"/>.
  </p>
  <p>
    <b>@@return_message@@</b>
  </p>

  <div style="margin: 0.8em 1.2em;">
    @@request_id@@: <xsl:value-of select="request/external_request_id" /><br />
    @@title@@: <xsl:value-of select="request/display/title" /><br />
    @@author@@: <xsl:value-of select="request/display/author" /><br />
    @@request_date@@: <xsl:value-of select="request/create_date" /><br />
    @@needed_by_date@@: <xsl:value-of select="request/needed_by" /><br />
    @@supplied_date@@: <xsl:value-of select="request/item_sent_date" />
  </div>
      
  <p>
    @@signature@@<br />
    <xsl:value-of select="library/name" /><br />
    <xsl:if test="library/address/line1 !=''">
      <xsl:value-of select="library/address/line1" /><br />
    </xsl:if>
    <xsl:if test="library/address/line2 !=''">
      <xsl:value-of select="library/address/line2" /><br />
    </xsl:if>
    <xsl:if test="library/address/line3 !=''">
      <xsl:value-of select="library/address/line3" /><br />
    </xsl:if>
    <xsl:if test="library/address/line4 !=''">
      <xsl:value-of select="library/address/line4" /><br />
    </xsl:if>
    <xsl:if test="library/address/line5 !=''">
      <xsl:value-of select="library/address/line5" /><br />
    </xsl:if>
    <xsl:if test="library/address/city !=''">
      <xsl:value-of select="library/address/city" /><br />
    </xsl:if>
    <xsl:if test="library/address/country !=''">
      <xsl:value-of select="library/address/country" /><br />
    </xsl:if>
  </p>

</xsl:template>
</xsl:stylesheet>