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
      <b><xsl:value-of select="phys_item_display/title_abcnph"/></b><br />

       <!-- BEGIN: Extremely crappy workaround for https://github.com/scriptotek/alma-slipsomat/issues/9 -->
       <xsl:if test="phys_item_display/chron_i != ''"><!-- Warning: We assume `chron_i` is always used. Is it? -->
        Issue: <xsl:value-of select="phys_item_display/enum_a"/>

        <xsl:if test="phys_item_display/chron_i != '' and phys_item_display/enum_a != ''">&#160;(</xsl:if>
        <xsl:value-of select="phys_item_display/chron_i"/>
        <xsl:if test="phys_item_display/chron_i != '' and phys_item_display/enum_a != ''">)</xsl:if>

        <xsl:if test="phys_item_display/chron_i != '' and phys_item_display/enum_a = ''">&#160;(</xsl:if>
        <xsl:value-of select="phys_item_display/enum_b"/>
        <xsl:if test="phys_item_display/chron_i != '' and phys_item_display/enum_a = ''">)</xsl:if>

        <br />
      </xsl:if>
      <!-- END: Extremely crappy workaround for https://github.com/scriptotek/alma-slipsomat/issues/9 -->

      <xsl:if test="item_loan/description != ''">
        @@description@@: <xsl:value-of select="item_loan/description"/><br />
      </xsl:if>

      <xsl:if test="item_loan/author != ''">
        @@by@@: <xsl:value-of select="item_loan/author"/><br />
      </xsl:if>

      @@library@@: <xsl:value-of select="organization_unit/name"/>
      <br />

      <xsl:if test="phys_item_display/call_number != ''">
        @@call_number@@: <xsl:value-of select="phys_item_display/call_number"/><br />
      </xsl:if>

      @@barcode@@: <xsl:value-of select="item_loan/barcode"/>
      <br />

      @@loan_date@@: <xsl:value-of select="item_loan/loan_date"/>
      <br />

      @@due_date@@: <xsl:value-of select="item_loan/due_date"/>
      <br />

      <br />
      </td>
     </tr>
    </table>
    </xsl:for-each>

    <xsl:choose>
      <xsl:when test="notification_data/item_loan/process_status = 'RECALL'">
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