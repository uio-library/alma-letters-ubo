<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" xmlns:ext="http://exslt.org/common" version="1.0" extension-element-prefixes="date ext">
   <!-- *DEPRECATED* -->
   <xsl:template name="salutation" />
   <!-- *DEPRECATED* -->
   <xsl:template name="lastFooter" />
   <!-- *DEPRECATED* -->
   <xsl:template name="contactUs" />
   <!--
  Email footer

  Depends on: multilingual, myAccount
-->
   <xsl:template name="email-footer">
      <xsl:param name="show_my_account" />
      <xsl:param name="show_help" select="true()" />
      <xsl:param name="email" />
      <xsl:param name="sender_name" />
      <div>
         <xsl:if test="$show_help">
            <p>
               <xsl:call-template name="multilingual">
                  <!-- header.xsl -->
                  <xsl:with-param name="nb" select="'Lurer du på noe? '" />
                  <xsl:with-param name="nn" select="'Lurer du på noko? '" />
                  <xsl:with-param name="en" select="'If you have any questions or concerns, '" />
               </xsl:call-template>
               <xsl:choose>
                  <!-- Bruk en bestemt epost-adresse fra parameter hvis gitt -->
                  <xsl:when test="$email != ''">
                     <xsl:call-template name="multilingual">
                        <!-- header.xsl -->
                        <xsl:with-param name="nb" select="'Ikke nøl med å kontakte oss på '" />
                        <xsl:with-param name="nn" select="'Ikkje nøl med å kontakte oss på '" />
                        <xsl:with-param name="en" select="'please contact us at '" />
                     </xsl:call-template>
                     <a>
                        <xsl:attribute name="href">
                           <xsl:value-of select="$email" />
                        </xsl:attribute>
                        <xsl:value-of select="$email" />
                     </a>
                     .
                  </xsl:when>
                  <!-- Reply to this email -->
                  <xsl:otherwise>
                     <xsl:call-template name="multilingual">
                        <!-- header.xsl -->
                        <xsl:with-param name="nb" select="'Svar på denne e-posten, så hjelper vi deg.'" />
                        <xsl:with-param name="nn" select="'Svar på denne e-posten, så hjelper vi deg.'" />
                        <xsl:with-param name="en" select="'please do not hesitate to contact us by replying to this e-mail.'" />
                     </xsl:call-template>
                  </xsl:otherwise>
               </xsl:choose>
            </p>
         </xsl:if>
         <xsl:if test="$show_my_account">
            <xsl:call-template name="myAccount" />
         </xsl:if>
         <p style="margin-bottom: 0;">
            <xsl:call-template name="multilingual">
               <!-- header.xsl -->
               <xsl:with-param name="nb" select="'Vennlig hilsen,'" />
               <xsl:with-param name="nn" select="'Venleg helsing,'" />
               <xsl:with-param name="en" select="'Kind regards,'" />
            </xsl:call-template>
            <br />
            <xsl:choose>
               <xsl:when test="$sender_name != ''">
                  <xsl:value-of select="$sender_name" />
               </xsl:when>
               <xsl:otherwise>
                  <!-- Until someone can fix the missing space in "UiO,Universitetsbiblioteket" we set the name manually here -->
                  <!--<xsl:value-of select="/notification_data/organization_unitname"/>-->
                  <xsl:call-template name="multilingual">
                     <!-- header.xsl -->
                     <xsl:with-param name="nb" select="'UiO Universitetsbiblioteket'" />
                     <xsl:with-param name="nn" select="'UiO Universitetsbiblioteket'" />
                     <xsl:with-param name="en" select="'University of Oslo Library'" />
                  </xsl:call-template>
               </xsl:otherwise>
            </xsl:choose>
         </p>
      </div>
   </xsl:template>
   <!--
  Provides a link to my account

  Depends on: multilingual
-->
   <xsl:template name="myAccount">
      <p id="myAccount">
         <xsl:call-template name="multilingual">
            <!-- header.xsl -->
            <xsl:with-param name="nb" select="'Besøk '" />
            <xsl:with-param name="nn" select="'Besøk '" />
            <xsl:with-param name="en" select="'Visit '" />
         </xsl:call-template>
         <a>
            <xsl:attribute name="href">@@email_my_account@@</xsl:attribute>
            @@my_account@@
         </a>
         <xsl:call-template name="multilingual">
            <!-- header.xsl -->
            <xsl:with-param name="nb" select="' for å administrere lån og bestillinger.'" />
            <xsl:with-param name="nn" select="' for å administrere lån og bestillingar.'" />
            <xsl:with-param name="en" select="' to manage your loans and orders.'" />
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
                 Betalingsmåter:
                 <ul>
                    <li>
                      Vipps: Velg «Kjøp og betal» og søk opp 542872 «UiO Universitetsbiblioteket».
                      Legg inn DokumentID (se over) i kommentarfeltet.
                    </li>
                    <li>
                      Kortbetaling på nett:
                      UiOs betalingsløsning
                      <a>
                        <xsl:attribute name="href">https://epay.uio.no/pay/shop/order-create.html?projectStepId=5203685</xsl:attribute>
                        Epay</a>.
                      Legg inn DokumentID (se over) i kommentarfeltet.
                    </li>
                    <li>
                      Kortterminal i skranken i biblioteket (Georg Sverdrups hus eller Domus Juridica).
                    </li>
                  </ul>
               </xsl:when>
               <xsl:when test="preferred_language = 'nn' or preferred_language = 'nno'">
                 Betalingsmåtar:
                 <ul>
                    <li>
                      Vipps: Velg «Kjøp og betal» og søk opp 542872 «UiO Universitetsbiblioteket».
                      Legg inn DokumentID (sjå over) i kommentarfeltet.
                    </li>
                    <li>
                      Kortbetaling på nett:
                      UiO si betalingsløysing
                      <a>
                        <xsl:attribute name="href">https://epay.uio.no/pay/shop/order-create.html?projectStepId=5203685</xsl:attribute>
                        Epay</a>.
                      Legg inn DokumentID (se over) i kommentarfeltet.
                    </li>
                    <li>
                      Kortterminal i skranken i biblioteket (Georg Sverdrups hus eller Domus Bibliotheca)
                    </li>
                  </ul>
               </xsl:when>
               <xsl:otherwise>
                 Payment options:
                 <ul>
                    <li>
                      Vipps: Choose «Buy and pay» and lookup 542872 «UiO Universitetsbiblioteket».
                      Please include the DocumentID (above) in the comment field.
                    </li>
                    <li>
                      Online card payment:
                      <a>
                        <xsl:attribute name="href">https://epay.uio.no/pay/shop/order-create.html?projectStepId=5203685</xsl:attribute>
                        Epay</a>.
                      Please include the DocumentID (see above) in the comment field.
                    </li>
                    <li>
                      Credit card terminal in the library (Georg Sverdrups hus or Domus Bibliotheca).
                    </li>
                  </ul>
                </xsl:otherwise>
              </xsl:choose>
         </xsl:for-each>
      </p>
   </xsl:template>
</xsl:stylesheet>