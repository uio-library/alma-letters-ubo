<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
 <xsl:include href="header.xsl"/>
 <xsl:include href="senderReceiver.xsl"/>
 <xsl:include href="mailReason.xsl"/>
 <xsl:include href="footer.xsl"/>
 <xsl:include href="style.xsl"/>
 <xsl:include href="recordTitle.xsl"/>
 <xsl:template match="/">
  <html>
   <head>
    <xsl:call-template name="generalStyle"/>

    <!-- =====================================================================================
      Libnummer

      Alternativ 1: UiO-løsning: Vi legger dette i en meta-tagg,
      som en instruksjon til html2ps om å skrive den ut i footer.

      Se https://github.com/scriptotek/alma-slipsomat#libnummer-norsk-isil-kode
      ===================================================================================== -->

    <xsl:element name="meta">
      <xsl:attribute name="name">libnummer</xsl:attribute>
      <xsl:attribute name="content">
        <xsl:for-each select="/notification_data/partner_address[1]/line5">
          <xsl:value-of select="substring(., 4,3)"/>&#160;&#160;<xsl:value-of select="substring(., 7,4)"/>
        </xsl:for-each>
      </xsl:attribute>
    </xsl:element>
    <!-- ===================================================================================== -->

   </head>
   <body>

    <xsl:attribute name="style">
      <xsl:call-template name="bodyStyleCss"/>
      <!-- style.xsl -->
    </xsl:attribute>

    <table cellspacing="0" cellpadding="5" border="0" width="100%">
      <tr>
        <td>
          <h2>
            @@returned@@
          </h2>
        </td>
        <td align="right" valign="top">
          <tt>
            <!-- =====================================================================================
                 Merk: Krever malen "isoDate" fra mailReason.xsl
                 ===================================================================================== -->
            <xsl:call-template name="isoDate"><!-- mailReason.xsl -->
              <xsl:with-param name="value" select="/notification_data/general_data/current_date"/>
            </xsl:call-template>
            <!-- ===================================================================================== -->
          </tt>
        </td>
      </tr>
    </table>

    <table cellspacing="0" cellpadding="5" border="0">
      <xsl:attribute name="style">
        <xsl:call-template name="listStyleCss"/>
        <!-- style.xsl -->
      </xsl:attribute>

      <tr>
        <td valign="top" colspan="2" align="center">
          <font size="2">@@request_id@@:</font><br/>
          <img src="externalId.png" alt="externalId"/>
        </td>
      </tr>

      <xsl:if test="/notification_data/request/display/title !=''">
        <tr>
          <th align="right"  valign="top">@@title@@:</th>
          <td>
           <xsl:value-of select="/notification_data/request/display/title"/>
          </td>
        </tr>
      </xsl:if>
      <xsl:if test="/notification_data/request/display/journal_title !=''">
        <tr>
         <th>@@journal_title@@:</th>
         <td>
          <xsl:value-of select="/notification_data/request/display/journal_title"/>
         </td>
        </tr>
      </xsl:if>

      <tr>
        <th align="right" valign="top">
          <xsl:if test="/notification_data/partner_address/country = 'NOR'">Avsender:</xsl:if>
          <xsl:if test="/notification_data/partner_address/country != 'NOR'">Sent from:</xsl:if>
        </th>
        <td>
          <xsl:value-of select="/notification_data/library/name"/> (<xsl:value-of select="/notification_data/library/code"/>)<br />
          <xsl:value-of select="/notification_data/library/address/line1"/><br />
          <xsl:value-of select="/notification_data/library/address/postal_code"/>&#160;<xsl:value-of select="/notification_data/library/address/city"/><br />
          <xsl:value-of select="/notification_data/library/email/email"/><br />
        </td>
      </tr>

      <tr>
        <th valign="top" align="right" nowrap="nowrap">@@returned_to@@:</th>
        <td>
          <xsl:value-of select="/notification_data/partner_name"/><br />
           <xsl:if test="/notification_data/partner_address/line1 !=''">
              <xsl:value-of select="/notification_data/partner_address/line1"/><br />
           </xsl:if>
           <xsl:if test="/notification_data/partner_address/line2 !=''">
              <xsl:value-of select="/notification_data/partner_address/line2"/><br />
           </xsl:if>
           <xsl:if test="/notification_data/partner_address/line3 !=''">
              <xsl:value-of select="/notification_data/partner_address/line3"/><br />
           </xsl:if>
           <xsl:if test="/notification_data/partner_address/line4 !=''">
              <xsl:value-of select="/notification_data/partner_address/line4"/><br />
           </xsl:if>
           <xsl:if test="/notification_data/partner_address/city !=''">
              <xsl:value-of select="/notification_data/partner_address/city"/><br />
           </xsl:if>
           <xsl:if test="/notification_data/partner_address/country !=''">
              <xsl:value-of select="/notification_data/partner_address/country"/><br />
           </xsl:if>
        </td>
      </tr>

      <xsl:if test="/notification_data/note_to_partner !=''">
        <tr>
          <th align="right"  valign="top">@@note_to_partner@@:</th>
          <td>
            <xsl:value-of select="/notification_data/note_to_partner"/>
          </td>
        </tr>
      </xsl:if>

    </table>

    <!-- =====================================================================================
          Libnummer

          Alternativ 2: CSS-basert løsning for de som ikke bruker html2ps

          Se https://github.com/scriptotek/alma-slipsomat#libnummer-norsk-isil-kode
          ===================================================================================== -->
    <xsl:if test="/notification_data/organization_unit/org_scope/institution_id != '2204'">
      <div id="libnummer" style="position: fixed; bottom: 100px; left: 30px; font-size: 60px;">
        <xsl:for-each select="/notification_data/partner_address[1]/line5">
          <xsl:value-of select="substring(., 4,3)"/>&#160;&#160;<xsl:value-of select="substring(., 7,4)"/>
        </xsl:for-each>
      </div>
    </xsl:if>
    <!-- ===================================================================================== -->

   </body>
  </html>
 </xsl:template>
</xsl:stylesheet>