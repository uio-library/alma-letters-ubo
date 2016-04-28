<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
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


    <table cellspacing="0" cellpadding="5" border="0">
    <tr>
    <td>
     @@inform_you_item_below@@.
    </td>
    </tr>
    </table>

    <table cellpadding="5" class="listing">
    <xsl:attribute name="style">
     <xsl:call-template name="mainTableStyleCss" /> <!-- style.xsl -->
    </xsl:attribute>

    <xsl:for-each select="notification_data">
    <table>
     <tr>
      <td>
      <b><xsl:value-of select="item_loan/title"/></b>
      <br />
      @@description@@ :<xsl:value-of select="item_loan/description"/>
      <br />
      @@library@@ :<xsl:value-of select="organization_unit/name"/>
      <br />
      @@loan_date@@ :<xsl:value-of select="item_loan/loan_date"/>
      <br />
      @@due_date@@ :<xsl:value-of select="item_loan/due_date"/>
      <br />
      @@barcode@@ :<xsl:value-of select="item_loan/barcode"/>
      <br />
      <br />
      @@charged_with_fines_fees@@
      </td>
     </tr>
    </table>
    </xsl:for-each>

    <table cellpadding="5" class="listing">
    <xsl:attribute name="style">
     <xsl:call-template name="mainTableStyleCss" /> <!-- style.xsl -->
    </xsl:attribute>
     <tr>
      <th>@@fee_type@@</th>
      <th>@@fee_amount@@</th>
      <th>@@note@@</th>
     </tr>
     <xsl:for-each select="notification_data/fines_fees_list/user_fines_fees">
     <tr>
      <td><xsl:value-of select="fine_fee_type_display"/></td>
      <td><xsl:value-of select="fine_fee_ammount/sum"/>&#160;<xsl:value-of select="fine_fee_ammount/currency"/></td>
      <td><xsl:value-of select="ff"/></td>
     </tr>
     </xsl:for-each>

    </table>
     <br />
      <xsl:choose>
        <xsl:when test="/notification_data/receivers/receiver/preferred_language = 'no'">
         Du kan betale i biblioteket eller med
        </xsl:when>
        <xsl:when test="/notification_data/receivers/receiver/preferred_language = 'nn'">
         Du kan betale i biblioteket eller med
        </xsl:when>
        <xsl:otherwise>
         You can pay at the library or with
        </xsl:otherwise>
      </xsl:choose>

    <a>
      <xsl:attribute name="href">https://epay.uio.no/pay/shop/order-create.html?projectStepId=5203685</xsl:attribute>
      E-pay
    </a>
    <!--
    @@additional_info_1@@
    <br />
    @@additional_info_2@@
    <br />
    -->
    </table>
    <br />

    <!-- Use special email adress if we're at ub.uio.no -->
    <xsl:choose>
      <xsl:when test="contains(notification_data/organization_unit/email/email, 'ub.uio.no')">
        <xsl:call-template name="lastFooter"><!-- Defined in footer.xsl -->
          
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="lastFooter" /><!-- Defined in footer.xsl -->
      </xsl:otherwise>
    </xsl:choose>

    <xsl:call-template name="contactUs" /> <!-- footer.xsl -->

   </body>
 </html>
</xsl:template>

</xsl:stylesheet>