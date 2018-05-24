<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:date="http://exslt.org/dates-and-times"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="date">
<xsl:include href="header.xsl"/>
<xsl:include href="senderReceiver.xsl"/>
<xsl:include href="mailReason.xsl"/>
<xsl:include href="footer.xsl"/>
<xsl:include href="style.xsl"/>
<xsl:include href="recordTitle.xsl"/>


<!--
  Template to standardize table styling without too much inline code.
  The main reason this template exists is because many email clients ignore
  css classes, so we need to embed inline styling.

  WARNING: If we move this to one of the call_template files, all letters
           including that template must define the ext: namespace prefix:
           xmlns:ext="http://exslt.org/common"
-->
<xsl:template name="defaultTableStyle">
  <xsl:param name="head" />
  <xsl:param name="body" />

  <table cellpadding="5" cellspacing="0" class="listing" width="100%; text-align:left;">
    <thead>
      <tr>
        <xsl:for-each select="ext:node-set($head)/column">
          <th align="left" style="background: #F9F9F9; border-bottom: 1px solid #ccc;">
            <xsl:value-of select="."/>
            <br /><!-- linjeskift for RT og andre systemer som konverterer eposten til ren tekst -->
          </th>
        </xsl:for-each>
      </tr>
    </thead>
    <tbody>
      <xsl:copy-of select="ext:node-set($body)"/>
    </tbody>
  </table>
</xsl:template>


<!--
  Template: formatProcessStatus

  Genererer en brukervennlig status for et lån, til bruk i tabellen over lån.

  Ved oppdatering av denne malen kan det være lurt å også ta en sjekk på tilsvarende
  maler i FulUserBorrowingActivityLetter.xsl og FulOverdueAndLostLoanNotificationLetter.xsl,
  men merk at logikken i malene er litt forskjellig.
-->
<xsl:template name="formatProcessStatus">
<xsl:variable name="group" select="user_group"/>
  <xsl:choose>
    <xsl:when test="process_status = 'RECALL'">
      <xsl:call-template name="multilingual"><!-- header.xsl -->
        <xsl:with-param name="nb" select="'Andre lånere venter. Må leveres snarest'"/>
        <xsl:with-param name="nn" select="'Andre lånarar ventar. Må leverast snarast'"/>
        <xsl:with-param name="en" select="'Other patrons are waiting. Please return as soon as possible'"/>
      </xsl:call-template>
    </xsl:when>
     <xsl:when test="starts-with(physical_item/barcode, 'RS-')">
      <!-- Innlån utland -->
      <xsl:call-template name="multilingual"><!-- header.xsl -->
        <xsl:with-param name="nb" select="'Lånt inn fra utlandet. Ta kontakt med oss for å fornye'"/>
        <xsl:with-param name="nn" select="'Lånt inn frå utlandet. Ta kontakt med oss for å fornye'"/>
        <xsl:with-param name="en" select="'Borrowed from a library abroad. Contact us to renew'"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="contains(location_name, 'Fjernlån')">
      <xsl:call-template name="multilingual"><!-- header.xsl -->
        <xsl:with-param name="nb" select="'Lånt inn fra annet bibliotek. Logg inn i Oria for å fornye '"/>
        <xsl:with-param name="nn" select="'Lånt inn frå anna bibliotek. Logg inn i Oria for å fornye '"/>
        <xsl:with-param name="en" select="'Borrowed from another library. Sign in to Oria to renew '"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="$group = '8' or $group = '9' or $group = '10' or $group = '11' or $group = '12' or $group = '13' or $group = '14' or $group = '15' or $group = '16' or $group = '17' or $group = '20' or $group = '21' or $group = '22' or $group = '23' or $group = '24' or $group = '25'">
      <xsl:call-template name="multilingual"><!-- header.xsl -->
        <xsl:with-param name="nb" select="'Logg på Oria for å se om boka kan fornyes'"/>
        <xsl:with-param name="nn" select="'Logg på Oria for å se om boka kan fornyes'"/>
        <xsl:with-param name="en" select="'Sign in to Oria to check if renewal is possible'"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="multilingual"><!-- header.xsl -->
        <xsl:with-param name="nb" select="'Kan ikke fornyes og må leveres'"/>
        <xsl:with-param name="nn" select="'Kan ikkje fornyast og må leverast'"/>
        <xsl:with-param name="en" select="'Cannot be renewed. Please return as soon as possible'"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<!--
  Template: formatLoan

  Generates a row in the loans table.
-->
<xsl:template name="formatLoan">
  <tr>
    <td valign="top">
      <xsl:value-of select="title"/>
      <xsl:if test="description != ''">
        <br />(<xsl:value-of select="description"/>)
      </xsl:if>
      <br /><!-- linjeskift for RT -->
    </td>
    <td valign="top">
      <xsl:call-template name="formatProcessStatus"></xsl:call-template>
      <br /><!-- linjeskift for RT -->
    </td>
    <td>
      <br /><!-- ekstra linjeskift for RT -->
    </td>
  </tr>
</xsl:template>


<!-- The letter itself -->

<xsl:template match="/">
  <xsl:call-template name="emailTemplate"/><!-- style.xsl -->
</xsl:template>

<xsl:template match="/notification_data">

  <xsl:call-template name="dearLibraryPatron"/><!-- mailReason.xsl -->

  <p>
    <xsl:call-template name="multilingual"><!-- header.xsl -->
      <xsl:with-param name="nb" select="'Vi vil minne deg på at du har lån som forfaller i dag. Disse vil ikke bli fornyet automatisk. Under finner du en oversikt over de aktuelle bøkene.'"/>
      <xsl:with-param name="nn" select="'Vi vil minne deg på at du har lån som forfell i dag. Desse vil ikkje bli fornya automatisk. Under finn du ein oversikt over dei aktuelle bøkene.'"/>
      <xsl:with-param name="en" select="'We would like to remind you that you have one or more loans due today, that will not be automatically renewed.'"/>
    </xsl:call-template>
  </p>

  <xsl:call-template name="defaultTableStyle"><!-- header.xsl -->
    <xsl:with-param name="head">
      <column>@@title@@</column>
      <column>Status</column>
      <column><!-- Tom kolonne for RT --></column>
    </xsl:with-param>
    <xsl:with-param name="body">
      <xsl:for-each select="item_loans/item_loan">
        <xsl:call-template name="formatLoan"></xsl:call-template>
      </xsl:for-each>
    </xsl:with-param>
  </xsl:call-template>

  <xsl:call-template name="email-footer"><!-- footer.xsl -->
    <xsl:with-param name="show_my_account" select="true()"/>
  </xsl:call-template>

</xsl:template>
</xsl:stylesheet>