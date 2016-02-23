<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:template name="salutation"/>

 <xsl:template name="lastFooter">
  <xsl:param name="email" />

  <div id="lastFooter">

   <!-- style.xsl -->
   <!--
 <xsl:attribute name="style"><xsl:call-template name="footerTableStyleCss" /></xsl:attribute>-->
   <xsl:for-each select="notification_data/organization_unit">
    <!-- style.xsl -->
    <!--
 <xsl:attribute name="style"><xsl:call-template name="listStyleCss" /></xsl:attribute>-->

    <p>
      <xsl:choose>
        <xsl:when test="/notification_data/receivers/receiver/preferred_language = 'no'">
         Har du spørsmål eller trenger hjelp?
        </xsl:when>
        <xsl:when test="/notification_data/receivers/receiver/preferred_language = 'nn'">
         Har du spørsmål eller treng hjelp?
        </xsl:when>
        <xsl:otherwise>
         Questions?
        </xsl:otherwise>
      </xsl:choose>

      <xsl:choose>

        <!-- Bruk epost-adresse fra parameter hvis gitt -->
        <xsl:when test="$email != ''">
          <xsl:choose>
            <xsl:when test="/notification_data/receivers/receiver/preferred_language = 'no'">
             Kontakt oss på
            </xsl:when>
            <xsl:when test="/notification_data/receivers/receiver/preferred_language = 'nn'">
             Kontakt oss på
            </xsl:when>
            <xsl:otherwise>
             Please contact us at
            </xsl:otherwise>
          </xsl:choose>
          <xsl:value-of select="$email"/>
        </xsl:when>

        <!-- Bruk epost-adresse til notification_data/organization_unit hvis tilgjengelig -->
        <xsl:when test="email/email != ''">
          <xsl:choose>
            <xsl:when test="/notification_data/receivers/receiver/preferred_language = 'no'">
             Kontakt oss på
            </xsl:when>
            <xsl:when test="/notification_data/receivers/receiver/preferred_language = 'nn'">
             Kontakt oss på
            </xsl:when>
            <xsl:otherwise>
             Please contact us at
            </xsl:otherwise>
          </xsl:choose>
          <xsl:value-of select="email/email"/>
        </xsl:when>

        <!-- Alternativt: Bruk standard-URL -->
        <xsl:otherwise>
          <a>
            <xsl:attribute name="href">@@email_contact_us@@</xsl:attribute>
            @@contact_us@@
          </a>.
        </xsl:otherwise>
      </xsl:choose>
    </p>

    <p>
      <xsl:choose>
       <xsl:when test="/notification_data/receivers/receiver/preferred_language = 'no'">
        Vennlig hilsen,<br />
        <xsl:value-of select="name"/>
       </xsl:when>
       <xsl:when test="/notification_data/receivers/receiver/preferred_language = 'nn'">
        Venleg hilsen,<br />
        <xsl:value-of select="name"/>
       </xsl:when>
       <xsl:otherwise>
        Kind regards,<br />
        <xsl:value-of select="name"/>
       </xsl:otherwise>
      </xsl:choose>
    </p>

   </xsl:for-each>
  </div>

 </xsl:template>

 <xsl:template name="contactUs">
   <!-- -->
 </xsl:template>

 <xsl:template name="myAccount">
  <p id="myAccount">
    <a>
      <xsl:attribute name="href">@@email_my_account@@</xsl:attribute>
      @@my_account@@
    </a>
  </p>
 </xsl:template>

</xsl:stylesheet>