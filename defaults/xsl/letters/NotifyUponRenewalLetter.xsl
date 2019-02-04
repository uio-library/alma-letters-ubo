<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />

<xsl:template match="/">
 <html>
  <head>
  <xsl:call-template name="generalStyle" />
  </head>

   <body>
   <xsl:attribute name="style">
    <xsl:call-template name="bodyStyleCss" /> <!-- style.xsl -->
   </xsl:attribute>

    <xsl:call-template name="head" /> <!-- header.xsl -->
    <xsl:call-template name="senderReceiver" /> <!-- SenderReceiver.xsl -->

    <br />
    <xsl:call-template name="toWhomIsConcerned" /> <!-- mailReason.xsl -->
     <div>
    @@is_up_for_renewal@@
    </div>

    <br />
    <table cellspacing="0" cellpadding="5" border="0">
    <tr>
     <td>
    <br />
    @@orderNumber@@ :

      <br />

     </td>
      <td>
    <br />
    <xsl:value-of  select="notification_data/line_number"/>

      <br />

     </td>
     </tr>
    <tr>
     <td>
    <br />
    @@title@@ :

      <br />

     </td>
      <td>
    <br />
    <xsl:value-of  select="notification_data/title"/>

      <br />

     </td>
     </tr>
     <tr>
     <td>
    <br />
    @@subscription_from_date@@ :

      <br />

     </td>
      <td>
    <br />
    <xsl:value-of  select="notification_data/subscription_from_date/full_date"/>

      <br />

     </td>
    </tr>
     <tr>
     <td>
    <br />
    @@subscription_to_date@@ :

      <br />

     </td>
      <td>
    <br />
    <xsl:value-of  select="notification_data/subscription_to_date/full_date"/>

      <br />

     </td>
     </tr>
     <tr>
     <td>
    <br />
    @@renewal_date@@ :

      <br />

     </td>
      <td>
    <br />
    <xsl:value-of  select="notification_data/renewal_date/full_date"/>

      <br />

     </td>
     </tr>


      <tr>
     <td>
    <br />
    @@identifier@@ :

      <br />

     </td>
      <td>
    <br />
    <xsl:if test="notification_data/line/identifier !=''">
     <xsl:value-of  select="notification_data/line/identifier"/>
   </xsl:if>
      <br />

     </td>
     </tr>


      <tr>
     <td>
    <br />
    @@price@@ :

      <br />

     </td>
      <td>
    <br />
    <xsl:if test="notification_data/line/foreign_currency_list_price !=''">
     <xsl:value-of  select="notification_data/line/foreign_currency_list_price/currency"/>&#160;<xsl:value-of select="notification_data/line/foreign_currency_list_price/normalized_sum"/>
    </xsl:if>
      <br />

     </td>
     </tr>

    </table>
    <br />

  <xsl:if test="notification_data/line/funds_transaction_items/funds_transaction_item !=''">

    <xsl:for-each select="notification_data/line/funds_transaction_items/funds_transaction_item">
    <table>
     <tr>
      <td>@@fund_code@@:<xsl:value-of select="fund/code"/></td>
     </tr>
     <tr>
      <td>@@fiscal_period@@:<xsl:value-of select="fund/fiscal_period_desc"/></td>
     </tr>
     <tr>
      <td>@@currency@@: <xsl:value-of select="amount/currency"/></td>
     </tr>
     <tr>
      <td>@@sum@@: <xsl:value-of select="amount/normalized_sum"/></td>
     </tr>

    </table>
    </xsl:for-each>
  </xsl:if>
    <br />

    <div>
    @@please_decide_if_you_want@@

    </div>
    <br />
    <table>
      <tr><td>@@sincerely@@</td></tr>
      <tr><td>@@department@@</td></tr>
    </table>

    <xsl:call-template name="lastFooter" /> <!-- footer.xsl -->
   </body>
 </html>
</xsl:template>

</xsl:stylesheet>