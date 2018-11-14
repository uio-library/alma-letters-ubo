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

    <!-- Melding om passordendring (ikke i bruk) -->
    <xsl:when test="notification_type = 'NOTIFY_PASSWORD_CHANGE' ">
      <h3>@@Line_1@@</h3>
      <p>
        <xsl:value-of select="temp_password" />
      </p>
      <p>
        @@Line_2@@
      </p>
    </xsl:when>

    <!-- Melding til tidligere studenter -->
    <xsl:when test="notification_type = 'ferdigstudert'">
      <p>
        <xsl:call-template name="multilingual"><!-- header.xsl -->

          <xsl:with-param name="nb" select="'Du får denne mailen fordi du har lånt bøker fra Universitetsbiblioteket i Oslo, og brukerkontoen din viser at du ikke er registrert student og betalt for høsten 2018. Brukeren din i biblioteksystemet har dermed fått en utløpsdato. Hvis du ikke er aktiv student lenger trenger vi å oppdatere informasjonen din knyttet til pålogging i Oria, studentkort o.l. Fint om du tar en tur innom skranken neste gang du er i biblioteket for å se på dette hvis du fortsatt ønsker å bruke Universitetsbiblioteket.'"/>

          <xsl:with-param name="nn" select="'Du får denne e-posten då du har lånt bøker frå Universitetsbiblioteket i Oslo, og brukarkontoen din viser at du ikkje er registrert student for høsten 2018.
Din brukarkonto i biblioteksystemet vil difor snart gå ut på dato. Om du ikkje er aktiv student lenger treng vi å oppdatere informasjonen din knytt til pålogging i Oria, studentkort o.l.
Om du fortsatt ynskjer å bruke Universitetsbiblioteket, er det fint om du tar ein tur innom oss i skranken neste gong du er i biblioteket.'"/>

          <xsl:with-param name="en" select="'You have received this email because you are registered with loans in our library system, and your user account has an imminent expiry date. If you are no longer an active student, we need to update your information regarding login to Oria, student card, etc. If you wish to continue using the University of Oslo Library’s services, please stop by a circulation desk the next time you visit the library so we can update your details.'"/>

        </xsl:call-template>
      </p>
    </xsl:when>

    <!-- Informasjonsmelding om automatisk fornying av lån. -->
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