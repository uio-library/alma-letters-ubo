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

<!-- Templates -->

<!--
  Template: formatProcessStatus

  Genererer en brukervennlig status for et lån, til bruk i tabellen over lån.

  Ved oppdatering av denne malen kan det være lurt å også ta en sjekk på tilsvarende
  maler i FulUserBorrowingActivityLetter.xsl og FulUserOverdueNoticeLetter.xsl,
  men merk at logikken er litt forskjellig.
-->
<xsl:template name="formatProcessStatus">
 <xsl:variable name="group" select="item_loan/user_group"/>
  <xsl:choose>
    <xsl:when test="item_loan/process_status = 'RECALL'">
      <xsl:call-template name="multilingual"><!-- footer.xsl -->
        <xsl:with-param name="nb" select="'Andre lånere venter. Boken må leveres snarest'"/>
        <xsl:with-param name="nn" select="'Andre lånarar ventar. Må leverast snarast'"/>
        <xsl:with-param name="en" select="'Other patrons are waiting. Please return as soon as possible'"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="contains(item_loan/barcode, 'RS-')">
      <!-- Innlån utland -->
      <xsl:call-template name="multilingual"><!-- footer.xsl -->
        <xsl:with-param name="nb" select="'Lånt inn fra utlandet. Ta kontakt med biblioteket for å fornye'"/>
        <xsl:with-param name="nn" select="'Lånt inn frå utlandet. Ta kontakt med biblioteket for å fornye'"/>
        <xsl:with-param name="en" select="'Borrowed from an library abroad. Contact your library to renew'"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="contains(item_loan/location_name, 'Fjernlån')">
      <xsl:call-template name="multilingual"><!-- footer.xsl -->
        <xsl:with-param name="nb" select="'Lånt inn fra et annet bibliotek. Logg inn i Oria for å fornye '"/><!-- Fornyes i Oria? -->
        <xsl:with-param name="nn" select="'Lånt inn frå eit anna bibliotek. Logg inn i Oria for å fornye '"/>
        <xsl:with-param name="en" select="'Borrowed from another library. Sign in to Oria to renew '"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="$group = '8' or $group = '9' or $group = '10' or $group = '11' or $group = '12' or $group = '13' or $group = '14' or $group = '15' or $group = '16' or $group = '17' or $group = '20' or $group = '21' or $group = '22' or $group = '23' or $group = '24' or $group = '25'">
      <xsl:call-template name="multilingual"><!-- footer.xsl -->
        <xsl:with-param name="nb" select="'Logg på Oria for å se om boka kan fornyes'"/>
        <xsl:with-param name="nn" select="'Logg på Oria for å se om boka kan fornyes'"/>
        <xsl:with-param name="en" select="'Sign in to Oria for renewal'"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="multilingual"><!-- footer.xsl -->
        <xsl:with-param name="nb" select="'Kan ikke fornyes og må leveres'"/><!-- Fornyes automatisk? -->
        <xsl:with-param name="nn" select="'Kan ikkje fornyast og må leverast'"/>
        <xsl:with-param name="en" select="'Cannot be renewed. Please return as soon as possible'"/><!-- Renewed automatically -->
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
      <xsl:value-of select="item_loan/title"/>
      <xsl:if test="description != ''">
        <br />(<xsl:value-of select="description"/>)
      </xsl:if>
    </td>
    <td valign="top">
      <xsl:value-of select="item_loan/barcode"/>
    </td>
    <td valign="top">
      <xsl:call-template name="formatProcessStatus"></xsl:call-template>
    </td>
  </tr>
</xsl:template>


<xsl:template match="/">
  <xsl:call-template name="email-template"/><!-- header.xsl -->
</xsl:template>

<xsl:template match="/notification_data">

  <xsl:call-template name="dearLibraryPatron"/><!-- mailReason.xsl -->

  <p>
    <xsl:choose>
      <xsl:when test="notification_type = 'OverdueNotificationType1'">
        @@inform_you_item_below_type1@@
      </xsl:when>
      <xsl:when test="notification_type = 'OverdueNotificationType2'">
        @@inform_you_item_below_type2@@
      </xsl:when>
      <xsl:when test="notification_type = 'OverdueNotificationType3'">
        @@inform_you_item_below_type3@@
      </xsl:when>
      <xsl:when test="/notification_data/notification_type = 'OverdueNotificationType4'">
        @@inform_you_item_below_type4@@
      </xsl:when>
      <xsl:otherwise><!-- This should never happen --></xsl:otherwise>
    </xsl:choose>
    <br />
    <xsl:choose>
      <xsl:when test="notification_type = 'OverdueNotificationType1'">
        @@decalred_as_lost_type1@@
      </xsl:when>
      <xsl:when test="notification_type = 'OverdueNotificationType2'">
        @@decalred_as_lost_type2@@
      </xsl:when>
      <xsl:when test="notification_type = 'OverdueNotificationType3'">
        @@decalred_as_lost_type3@@
      </xsl:when>
      <xsl:when test="notification_type = 'OverdueNotificationType4'">
        @@decalred_as_lost_type4@@
      </xsl:when>
    </xsl:choose>
  </p>

  <table cellpadding="5" cellspacing="0" class="listing" width="100%">
    <xsl:attribute name="style">
      <xsl:call-template name="mainTableStyleCss"/><!-- style.xsl -->
    </xsl:attribute>
    <tr>
      <th align="left">
        @@lost_item@@
      </th>
      <th align="left">
        @@barcode@@
      </th>
      <th align="left">
        Status
      </th>
    </tr>

    <xsl:for-each select="display_list/overdue_and_lost_loan_notification_display">
      <xsl:call-template name="formatLoan"></xsl:call-template>
    </xsl:for-each>
  </table>

  <xsl:call-template name="email-footer"><!-- footer.xsl -->
    <xsl:with-param name="show_my_account" select="true()"/>
  </xsl:call-template>

</xsl:template>
</xsl:stylesheet>