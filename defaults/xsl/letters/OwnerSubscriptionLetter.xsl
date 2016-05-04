<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />

<xsl:template match="/">
 <html>
  <head>
  <xsl:call-template name="generalStyle" />
  </head>

   <body>
   <xsl:attribute name="style">
    <xsl:call-template name="bodyStyleCss" /> <!-- style.xsl -->
   </xsl:attribute>

    <xsl:call-template name="head" /> <!-- header.xsl -->
    <xsl:call-template name="senderReceiver" /> <!-- SenderReceiver.xsl -->

    <br />
    <xsl:call-template name="toWhomIsConcerned" /> <!-- mailReason.xsl -->

    <table cellspacing="0" cellpadding="5" border="0">
     <tr>
      <td>


     @@you_are_joined@@
     <xsl:if test="notification_data/owner/hierarchy='OWNER'"> @@as_an@@ @@owner@@</xsl:if>
     <xsl:if test="notification_data/owner/hierarchy='COLLABORATOR'"> @@as_a@@ @@collaborator@@</xsl:if>
     <xsl:if test="notification_data/owner/hierarchy='SUBSCRIBER'">@@as_a@@  @@subscriber@@</xsl:if>
      @@to@@  <xsl:value-of select="/notification_data/owner/object_display_name" />


     <xsl:choose>
      <xsl:when test="notification_data/perma_link!= ''">
        : &#160; <xsl:element name="a">
         <xsl:attribute name="href">
         <xsl:value-of select="/notification_data/perma_link" />
         </xsl:attribute>
         <xsl:value-of select="/notification_data/owner_object_name" />
        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
       : &#160; <xsl:value-of select="/notification_data/owner_object_name" />
      </xsl:otherwise>
       </xsl:choose>

      </td>
     </tr>
    </table>
    <xsl:if test="notification_data/note!= ''">
    <br/>
    <strong>@@note@@:</strong>&#160;<xsl:value-of select="/notification_data/note" />
     </xsl:if>
     <br />
    <table>
  <xsl:attribute name="style">
   <xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
  </xsl:attribute>

  <tr><td>@@sincerely@@</td></tr>

    <xsl:for-each select="notification_data/creator">
   <tr><td><b>@@mr_mrs@@</b></td><td><xsl:value-of select="last_name"/></td><td><xsl:value-of select="first_name"/> </td></tr>
  </xsl:for-each>
  <xsl:for-each select="notification_data/organization_unit">
  <tr><td><xsl:value-of select="name"/> </td></tr>
  </xsl:for-each>
   </table>

    <xsl:call-template name="lastFooter" /> <!-- footer.xsl -->
   </body>
 </html>
</xsl:template>

</xsl:stylesheet>