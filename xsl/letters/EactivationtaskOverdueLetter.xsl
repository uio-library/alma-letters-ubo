<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />
<xsl:include href="recordTitle.xsl" />
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

    <table cellspacing="0" cellpadding="5" border="0">
    <tr>
     <td>

    @@notificationTxt@@ :



     </td>
     </tr>
     <tr>
     <td>
      <br />
      <div style="height:10px;font-size: 1.5em;">
    @@eTaskList@@ :
      </div>
      <br />
     </td>
     </tr>
     <tr>
     <td>
       <table cellpadding="5" class="listing">
    <xsl:attribute name="style">
     <xsl:call-template name="mainTableStyleCss" /> <!-- style.xsl -->
    </xsl:attribute>
     <tr>
      <th>@@title@@</th>
      <th>@@identifier@@</th>
      <th>@@dueDate@@</th>
      </tr>
   <xsl:for-each select="notification_data/etasks_list/activation_task">
     <tr>
     <td><xsl:value-of  select="title"/></td>
     <td><xsl:value-of  select="identifier"/></td>
     <td><xsl:value-of  select="due_date"/></td>
     </tr>

        </xsl:for-each>
 </table>
</td></tr>
    </table>
    <br />
    <table>
      <tr><td>@@sincerely@@</td></tr>
      <tr><td>@@department@@</td></tr>
    </table>

    <xsl:call-template name="lastFooter" /> <!-- footer.xsl -->
   </body>
 </html>
</xsl:template>

</xsl:stylesheet>