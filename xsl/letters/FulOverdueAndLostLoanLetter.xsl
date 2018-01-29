<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:date="http://exslt.org/dates-and-times"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="date">
<xsl:include href="header.xsl"/>
<xsl:include href="senderReceiver.xsl"/>
<xsl:include href="mailReason.xsl"/>
<xsl:include href="footer.xsl"/>
<xsl:include href="style.xsl"/>
<xsl:include href="recordTitle.xsl"/>

<!-- Templates -->

<!--
  Template to standardize table styling without too much inline code.
  The main reason this template exists is because many email clients ignore
  css classes, so we need to embed inline styling.

  NOTE: If we move this to one of the call_template files, all letters including that template
  must define the ext: namespace prefix:

      xmlns:ext="http://exslt.org/common"
-->
<xsl:template name="default-table-style">
  <xsl:param name="head" />
  <xsl:param name="body" />

  <table cellpadding="5" cellspacing="0" class="listing" width="100%; text-align:left;">
    <thead>
      <tr>
        <xsl:for-each select="ext:node-set($head)/column">
          <th align="left" style="background: #F9F9F9; border-bottom: 1px solid #ccc;">
            <xsl:value-of select="."/>
          </th>
        </xsl:for-each>
      </tr>
    </thead>
    <tbody>
      <xsl:copy-of select="ext:node-set($body)"/>
    </tbody>
  </table>
</xsl:template>


<!--
  Template: formatFineFeeType

  Genererer en brukervennlig forklaring på en gebyrtype, til bruk i gebyrtabellen.
-->
<xsl:template name="formatFineFeeType">
  <xsl:choose>
    <xsl:when test="fine_fee_type = 'LOSTITEMPROCESSFEE'">
      <xsl:call-template name="multilingual"><!-- footer.xsl -->
        <xsl:with-param name="nb" select="'Gebyr'"/>
        <xsl:with-param name="nn" select="'Gebyr'"/>
        <xsl:with-param name="en" select="'Fee'"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="fine_fee_type = 'LOSTITEMREPLACEMENTFEE'">
      <xsl:call-template name="multilingual"><!-- footer.xsl -->
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

<!--
  Template: formatLoan

  Generates rows for the fines/fees associated with a single document/loan.
  Usually there will be either one (LOSTITEMREPLACEMENTFEE) or two rows
  (LOSTITEMREPLACEMENTFEE and LOSTITEMPROCESSFEE).
-->
<xsl:template name="formatLoan">
  <xsl:variable name="loan" select="."/>
  <xsl:variable name="fees" select="count(fines_fees_list/user_fines_fees)"/>
  <xsl:for-each select="fines_fees_list/user_fines_fees">
    <tr>
      <!-- Don't repeat barcode and title for each fine/fee -->
      <xsl:if test="position() = 1">
        <td valign="top">
          <xsl:attribute name="rowspan">
            <xsl:value-of select="$fees"/>
          </xsl:attribute>
          <xsl:value-of select="$loan/item_loan/barcode"/>
        </td>
        <td valign="top">
          <xsl:attribute name="rowspan">
            <xsl:value-of select="$fees"/>
          </xsl:attribute>
          <xsl:value-of select="item_title"/>
        </td>
      </xsl:if>
      <td valign="top" style="white-space: nowrap;">
        <!--<xsl:value-of select="fine_fee_type_display"/>--><!-- Denne er ENSPRÅKLIG, så vi kan ikke bruke den. -->
        <xsl:call-template name="formatFineFeeType"></xsl:call-template>
      </td>
      <!--
      <td valign="top" style="white-space: nowrap;">
        <xsl:value-of select="translate(status_date,'/','.')"/>
      </td>-->
      <td valign="top" style="text-align: right; white-space: nowrap;">
        <xsl:value-of select="fine_fee_ammount/sum"/>,-
      </td>
    </tr>
  </xsl:for-each>
</xsl:template>


<!-- The letter itself -->

<xsl:template match="/">
  <xsl:call-template name="email-template"/><!-- header.xsl -->
</xsl:template>

<xsl:template match="/notification_data">

  <xsl:call-template name="emailLogo"/><!-- mailReason.xsl -->

  <!-- <xsl:call-template name="toWhomIsConcerned"/> -->
  <p style="margin-top: 0;">
    <xsl:call-template name="multilingual"><!-- footer.xsl -->
      <xsl:with-param name="nb" select="'Kjære bruker av biblioteket'"/>
      <xsl:with-param name="nn" select="'Kjære brukar av biblioteket'"/>
      <xsl:with-param name="en" select="'Dear library patron,'"/>
    </xsl:call-template>
  </p>

  <p>
    <xsl:call-template name="multilingual"><!-- footer.xsl -->
      <xsl:with-param name="nb" select="'Følgende lån er ikke blitt returnert etter flere påminnelser. Du mottar derfor nå erstatningskrav for disse.'"/>
      <xsl:with-param name="nn" select="'Følgjande lån er ikkje blitt returnert etter fleire påminningar. Du mottek difor nå erstatningskrav for desse.'"/>
      <xsl:with-param name="en" select="'The following loans have been recalled several times without success. We now consider them lost and invoice you for the replacement costs.'"/>
    </xsl:call-template>
  </p>

  <p>
    <xsl:call-template name="multilingual"><!-- footer.xsl -->
      <xsl:with-param name="nb" select="'Merk at vi frafraller erstatningskravet for et dokument hvis du returnerer det eller kjøper et nytt erstatningseksemplar selv.'"/>
      <xsl:with-param name="nn" select="'Merk at vi fråfaller erstatningskravet for eit dokument hvis du returnerer det eller kjøper eit nytt erstatningseksemplar sjølv.'"/>
      <xsl:with-param name="en" select="'Note that we will waive the replacement cost claim for a document if you return the document or a new replacement copy.'"/>
    </xsl:call-template>

    <xsl:if test="/notification_data/display_list/overdue_and_lost_loan_notification_display/fines_fees_list/user_fines_fees/fine_fee_type = 'LOSTITEMPROCESSFEE'">
      <xsl:call-template name="multilingual"><!-- footer.xsl -->
        <xsl:with-param name="nb" select="' Gebyr må betales uansett.'"/>
        <xsl:with-param name="nn" select="' Gebyr må betalast uansett.'"/>
        <xsl:with-param name="en" select="' Fees must be paid in any case though.'"/>
      </xsl:call-template>
    </xsl:if>
  </p>

  <!-- List of fees -->

  <xsl:call-template name="default-table-style"><!-- footer.xsl -->
    <xsl:with-param name="head">
      <column>@@barcode@@</column>
      <column>@@lost_item@@</column>
      <column>@@fee_type@@</column>
      <column>@@fee_amount@@</column>
    </xsl:with-param>
    <xsl:with-param name="body">
      <xsl:for-each select="display_list/overdue_and_lost_loan_notification_display">
        <xsl:call-template name="formatLoan"></xsl:call-template>
      </xsl:for-each>
    </xsl:with-param>
  </xsl:call-template>

  <!-- Sum -->

  <p>
    <xsl:call-template name="multilingual"><!-- footer.xsl -->
      <xsl:with-param name="nb" select="'Sum: '"/>
      <xsl:with-param name="nn" select="'Sum: '"/>
      <xsl:with-param name="en" select="'Sum: '"/>
    </xsl:call-template>
    <xsl:value-of select="format-number(sum(display_list/overdue_and_lost_loan_notification_display/fines_fees_list/user_fines_fees/fine_fee_ammount/sum), '0.00 NOK')"/>
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