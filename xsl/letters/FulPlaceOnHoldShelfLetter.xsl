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

  <xsl:call-template name="email-logo"/><!-- header.xsl -->
  <xsl:call-template name="toWhomIsConcerned"/><!-- mailReason.xsl -->

  <!-- Materialet du bestilte (dato) kan nå hentes i (ditt bibliotek) -->
  <p>
    @@following_item_requested_on@@
    <xsl:value-of select="request/create_date"/>,
    @@can_picked_at@@

    <xsl:choose>
      <xsl:when test="request/delivery_address != ''">
        <xsl:value-of select="request/delivery_address"/>
      </xsl:when>
      <xsl:otherwise>
        <!-- Physical non-returnable -->
        <xsl:value-of select="phys_item_display/owning_library_name"/>
      </xsl:otherwise>
    </xsl:choose>.
  </p>

  <!-- ===========================================================
       START: Hentehylle
       =========================================================== -->
  <xsl:if test="notification_data/request/work_flow_entity/expiration_date">
    <p>
      <b>
        <xsl:call-template name="pickupNumberWithLabel"/><!-- mailReason.xsl -->
      </b>
    </p>
  </xsl:if>
  <!-- ===========================================================
       SLUTT: Hentehylle
       =========================================================== -->


  <div style="padding: 0 1.8em;">
    <xsl:call-template name="recordTitle"/><!-- recordTitle.xsl -->
  </div>

  <xsl:if test="request/work_flow_entity/expiration_date != ''">
    <p>
      @@note_item_held_until@@
      <xsl:value-of select="request/work_flow_entity/expiration_date"/>.
    </p>
  </xsl:if>
  
  <xsl:if test="request/system_notes != ''">
    <p>
      <b>@@notes_affect_loan@@:</b>
    </p>
    <p>
      <xsl:value-of select="request/system_notes"/>
    </p>
  </xsl:if>

  <xsl:call-template name="email-footer"/><!-- footer.xsl -->

</xsl:template>
</xsl:stylesheet>