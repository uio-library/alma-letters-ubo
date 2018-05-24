<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:date="http://exslt.org/dates-and-times"
  extension-element-prefixes="date">
<xsl:include href="header.xsl"/>
<xsl:include href="senderReceiver.xsl"/>
<xsl:include href="mailReason.xsl"/>
<xsl:include href="footer.xsl"/>
<xsl:include href="style.xsl"/>
<xsl:include href="recordTitle.xsl"/>

<!-- Templates -->

<!--
  Template: checkDueDate

  Formats a date with red text color if in the past.
-->
<xsl:template name="checkDueDate">
  <xsl:param name="dueDate" />
  <xsl:variable name="today" select="translate(substring-before(date:date-time(),'T'),'-','')"/>
  <xsl:variable name="dueDateCompact" select="concat(substring($dueDate, 7), substring($dueDate, 4, 2), substring($dueDate, 1, 2))"/>
  <xsl:choose>
    <xsl:when test="number($dueDateCompact) &lt; number($today)">
      <span style="color:#dd0000">
        <xsl:value-of select="translate($dueDate,'/','.')"/>
      </span>
    </xsl:when>
    <xsl:otherwise>
      <span>
        <xsl:value-of select="translate($dueDate,'/','.')"/>
      </span>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!--
  Template: formatProcessStatus

  Genererer en brukervennlig status for et lån, til bruk i utlånstabellen.

  Ved oppdatering av denne malen kan det være lurt å også ta en sjekk på tilsvarende
  maler i FulUserOverdueNoticeLetter.xsl og FulOverdueAndLostLoanNotificationLetter.xsl,
  men merk at logikken i malene er litt forskjellig.
-->
<xsl:template name="formatProcessStatus">
  <xsl:choose>
    <xsl:when test="process_status = 'LOST'">
      <xsl:call-template name="multilingual"><!-- header.xsl -->
        <xsl:with-param name="nb" select="'Må leveres snarest, erstatningskrav sendt'"/>
        <xsl:with-param name="nn" select="'Må leverast snarast, erstatningskrav sendt'"/>
        <xsl:with-param name="en" select="'Must be returned immediately, lost item bill sent'"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="process_status = 'RECALL'">
      <xsl:call-template name="multilingual"><!-- header.xsl -->
        <xsl:with-param name="nb" select="'Andre lånere venter'"/>
        <xsl:with-param name="nn" select="'Andre lånere venter'"/>
        <xsl:with-param name="en" select="'Other patrons are waiting'"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="starts-with(barcode, 'RS-')">
      <!-- Innlån utland -->
      <xsl:call-template name="multilingual"><!-- header.xsl -->
        <xsl:with-param name="nb" select="'Kontakt biblioteket'"/>
        <xsl:with-param name="nn" select="'Kontakt biblioteket'"/>
        <xsl:with-param name="en" select="'Contact the library'"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="contains(location_name, 'Fjernlån')">
      <xsl:call-template name="multilingual"><!-- header.xsl -->
        <xsl:with-param name="nb" select="'Fornybar'"/><!-- Fornyes i Oria? -->
        <xsl:with-param name="nn" select="'Fornybar'"/>
        <xsl:with-param name="en" select="'Renewable'"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="multilingual"><!-- header.xsl -->
        <xsl:with-param name="nb" select="'Fornybar'"/><!-- Fornyes automatisk? -->
        <xsl:with-param name="nn" select="'Fornybar'"/>
        <xsl:with-param name="en" select="'Renewable'"/><!-- Renewed automatically -->
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
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
        <xsl:with-param name="en" select="'Processing fee'"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="fine_fee_type = 'LOSTITEMREPLACEMENTFEE'">
      <xsl:call-template name="multilingual"><!-- header.xsl -->
        <xsl:with-param name="nb" select="'Erstatningskrav'"/>
        <xsl:with-param name="nn" select="'Erstatningskrav'"/>
        <xsl:with-param name="en" select="'Lost item bill'"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="multilingual"><!-- header.xsl -->
        <xsl:with-param name="nb" select="'Annet'"/>
        <xsl:with-param name="nn" select="'Anna'"/>
        <xsl:with-param name="en" select="'Other'"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<!--
  Template: formatLoan

  Generates a row in the loans table.
-->
<xsl:template name="formatLoan">
  <tr>
    <td valign="top">
      <xsl:value-of select="title"/>
      <xsl:if test="description != ''">
        <br />(<xsl:value-of select="description"/>)
      </xsl:if>
      <br /><!-- linjeskift for RT -->
    </td>
    <td valign="top" style="white-space: nowrap;">
      <xsl:call-template name="checkDueDate">
        <xsl:with-param name="dueDate" select="due_date"/>
      </xsl:call-template>
      <br /><!-- linjeskift for RT -->
    </td>
    <td valign="top">
      <xsl:call-template name="formatProcessStatus"></xsl:call-template>
      <br /><!-- linjeskift for RT -->
    </td>
    <td valign="top">
      <br /><!-- linjeskift for RT -->
    </td>
  </tr>
