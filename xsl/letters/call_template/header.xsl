<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:date="http://exslt.org/dates-and-times"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="date ext">


<!--
  Template to make it easier to insert multilingual text.
  Depends on: (none)
-->
<xsl:template name="multilingual">
  <xsl:param name="en" />
  <xsl:param name="nn" />
  <xsl:param name="nb" />
  <xsl:choose>
    <xsl:when test="/notification_data/receivers/receiver/preferred_language = 'nob'"><xsl:value-of select="$nb"/></xsl:when>
    <xsl:when test="/notification_data/receivers/receiver/preferred_language = 'no'"><xsl:value-of select="$nb"/></xsl:when>
    <xsl:when test="/notification_data/receivers/receiver/preferred_language = 'nb'"><xsl:value-of select="$nb"/></xsl:when>
    <xsl:when test="/notification_data/receivers/receiver/preferred_language = 'nn'"><xsl:value-of select="$nn"/></xsl:when>
    <xsl:when test="/notification_data/receivers/receiver/preferred_language = 'nno'"><xsl:value-of select="$nn"/></xsl:when>
    <xsl:otherwise><xsl:value-of select="$en"/></xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!--
  Semi-formal greeting.
  Depends on: multilingual
  -->
<xsl:template name="dearLibraryPatron">
  <p style="margin-top: 0;">
    <xsl:call-template name="multilingual"><!-- header.xsl -->
      <xsl:with-param name="nb" select="'Kjære bruker av biblioteket'"/>
      <xsl:with-param name="nn" select="'Kjære brukar av biblioteket'"/>
      <xsl:with-param name="en" select="'Dear library patron,'"/>
    </xsl:call-template>
  </p>
</xsl:template>


<!--
  Hentenummer
  Added by: DMOH 2016-05-24
  Depends on: (none)
-->
<xsl:template name="pickupNumber">
  <xsl:value-of select="concat(
      substring-before(/notification_data/request/work_flow_entity/expiration_date,'/'),
      '-',
      substring(/notification_data/user_for_printing/identifiers/code_value/value, string-length(/notification_data/user_for_printing/identifiers/code_value/value)-1),
      substring(/notification_data/request/selected_inventory_id, string-length(/notification_data/request/selected_inventory_id)-8, 2)
      )"/>
</xsl:template>


<!--
  Hentenummer
  Added by: DMOH 2016-05-24
  Depends on: pickupNumber
