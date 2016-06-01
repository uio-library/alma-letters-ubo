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
      <xsl:if test="notification_data/notification_type = 'OverdueNotificationType1'">
       <h>@@inform_you_item_below_type1@@</h> 
    </xsl:if>    
    <xsl:if test="notification_data/notification_type = 'OverdueNotificationType2'">
        <h> @@inform_you_item_below_type2@@</h>  
    </xsl:if> 
    <xsl:if test="notification_data/notification_type = 'OverdueNotificationType3'">
        <h> @@inform_you_item_below_type3@@</h> 
    </xsl:if>    
     
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

    
    <xsl:if test="notification_data/notification_type = 'OverdueNotificationType1'">
       @@decalred_as_lost_type1@@ 
    </xsl:if>
    <xsl:if test="notification_data/notification_type = 'OverdueNotificationType2'">
        @@decalred_as_lost_type2@@ 
    </xsl:if>
    <xsl:if test="notification_data/notification_type = 'OverdueNotificationType3'">
       @@decalred_as_lost_type3@@ 
    </xsl:if>
     

    @@additional_info_1@@
    <br />
    @@additional_info_2@@
    <br />
    </table>
    
        <xsl:call-template name="lastFooter" /> <!-- footer.xsl -->
         
      
   </body>
 </html>
</xsl:template>

</xsl:stylesheet>