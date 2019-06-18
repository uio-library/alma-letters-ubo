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
      <xsl:call-template name="multilingual"><!-- header.xsl -->
        <xsl:with-param name="nb" select="'Andre lånere venter. Må leveres snarest.'"/>
        <xsl:with-param name="nn" select="'Andre lånarar ventar. Må leverast snarast.'"/>
        <xsl:with-param name="en" select="'Other patrons are waiting. Please return as soon as possible.'"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="contains(item_loan/barcode, 'RS-')">
      <!-- Innlån utland -->
      <xsl:call-template name="multilingual"><!-- header.xsl -->
        <xsl:with-param name="nb" select="'Lånt inn fra utlandet. Kontakt oss for å sjekke om fornying er mulig.'"/>
        <xsl:with-param name="nn" select="'Lånt inn frå utlandet. Kontakt oss for å sjekke om fornying er mogleg.'"/>
        <xsl:with-param name="en" select="'Borrowed from a library abroad. Contact us to check if renewal is possible.'"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="contains(item_loan/location_name, 'Fjernlån')">
      <xsl:call-template name="multilingual"><!-- header.xsl -->
        <xsl:with-param name="nb" select="'Lånt inn fra annet bibliotek. Sjekk i Oria om fornying er mulig.'"/><!-- Fornyes i Oria? -->
        <xsl:with-param name="nn" select="'Lånt inn frå anna bibliotek. Sjekk i Oria om fornying er mogleg.'"/>
        <xsl:with-param name="en" select="'Borrowed from another library. Check Oria to find out if renewal is possible.'"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="$group = '8' or $group = '9' or $group = '10' or $group = '11' or $group = '12' or $group = '13' or $group = '14' or $group = '15' or $group = '16' or $group = '17' or $group = '20' or $group = '21' or $group = '22' or $group = '23' or $group = '24' or $group = '25'">
      <xsl:call-template name="multilingual"><!-- header.xsl -->
        <xsl:with-param name="nb" select="'Sjekk i Oria om fornying er mulig.'"/>
        <xsl:with-param name="nn" select="'Sjekk i Oria om fornying er mogleg.'"/>
        <xsl:with-param name="en" select="'Check Oria to find out if renewal is possible.'"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="multilingual"><!-- header.xsl -->
        <xsl:with-param name="nb" select="'Må leveres."/><!-- Fornyes automatisk? -->
        <xsl:with-param name="nn" select="'Må leverast.'"/>
        <xsl:with-param name="en" select="'Must be returned.'"/><!-- Renewed automatically -->
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
      <xsl:value-of select="item_loan/barcode"/>
      <br /><!-- linjeskift for RT -->
    </td>
    <td valign="top">
      <xsl:value-of select="item_loan/title"/>
      <xsl:if test="item_loan/description != ''">
        <br /><xsl:value-of select="item_loan/description"/>
      </xsl:if>
      <br /><!-- linjeskift for RT -->
    </td>
    <td valign="top">
      <xsl:call-template name="formatProcessStatus"></xsl:call-template>
      <br /><!-- linjeskift for RT -->
    </td>
    <td valign="top">
      <br /><!-- linjeskift for RT -->
    </td>
  </tr>
</xsl:template>


<xsl:template match="/">
  <xsl:call-template name="emailTemplate"/><!-- style.xsl -->
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
        @@barcode@@
        <br /><!-- linjeskift for RT -->
      </th>
      <th align="left">
        @@lost_item@@
        <br /><!-- linjeskift for RT -->
      </th>
      <th align="left">
        Status
        <br /><!-- linjeskift for RT -->
      </th>
      <th>
        <br /><!-- linjeskift for RT -->
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