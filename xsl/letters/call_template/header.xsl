<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:template name="dearLibraryPatron">
  <p style="margin-top: 0;">
    <xsl:call-template name="multilingual"><!-- footer.xsl -->
      <xsl:with-param name="nb" select="'Kjære bruker av biblioteket'"/>
      <xsl:with-param name="nn" select="'Kjære brukar av biblioteket'"/>
      <xsl:with-param name="en" select="'Dear library patron,'"/>
    </xsl:call-template>
  </p>
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
   <xsl:call-template name="isoDate"><!-- mailReason.xsl -->
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
              <xsl:call-template name="isoDate"><!-- mailReason.xsl -->
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


<!-- Deprecated: the old logo template -->
<xsl:template name="emailLogo"></xsl:template>


<!-- The logo -->
<xsl:template name="logo">
  <p id="logoContainer">
    <img src="cid:logo.jpg" class="logo" style="max-width: 100%; margin: 0; padding: 0;" />
  </p>
</xsl:template>


<!-- Main email template -->
<xsl:template name="email-template">
<html>
  <head>
    <style>
.listing td {
    border-bottom: 1px solid #eee;
    font-family: Arial, Helvetica, sans-serif;font-size: 13px; line-height: 20px; color:#4b4d4e;
}
.listing th {
    font-family: Arial, Helvetica, sans-serif;font-size: 13px;
    background-color:#F9F9F9;
}
.transitLetter th { vertical-align: top; }
.transitLetter th, .transitLetter td { padding: 3px; }
    </style>
  </head>
  <body style="background-color: #F9F9F9; margin: 0; padding: 0;">

    <div style="background-color: #F9F9F9; padding: .8em 0;">

      <table style="max-width: 600px; margin: 0 auto;" border="0" cellpadding="0" cellspacing="0" align="center">
        <tbody>
          <tr>
            <td width="100%" style="margin: 12px 0;">

              <!-- Begin:CenteredColumn -->
              <table>
                <tbody>
                  <tr>
                    <td style="padding: 12px 0;">
                      <xsl:call-template name="logo"/>
                    </td>
                  </tr>
                  <tr>
                    <td style="padding:22px; font-family: Arial, Helvetica, sans-serif;font-size: 13px; line-height: 20px; color:#4b4d4e; border:1px solid #efefef; border-radius: 3px;" bgcolor="#ffffff">
                      <xsl:apply-templates/>
                    </td>
                  </tr>
                </tbody>
              </table>
              <!-- End:CenteredColumn -->

            </td>
          </tr>
        </tbody>
      </table>
    </div>

  </body>
</html>
</xsl:template>


</xsl:stylesheet>