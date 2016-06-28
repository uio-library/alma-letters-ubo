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

  <xsl:call-template name="email-logo"/><!-- header.xsl -->
  <xsl:call-template name="toWhomIsConcerned"/><!-- mailReason.xsl -->

  <xsl:if test="item_loans/item_loan or overdue_item_loans/item_loan">

    <p>
      @@reminder_message@@
      <!-- Under følger en oversikt over dine lån: -->
    </p>

    <xsl:if test="overdue_item_loans/item_loan">

      <h3>@@overdue_loans@@</h3>

      <table cellpadding="5" cellspacing="0" class="listing" width="100%">
        <tr>
          <th align="left">@@title@@</th>
          <th align="left">@@due_date@@</th>
          <th align="left">@@fine@@</th>
        </tr>
        <xsl:for-each select="overdue_item_loans/item_loan">
        <tr>
          <td valign="top">
            <xsl:value-of select="title"/>
            <xsl:if test="description != ''">
              <br />(<xsl:value-of select="description"/>)
            </xsl:if>
          </td>
          <td valign="top" style="white-space: nowrap;">
            <xsl:call-template name="isoDate"><!-- header.xsl -->
              <xsl:with-param name="value" select="due_date"/>
            </xsl:call-template>
          </td>
          <td valign="top" style="white-space: nowrap;">
            <xsl:value-of select="fine"/>
          </td>
        </tr>
        </xsl:for-each>
      </table>
    </xsl:if>

    <xsl:if test="item_loans/item_loan">

    <!-- Skip header if no overdue loans -->
    <xsl:if test="overdue_item_loans/item_loan">
     <h3>@@loans@@</h3>
    </xsl:if>

    <table cellpadding="5" cellspacing="0" class="listing" width="100%">
     <xsl:attribute name="style">
      <xsl:call-template name="mainTableStyleCss"/>
      <!-- style.xsl -->
     </xsl:attribute>
     <tr>
      <th align="left">@@title@@</th>
      <th align="left">@@due_date@@</th>
     </tr>
     <xsl:for-each select="item_loans/item_loan">
      <tr>
       <td>
        <xsl:value-of select="title"/>
       </td>
       <td valign="top" style="white-space: nowrap;">
        <xsl:call-template name="isoDate"><!-- header.xsl -->
          <xsl:with-param name="value" select="due_date"/>
        </xsl:call-template>
       </td>
      </tr>
     </xsl:for-each>
    </table>
   </xsl:if>
  </xsl:if>

  <xsl:if test="organization_fee_list/string">
   <p>
    <h3>@@debt_message@@</h3>
   </p>
   <ul>
    <xsl:for-each select="organization_fee_list/string">
     <li>
      <xsl:value-of select="."/>
     </li>
    </xsl:for-each>
   </ul>
   <p>
    <em>
     @@total@@ <xsl:value-of select="total_fee"/>
    </em>
   </p>
   <p>
    @@please_pay_message@@
   </p>
  </xsl:if>

  <xsl:call-template name="email-footer"/><!-- footer.xsl -->
  <xsl:call-template name="myAccount"/>
  <xsl:call-template name="contactUs" /><!-- footer.xsl -->

</xsl:template>
</xsl:stylesheet>