<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:template name="salutation"/>

 <xsl:template name="lastFooter">

  <div class="lastFooter">

   <!-- style.xsl -->
   <!--
 <xsl:attribute name="style"><xsl:call-template name="footerTableStyleCss" /></xsl:attribute>-->
   <xsl:for-each select="notification_data/organization_unit">
    <!-- style.xsl -->
    <!--
 <xsl:attribute name="style"><xsl:call-template name="listStyleCss" /></xsl:attribute>-->

     <xsl:if test="email/email != ''">
      <p>
       <xsl:choose>
        <xsl:when test="/notification_data/receivers/receiver/preferred_language = 'no'">
         Har du spørsmål eller trenger hjelp, kontakt oss på
        </xsl:when>
        <xsl:when test="/notification_data/receivers/receiver/preferred_language = 'nn'">
         Har du spørsmål eller treng hjelp, kontakt oss på
        </xsl:when>
        <xsl:otherwise>
         Questions? Please contact us at
        </xsl:otherwise>
       </xsl:choose>
       <xsl:value-of select="email/email"/>.
      </p>
     </xsl:if>

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
  <table align="left">
   <tr>
    <td align="left">
      <a>
        <xsl:attribute name="href">@@email_contact_us@@</xsl:attribute>
        @@contact_us@@
      </a>
    </td>
   </tr>
  </table>
 </xsl:template>

 <xsl:template name="myAccount">
  <table align="right">
   <tr>
    <td align="right">
      <a>
        <xsl:attribute name="href">@@email_my_account@@</xsl:attribute>
        @@my_account@@
      </a>
    </td>
   </tr>
  </table>
 </xsl:template>

</xsl:stylesheet>