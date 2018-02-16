<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:date="http://exslt.org/dates-and-times"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="date ext">
<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl"/>
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />

<xsl:template match="/">
  <xsl:call-template name="emailTemplate"/><!-- style.xsl -->
</xsl:template>

<xsl:template match="/notification_data">

  <xsl:call-template name="dearLibraryPatron"/><!-- mailReason.xsl -->

  <p>
    <xsl:call-template name="multilingual"><!-- header.xsl -->
      <xsl:with-param name="nb" select="'Følgende lån er ikke blitt returnert etter flere påminnelser. Derfor mottar du nå erstatningskrav for dette.'"/>
      <xsl:with-param name="nn" select="'Følgjande lån er ikkje blitt returnert etter fleire påminningar. Derfor mottek du nå erstatningskrav for dette.'"/>
      <xsl:with-param name="en" select="'The following loan has been recalled several times without success. We now consider it lost and invoice you for the replacement cost.'"/>
    </xsl:call-template>
  </p>

  <div style="margin: 0.8em 1.2em;">
    <strong>
      <xsl:value-of select="phys_item_display/title_abcnph"/>
    </strong>
    <br />
    @@barcode@@: <strong><xsl:value-of select="item_loan/barcode"/></strong>
    <br />
    <xsl:if test="item_loan/description != ''">
      @@description@@: <xsl:value-of select="item_loan/description"/>
      <br />
    </xsl:if>
    @@library@@: <xsl:value-of select="organization_unit/name"/>
    <br />
    @@loan_date@@: <xsl:value-of select="item_loan/loan_date"/>
    <br />
    @@due_date@@: <xsl:value-of select="item_loan/due_date"/>
  </div>

  <p>
    <xsl:call-template name="multilingual"><!-- header.xsl -->
      <xsl:with-param name="nb" select="'Merk at vi frafraller erstatningskravet hvis du returnerer det eller kjøper et nytt erstatningseksemplar selv.'"/>
      <xsl:with-param name="nn" select="'Merk at vi fråfaller erstatningskravet hvis du returnerer det eller kjøper eit nytt erstatningseksemplar sjølv.'"/>
      <xsl:with-param name="en" select="'Note that we will waive the replacement cost claim if you return the document or a new replacement copy.'"/>
    </xsl:call-template>

    <xsl:if test="fines_fees_list/user_fines_fees/fine_fee_type = 'LOSTITEMPROCESSFEE'">
      <xsl:call-template name="multilingual"><!-- header.xsl -->
        <xsl:with-param name="nb" select="' Gebyret må betales uansett.'"/>
        <xsl:with-param name="nn" select="' Gebyret må betalast uansett.'"/>
        <xsl:with-param name="en" select="' The processing fee must be paid in any case though.'"/>
      </xsl:call-template>
    </xsl:if>
  </p>

  <table cellpadding="5" cellspacing="0" class="listing" width="100%">
    <tr>
      <th align="left">@@fee_type@@</th>
      <th align="right">@@fee_amount@@</th>
      <th align="left"></th>
    </tr>
    <xsl:for-each select="fines_fees_list/user_fines_fees">
      <tr>
        <td><xsl:value-of select="fine_fee_type_display"/></td>
        <td align="right"><xsl:value-of select="fine_fee_ammount/sum"/>&#160;<xsl:value-of select="fine_fee_ammount/currency"/></td>
        <td><xsl:value-of select="ff"/></td>
      </tr>
    </xsl:for-each>
  </table>

  <!-- Sum -->

  <p>
    <xsl:call-template name="multilingual"><!-- header.xsl -->
      <xsl:with-param name="nb" select="'Sum: '"/>
      <xsl:with-param name="nn" select="'Sum: '"/>
      <xsl:with-param name="en" select="'Sum: '"/>
    </xsl:call-template>
    <xsl:value-of select="format-number(sum(fines_fees_list/user_fines_fees/fine_fee_ammount/sum), '0.00 NOK')"/>
  </p>

  <!-- Payment details -->

  <xsl:call-template name="payment-details"></xsl:call-template><!-- footer.xsl -->

  <!-- Footer -->

  <xsl:call-template name="email-footer"><!-- footer.xsl -->
    <xsl:with-param name="show_my_account" select="true()"/>
    <xsl:with-param name="email" select="'reply'"/>
  </xsl:call-template>

</xsl:template>

</xsl:stylesheet>