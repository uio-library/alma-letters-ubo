<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:variable name="counter" select="0"/>


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



   <div class="messageArea">
    <div class="messageBody">
      <table cellspacing="0" cellpadding="5" border="0">

      <tr>
       <td>
        <b>@@course_code@@: </b>
        <xsl:value-of select="notification_data/course/code"/>
       </td>
      </tr>

      <tr>
       <td>
        <b>@@course_name@@: </b>
        <xsl:value-of select="notification_data/course/name"/>
       </td>
      </tr>

      <tr>
       <td>
        <b>@@course_department@@: </b>
        <xsl:value-of select="notification_data/department"/>
       </td>
      </tr>

      <tr>
       <td>
        <b>@@reading_list_code@@: </b>
        <xsl:value-of select="notification_data/reading_list/code"/>
       </td>
      </tr>

      <tr>
       <td>
        <b>@@reading_list_name@@: </b>
        <xsl:value-of select="notification_data/reading_list/name"/>
       </td>
      </tr>

      <xsl:if  test="notification_data/reading_list/assignee != ''" >
       <tr>
        <td>
         <b>@@reading_list_assignee@@: </b>
         <xsl:value-of select="notification_data/reading_list/assignee"/>
        </td>
       </tr>
      </xsl:if>

      <xsl:for-each select="notification_data/items/physical_item_display_for_printing">
       <br></br>

       <tr>
         <td><b>@@item_barcode@@: </b><img src="cid:{concat(concat('Barcode',position()),'.png')}" alt="{concat('Barcode',position())}" /></td>
       </tr>

       <tr>
        <td><xsl:value-of select="title"/></td>
       </tr>

       <tr>
        <td>
         <b>@@library@@: </b>
         <xsl:value-of select="library_name"/>
        </td>
       </tr>

       <tr>
        <td><b>@@location@@: </b><xsl:value-of select="location_name"/></td>
       </tr>

       <xsl:if  test="call_number" >
        <tr>
         <td><b>@@call_number@@: </b><xsl:value-of select="call_number"/></td>
        </tr>
       </xsl:if>

       <xsl:if  test="shelving_location/string" >
        <tr>
         <td><b>@@shelving_location_for_item@@: </b>
          <xsl:for-each select="shelving_location/string">
          <xsl:value-of select="."/>
          &#160;
          </xsl:for-each>
         </td>
        </tr>
       </xsl:if>
      </xsl:for-each>
     </table>
    </div>
   </div>




 <xsl:call-template name="lastFooter" /> <!-- footer.xsl -->





</body>
</html>


 </xsl:template>
</xsl:stylesheet>