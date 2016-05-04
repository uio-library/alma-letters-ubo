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

   <!-- <xsl:call-template name="head" />  header.xsl -->
<div class="messageArea">
<br />
  <table cellspacing="0" cellpadding="5" border="0">
      <tr>
       <td><font size="7"><b>@@arrival_date@@ : </b><xsl:value-of select="notification_data/arrival_date/calendar"/></font></td>
      </tr>
      <tr>
       <td><b>@@mms_id@@ : </b><xsl:value-of select="notification_data/mms_id"/></td>
      </tr>
      </table>

      </div>

   <div class="messageArea">
    <div class="messageBody">


      <table cellspacing="0" cellpadding="5" border="0">


      <br /><br /><br />
      <tr>
       <td><b>@@item_barcode@@: </b></td>
      </tr>
      <tr>
       <td><img src="cid:item_id_barcode.png" alt="Item Barcode"/></td>
      </tr>

      <br /><br /><br />
      <tr>
       <td>
      <b>@@title@@ : </b>
       <xsl:value-of select="notification_data/title"/></td>
      </tr>
      <tr>
       <td>
      <b>@@description@@: </b>
       <xsl:value-of select="notification_data/description"/></td>
      </tr>
      <tr>
       <td>
      <b>@@vendor@@: </b>
       <xsl:value-of select="notification_data/vendor_code"/></td>
      </tr>
      <tr>
       <td>
      <b>@@order_number@@ : </b>
       <xsl:value-of select="notification_data/poline_number"/></td>
      </tr>
      <b></b>
      <tr>
       <td><b>@@library@@ : </b><xsl:value-of select="notification_data/organization_unit/name"/></td>

      </tr>
      <tr>
       <td><b>@@location@@ : </b><xsl:value-of select="notification_data/location"/></td>

      </tr>
      <tr>
       <td>
      <b>@@call_number@@: </b>
       <xsl:value-of select="notification_data/call_number"/></td>
      </tr>

      <xsl:if test="notification_data/rush='true'">

      <tr>
       <td>
      <b>@@notes@@: </b>
      @@is_rush@@

      </td>
      </tr>
      </xsl:if>


      <xsl:if test="notification_data/receiving_note !=''">
      <tr>
       <td>
      <b>@@receiving_note@@: </b>
       <xsl:value-of select="notification_data/receiving_note"/></td>
      </tr>
      </xsl:if>

       <tr>
       <td>
      <b>@@enumeration_a@@: </b>
       <xsl:value-of select="notification_data/physical_item_info/enumeration_a"/></td>
      </tr>
      <tr>
       <td>
      <b>@@enumeration_b@@: </b>
       <xsl:value-of select="notification_data/physical_item_info/enumeration_b"/></td>
      </tr>
      <tr>
       <td>
      <b>@@enumeration_c@@: </b>
       <xsl:value-of select="notification_data/physical_item_info/enumeration_c"/></td>
      </tr>
         <tr>
       <td>
      <b>@@enumeration_d@@: </b>
       <xsl:value-of select="notification_data/physical_item_info/enumeration_d"/></td>
      </tr>
      <tr>
       <td>
      <b>@@enumeration_e@@: </b>
       <xsl:value-of select="notification_data/physical_item_info/enumeration_e"/></td>
      </tr>
      <tr>
       <td>
      <b>@@enumeration_f@@: </b>
       <xsl:value-of select="notification_data/physical_item_info/enumeration_f"/></td>
      </tr>
      <tr>
       <td>
      <b>@@enumeration_g@@: </b>
       <xsl:value-of select="notification_data/physical_item_info/enumeration_g"/></td>
      </tr>
      <tr>
       <td>
      <b>@@enumeration_h@@: </b>
       <xsl:value-of select="notification_data/physical_item_info/enumeration_h"/></td>
      </tr>
      <tr>
       <td>
      <b>@@chronology_i@@: </b>
       <xsl:value-of select="notification_data/physical_item_info/chronology_i"/></td>
      </tr>
      <tr>
       <td>
      <b>@@chronology_j@@: </b>
       <xsl:value-of select="notification_data/physical_item_info/chronology_j"/></td>
      </tr>
      <tr>
       <td>
      <b>@@chronology_k@@: </b>
       <xsl:value-of select="notification_data/physical_item_info/chronology_k"/></td>
      </tr>
       <tr>
       <td>
      <b>@@chronology_l@@: </b>
       <xsl:value-of select="notification_data/physical_item_info/chronology_l"/></td>
      </tr>
      <tr>
       <td>
      <b>@@chronology_m@@: </b>
       <xsl:value-of select="notification_data/physical_item_info/chronology_m"/></td>
      </tr>
      <tr>
       <td>
               <b>@@request_note@@: </b>
       <xsl:value-of select="notification_data/request_note"/></td>
      </tr>


   <xsl:if test="notification_data/notes_list">
   <tr>
      <td>
      <b>@@order_notes@@: </b>
      </td>
   </tr>

    <tr>
       <table cellpadding="5" class="listing">
       <xsl:attribute name="style">
        <xsl:call-template name="mainTableStyleCss" /> <!-- style.xsl -->
       </xsl:attribute>
        <tr>
         <th>@@note@@</th>
         <th>@@createDate@@</th>
        </tr>
        <xsl:for-each select="notification_data/notes_list/note">
        <tr>
         <td><xsl:value-of select="note_text"/></td>
         <td><xsl:value-of select="create_date"/></td>

        </tr>
        </xsl:for-each>
       </table>
    </tr>
     </xsl:if>

     </table>
    </div>
   </div>




 <xsl:call-template name="lastFooter" /> <!-- footer.xsl -->





</body>
</html>


 </xsl:template>
</xsl:stylesheet>