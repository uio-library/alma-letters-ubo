<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:date="http://exslt.org/dates-and-times"
  extension-element-prefixes="date">
<xsl:include href="header.xsl"/>
<xsl:include href="senderReceiver.xsl"/>
<xsl:include href="mailReason.xsl"/>
<xsl:include href="footer.xsl"/>
<xsl:include href="style.xsl"/>
<xsl:include href="recordTitle.xsl"/>


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
      <xsl:call-template name="multilingual"><!-- footer.xsl -->
        <xsl:with-param name="nb" select="'Andre lånere venter. Må leveres snarest'"/>
        <xsl:with-param name="nn" select="'Andre lånarar ventar. Må leverast snarast'"/>
        <xsl:with-param name="en" select="'Other patrons are waiting. Please return as soon as possible'"/>
      </xsl:call-template>
    </xsl:when>
     <xsl:when test="contains(physical_item/barcode, 'RS-')">
      <!-- Innlån utland -->
      <xsl:call-template name="multilingual"><!-- footer.xsl -->
        <xsl:with-param name="nb" select="'Lånt inn fra utlandet. Ta kontakt med oss for å fornye'"/>
        <xsl:with-param name="nn" select="'Lånt inn frå utlandet. Ta kontakt med oss for å fornye'"/>
        <xsl:with-param name="en" select="'Borrowed from a library abroad. Contact us to renew'"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="contains(location_name, 'Fjernlån')">
      <xsl:call-template name="multilingual"><!-- footer.xsl -->
        <xsl:with-param name="nb" select="'Lånt inn fra annet bibliotek. Logg inn i Oria for å fornye '"/>
        <xsl:with-param name="nn" select="'Lånt inn frå anna bibliotek. Logg inn i Oria for å fornye '"/>
        <xsl:with-param name="en" select="'Borrowed from another library. Sign in to Oria to renew '"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="$group = '8' or $group = '9' or $group = '10' or $group = '11' or $group = '12' or $group = '13' or $group = '14' or $group = '15' or $group = '16' or $group = '17' or $group = '20' or $group = '21' or $group = '22' or $group = '23' or $group = '24' or $group = '25'">
      <xsl:call-template name="multilingual"><!-- footer.xsl -->
        <xsl:with-param name="nb" select="'Logg på Oria for å se om boka kan fornyes'"/>
        <xsl:with-param name="nn" select="'Logg på Oria for å se om boka kan fornyes'"/>
        <xsl:with-param name="en" select="'Sign in to Oria to check if renewal is possible'"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="multilingual"><!-- footer.xsl -->
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
    </td>
    <td valign="top">
      <xsl:call-template name="formatProcessStatus"></xsl:call-template>
    </td>
  </tr>
</xsl:template>


<!-- The letter itself -->

<xsl:template match="/">
  <xsl:call-template name="email-template"/><!-- header.xsl -->
</xsl:template>

<xsl:template match="/notification_data">

  <xsl:call-template name="dearLibraryPatron"/><!-- mailReason.xsl -->

  <p>
    <xsl:call-template name="multilingual"><!-- footer.xsl -->
      <xsl:with-param name="nb" select="'Vi vil minne deg på at du har lån som forfaller i dag. Disse vil ikke bli fornyet automatisk. Under finner du en oversikt over de aktuelle bøkene.'"/>
      <xsl:with-param name="nn" select="'Vi vil minne deg på at du har lån som forfell i dag. Desse vil ikkje bli fornya automatisk. Under finn du ein oversikt over dei aktuelle bøkene.'"/>
      <xsl:with-param name="en" select="'We would like to remind you that you have one or more loans due today, that will not be automatically renewed.'"/>
    </xsl:call-template>
  </p>

  <table cellpadding="5" cellspacing="0" class="listing" width="100%">
    <xsl:attribute name="style">
      <xsl:call-template name="mainTableStyleCss"/><!-- style.xsl -->
    </xsl:attribute>
    <tr>
      <th align="left">
        @@title@@
      </th>
      <th align="left">
        Status
      </th>
    </tr>

    <!-- List overdue loans first -->
    <xsl:for-each select="item_loans/item_loan">
      <xsl:call-template name="formatLoan"></xsl:call-template>
    </xsl:for-each>

  </table>

  <xsl:call-template name="email-footer"><!-- footer.xsl -->
    <xsl:with-param name="show_my_account" select="true()"/>
  </xsl:call-template>

</xsl:template>
</xsl:stylesheet>