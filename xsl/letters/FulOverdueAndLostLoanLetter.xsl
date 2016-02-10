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
     <h>@@borrowed_by_you@@ @@decalred_as_lost@@</h>
    </td>
    </tr>
    </table>

    <table cellpadding="5" class="listing">
    <xsl:attribute name="style">
     <xsl:call-template name="mainTableStyleCss" /> <!-- style.xsl -->
    </xsl:attribute>

    <xsl:for-each select="notification_data/display_list/overdue_and_lost_loan_notification_display">
    <table>
     <tr>
      <td>
      <b>@@lost_item@@ :</b> <xsl:value-of select="item_loan/title"/>
      <br />
      <b>@@description@@ :</b><xsl:value-of select="item_loan/description"/>
      <br />
      <b> @@by@@ :</b><xsl:value-of select="item_loan/author"/>
      <br />
      <b>@@library@@ :</b><xsl:value-of select="physical_item_display_for_printing/library_name"/>
      <br />
      <b>@@loan_date@@ :</b><xsl:value-of select="item_loan/loan_date"/>
      <br />
      <b>@@due_date@@ :</b><xsl:value-of select="item_loan/due_date"/>
      <br />
      <b>@@barcode@@ :</b><xsl:value-of select="item_loan/barcode"/>
      <br />
      <b>@@call_number@@ :</b><xsl:value-of select="physical_item_display_for_printing/call_number"/>
      <br />
      <b>@@charged_with_fines_fees@@ </b>
      <br />
      <xsl:for-each select="fines_fees_list/user_fines_fees">
       <b><xsl:value-of select="fine_fee_type"/> :</b><xsl:value-of select="fine_fee_ammount/sum"/>&#160;<xsl:value-of select="fine_fee_ammount/currency"/>&#160;<xsl:value-of select="ff"/>
      <br />
      </xsl:for-each>
      </td>
     </tr>
    </table>

    </xsl:for-each>


    <br />
    <br />
    @@additional_info_1@@
    <br />
    @@additional_info_2@@
    <br />
    <table>

      

    </table>
    </table>
   

    <xsl:call-template name="lastFooter" /> <!-- footer.xsl -->
   </body>
 </html>
</xsl:template>

</xsl:stylesheet>