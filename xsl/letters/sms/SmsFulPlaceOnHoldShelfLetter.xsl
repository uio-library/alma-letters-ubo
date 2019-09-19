<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:date="http://exslt.org/dates-and-times"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="date ext">
<xsl:include href="header.xsl" />
<xsl:template match="/">

<!--
  Hvem skal ha dokumenter tilsendt med internpost?
  - NHM (Postboks 1172)
-->
<xsl:variable 
  name="internpost"
  select="contains(/notification_data/user_for_printing/address1, 'Postboks 1172')"
/>


<!-- Header -->
<xsl:value-of select="/notification_data/receivers/receiver/user_phone/phone"/>
<xsl:text> : </xsl:text>
<xsl:value-of select="/notification_data/organization_unit/name"/>: <xsl:if test = "notification_data/receivers/receiver/user/user_name"> <xsl:value-of select="notification_data/receivers/receiver/user/user_name"/></xsl:if>
<xsl:text>.&#10;</xsl:text><!-- Line feed -->

<!-- ########################################################################
  Del 1: "På vei" eller "Klar til henting ved ..."
-->
<xsl:choose>

  <!-- Case 1: Dokumenter som skal sendes med internpost -->
  <xsl:when test="$internpost">
    <xsl:call-template name="multilingual">
      <!-- header.xsl -->
      <xsl:with-param name="nb" select="'På vei til deg med internpost'" />
      <xsl:with-param name="nn" select="'På vei til deg med internpost'" />
      <xsl:with-param name="en" select="'Just shipped using internal mail'" />
    </xsl:call-template>
  </xsl:when>

  <!-- Case 2: Artikkelkopier -->
  <xsl:when test="/notification_data/outgoing/format = 'PHYSICAL_NON_RETURNABLE'">
    <!-- Klar til henting ved ... -->
    <xsl:text>@@can_picked_at@@ </xsl:text>
    <xsl:value-of select="/notification_data/phys_item_display/owning_library_name"/>
    <!-- Vi kunne også brukt `outgoing/pickup_location_str` her, men bruker
         i stedet `phys_item_display/owning_library_name` fordi denne ikke inkluderer skrankenavn.
         Eksempel:
         - 'phys_item_display/owning_library_name' : 'UiO Realfagsbiblioteket'
         - 'outgoing/pickup_location_str'          : 'UiO Realfagsbiblioteket – Utlånet Ureal'
    -->
  </xsl:when>

  <!-- Case 3: Vanlige utlån -->
  <xsl:otherwise>
    <!-- Klar til henting ved ... -->
    <xsl:text>@@can_picked_at@@ </xsl:text>
    <xsl:value-of select="/notification_data/request/delivery_address"/>
  </xsl:otherwise>

</xsl:choose>

<!-- ########################################################################
  Del 2: Hentenummer eller "Hentes i skranken"
-->
<xsl:if test="not($internpost)">
  <xsl:text>, </xsl:text>
  <xsl:if test="/notification_data/request/work_flow_entity/expiration_date">
    <xsl:call-template name="pickupNumberWithLabel"><!-- header.xsl -->
      <xsl:with-param name="lcfirst" select="true()" />
    </xsl:call-template>
  </xsl:if>
</xsl:if>

<xsl:text>:&#10;&#10; </xsl:text><!-- Line breaks and indent -->

<!-- ########################################################################
  Del 3: Beskrivelse av dokumentet
-->
<xsl:text>"</xsl:text>
<xsl:value-of select="/notification_data/phys_item_display/title" />
<xsl:text>". </xsl:text>
<xsl:value-of select="/notification_data/phys_item_display/author"/>
<xsl:text>.</xsl:text>

<!-- ########################################################################
  Del 4: Hentefrist

  Vi har 5 dagers hold shelf period konfigurert for circ-deskene, men lar
  innlånte bøker stå lenger, inntil 28 dager hvis det er plass. For å ikke
  gjøre dette altfor komplisert skjuler vi bare hentefristen for innlånte bøker.
  (2018-01)
-->
<xsl:if test="not($internpost) and /notification_data/request/work_flow_entity/expiration_date != '' and not(contains(/notification_data/phys_item_display/location_name, 'Fjernlån'))">
  <xsl:text>&#10;&#10;@@note_item_held_until@@: </xsl:text>
    <xsl:call-template name="stdDate"><!-- header.xsl -->
      <xsl:with-param name="value" select="/notification_data/request/work_flow_entity/expiration_date"/>
    </xsl:call-template>
  <xsl:text>.</xsl:text>
</xsl:if>

</xsl:template>
</xsl:stylesheet>