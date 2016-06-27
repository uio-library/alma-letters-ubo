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

  <xsl:call-template name="email-logo"/><!-- header.xsl -->
  <xsl:call-template name="toWhomIsConcerned"/><!-- mailReason.xsl -->

  <p>
    @@message@@
  </p>

  <table cellpadding="5" cellspacing="0" class="listing" width="100%">
    <!-- Når teksten ovenfor sier "forfaller i dag" er det unødvendig å skrive ut "due date". 
         Bibliotek er også unødvendig fordi det er det samme hvor man leverer -->
    <!--<tr>
     <th align="left">@@title@@</th>
     <th align="left">@@due_date@@</th>
     <th align="left">@@library@@</th>
    </tr>-->

    <xsl:for-each select="item_loans/item_loan">
      <tr>
        <td>
          <xsl:value-of select="title"/>
          <xsl:if test="description != ''">
            <br />(<xsl:value-of select="description"/>)
          </xsl:if>
        </td>
        <!--<td valign="top" style="white-space: nowrap;">
          <xsl:call-template name="normalizedDate">
            <xsl:with-param name="value" select="due_date"/>
          </xsl:call-template>
        </td>
        <td>
          <xsl:value-of select="library_name"/>
        </td>-->
      </tr>
    </xsl:for-each>

  </table>

  <p>
    @@additional_info_1@@
  </p>

  <p>
    @@additional_info_2@@
  </p>

  <xsl:call-template name="email-footer" /> <!-- footer.xsl -->
  <xsl:call-template name="myAccount" />

</xsl:template>
</xsl:stylesheet>