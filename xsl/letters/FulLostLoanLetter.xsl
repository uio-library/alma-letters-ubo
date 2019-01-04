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


<!--
  Template: formatFineFeeType

  Genererer en brukervennlig forklaring på en gebyrtype, til bruk i gebyrtabellen.
-->
<xsl:template name="formatFineFeeType">
  <xsl:choose>
    <xsl:when test="fine_fee_type = 'LOSTITEMPROCESSFEE'">
      <xsl:call-template name="multilingual"><!-- header.xsl -->
        <xsl:with-param name="nb" select="'Gebyr'"/>
        <xsl:with-param name="nn" select="'Gebyr'"/>
        <xsl:with-param name="en" select="'Fee'"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="fine_fee_type = 'LOSTITEMREPLACEMENTFEE'">
      <xsl:call-template name="multilingual"><!-- header.xsl -->
        <xsl:with-param name="nb" select="'Erstatningskrav'"/>
        <xsl:with-param name="nn" select="'Erstatningskrav'"/>
        <xsl:with-param name="en" select="'Replacement cost'"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="fine_fee_type_display"/>
    </xsl:otherwise>
  </xsl:choose>
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
    @@due_date@@:
    <xsl:call-template name="stdDate"><!-- header.xsl -->
      <xsl:with-param name="value" select="item_loan/due_date"/>
    </xsl:call-template>
  </div>

  <p>
    <xsl:call-template name="multilingual"><!-- header.xsl -->
      <xsl:with-param name="nb" select="'Vi frafraller erstatningskravet hvis du returnerer dokumentet eller kjøper nytt erstatningseksemplar selv.'"/>
      <xsl:with-param name="nn" select="'Vi fråfaller erstatningskravet hvis du returnerer dokumentet eller kjøper nytt erstatningseksemplar sjølv.'"/>
      <xsl:with-param name="en" select="'The replacement cost is waived if you return the document or buy a new replacement copy.'"/>
    </xsl:call-template>

    <xsl:if test="fines_fees_list/user_fines_fees/fine_fee_type = 'LOSTITEMPROCESSFEE'">
      <xsl:call-template name="multilingual"><!-- header.xsl -->
        <xsl:with-param name="nb" select="' Gebyret på 250 kr må betales uansett.'"/>
        <xsl:with-param name="nn" select="' Gebyret på 250 kr må betalast uansett.'"/>
        <xsl:with-param name="en" select="' You will still owe the NOK 250 fee.'"/>
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
        <td>
          <xsl:call-template name="formatFineFeeType"></xsl:call-template>
          <br /><!-- linjeskift for RT -->
        </td>
        <td valign="top" style="text-align: right; white-space: nowrap;">
          <xsl:call-template name="formatDecimalNumber"><!-- header.xsl -->
            <xsl:with-param name="value" select="fine_fee_ammount/sum"/>
          </xsl:call-template>
          <br /><!-- linjeskift for RT -->
        </td>
        <td>
          <xsl:value-of select="ff"/>
        </td>
      </tr>
    </xsl:for-each>
  </table>

  <!-- Sum -->
  <p>
    <xsl:call-template name="multilingual"><!-- header.xsl -->
      <xsl:with-param name="nb" select="'Totalt kr '"/>
      <xsl:with-param name="nn" select="'Totalt kr '"/>
      <xsl:with-param name="en" select="'Sum: NOK '"/>
    </xsl:call-template>
    <xsl:call-template name="formatDecimalNumber"><!-- header.xsl -->
      <xsl:with-param name="value" select="sum(fines_fees_list/user_fines_fees/fine_fee_ammount/sum)"/>
    </xsl:call-template>
  </p>

  <!-- Payment details -->

  <xsl:call-template name="payment-details"></xsl:call-template><!-- footer.xsl -->

  <!-- Footer -->

  <xsl:call-template name="email-footer"><!-- footer.xsl -->
    <xsl:with-param name="show_my_account" select="true()"/>
  </xsl:call-template>

</xsl:template>

</xsl:stylesheet>