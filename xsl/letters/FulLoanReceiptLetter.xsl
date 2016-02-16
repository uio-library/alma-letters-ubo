<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="header.xsl" />
  <xsl:include href="senderReceiver.xsl" />
  <xsl:include href="mailReason.xsl" />
  <xsl:include href="footer.xsl" />
  <xsl:include href="style.xsl" />
  <xsl:include href="recordTitle.xsl" />

  <xsl:template match="/">
    <html>
      <head>
        <xsl:call-template name="generalStyle" />
      </head>
      <body>
        <xsl:attribute name="style">
          <xsl:call-template name="bodyStyleCss" /><!-- style.xsl -->
        </xsl:attribute>

        <xsl:call-template name="head" /><!-- header.xsl -->

        <!--
        <xsl:call-template name="senderReceiver" />--> <!-- SenderReceiver.xsl -->
    <!--<br />-->

    <div class="messageArea">
        <div class="messageBody">

      <xsl:call-template name="toWhomIsConcerned" /> <!-- mailReason.xsl -->

          <p>
            @@inform_loaned_items@@ <xsl:value-of select="notification_data/organization_unit/name" />:
          </p>

          <table cellpadding="5" class="listing">
        <xsl:attribute name="style">
          <xsl:call-template name="mainTableStyleCss" /> <!-- style.xsl -->
        </xsl:attribute>
        <tr>
          <th>@@title@@</th>
          <th>@@loan_date@@</th>
          <th>@@due_date@@</th>
          <th>@@description@@</th>
        </tr>

            <xsl:for-each select="notification_data/items/item_loan">
        <tr>
          <td><xsl:value-of select="title"/></td>
          <td>
            <xsl:call-template name="normalizedDate"><!-- header.xsl -->
              <xsl:with-param name="value" select="loan_date"/>
            </xsl:call-template>
          </td>
          <td>
            <xsl:call-template name="normalizedDate"><!-- header.xsl -->
              <xsl:with-param name="value" select="new_due_date_str"/>
            </xsl:call-template>
          </td>
          <td><xsl:value-of select="description"/></td>
        </tr>
        </xsl:for-each>

          </table>

        </div>
        </div>

        <xsl:call-template name="lastFooter" /> <!-- footer.xsl -->

      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>