<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl"/>
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />

<xsl:template match="/">
  <xsl:call-template name="email-template"/><!-- header.xsl -->
</xsl:template>

<xsl:template match="/notification_data">

  <xsl:call-template name="emailLogo"/><!-- mailReason.xsl -->
  <xsl:call-template name="toWhomIsConcerned"/><!-- mailReason.xsl -->

  <p>
    <xsl:if test="/notification_data/notification_type = 'OverdueNotificationType1'">
      @@inform_you_item_below_type1@@
    </xsl:if>
    <xsl:if test="/notification_data/notification_type = 'OverdueNotificationType2'">
      @@inform_you_item_below_type2@@
    </xsl:if>
    <xsl:if test="/notification_data/notification_type = 'OverdueNotificationType3'">
      @@inform_you_item_below_type3@@
    </xsl:if>
    <xsl:if test="/notification_data/notification_type = 'OverdueNotificationType4'">
      @@inform_you_item_below_type4@@
    </xsl:if>
  </p>

  <div style="margin: 0.8em 1.2em;">

    <em><xsl:value-of select="phys_item_display/title_abcnph"/></em><br />

    @@barcode@@: <xsl:value-of select="item_loan/barcode"/><br />

    <!-- BEGIN: Extremely crappy workaround for https://github.com/scriptotek/alma-slipsomat/issues/9 -->
    <xsl:if test="phys_item_display/chron_i != ''"><!-- Warning: We assume `chron_i` is always used. Is it? -->
      Issue: <xsl:value-of select="phys_item_display/enum_a"/>

      <xsl:if test="phys_item_display/chron_i != '' and phys_item_display/enum_a != ''">&#160;(</xsl:if>
      <xsl:value-of select="phys_item_display/chron_i"/>
      <xsl:if test="phys_item_display/chron_i != '' and phys_item_display/enum_a != ''">)</xsl:if>

      <xsl:if test="phys_item_display/chron_i != '' and phys_item_display/enum_a = ''">&#160;(</xsl:if>
      <xsl:value-of select="phys_item_display/enum_b"/>
      <xsl:if test="phys_item_display/chron_i != '' and phys_item_display/enum_a = ''">)</xsl:if>
      <br />
    </xsl:if>
    <!-- END: Extremely crappy workaround for https://github.com/scriptotek/alma-slipsomat/issues/9 -->

    <xsl:if test="item_loan/description != ''">
      @@description@@: <xsl:value-of select="item_loan/description"/><br />
    </xsl:if>

    <!--
    <xsl:if test="item_loan/author != ''">
      @@by@@: <xsl:value-of select="item_loan/author"/><br />
    </xsl:if>
    -->

  </div>

  <!--Beskjed type i forhold til hvilken purringtype -->
  <p>
    <xsl:if test="/notification_data/notification_type = 'OverdueNotificationType1'">
      @@decalred_as_lost_type1@@
    </xsl:if>
    <xsl:if test="/notification_data/notification_type = 'OverdueNotificationType2'">
      @@decalred_as_lost_type2@@
    </xsl:if>
    <xsl:if test="/notification_data/notification_type = 'OverdueNotificationType3'">
      @@decalred_as_lost_type3@@
    </xsl:if>
    <xsl:if test="/notification_data/notification_type = 'OverdueNotificationType4'">
       @@decalred_as_lost_type4@@
    </xsl:if>
  </p>

  <div>@@additional_info_1@@</div>
  <div>@@additional_info_2@@</div>

  <xsl:call-template name="email-footer"/><!-- footer.xsl -->
  <xsl:call-template name="myAccount" /> <!-- footer.xsl -->

</xsl:template>
</xsl:stylesheet>
