<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="header.xsl"/>
<xsl:include href="senderReceiver.xsl"/>
<xsl:include href="mailReason.xsl"/>
<xsl:include href="footer.xsl"/>
<xsl:include href="style.xsl"/>
<xsl:include href="recordTitle.xsl"/>

<xsl:template match="/">
  <xsl:call-template name="email-template"/><!-- header.xsl -->
</xsl:template>

<xsl:template match="/notification_data">

  <xsl:call-template name="emailLogo"/><!-- mailReason.xsl -->
  <xsl:call-template name="toWhomIsConcerned"/><!-- mailReason.xsl -->

  <p>
    @@inform_returned_items@@ <xsl:value-of select="organization_unit/name"/>:
  </p>

  <table cellpadding="5" cellspacing="0" class="listing" width="100%">
    <tr>
      <th align="left">@@title@@</th>
      <th align="left">@@return_date@@</th>
    </tr>
    <xsl:for-each select="items/item_loan">
      <tr>
        <td>
          <xsl:value-of select="title"/>
          <xsl:if test="description != ''">
            <xsl:value-of select="description"/>
          </xsl:if>
        </td>
        <td valign="top" style="white-space: nowrap;">
          <xsl:call-template name="isoDate"><!-- mailReason.xsl -->
            <xsl:with-param name="value" select="return_date_str"/>
          </xsl:call-template>
        </td>
      </tr>
    </xsl:for-each>
  </table>

  <xsl:call-template name="email-footer" /> <!-- footer.xsl -->

</xsl:template>
</xsl:stylesheet>