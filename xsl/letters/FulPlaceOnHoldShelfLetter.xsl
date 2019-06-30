<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:date="http://exslt.org/dates-and-times"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="date ext">
<xsl:include href="header.xsl"/>
<xsl:include href="senderReceiver.xsl"/>
<xsl:include href="mailReason.xsl"/>
<xsl:include href="footer.xsl"/>
<xsl:include href="style.xsl"/>
<xsl:include href="recordTitle.xsl"/>

<xsl:template match="/">
  <xsl:call-template name="emailTemplate"/><!-- style.xsl -->
</xsl:template>

<xsl:template match="/notification_data">

  <xsl:call-template name="emailLogo"/><!-- mailReason.xsl -->
  <xsl:call-template name="toWhomIsConcerned"/><!-- mailReason.xsl -->

  <!--
    en: The following item is ready for pick up at {your library}:
    nb: Følgende er klar til henting i {navn på bibliotek}:
    nn: Følgjande er klar til henting i {navn på bibliotek}:
  -->
  <p>
    @@following_item_requested_on@@
    <xsl:choose>
      <xsl:when test="starts-with(/notification_data/request/calculated_destination_name, 'UiO Realfagsbiblioteket') or starts-with(/notification_data/request/calculated_destination_name, 'UiO Informatikkbiblioteket')">
        UiO HumSam-biblioteket (Georg Sverdrups hus)
      </xsl:when>
      <xsl:when test="/notification_data/outgoing/format = 'PHYSICAL_NON_RETURNABLE'">

        <xsl:value-of select="/notification_data/phys_item_display/owning_library_name"/>
        <!-- Vi kunne også brukt `outgoing/pickup_location_str` her, men bruker
             i stedet `phys_item_display/owning_library_name` fordi denne ikke inkluderer skrankenavn.
             Eksempel:
             - 'phys_item_display/owning_library_name' : 'UiO Realfagsbiblioteket'
             - 'outgoing/pickup_location_str'          : 'UiO Realfagsbiblioteket – Utlånet Ureal'
        -->

      </xsl:when>
      <xsl:otherwise>

        <xsl:value-of select="/notification_data/request/delivery_address"/>

      </xsl:otherwise>
    </xsl:choose>:
  </p>

  <div style="padding: 0 1.2em; border-left:5px solid #eee;">
    <xsl:call-template name="recordTitle"/><!-- recordTitle.xsl -->
  </div>

  <!-- ===========================================================
       START: Hentekode eller informasjon om henting
       =========================================================== -->
  <xsl:if test="/notification_data/request/work_flow_entity/expiration_date">
    <p>
      <xsl:call-template name="pickupNumberWithLabel"/><!-- header.xsl -->
    </p>
  </xsl:if>
  <!-- ===========================================================
       SLUTT: Hentekode eller informasjon om henting
       =========================================================== -->

  <!--
    # System_notes (notes that may affect the loan):

    Eksempler:
        - "Cash - Limit of 200.00 NOK exceeded. User has 2,250.00 NOK."
        - "Patron is not active"
        - "Loan - Siste varsel før erstatningskrav . Block created by 'Loans - Overdue and Lost Item' job. Job ID: 8419699160002204."

    Disse har ikke en form som egner seg for sluttbrukerkommunikasjon, og de er heller
    ikke alltid aktuelle for det relevante lånet. Vi viser dem derfor ikke i hentebrevet.

    @TODO: Vi kunne heller vist en egen melding hvis brukeren skylder mer enn grensen (200 kr).

    <xsl:if test="/notification_data/request/system_notes != ''">
      <p>
        @@notes_affect_loan@@: <xsl:value-of select="/notification_data/request/system_notes"/>
      </p>
    </xsl:if>
  -->

  <!--
    ## Hentefrist

    - 2018-01: Vi har 5 dagers hold shelf period konfigurert for circ-deskene, men lar
               innlånte bøker stå lenger, inntil 28 dager hvis det er plass. For å ikke
               gjøre dette altfor komplisert skjuler vi bare hentefristen for innlånte bøker.
  -->
  <xsl:if test="/notification_data/request/work_flow_entity/expiration_date != '' and not(contains(/notification_data/phys_item_display/location_name, 'Fjernlån'))">
    <p>
      @@note_item_held_until@@
      <xsl:call-template name="stdDate"><!-- header.xsl -->
        <xsl:with-param name="value" select="request/work_flow_entity/expiration_date"/>
      </xsl:call-template>.
    </p>
  </xsl:if>

  <!-- Fulfillment note: Informasjon om lesesalslån o.l. -->
  <xsl:if test="/notification_data/phys_item_display/fulfillment_note != ''">
    <p>
      <xsl:value-of select="/notification_data/phys_item_display/fulfillment_note"/>
    </p>
  </xsl:if>

  <xsl:if test="starts-with(/notification_data/request/calculated_destination_name, 'UiO Realfagsbiblioteket')">
    <p>
      <xsl:choose>
        <xsl:when test="/notification_data/receivers/receiver/preferred_language = 'en'">
          <strong>Please note:</strong> The Science Library building will be closed from July 1 to August 4,
          but library services will still be available. We will process requests and e-mails,
          and counter services (pickup, return etc.) will be available through the Humanities
          and Social sciences library in Georg Sverdrups hus.
        </xsl:when>
        <xsl:otherwise>
          <strong>Merk:</strong> Realfagsbiblioteket holder sommerstengt fra 1. juli til 4.august,
          men bibliotekstjenester vil allikevel være tilgjengelige. Vi behandler bestillinger og e-post,
          og henting, retur, etc. kan gjøres ved HumSam-biblioteket i Georg Sverdrups hus.
        </xsl:otherwise>
      </xsl:choose>
    </p>
  </xsl:if>
  <xsl:if test="starts-with(/notification_data/request/calculated_destination_name, 'UiO Informatikkbiblioteket')">
    <p>
      <xsl:choose>
        <xsl:when test="/notification_data/receivers/receiver/preferred_language = 'en'">
          <strong>Please note:</strong> The Informatics Library building will be closed from July 1 to August 4,
          but library services will still be available. We will process requests and e-mails,
          and counter services (pickup, return etc.) will be available through the Humanities
          and Social sciences library in Georg Sverdrups hus.
        </xsl:when>
        <xsl:otherwise>
          <strong>Merk:</strong> Informatikkbiblioteket holder sommerstengt fra 1. juli til 4.august,
          men bibliotekstjenester vil allikevel være tilgjengelige. Vi behandler bestillinger og e-post,
          og henting, retur, etc. kan gjøres ved HumSam-biblioteket i Georg Sverdrups hus.
        </xsl:otherwise>
      </xsl:choose>
    </p>
  </xsl:if>

  <xsl:choose>
    <xsl:when test="/notification_data/request/delivery_address != ''">
      <xsl:call-template name="email-footer">
        <xsl:with-param name="sender_name" select="/notification_data/request/delivery_address" />
      </xsl:call-template><!-- footer.xsl -->
    </xsl:when>
    <xsl:otherwise>
      <!-- Physical non-returnable -->
      <xsl:call-template name="email-footer">
        <xsl:with-param name="sender_name" select="/notification_data/phys_item_display/owning_library_name" />
      </xsl:call-template><!-- footer.xsl -->
    </xsl:otherwise>
  </xsl:choose>

</xsl:template>
</xsl:stylesheet>