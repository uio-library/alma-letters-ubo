<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:date="http://exslt.org/dates-and-times"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="date ext">


<!-- *DEPRECATED* -->
<xsl:template name="salutation"/>


<!-- *DEPRECATED* -->
<xsl:template name="lastFooter"/>


<!-- *DEPRECATED* -->
<xsl:template name="contactUs"/>


<!--
  Email footer

  Depends on: multilingual, myAccount
-->
<xsl:template name="email-footer">
  <xsl:param name="show_my_account" />
  <xsl:param name="email" />
  <xsl:param name="sender_name" />

  <div>

    <xsl:for-each select="/notification_data/organization_unit">
      <p>
        <xsl:call-template name="multilingual"><!-- header.xsl -->
          <xsl:with-param name="nb" select="'Har du spørsmål eller trenger hjelp? '"/>
          <xsl:with-param name="nn" select="'Har du spørsmål eller treng hjelp? '"/>
          <xsl:with-param name="en" select="'Do you have questions or need help? '"/>
        </xsl:call-template>

        <xsl:choose>

          <!-- Bruk en bestemt epost-adresse fra parameter hvis gitt -->
          <xsl:when test="$email != ''">
            <xsl:call-template name="multilingual"><!-- header.xsl -->
              <xsl:with-param name="nb" select="'Ikke nøl med å kontakte oss på '"/>
              <xsl:with-param name="nn" select="'Ikkje nøl med å kontakte oss på '"/>
              <xsl:with-param name="en" select="'Please contact us at '"/>
            </xsl:call-template>
            <a>
              <xsl:attribute name="href"><xsl:value-of select="$email"/></xsl:attribute>
              <xsl:value-of select="$email"/>
            </a>.
          </xsl:when>

          <!-- Reply to this email -->
          <xsl:otherwise>
            <xsl:call-template name="multilingual"><!-- header.xsl -->
              <xsl:with-param name="nb" select="'Svar på denne e-posten, så hjelper vi deg så raskt vi kan.'"/>
              <xsl:with-param name="nn" select="'Svar på denne e-posten, så hjelper vi deg så raskt vi kan.'"/>
              <xsl:with-param name="en" select="'Please reply to this e-mail, and we will help you as best we can.'"/>
            </xsl:call-template>
          </xsl:otherwise>

        </xsl:choose>
      </p>

      <xsl:if test="$show_my_account">
        <xsl:call-template name="myAccount"/>
      </xsl:if>

      <p style="margin-bottom: 0;">
        <xsl:call-template name="multilingual"><!-- header.xsl -->
          <xsl:with-param name="nb" select="'Vennlig hilsen,'"/>
          <xsl:with-param name="nn" select="'Venleg helsing,'"/>
          <xsl:with-param name="en" select="'Kind regards,'"/>
        </xsl:call-template><br />
        <xsl:choose>
          <xsl:when test="$sender_name != ''">
            <xsl:value-of select="$sender_name"/>
          </xsl:when>
          <xsl:otherwise>
            <!-- Until someone can fix the missing space in "UiO,Universitetsbiblioteket" we set the name manually here -->
            <!--<xsl:value-of select="name"/>-->
            <xsl:call-template name="multilingual"><!-- header.xsl -->
              <xsl:with-param name="nb" select="'UiO Universitetsbiblioteket'"/>
              <xsl:with-param name="nn" select="'UiO Universitetsbiblioteket'"/>
              <xsl:with-param name="en" select="'University of Oslo Library'"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </p>

    </xsl:for-each>
  </div>
</xsl:template>


<!--
  Provides a link to my account

  Depends on: multilingual
-->
<xsl:template name="myAccount">
  <p id="myAccount">
    <xsl:call-template name="multilingual"><!-- header.xsl -->
      <xsl:with-param name="nb" select="'Besøk '"/>
      <xsl:with-param name="nn" select="'Besøk '"/>
      <xsl:with-param name="en" select="'Visit '"/>
    </xsl:call-template>
    <a><xsl:attribute name="href">@@email_my_account@@</xsl:attribute>@@my_account@@</a>
    <xsl:call-template name="multilingual"><!-- header.xsl -->
      <xsl:with-param name="nb" select="' for å administrere dine lån og bestillinger.'"/>
      <xsl:with-param name="nn" select="' for å administrere dine lån og bestillingar.'"/>
      <xsl:with-param name="en" select="' to manage your loans and orders.'"/>
    </xsl:call-template>
  </p>
</xsl:template>


<!--
  Provides a link to the University of Oslo payment form

  Depends on: (none)
-->
<xsl:template name="payment-details">
  <p>
    <xsl:for-each select="/notification_data/receivers/receiver">
      <xsl:choose>
        <xsl:when test="preferred_language = 'nob' or preferred_language = 'no' or preferred_language = 'nb'">
          Du kan enten betale i biblioteket eller med
          <a><xsl:attribute name="href">https://epay.uio.no/pay/shop/order-create.html?projectStepId=5203685</xsl:attribute>Epay</a>.
          Hvis du betaler med Epay, legg inn DokumentID i kommentarfeltet.
        </xsl:when>
        <xsl:when test="preferred_language = 'nn' or preferred_language = 'nno'">
          Du kan anten betale i biblioteket eller med
          <a><xsl:attribute name="href">https://epay.uio.no/pay/shop/order-create.html?projectStepId=5203685</xsl:attribute>Epay</a>.
          Om du betalar med Epay, legg inn DokumentID i kommentarfeltet.
        </xsl:when>
        <xsl:otherwise>
          You can either pay in the library or with
          <a><xsl:attribute name="href">https://epay.uio.no/pay/shop/order-create.html?projectStepId=5203685</xsl:attribute>Epay</a>.
          If you use Epay, please include the DocumentID(s) in the comment field.
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </p>
</xsl:template>


</xsl:stylesheet>