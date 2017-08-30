<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet exclude-result-prefixes="java" version="1.0" xmlns:java="http://xml.apache.org/xslt/java" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="header.xsl"/>
<xsl:include href="senderReceiver.xsl"/>
<xsl:include href="mailReason.xsl"/>
<xsl:include href="footer.xsl"/>
<xsl:include href="style.xsl"/>
<xsl:include href="recordTitle.xsl"/>

<xsl:template match="/">
  <xsl:call-template name="email-template"/><!-- header.xsl -->
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
      <xsl:when test="request/delivery_address != ''">
        <xsl:value-of select="request/delivery_address"/>
      </xsl:when>
      <xsl:otherwise>
        <!-- Physical non-returnable -->
        <xsl:value-of select="phys_item_display/owning_library_name"/>
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
      <xsl:call-template name="pickupNumberWithLabel"/><!-- mailReason.xsl -->
    </p>
  </xsl:if>
  <!-- ===========================================================
       SLUTT: Hentekode eller informasjon om henting
       =========================================================== -->

  <!-- Examples of "system notes" (notes that may affect the loan):
        - "Cash - Limit of 200.00 NOK exceeded. User has 2,250.00 NOK."
        - "Patron is not active"
   -->
  <xsl:if test="/notification_data/request/system_notes != ''">
    <p>
      @@notes_affect_loan@@: <xsl:value-of select="/notification_data/request/system_notes"/>
    </p>
  </xsl:if>

  <xsl:if test="request/work_flow_entity/expiration_date != ''">
    <p>
      @@note_item_held_until@@
      <xsl:call-template name="stdDate"><!-- Defined in header.xsl -->
        <xsl:with-param name="value" select="request/work_flow_entity/expiration_date"/>
      </xsl:call-template>.
    </p>
  </xsl:if>

  <xsl:choose>
    <xsl:when test="/notification_data/request/delivery_address != ''">
      <xsl:call-template name="email-footer">
        <xsl:with-param name="sender_name" select="/notification_data/request/delivery_address" />
        <xsl:with-param name="email" select="'oria-hjelp@ub.uio.no'" />
      </xsl:call-template><!-- footer.xsl -->
    </xsl:when>
    <xsl:otherwise>
      <!-- Physical non-returnable -->
      <xsl:call-template name="email-footer">
        <xsl:with-param name="sender_name" select="/notification_data/phys_item_display/owning_library_name" />
        <xsl:with-param name="email" select="'oria-hjelp@ub.uio.no'" />
      </xsl:call-template><!-- footer.xsl -->
    </xsl:otherwise>
  </xsl:choose>

</xsl:template>
</xsl:stylesheet>
