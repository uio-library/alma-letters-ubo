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
     <h>@@inform_you_item_below@@ </h>
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
      @@by@@ :<xsl:value-of select="item_loan/author"/>
      <br />
      @@library@@ :<xsl:value-of select="organization_unit/name"/>
      <br />
      @@loan_date@@ :<xsl:value-of select="item_loan/loan_date"/>
      <br />
      @@due_date@@ :<xsl:value-of select="item_loan/due_date"/>
      <br />
      @@barcode@@ :<xsl:value-of select="item_loan/barcode"/>
      <br />
      @@call_number@@ :<xsl:value-of select="phys_item_display/call_number"/>
      <br />
      <br />
      </td>
     </tr>
    </table>
    </xsl:for-each>

    <xsl:choose>
      <xsl:when test="notification_data/item_loan/process_status = 'RECALLED'">
    <xsl:if test="notification_data/receivers/receiver/preferred_language = 'no'"><b>Dette er siste varsel før erstatningskrav</b></xsl:if>
    <xsl:if test="notification_data/receivers/receiver/preferred_language = 'nn'"><b>Dette er siste varsel før erstatningskrav</b></xsl:if>
    <xsl:if test="notification_data/receivers/receiver/preferred_language = 'en'"><b>This is the final notification before the item will be considered lost, and you will be charged with a replacement fee.</b></xsl:if>
    </xsl:when>
    <xsl:otherwise>
    <xsl:if test="notification_data/receivers/receiver/preferred_language = 'no'"><b>Purring</b></xsl:if>
    <xsl:if test="notification_data/receivers/receiver/preferred_language = 'nn'"><b>Purring</b></xsl:if>
    <xsl:if test="notification_data/receivers/receiver/preferred_language = 'en'"><b>Overdue notification</b></xsl:if>
    </xsl:otherwise>
    </xsl:choose>
    
    @@additional_info_1@@
    <br />
    @@additional_info_2@@
    <br />
    </table>

 <!-- Use special email adress if we're at ub.uio.no -->
    
        <xsl:call-template name="lastFooter" /> <!-- footer.xsl -->
         
      


   </body>
 </html>
</xsl:template>

</xsl:stylesheet>