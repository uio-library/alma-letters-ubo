<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />
<xsl:include href="recordTitle.xsl" />

<xsl:template match="/">
  <xsl:call-template name="email-template"/><!-- header.xsl -->
</xsl:template>

<xsl:template match="/notification_data">

  <xsl:call-template name="emailLogo"/><!-- mailReason.xsl -->
  <xsl:call-template name="toWhomIsConcerned"/><!-- mailReason.xsl -->

  <p>
    @@message@@
  </p>
  <p>
    @@loans@@
  </p>

  <table cellpadding="5" class="listing">
    <xsl:attribute name="style">
      <xsl:call-template name="mainTableStyleCss" /> <!-- style.xsl -->
    </xsl:attribute>
    <tr>
      <th>@@title@@</th>
      <th>@@author@@</th>
      <th>@@due_date@@</th>
    </tr>
    <xsl:for-each select="/notification_data/item_loans/item_loan">
      <tr>
        <td>
          <xsl:value-of select="title"/>
          <xsl:if test="description != ''">
            <br />(<xsl:value-of select="description"/>)
          </xsl:if>
        </td>
        <td>
          <xsl:value-of select="author"/>
        </td>
        <td>
          <xsl:value-of select="due_date"/>
        </td>
      </tr>
    </xsl:for-each>
  </table>

  <xsl:if test="'@@additional_info_1@@' != ''">
    <p>
      @@additional_info_1@@
    </p>
  </xsl:if>
  <xsl:if test="'@@additional_info_2@@' != ''">
    <p>
      @@additional_info_2@@
    </p>
  </xsl:if>

  <xsl:call-template name="email-footer" /> <!-- footer.xsl -->
  <xsl:call-template name="myAccount" />

</xsl:template>
</xsl:stylesheet>