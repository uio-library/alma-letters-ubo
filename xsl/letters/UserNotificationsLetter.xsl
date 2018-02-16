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


  <xsl:choose>

    <!-- Your password has been changed to: -->
    <xsl:when test="notification_type = 'NOTIFY_PASSWORD_CHANGE' ">
      <h3>@@Line_1@@</h3>
      <p>
        <xsl:value-of select="temp_password" />
      </p>
      <p>
        @@Line_2@@
      </p>
    </xsl:when>

    <!-- Forklarende kommentar -->
    <xsl:when test="notification_type = 'Informasjon'">
      <p>
        <xsl:call-template name="multilingual"><!-- header.xsl -->
          <xsl:with-param name="nb" select="'Nå blir lånene dine fornyet automatisk!
Lån fra Universitetsbibliotekets samlinger blir automatisk fornyet hvis det ikke er venteliste.
'"/>
          <xsl:with-param name="nn" select="'No blir låna dine fornya automatisk!
Lån frå Universitetsbiblioteket si samling blir automatisk fornya visst det ikkje er venteliste.
'"/>
          <xsl:with-param name="en" select="'Loans from our collections are now automatically renewed when there is no waiting list.
If we ask you to return a book, that means someone else has requested it, and it needs to be returned. If you return by the due date, you won’t need to pay late fee of 250 NOK.
'"/>
        </xsl:call-template>
      </p>
      <p>
        <xsl:call-template name="multilingual"><!-- header.xsl -->
          <xsl:with-param name="nb" select="'Får du beskjed om å levere boka betyr det at noen venter på den.
Lever innen fristen, og du slipper å betale gebyr på kr 250 per bok.
Alt om de nye lånereglene finner du her: http://www.ub.uio.no/bruk/alt-om-lan/
'"/>
          <xsl:with-param name="nn" select="'Får du beskjed om å levere boka betyr det at nokon ventar på den.
Lever innan fristen, og du slepp å betale gebyr på kr 250 per bok.
Alt om dei nye lånereglane finn du her: http://www.ub.uio.no/bruk/alt-om-lan/
'"/>
          <xsl:with-param name="en" select="'For more info, please see our library regulations: http://www.ub.uio.no/english/using/about-borrowing/'"/>
        </xsl:call-template>
      </p>
    </xsl:when>


  </xsl:choose>


  <xsl:call-template name="email-footer"><!-- footer.xsl -->
    <xsl:with-param name="show_my_account" select="true()"/>
  </xsl:call-template>

</xsl:template>
</xsl:stylesheet>