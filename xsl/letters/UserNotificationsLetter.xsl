<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet exclude-result-prefixes="java" version="1.0" xmlns:java="http://xml.apache.org/xslt/java" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="header.xsl"/>
<xsl:include href="senderReceiver.xsl"/>
<xsl:include href="mailReason.xsl"/>
<xsl:include href="footer.xsl"/>
<xsl:include href="style.xsl"/>
<xsl:include href="recordTitle.xsl"/>

<xsl:template match="/">
  <xsl:call-template name="email-template"/><!-- header.xsl -->
</xsl:template>

<xsl:template match="/notification_data">

  <xsl:call-template name="emailLogo"/><!-- mailReason.xsl -->
  <xsl:call-template name="toWhomIsConcerned"/><!-- mailReason.xsl -->


  <xsl:choose>

    <!-- Your password has been changed to: -->
    <xsl:when test="notification_type = 'NOTIFY_PASSWORD_CHANGE' ">
      <h3>@@Line_1@@</h3>
      <p>
        <xsl:value-of select="temp_password" />
      </p>
      <p>
        @@Line_2@@
      </p>
    </xsl:when>

    <!-- Forklarende kommentar -->
    <xsl:when test="notification_type = 'EN_HELT_ANNEN_TING' ">
      <p>
        <xsl:call-template name="multilingual"><!-- footer.xsl -->
          <xsl:with-param name="nb" select="'Melding på bokmål'"/>
          <xsl:with-param name="nn" select="'Melding på nynorsk'"/>
          <xsl:with-param name="en" select="'Melding på engelsk'"/>
        </xsl:call-template>
      </p>
      <p>
        <xsl:call-template name="multilingual"><!-- footer.xsl -->
          <xsl:with-param name="nb" select="'Melding på bokmål'"/>
          <xsl:with-param name="nn" select="'Melding på nynorsk'"/>
          <xsl:with-param name="en" select="'Melding på engelsk'"/>
        </xsl:call-template>
      </p>
    </xsl:when>


  </xsl:choose>


  <xsl:call-template name="email-footer"><!-- footer.xsl -->
    <xsl:with-param name="show_my_account" select="true()"/>
  </xsl:call-template>

</xsl:template>
</xsl:stylesheet>