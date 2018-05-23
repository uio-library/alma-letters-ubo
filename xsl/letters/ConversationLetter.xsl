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

<xsl:template match="/">
  <xsl:call-template name="emailTemplate"/><!-- style.xsl -->
</xsl:template>

<xsl:template match="/notification_data">

  <xsl:call-template name="emailLogo"/><!-- mailReason.xsl -->
  <!--<xsl:call-template name="toWhomIsConcerned"/>--><!-- mailReason.xsl -->

  <xsl:for-each select="conversation_messages/message">

    <p>
      <xsl:value-of select="message_subject"/>
    </p>

    <p style="font-size:85%; border-top:1px solid #ccc; border-bottom:1px solid #ccc">
      <xsl:value-of select="message_body" disable-output-escaping="yes"/>
    </p>

    <p class="sincerely">
      @@sincerely@@,<br />
      <xsl:value-of select="author/first_name" />&#160;<xsl:value-of select="author/last_name" /><br />
      <xsl:choose>
        <xsl:when test="author/library_code = '1030300'">
          Humsam-biblioteket
        </xsl:when>
        <xsl:when test="author/library_code = '1030310'">
          Realfagsbiblioteket
        </xsl:when>
        <xsl:when test="author/library_code = '1030010'">
          Arkeologisk bibliotek
        </xsl:when>
        <xsl:when test="author/library_code = '1030011'">
          Etnografisk bibliotek
        </xsl:when>
        <xsl:when test="author/library_code = '1030317'">
          Informatikkbiblioteket
        </xsl:when>
        <xsl:when test="author/library_code = '1030000'">
          Juridisk bibliotek DB
        </xsl:when>
        <xsl:when test="author/library_code = '1030002'">
          Kriminologibiblioteket
        </xsl:when>
        <xsl:when test="author/library_code = '1030307'">
          Medisinsk bibliotek Odontologi
        </xsl:when>
        <xsl:when test="author/library_code = '1032300'">
          Medisinsk bibliotek Rikshospitalet
        </xsl:when>
        <xsl:when test="author/library_code = '1030338'">
          Medisinsk bibliotek Ullevål sykehus
        </xsl:when>
        <xsl:when test="author/library_code = '1030500'">
          Naturhistorisk museum biblioteket
        </xsl:when>
        <xsl:when test="author/library_code = '1030003'">
          Offentligrettsbiblioteket
        </xsl:when>
        <xsl:when test="author/library_code = '1030005'">
          Petroleums- og EU-rettsbiblioteket
        </xsl:when>
        <xsl:when test="author/library_code = '1030001'">
          Privatrettsbiblioteket
        </xsl:when>
        <xsl:when test="author/library_code = '1030015'">
          Rettshistorisk samling
        </xsl:when>
        <xsl:when test="author/library_code = '1030004'">
          Rettsinformatikkbiblioteket
        </xsl:when>
        <xsl:when test="author/library_code = '1030006'">
          Sjørettsbiblioteket
        </xsl:when>
        <xsl:when test="author/library_code = '10300303'">
          Sophus Bugge
        </xsl:when>
        <xsl:when test="author/library_code = '1030301'">
          Teologisk bibliotek
        </xsl:when>
      </xsl:choose><br />
      <xsl:value-of select="/notification_data/organization_unit/name" />
    </p>
  </xsl:for-each>

</xsl:template>

</xsl:stylesheet>