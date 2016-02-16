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
     @@You_were_specify@@:
    <br />
    <table cellspacing="0" cellpadding="5" border="0">
    <tr>
     <td>
    <br />
    @@orderNumber@@ :

      <br />

     </td>
      <td>
    <br />
    <xsl:value-of  select="notification_data/line_number"/>

      <br />

     </td>
     </tr>
    <tr>
     <td>
    <br />
    @@title@@ :

      <br />

     </td>
      <td>
    <br />
    <xsl:value-of  select="notification_data/title"/>

      <br />

     </td>
     </tr>
     <tr>
     <td>
    <br />
    @@callNumber@@ :

      <br />

     </td>
      <td>
    <br />
    <xsl:value-of  select="notification_data/poline_inventory/call_number"/>

      <br />

     </td>
    </tr>
     <tr>
     <td>
    <br />
    @@message@@ :

      <br />

     </td>
      <td>
    <br />
    <xsl:value-of  select="notification_data/message"/>

      <br />

     </td>
     </tr>

    </table>
    <br />

    <xsl:call-template name="lastFooter" /> <!-- footer.xsl -->

   </body>
 </html>
</xsl:template>

</xsl:stylesheet>