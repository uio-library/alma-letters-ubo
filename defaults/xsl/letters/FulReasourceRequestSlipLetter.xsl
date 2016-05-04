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
   <h1>
    <b>@@requested_for@@ :
       <xsl:value-of select="notification_data/user_for_printing/identifiers/code_value[1]/value"/>
       : &#160;
       <xsl:value-of select="notification_data/user_for_printing/name"/>
                                                        : &#160;
       <xsl:value-of select="notification_data/user_for_printing/user_group"/>
    </b>
          
   </h1>


    <xsl:call-template name="head" /> <!-- header.xsl -->



   <div class="messageArea">
    <div class="messageBody">
      <table cellspacing="0" cellpadding="5" border="0">
      <xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
      <tr>
       <td><b>@@note_item_specified_request@@.</b></td>
      </tr>
      </xsl:if>
      <xsl:if  test="notification_data/request/manual_description != ''" >
      <tr>
       <td><b>@@please_note@@: </b>@@manual_description_note@@ - <xsl:value-of select="notification_data/request/manual_description"/></td>
      </tr>
      </xsl:if>
      <tr>
       <td><b>@@request_id@@: </b><img src="cid:request_id_barcode.png" alt="Request Barcode"/></td>
      </tr>
      <xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
       <tr>
        <td><b>@@item_barcode@@: </b><img src="cid:item_id_barcode.png" alt="Item Barcode"/></td>
       </tr>
      </xsl:if>
 
                                                 <tr>
       <table cellpadding="5" class="listing">
        <xsl:attribute name="style">
         <xsl:call-template name="mainTableStyleCss" /> <!-- style.xsl -->
        </xsl:attribute>
                                                                <tr> <td colspan="6"><b>Alternative items:</b></td></tr>
                                                                <tr>
         <th>Barcode</th>
         <th>Call number</th>
         <th>Library</th>
         <th>Location</th>
         <th>Item policy</th>
         <th>Public note</th>
        </tr>
                                                                <xsl:for-each select="notification_data/phys_item_display/available_items/available_item">
                                                                    <tr>
          <td><xsl:value-of select="barcode"/></td>
          <td><xsl:value-of select="call_number"/></td>
          <td><xsl:value-of select="library_name"/></td>
          <td><xsl:value-of select="location_name"/></td>
          <td><xsl:value-of select="item_policy"/></td>
          <td><xsl:value-of select="public_note"/></td>
         </tr>
        </xsl:for-each>
                      </table>
                                                 </tr>



      <xsl:if  test="notification_data/external_id != ''" >
       <tr>
        <td><b>@@external_id@@: </b><xsl:value-of select="notification_data/external_id"/></td>
       </tr>
      </xsl:if>

      <xsl:if test="notification_data/user_for_printing/name">

      <tr>
       <td>
              <b>@@requested_for@@: </b><br />
       <xsl:value-of select="notification_data/user_for_printing/name"/>
                                                        <xsl:if test="notification_data/user_for_printing/address1 != ''">
                                                       <br />
                                                        <xsl:value-of select="notification_data/user_for_printing/address1"/>
                                                        </xsl:if>
                                                        <xsl:if test="notification_data/user_for_printing/address2 != ''">
                                                       <br /> 
                                                        <xsl:value-of select="notification_data/user_for_printing/address2"/>
                                                        </xsl:if>
                                                        <xsl:if test="notification_data/user_for_printing/address3 != ''">
                                                        <br />
                                                        <xsl:value-of select="notification_data/user_for_printing/address3"/>
                                                         </xsl:if>
                                                        <xsl:if test="notification_data/user_for_printing/user_group != ''">
                                                        <br />
                                                        User Group: <xsl:value-of select="notification_data/user_for_printing/user_group"/>
                                                        </xsl:if>
                                                        <br />
                                                       </td>
      </tr>

      </xsl:if>

      <tr>
       <td><xsl:call-template name="recordTitle" />
       </td>
      </tr>

       <xsl:if test="notification_data/phys_item_display/isbn != ''">
        <tr>
        <td>@@isbn@@: <xsl:value-of select="notification_data/phys_item_display/isbn"/></td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/phys_item_display/issn != ''">
        <tr>
        <td>@@issn@@: <xsl:value-of select="notification_data/phys_item_display/issn"/></td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/phys_item_display/edition != ''">
        <tr>
        <td>@@edition@@: <xsl:value-of select="notification_data/phys_item_display/edition"/></td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/phys_item_display/imprint != ''">
        <tr>
        <td>@@imprint@@: <xsl:value-of select="notification_data/phys_item_display/imprint"/></td>
        </tr>
       </xsl:if>

      <b></b>
      <tr>
       <td><h2><b>@@location@@: </b><xsl:value-of select="notification_data/phys_item_display/location_name"/></h2></td>
       <xsl:if test="notification_data/phys_item_display/call_number != ''">
        <td><h2><b>@@call_number@@: </b><xsl:value-of select="notification_data/phys_item_display/call_number"/></h2></td>
       </xsl:if>
       <xsl:if test="notification_data/phys_item_display/accession_number != ''">
        <td><h2><b>@@accession_number@@: </b><xsl:value-of select="notification_data/phys_item_display/accession_number"/></h2></td>
       </xsl:if>
      </tr>
      <xsl:if  test="notification_data/phys_item_display/shelving_location/string" >
       <xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
       <tr>
        <td><b>@@shelving_location_for_item@@: </b>
         <xsl:for-each select="notification_data/phys_item_display/shelving_location/string">
         <xsl:value-of select="."/>
         &#160;
         </xsl:for-each>
        </td>
       </tr>
       </xsl:if>
       <xsl:if  test="notification_data/request/selected_inventory_type='HOLDING'" >
       <tr>
        <td><b>@@shelving_locations_for_holding@@: </b>
        <xsl:for-each select="notification_data/phys_item_display/shelving_location/string">
         <xsl:value-of select="."/>
        &#160;
         </xsl:for-each>
        </td>
       </tr>
       </xsl:if>
       <xsl:if  test="notification_data/request/selected_inventory_type='VIRTUAL_HOLDING'" >
       <tr>
        <td><b>@@shelving_locations_for_holding@@: </b>
        <xsl:for-each select="notification_data/phys_item_display/shelving_location/string">
         <xsl:value-of select="."/>
        &#160;
         </xsl:for-each>
        </td>
       </tr>
       </xsl:if>
      </xsl:if>
      <xsl:if  test="notification_data/phys_item_display/display_alt_call_numbers/string" >
       <xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
       <tr>
        <td><b>@@alt_call_number@@: </b>
         <xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
         <xsl:value-of select="."/>
         &#160;
         </xsl:for-each>
        </td>
       </tr>
       </xsl:if>
       <xsl:if  test="notification_data/request/selected_inventory_type='HOLDING'" >
       <tr>
        <td><b>@@alt_call_number@@: </b>
        <xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
         <xsl:value-of select="."/>
        &#160;
         </xsl:for-each>
        </td>
       </tr>
       </xsl:if>
       <xsl:if  test="notification_data/request/selected_inventory_type='VIRTUAL_HOLDING'" >
       <tr>
        <td><b>@@alt_call_number@@: </b>
        <xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
         <xsl:value-of select="."/>
        &#160;
         </xsl:for-each>
        </td>
       </tr>
       </xsl:if>
      </xsl:if>

      <b></b>

      <tr>
       <td><b>@@move_to_library@@: </b><xsl:value-of select="notification_data/destination"/></td>
      </tr>
      <tr>
       <td><b>@@request_type@@: </b><xsl:value-of select="notification_data/request_type"/></td>
      </tr>

      <xsl:if test="notification_data/request/system_notes != ''">
       <tr>
       <td><b>@@system_notes@@:</b><xsl:value-of select="notification_data/request/system_notes"/></td>
      </tr>
      </xsl:if>

      <xsl:if test="notification_data/request/note != ''">
       <tr>
       <td><b>@@request_note@@:</b> <xsl:value-of select="notification_data/request/note"/></td>
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