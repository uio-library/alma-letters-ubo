<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- DMOH 2016-01-20: Mal for å endre dato fra MM/DD/YYYY til YYYY-MM-DD og fjerne evt. tidspunkt.
     OBS: Denne brukes også av mange andre XSL-filer. -->
<xsl:template name="normalizedDate">
  <xsl:param name="value"/>
  <xsl:value-of select="substring($value, 7, 4)"/>-<xsl:value-of select="substring($value, 4, 2)"/>-<xsl:value-of select="substring($value, 1, 2)"/>
</xsl:template>
<!-- DMOH 2016-01-20: SLUTT -->


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

  <xsl:for-each select="notification_data/general_data">
  <td bgcolor="#eee">
  <h2><xsl:value-of select="letter_name"/></h2>
 </td>
 <td align="right" bgcolor="#eee">
  <h2>
   <xsl:call-template name="normalizedDate"><!-- header.xsl -->
              <xsl:with-param name="value" select="current_date"/>
            </xsl:call-template>
  </h2>
 </td>
  </xsl:for-each>

</tr>
</table>


</xsl:template>

</xsl:stylesheet>