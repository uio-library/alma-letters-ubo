<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:date="http://exslt.org/dates-and-times"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="date ext">
<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />
<xsl:include href="recordTitle.xsl" />

<xsl:template match="/">
  <xsl:call-template name="emailTemplate"/><!-- style.xsl -->
</xsl:template>

<xsl:template match="/notification_data">

  <xsl:call-template name="emailLogo"/><!-- mailReason.xsl -->
  <xsl:call-template name="toWhomIsConcerned"/><!-- mailReason.xsl -->

  <p>
    <!-- Your purchase request with the following information has been -->
    @@introduction@@

    <xsl:choose >
      <xsl:when test="purchase_request/request_status='APPROVED'">
        <!-- approved and an order has been created  -->
        @@approved@@. 
      </xsl:when>
      <xsl:otherwise>
        <!-- rejected with the following reason -->
        @@rejected@@: <xsl:value-of select="purchase_request/reject_reason_desc" />.
      </xsl:otherwise>
    </xsl:choose>
  </p>
  <p>
    @@title@@: <xsl:value-of select="purchase_request/title" />
    <xsl:if test="purchase_request/issn_isbn != ''">
      <br />
      ISBN: <xsl:value-of select="purchase_request/issn_isbn" />
    </xsl:if>
  </p>

  <xsl:call-template name="email-footer"><!-- footer.xsl -->
  </xsl:call-template>

</xsl:template>
</xsl:stylesheet>