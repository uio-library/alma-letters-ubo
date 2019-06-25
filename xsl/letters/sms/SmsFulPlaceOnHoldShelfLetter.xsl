<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:date="http://exslt.org/dates-and-times"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="date ext">
<xsl:include href="header.xsl" />
<xsl:template match="/">

<!-- Header -->

<xsl:value-of select="/notification_data/receivers/receiver/user_phone/phone"/>
<xsl:text> : </xsl:text>
<xsl:value-of select="/notification_data/organization_unit/name"/>: <xsl:if test = "notification_data/receivers/receiver/user/user_name"> <xsl:value-of select="notification_data/receivers/receiver/user/user_name"/></xsl:if>
<xsl:text>.&#10;</xsl:text><!-- Line feed -->

<!-- Klar til henting ved ... -->
<xsl:text>@@can_picked_at@@ </xsl:text>
<xsl:choose>
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
</xsl:choose>
<xsl:text>, </xsl:text>

<!-- Hentenummer eller "Hentes i skranken" -->

<xsl:if test="/notification_data/request/work_flow_entity/expiration_date">
  <xsl:call-template name="pickupNumberWithLabel"><!-- header.xsl -->
    <xsl:with-param name="lcfirst" select="true()" />
  </xsl:call-template>
</xsl:if>

<xsl:text>:&#10;&#10; </xsl:text><!-- Line breaks and indent -->

<!-- Bibliographic description -->

<xsl:text>"</xsl:text>
<xsl:value-of select="/notification_data/phys_item_display/title" />
<xsl:text>". </xsl:text>
<xsl:value-of select="/notification_data/phys_item_display/author"/>
<xsl:text>.</xsl:text>

<!--
  ## Hentefrist

  - 2018-01: Vi har 5 dagers hold shelf period konfigurert for circ-deskene, men lar
             innlånte bøker stå lenger, inntil 28 dager hvis det er plass. For å ikke
             gjøre dette altfor komplisert skjuler vi bare hentefristen for innlånte bøker.
-->
<xsl:if test="/notification_data/request/work_flow_entity/expiration_date != '' and not(contains(/notification_data/phys_item_display/location_name, 'Fjernlån'))">
  <xsl:text>&#10;&#10;@@note_item_held_until@@: </xsl:text>
  <xsl:call-template name="stdDate"><!-- header.xsl -->
    <xsl:with-param name="value" select="/notification_data/request/work_flow_entity/expiration_date"/>
  </xsl:call-template>
  <xsl:text>.</xsl:text>
</xsl:if>
<xsl:if test="starts-with(/notification_data/request/calculated_destination_name, 'UiO Realfagsbiblioteket') or starts-with(/notification_data/request/calculated_destination_name, 'UiO Informatikkbiblioteket')">
  <xsl:choose>
    <xsl:when test="/notification_data/receivers/receiver/preferred_language = 'en'">
      &#10;From 1 July: pick-up in the library in Georg Sverdrups hus.
    </xsl:when>
    <xsl:otherwise>
      &#10;Fra 1. juli: henting i biblioteket i Georg Sverdrups hus.
    </xsl:otherwise>
  </xsl:choose>
</xsl:if>

</xsl:template>
</xsl:stylesheet>