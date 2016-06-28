<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">



<!--
    Template for converting date from MM/DD/YYYY to YYYY-MM-DD and remove time.
    Added by: DMOH 2016-01-20

    Parameters:
      value:     The date on format MM/DD/YYYY
-->
<xsl:template name="isoDate">
  <xsl:param name="value"/>
  <xsl:value-of select="concat(
    substring($value, 7, 4),
    '-',
    substring($value, 4, 2),
    '-',
    substring($value, 1, 2)
  )"/>
</xsl:template>


<xsl:template name="hi">
@@dear@@
</xsl:template>

<xsl:template name="toWhomIsConcerned">
@@dear@@
</xsl:template>

<!--
    Hentenummer
    Added by: DMOH 2016-05-24
-->
<xsl:template name="pickupNumber">
  <xsl:value-of select="concat(
      substring-before(/notification_data/request/work_flow_entity/expiration_date,'/'),
      ' ',
      substring(/notification_data/user_for_printing/identifiers/code_value/value, string-length(/notification_data/user_for_printing/identifiers/code_value/value)-1),
      ' ',
      substring(/notification_data/request/selected_inventory_id, string-length(/notification_data/request/selected_inventory_id)-8, 2)
      )"/>
</xsl:template>

<xsl:template name="pickupNumberWithLabel">
  <xsl:choose>

    <!-- Merk: Artikkelkopier (uten expiration_date) og innlånte bøker stilles opp på navn, ikke på hentenummer -->
    <xsl:when test="/notification_data/request/work_flow_entity/expiration_date = '' or /notification_data/request/calculated_destination_name = 'UiO HumSam-biblioteket - HumSam-biblioteket-Innlån' or /notification_data/request/calculated_destination_name = 'UiO Informatikkbiblioteket - Utlånet Inf' or contains(/notification_data/phys_item_display/available_items/available_item/location_name, 'Fjernlån') or contains(/notification_data/request/calculated_destination_name, 'UiO Realfagsbiblioteket')">
      <xsl:if test="/notification_data/receivers/receiver/preferred_language = 'no'">Hentes i skranken</xsl:if>
      <xsl:if test="/notification_data/receivers/receiver/preferred_language = 'nb'">Hentes i skranken</xsl:if>
      <xsl:if test="/notification_data/receivers/receiver/preferred_language = 'en'">Pick-up at the counter</xsl:if>
    </xsl:when>

    <!-- Hentenummer konstruert av hentefrist, siste tre siffer i LTID og to siffer fra selected_inventory_id -->
    <xsl:otherwise>
      <xsl:if test="/notification_data/receivers/receiver/preferred_language = 'no'">Hentenummer</xsl:if>
      <xsl:if test="/notification_data/receivers/receiver/preferred_language = 'nb'">Hentenummer</xsl:if>
      <xsl:if test="/notification_data/receivers/receiver/preferred_language = 'en'">Pick-up number</xsl:if>
      <xsl:text>: </xsl:text>
      <xsl:call-template name="pickupNumber"/>
    </xsl:otherwise>

  </xsl:choose>
</xsl:template>



<!-- Heading with logo for outgoing letters -->
<xsl:template name="head">
<table cellspacing="0" cellpadding="5" border="0">
 <xsl:attribute name="style">
  <xsl:call-template name="headerTableStyleCss" /> <!-- style.xsl -->
 </xsl:attribute>
 <!-- LOGO INSERT -->
 <tr>
 <xsl:attribute name="style">
  <xsl:call-template name="headerLogoStyleCss" /> <!-- style.xsl -->
 </xsl:attribute>
  <td colspan="2">
  <div id="mailHeader">
              <div id="logoContainer" class="alignLeft">
                    <img src="cid:logo.jpg" alt="logo"/>
               </div>
  </div>
  </td>
 </tr>
<!-- END OF LOGO INSERT -->
 <tr>

  <xsl:for-each select="/notification_data/general_data">
  <td bgcolor="#eee">
  <h2><xsl:value-of select="letter_name"/></h2>
 </td>
 <td align="right" bgcolor="#eee">
  <h2>
   <xsl:call-template name="isoDate"><!-- header.xsl -->
              <xsl:with-param name="value" select="current_date"/>
            </xsl:call-template>
  </h2>
 </td>
  </xsl:for-each>

</tr>
</table>

</xsl:template>

<!-- Heading without logo for internal letters -->
<xsl:template name="headWithoutLogo">
  <xsl:for-each select="/notification_data/general_data">
    <div>
      <xsl:attribute name="style">
        <xsl:call-template name="headerTableStyleCss" /> <!-- style.xsl -->
      </xsl:attribute>
      <table width="100%">
        <tr>
          <td>
            <h2><xsl:value-of select="letter_name"/></h2>
          </td>
          <td align="right" valign="top">
            <h2>
              <xsl:call-template name="isoDate"><!-- header.xsl -->
                <xsl:with-param name="value" select="current_date"/>
              </xsl:call-template>
            </h2>
          </td>
        </tr>
      </table>
    </div>
  </xsl:for-each>
</xsl:template>


<!-- Just the logo -->
<xsl:template name="logo">
  <img src="cid:logo.jpg" alt="logo" class="logo"/>
</xsl:template>


<!-- Logo with bottom border -->
<xsl:template name="emailLogo">
  <div style="border-bottom:1px solid #ccc; padding-bottom:1em; margin-bottom: 1.8em;">
    <xsl:call-template name="logo"/>
  </div>
</xsl:template>


</xsl:stylesheet>