-->
<xsl:template name="pickupNumberWithLabel">
  <xsl:param name="lcfirst" select="false()"/><!-- lower-case first -->
  <xsl:choose>

    <!-- Merk: Artikkelkopier (uten expiration_date) og innlånte bøker stilles opp på navn, ikke på hentenummer -->
    <xsl:when test="/notification_data/request/work_flow_entity/expiration_date = '' or /notification_data/request/calculated_destination_name = 'UiO HumSam-biblioteket - HumSam-biblioteket-Innlån' or /notification_data/request/calculated_destination_name = 'UiO Informatikkbiblioteket - Utlånet Inf' or contains(/notification_data/phys_item_display/available_items/available_item/location_name, 'Fjernlån') or contains(/notification_data/request/calculated_destination_name, 'UiO Realfagsbiblioteket')">
      <xsl:if test="$lcfirst">
        <xsl:if test="/notification_data/receivers/receiver/preferred_language = 'no'">hentes i skranken</xsl:if>
        <xsl:if test="/notification_data/receivers/receiver/preferred_language = 'nb'">hentes i skranken</xsl:if>
        <xsl:if test="/notification_data/receivers/receiver/preferred_language = 'nn'">hentast i skranken</xsl:if>
        <xsl:if test="/notification_data/receivers/receiver/preferred_language = 'en'">pick-up at the counter</xsl:if>
      </xsl:if>
      <xsl:if test="not($lcfirst)">
        <xsl:if test="/notification_data/receivers/receiver/preferred_language = 'no'">Henvend deg i skranken for henting.</xsl:if>
        <xsl:if test="/notification_data/receivers/receiver/preferred_language = 'nb'">Henvend deg i skranken for henting.</xsl:if>
        <xsl:if test="/notification_data/receivers/receiver/preferred_language = 'nn'">Til henting i skranken.</xsl:if>
        <xsl:if test="/notification_data/receivers/receiver/preferred_language = 'en'">Ask at the counter to pick up the material.</xsl:if>
      </xsl:if>
    </xsl:when>

    <!-- Hentenummer konstruert av hentefrist, siste tre siffer i LTID og to siffer fra selected_inventory_id -->
    <xsl:otherwise>
      <xsl:if test="$lcfirst">
        <xsl:if test="/notification_data/receivers/receiver/preferred_language = 'no'">hentenummer</xsl:if>
        <xsl:if test="/notification_data/receivers/receiver/preferred_language = 'nb'">hentenummer</xsl:if>
        <xsl:if test="/notification_data/receivers/receiver/preferred_language = 'nn'">hentenummer</xsl:if>
        <xsl:if test="/notification_data/receivers/receiver/preferred_language = 'en'">pick-up number</xsl:if>
        <xsl:text>: </xsl:text>
        <xsl:call-template name="pickupNumber"/>
      </xsl:if>
      <xsl:if test="not($lcfirst)">
        <xsl:if test="/notification_data/receivers/receiver/preferred_language = 'no'">Hentenummer</xsl:if>
        <xsl:if test="/notification_data/receivers/receiver/preferred_language = 'nb'">Hentenummer</xsl:if>
        <xsl:if test="/notification_data/receivers/receiver/preferred_language = 'nn'">Hentenummer</xsl:if>
        <xsl:if test="/notification_data/receivers/receiver/preferred_language = 'en'">Pick-up number</xsl:if>
        <xsl:text>: </xsl:text>
        <b><xsl:call-template name="pickupNumber"/></b>
      </xsl:if>
    </xsl:otherwise>

  </xsl:choose>
</xsl:template>


<!--
    Template for converting date from DD/MM/YYYY to YYYY-MM-DD and remove time.
    Added by: DMOH 2016-01-20

    Depends on: (none)

    Parameters:
      value:     The date on format DD/MM/YYYY
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


<!--
    Template for converting date from MM/DD/YYYY to d. m YYYY (and remove time).
    Added by: DMOH 2016-06-28

    Depends on: (none)

    Parameters:
      value:     The date on format MM/DD/YYYY
-->
<xsl:template name="stdDate">
  <xsl:param name="value"/>
  <xsl:value-of select="number(substring($value, 1, 2))"/>
  <xsl:choose>
    <xsl:when test="/notification_data/receivers/receiver/preferred_language = 'en'">
      <xsl:text> </xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>. </xsl:text>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:call-template name="monthName">
    <xsl:with-param name="value" select="substring($value, 4, 2)" />
  </xsl:call-template>
  <xsl:text> </xsl:text>
  <xsl:value-of select="substring($value, 7, 4)"/>
</xsl:template>

<xsl:template name="monthName">
  <xsl:param name="value"/>
  <xsl:choose>
    <xsl:when test="/notification_data/receivers/receiver/preferred_language = 'en'">
      <xsl:choose>
        <xsl:when test="$value = '01'">January</xsl:when>
        <xsl:when test="$value = '02'">February</xsl:when>
        <xsl:when test="$value = '03'">March</xsl:when>
        <xsl:when test="$value = '04'">April</xsl:when>
        <xsl:when test="$value = '05'">May</xsl:when>
        <xsl:when test="$value = '06'">June</xsl:when>
        <xsl:when test="$value = '07'">July</xsl:when>
        <xsl:when test="$value = '08'">August</xsl:when>
        <xsl:when test="$value = '09'">September</xsl:when>
        <xsl:when test="$value = '10'">October</xsl:when>
        <xsl:when test="$value = '11'">November</xsl:when>
        <xsl:when test="$value = '12'">December</xsl:when>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <xsl:choose>
        <xsl:when test="$value = '01'">januar</xsl:when>
        <xsl:when test="$value = '02'">februar</xsl:when>
        <xsl:when test="$value = '03'">mars</xsl:when>
        <xsl:when test="$value = '04'">april</xsl:when>
        <xsl:when test="$value = '05'">mai</xsl:when>
        <xsl:when test="$value = '06'">juni</xsl:when>
        <xsl:when test="$value = '07'">juli</xsl:when>
        <xsl:when test="$value = '08'">august</xsl:when>
        <xsl:when test="$value = '09'">september</xsl:when>
        <xsl:when test="$value = '10'">oktober</xsl:when>
        <xsl:when test="$value = '11'">november</xsl:when>
        <xsl:when test="$value = '12'">desember</xsl:when>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<xsl:template name="headerTableStyleCss">
