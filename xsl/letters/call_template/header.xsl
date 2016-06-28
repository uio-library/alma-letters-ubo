<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


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
    background-color:#eeeeee;
}
.transitLetter th { vertical-align: top; }
.transitLetter th, .transitLetter td { padding: 3px; }
    </style>
  </head>
  <body style="background-color: #f0f0f0; margin: 0; padding: 0;">
<!--
    <table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
      <tr>
        <td width="100%" valign="top" bgcolor="#eeeeee" style="padding: 18px 0;">
 -->

  <div style="background-color: #f0f0f0; padding: .8em 0;">
          <table style="max-width: 600px; margin: 0 auto;" border="0" cellpadding="0" cellspacing="0" align="center">
            <tr>
              <td width="100%" style="margin: 12px 0; padding:22px; font-family: Arial, Helvetica, sans-serif;font-size: 13px; line-height: 20px; color:#4b4d4e;" bgcolor="#ffffff">

                <xsl:apply-templates/>

              </td>
            </tr>
          </table>
        </div>
<!--

        </td>
      </tr>
    </table>-->

  </body>
</html>
</xsl:template>


</xsl:stylesheet>