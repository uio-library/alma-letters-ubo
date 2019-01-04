<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:date="http://exslt.org/dates-and-times"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="date ext">
<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />
<xsl:include href="recordTitle.xsl" />

<xsl:template match="/">

  <xsl:if test="/notification_data/request/status_note = 'ConvertedToResourceSharingRequest'">
    <xsl:message terminate="yes">Converted to Resource Sharing Request - No automatic cancellation letter sent</xsl:message>
  </xsl:if>
  <xsl:if test="/notification_data/request/status_note = 'RejectedBySupplier'">
    <xsl:message terminate="yes">Deaktivert inntil videre</xsl:message>
  </xsl:if>
  <xsl:call-template name="emailTemplate"/><!-- style.xsl -->
</xsl:template>

<xsl:template match="/notification_data">

  <xsl:call-template name="emailLogo"/><!-- mailReason.xsl -->

  <p>
    <xsl:call-template name="multilingual"><!-- header.xsl -->
      <xsl:with-param name="nb" select="'Hei '"/>
      <xsl:with-param name="nn" select="'Hei '"/>
      <xsl:with-param name="en" select="'Hi '"/>
    </xsl:call-template>
    <xsl:value-of select="receivers/receiver/user/first_name"/>&#160;<xsl:value-of select="receivers/receiver/user/last_name"/>
    (<xsl:value-of select="receivers/receiver/user/user_name"/>)
  </p>

  <p>
    <xsl:choose>
      <xsl:when test="request/status_note = 'CancelledAtPatronRequest'">
        <xsl:call-template name="multilingual"><!-- header.xsl -->
          <xsl:with-param name="nb" select="'Dette er en bekreftelse på at vi har kansellert bestilllingen din:'"/>
          <xsl:with-param name="nn" select="'Dette er ei stadfesting på at vi har kansellert bestilllinga di:'"/>
          <xsl:with-param name="en" select="'This is to confirm that we have cancelled your request:'"/>
        </xsl:call-template>
     </xsl:when>
     <xsl:otherwise>
       @@we_cancel_y_req_of@@ <xsl:value-of select="request/create_date"/> @@detailed_below@@:
     </xsl:otherwise>
    </xsl:choose>
  </p>
  <ul>
    <li>
      <xsl:if test="phys_item_display/author != ''">
        <xsl:value-of select="phys_item_display/author"/>:&#160;
      </xsl:if>
      <em><xsl:value-of select="phys_item_display/title"/></em>
      (<xsl:value-of select="phys_item_display/edition"/><xsl:if test="phys_item_display/edition != ''">&#160;
       </xsl:if><xsl:value-of select="phys_item_display/publication_date"/>)
      <xsl:if test="phys_item_display/issn != ''">
        <br />ISSN: <xsl:value-of select="phys_item_display/issn"/>
      </xsl:if>
      <xsl:if test="phys_item_display/isbn != ''">
        <br />ISBN: <xsl:value-of select="phys_item_display/isbn"/>
      </xsl:if>
      <xsl:if test="request/external_request_id != ''">
        <br />Bestillingsnummer: <xsl:value-of select="request/external_request_id"/>
      </xsl:if>
    </li>
  </ul>

  <p>
    <xsl:choose>
     <xsl:when test="request/status_note = 'CannotBeFulfilled'">
      <xsl:call-template name="multilingual"><!-- header.xsl -->
        <xsl:with-param name="nb" select="'Vi kan dessverre ikke gjennomføre denne bestilllingen.'"/>
        <xsl:with-param name="nn" select="'Vi kan dessverre ikkje gjennomføre denne bestilllinga.'"/>
        <xsl:with-param name="en" select="'Unfortunately we cannot fulfill this request.'"/>
      </xsl:call-template>
     </xsl:when>
     <xsl:when test="request/status_note = 'RequestedMaterialCannotBeLocated'">
       <xsl:choose>
        <xsl:when test="receivers/receiver/preferred_language = 'en'">
         Unfortunately the document could not be found at the shelf.
         It's still possible that there are copies in other libraries in Norway or elsewhere
         that we can borrow for you (free of charge).
         Please contact us using the email adress below if you want us to check this.
        </xsl:when>
        <xsl:otherwise>
         Dokumentet ble dessverre ikke funnet på hylla.
         Det kan imidlertid være det finnes eksemplarer ved andre bibliotek i Norge eller
         utlandet som vi kan få lånt inn.
         Kontakt oss på epostadressen under hvis du ønsker at vi skal sjekke dette for deg.
        </xsl:otherwise>
       </xsl:choose>
     </xsl:when>
     <xsl:when test="request/status_note = 'CancelledAtPatronRequest'">
      <!-- Hvis det er etter låners ønske trenger vi ikke si "Årsak: Kansellert på låntakers anmodning." -->
     </xsl:when>
     <xsl:otherwise>
      @@reason_deleting_request@@:
      <xsl:value-of select="request/status_note_display"/>.
     </xsl:otherwise>
    </xsl:choose>
  </p>

  <!-- "Cancellation note" havner her -->
  <xsl:if test="request/system_notes != ''">
    <p>
      <strong><xsl:value-of select="request/system_notes"/></strong>
    </p>
  </xsl:if>

  <xsl:call-template name="email-footer"><!-- footer.xsl -->
    <xsl:with-param name="show_my_account" select="true()"/>
  </xsl:call-template>

</xsl:template>
</xsl:stylesheet>