</xsl:template>


<!--
  Template: formatFee

  Generates a row in the fees table.
-->
<xsl:template name="formatFee">
  <tr>
    <td valign="top" style="white-space: nowrap;">
      <xsl:call-template name="formatFineFeeType"></xsl:call-template>
      <br /><!-- linjeskift for RT -->
    </td>
    <td valign="top">
      <xsl:value-of select="item_title"/>
      <br /><!-- linjeskift for RT -->
    </td>
    <td valign="top" style="white-space: nowrap;">
      <xsl:value-of select="translate(status_date,'/','.')"/>
      <br /><!-- linjeskift for RT -->
    </td>
    <td valign="top" style="text-align: right; white-space: nowrap;">
      <xsl:call-template name="formatDecimalNumber"><!-- header.xsl -->
        <xsl:with-param name="value" select="fine_fee_ammount/sum"/>
      </xsl:call-template>
      <br /><!-- linjeskift for RT -->
    </td>
    <td valign="top">
      <br /><!-- linjeskift for RT -->
    </td>
  </tr>
</xsl:template>


<!-- The letter itself -->

<xsl:template match="/">
  <xsl:call-template name="emailTemplate"/><!-- style.xsl -->
</xsl:template>

<xsl:template match="/notification_data">

  <xsl:call-template name="dearLibraryPatron"/><!-- mailReason.xsl -->

  <p>
    <xsl:call-template name="multilingual"><!-- header.xsl -->
      <xsl:with-param name="nb" select="'Vi ønsker å gjøre det enklest mulig for deg å holde oversikt over dine låneaktiviteter. Under finner du en oversikt over hvilke lån som er registrert på din bruker og forfallsdato for disse. Lån med status «Fornybar» vil bli fornyet automatisk.'"/>
      <xsl:with-param name="nn" select="'Vi ynskjer å gjere det enklast mogleg for deg å halde oversikt over låneaktivitetane dine!'"/>
      <xsl:with-param name="en" select="'Please find below a list of your current loans at the University of Oslo Library and their due dates. Loans marked as ‘Renewable’ will be renewed automatically.'"/>
    </xsl:call-template>
  </p>

  <!-- First part: List of loans -->
  <xsl:choose>
    <xsl:when test="overdue_item_loans/item_loan or item_loans/item_loan">

      <h3>@@loans@@</h3>

      <table cellpadding="5" cellspacing="0" class="listing" width="100%">
        <xsl:attribute name="style">
          <xsl:call-template name="mainTableStyleCss"/><!-- style.xsl -->
        </xsl:attribute>
        <tr>
          <th align="left">
            @@title@@
            <br /><!-- linjeskift for RT -->
          </th>
          <th align="left">
            @@due_date@@
            <br /><!-- linjeskift for RT -->
          </th>
          <th align="left">
            Status
            <br /><!-- linjeskift for RT -->
          </th>
          <th>
            <br /><!-- linjeskift for RT -->
          </th>
        </tr>

        <!-- List overdue loans first -->
        <xsl:for-each select="overdue_item_loans/item_loan">
          <xsl:sort select="concat(substring(due_date, 7, 4), substring(due_date, 4, 2), substring(due_date, 1, 2))"
                    order="ascending" data-type="number" />
          <xsl:call-template name="formatLoan"></xsl:call-template>
        </xsl:for-each>

        <!-- Then regular loans -->
        <xsl:for-each select="item_loans/item_loan">
          <xsl:sort select="concat(substring(due_date, 7, 4), substring(due_date, 4, 2), substring(due_date, 1, 2))"
                    order="ascending" data-type="number" />
          <xsl:call-template name="formatLoan"></xsl:call-template>
        </xsl:for-each>

      </table>
    </xsl:when>
    <xsl:otherwise>
      <em>
        <xsl:call-template name="multilingual"><!-- header.xsl -->
          <xsl:with-param name="nb" select="'Du har ingen ingen aktive lån'"/>
          <xsl:with-param name="nn" select="'Du har ingen ingen aktive lån'"/>
          <xsl:with-param name="en" select="'You have no active loans'"/>
        </xsl:call-template>
      </em>
    </xsl:otherwise>
  </xsl:choose>

  <!-- Second part: List of fees -->
  <xsl:if test="organization_fee_list/string">

    <h3>@@debt_message@@</h3>

    <table cellpadding="5" cellspacing="0" class="listing" width="100%">
      <xsl:attribute name="style">
        <xsl:call-template name="mainTableStyleCss"/><!-- style.xsl -->
      </xsl:attribute>
      <tr>
        <th align="left">
          Type
          <br /><!-- linjeskift for RT -->
        </th>
        <th align="left">
          @@title@@
          <br /><!-- linjeskift for RT -->
        </th>
        <th align="left">
          @@due_date@@
          <br /><!-- linjeskift for RT -->
        </th>
        <th align="right" style="text-align: right;">
          @@fine@@
          <br /><!-- linjeskift for RT -->
        </th>
      </tr>
      <xsl:for-each select="loans_by_library/library_loans_for_display/item_loans/overdue_and_lost_loan_notification_display/fines_fees_list/user_fines_fees">
        <xsl:if test="fine_fee_ammount/sum != '0.00'">
          <xsl:choose>
            <xsl:when test="fine_fee_type = 'LOSTITEMREPLACEMENTFEE'">
              <xsl:if test="not(/notification_data/loans_by_library/library_loans_for_display/item_loans/overdue_and_lost_loan_notification_display/fines_fees_list/user_fines_fees[./item_loan_id = current()/item_loan_id and ./fine_fee_type = 'CREDIT'])">
                <!-- Vi trekker fra hvis det finnes en matchende CREDIT. OBS: Hvis en bok settes til lost, gjenfinnes og så til lost igjen blir denne testen litt for enkel. -->
                <xsl:call-template name="formatFee"></xsl:call-template>
              </xsl:if>
            </xsl:when>
            <xsl:when test="fine_fee_type = 'CREDIT'">
              <!-- IGNORE -->
            </xsl:when>
            <xsl:otherwise>
              <xsl:call-template name="formatFee"></xsl:call-template>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>
      </xsl:for-each>

      <xsl:variable name="totalFeeAsNumber">
        <!--
            Utfordring: total_fee er en ferdigformatert streng på brukerens eget språk.
            Eks: "1,600.00 NOK" på engelsk, "1 600,00 NOK" på norsk.
            For å kunne regne med denne må vi derfor først normalisere den.
            Merk at mellomrommet i den norske strengen er et hardt mellomrom.
        -->
        <xsl:call-template name="string-replace">
          <xsl:with-param name="string" select="translate(substring-before(total_fee,'00 NOK'), ',. ', '')"/>
          <xsl:with-param name="replace" select="'&#160;'"/>
          <xsl:with-param name="with" select="''"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="remainderFee">
        <!--
            Gebyrer for leverte dokumenter er ikke med i XML-en og vises derfor ikke i tabellen vår.
            For å få summen av disse til å gå opp med totalsummen (som er med i XML-en),
            regner vi ut differansen og viser dette som "Eldre gebyrer".
        -->
        <xsl:value-of select="$totalFeeAsNumber - sum(/notification_data/loans_by_library/library_loans_for_display/item_loans/overdue_and_lost_loan_notification_display/fines_fees_list/user_fines_fees/fine_fee_ammount/sum)"/>
      </xsl:variable>

      <xsl:if test="$remainderFee != 0.0">
        <tr>
          <td>
            <xsl:call-template name="multilingual"><!-- header.xsl -->
              <xsl:with-param name="nb" select="'Eldre gebyrer'"/>
              <xsl:with-param name="nn" select="'Eldre gebyr'"/>
              <xsl:with-param name="en" select="'Older fees'"/>
            </xsl:call-template>
          </td>
          <td>
            &#160;
          </td>
          <td>
            &#160;
          </td>
          <td style="text-align: right; white-space: nowrap;">
            <xsl:call-template name="formatDecimalNumber"><!-- header.xsl -->
              <xsl:with-param name="value" select="$remainderFee"/>
            </xsl:call-template>
          </td>
        </tr>
      </xsl:if>

    </table>

    <!-- Omsider: Grand totale! -->
    <p>
      <xsl:call-template name="multilingual"><!-- header.xsl -->
        <xsl:with-param name="nb" select="'Totalt kr '"/>
        <xsl:with-param name="nn" select="'Totalt kr '"/>
        <xsl:with-param name="en" select="'Sum: NOK '"/>
      </xsl:call-template>
      <xsl:call-template name="formatDecimalNumber"><!-- header.xsl -->
        <xsl:with-param name="value" select="translate(substring-before(total_fee,'00 NOK'), ',. ', '')"/>
      </xsl:call-template>
    </p>

    <p>
      <xsl:if test="item_loans/item_loan/process_status = 'LOST' or overdue_item_loans/item_loan/process_status = 'LOST'">
        <xsl:call-template name="multilingual"><!-- header.xsl -->
          <!-- TODO: Endre til noe ála «Merk at erstatningskrav frafaller hvis du leverer dokumentet eller kjøper nytt eksemplar. Gebyret må betales uansett.  -->
          <xsl:with-param name="nb" select="'Merk at erstatningskrav frafaller hvis du leverer dokumentet eller kjøper nytt eksemplar. Gebyr må betales uansett. '"/>
          <xsl:with-param name="nn" select="'Du må anten levere dokumentet, kjøpe nytt eksemplar eller betale erstatningskrav. '"/>
          <xsl:with-param name="en" select="'You must either return the document, buy a new one or pay the replacement cost. '"/>
        </xsl:call-template>
      </xsl:if>
    </p>

    <xsl:call-template name="payment-details"></xsl:call-template><!-- footer.xsl -->

  </xsl:if>

  <xsl:call-template name="email-footer"><!-- footer.xsl -->
    <xsl:with-param name="show_my_account" select="true()"/>
  </xsl:call-template>

</xsl:template>
</xsl:stylesheet>