background-color:#e8e8e8;  width:100%; height:30px; text-shadow:1px 1px 1px #fff;
</xsl:template>

<!--
  Heading with logo for outgoing letters

  *DEPRECATED*: Use emailTemplate instead.

  Depends on: headerTableStyleCss
-->
<xsl:template name="head">
  <table cellspacing="0" cellpadding="5" border="0">
    <xsl:attribute name="style">
      <xsl:call-template name="headerTableStyleCss" />
    </xsl:attribute>
    <tr>
      <td colspan="2">
        <img src="cid:logo.jpg" alt="logo"/>
      </td>
    </tr>
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


<!--
  Heading without logo for internal letters

  Depends on: headerTableStyleCss
-->
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


<!--
  Template for replacing text when the replace() function is not available.
  Source: https://gist.github.com/ijy/6572481
  Added by: DMOH 2016-02-23 (modified by adding disable-output-escaping)

  Parameters:
    string:     The text to be evaluated
    replace:    The character or string to look for in the above string
    with:       What to replace it with
-->
<xsl:template name="string-replace">
  <xsl:param name="string" />
  <xsl:param name="replace" />
  <xsl:param name="with" />

  <xsl:choose>
    <xsl:when test="contains($string, $replace)">
      <xsl:value-of select="substring-before($string, $replace)" disable-output-escaping="yes" />
      <xsl:value-of select="$with" disable-output-escaping="yes" />
      <xsl:call-template name="string-replace">
        <xsl:with-param name="string" select="substring-after($string,$replace)" />
        <xsl:with-param name="replace" select="$replace" />
        <xsl:with-param name="with" select="$with" />
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$string" disable-output-escaping="yes" />
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<!--
    Template for formatting decimal numbers according to the user's locale.
    Added by: DMOH 2018-05-23

    Depends on: (none)

    Parameters:
      value:     The number, as formatted by Alma.
-->
<xsl:template name="formatDecimalNumber">
  <!--
    1. Fjern tusenskilletegn
    2. Gjør om til tall
    3. Formater tallet vha. format-number

    Husk å alltid teste både på norsk og engelsk!
  -->
  <xsl:param name="value"/>
  <xsl:variable name="numeric_value" select="number(translate($value, '&#160;,', ''))"/>
  <xsl:choose>
    <xsl:when test="/notification_data/receivers/receiver/preferred_language = 'nob' or /notification_data/receivers/receiver/preferred_language = 'no' or /notification_data/receivers/receiver/preferred_language = 'nb' or /notification_data/receivers/receiver/preferred_language = 'nn' or /notification_data/receivers/receiver/preferred_language = 'nno'">
      <xsl:decimal-format name="no" decimal-separator="," grouping-separator="&#160;"/>
      <xsl:value-of select="format-number($numeric_value, '#&#160;##0,00', 'no')"></xsl:value-of>
    </xsl:when>
    <xsl:otherwise>
      <xsl:decimal-format name="en" decimal-separator="." grouping-separator=","/>
      <xsl:value-of select="format-number($numeric_value, '#,##0.00', 'en')"></xsl:value-of>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<!--
  *DEPRECATED*: the old logo template
-->
<xsl:template name="emailLogo"></xsl:template>


</xsl:stylesheet>