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

  <!--
    Reminder to self:

    Brukes for å gi svar på patron purchase requests (PPR).
    Brevet har to problemer:

    1) Det mangler vesentlig informasjon under "receivers",
       deriblant "/notification_data/receivers/receiver/preferred_language",
       så vi kan ikke lage det på brukers foretrukne språk. Vi fjerner
       derfor mest mulig av header og footer.

    2) Hele hovedinnholdet i brevet kommer ferdigformatert i ett felt kalt
       "message_body". Vi har derfor ikke mulighet til å formatere dette
       som vi vil.
  -->


  <p>
    <!-- Vi bruker søk-og-erstatt for å fjerne 'Query to requester:'
         og erstatte 'Regarding your purchase request' med en tospråklig tekst.
    -->
    <xsl:call-template name="string-replace"><!-- Defined in header.xsl -->
      <xsl:with-param name="string">
        <xsl:call-template name="string-replace"><!-- Defined in header.xsl -->
          <xsl:with-param name="string" select="message_body"/>
          <xsl:with-param name="replace" select="'&lt;br&gt;Query to requester:'"/>
          <xsl:with-param name="with" select="''"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="replace" select="'Regarding your purchase request'"/>
      <xsl:with-param name="with" select="'Angående innkjøpsforslaget ditt / Regarding your purchase request:'"/>
    </xsl:call-template>
  </p>

</xsl:template>
</xsl:stylesheet>