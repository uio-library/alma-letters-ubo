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



<!-- SKRIPTOTEKETS TILLEGG -->
     <xsl:element name="meta">
          <xsl:attribute name="name">libnummer</xsl:attribute>
          <xsl:attribute name="content">

            <xsl:for-each select="notification_data/request">
                <xsl:if test="contains(calculated_destination_name, 'UiO Arkeologisk bibliotek')">
                 103 &#160; 0011
               </xsl:if>
               <xsl:if test="contains(calculated_destination_name, 'UiO Etnografisk bibliotek')">
                 103 &#160; 0010
               </xsl:if>
               <xsl:if test="contains(calculated_destination_name, 'UiO Etnografisk bibliotek Numismatikk')">
                 103 &#160; 0010
               </xsl:if>
               <xsl:if test="contains(calculated_destination_name, 'UiO HumSam-biblioteket')">
                 103 &#160; 0300
               </xsl:if>
               <xsl:if test="contains(calculated_destination_name, 'UiO Ibsensenterets bibliotek')">
                 103 &#160; 0104
               </xsl:if>
               <xsl:if test="contains(calculated_destination_name, 'UiO Informatikkbiblioteket')">
                 103 &#160; 0317
               </xsl:if>
               <xsl:if test="contains(calculated_destination_name, 'UiO Juridisk bibliotek DB')">
                 103 &#160; 0000
               </xsl:if>
               <xsl:if test="contains(calculated_destination_name, 'UiO Kriminologibiblioteket')">
                 103 &#160; 0002
               </xsl:if>
               <xsl:if test="contains(calculated_destination_name, 'UiO Læringssenteret DN')">
                 103 &#160; 0009
               </xsl:if>
               <xsl:if test="contains(calculated_destination_name, 'UiO Medisinsk bibliotek')">
                 103 &#160; 2300
               </xsl:if>
               <xsl:if test="contains(calculated_destination_name, 'UiO Menneskerettighetsbiblioteket')">
                 103 &#160; 0048
               </xsl:if>
               <xsl:if test="contains(calculated_destination_name, 'UiO NSSF Selvmordsforskning/forebygging')">
                 103 &#160; 2304
               </xsl:if>
               <xsl:if test="contains(calculated_destination_name, 'UiO Naturhistorisk museum biblioteket')">
                 103 &#160; 0500
               </xsl:if>
               <xsl:if test="contains(calculated_destination_name, 'UiO Odontologisk bibliotek')">
                 103 &#160; 0307
               </xsl:if>
               <xsl:if test="contains(calculated_destination_name, 'UiO Offentligrettsbiblioteket')">
                 103 &#160; 0003
               </xsl:if>
               <xsl:if test="contains(calculated_destination_name, 'UiO Petroleums- og EU-rettsbiblioteket')">
                 103 &#160; 0005
               </xsl:if>
               <xsl:if test="contains(calculated_destination_name, 'UiO Privatrettsbiblioteket')">
                 103 &#160; 0001
               </xsl:if>
               <xsl:if test="contains(calculated_destination_name, 'UiO Realfagsbiblioteket')">
                 103 &#160; 0310
               </xsl:if>
               <xsl:if test="contains(calculated_destination_name, 'UiO Rettshistorisk samling')">
                 103 &#160; 0015
               </xsl:if>
               <xsl:if test="contains(calculated_destination_name, 'UiO Rettsinformatikkbiblioteket')">
                 103 &#160; 0004
               </xsl:if>
               <xsl:if test="contains(calculated_destination_name, 'UiO Sjørettsbiblioteket')">
                 103 &#160; 0006
               </xsl:if>
               <xsl:if test="contains(calculated_destination_name, 'UiO Sophus Bugge')">
                 103 &#160; 0303
               </xsl:if>
               <xsl:if test="contains(calculated_destination_name, 'UiO Teologisk bibliotek')">
                 103 &#160; 0301
               </xsl:if>
               <xsl:if test="contains(calculated_destination_name, 'UiO Ullevål sykehus')">
                 103 &#160; 0338
               </xsl:if>
              </xsl:for-each>
                    </xsl:attribute>
        </xsl:element>
        
        <xsl:element name="meta">
          <xsl:attribute name="name">libnummer</xsl:attribute>
          <xsl:attribute name="content">

            <xsl:for-each select="notification_data/request">
               <xsl:if test="contains(calculated_destination_name, 'UiO Juridisk bibliotek DB')">
                 Juridisk bibliotek, DB
               </xsl:if>
               <xsl:if test="contains(calculated_destination_name, 'UiO Kriminologibiblioteket')">
                 IKR-bibl, DN 6. etg.
               </xsl:if>
               <xsl:if test="contains(calculated_destination_name, 'UiO Læringssenteret DN')">
                 Læringssenteret, DN 2. etg
               </xsl:if>
               <xsl:if test="contains(calculated_destination_name, 'UiO Menneskerettighetsbiblioteket')">
                 SMR-bibl, CA 30
               </xsl:if>
               <xsl:if test="contains(calculated_destination_name, 'UiO Offentligrettsbiblioteket')">
                 IOR-bibl, DB
               </xsl:if>
               <xsl:if test="contains(calculated_destination_name, 'UiO Petroleums- og EU-rettsbiblioteket')">
                 EU-bibl, DMØ
               </xsl:if>
               <xsl:if test="contains(calculated_destination_name, 'UiO Rettshistorisk samling')">
                 RS, DB 2. etg
               </xsl:if>
               <xsl:if test="contains(calculated_destination_name, 'UiO Rettsinformatikkbiblioteket')">
                 SERI-bibl, DN 4. etg.
               </xsl:if>
               </xsl:for-each>
           </xsl:attribute>
        </xsl:element>
<!-- SKRIPTOTEKETS TILLEGG SLUTT -->



      </head>

      <body>
        <table width="1500">
        <tr>
          <td>
            <h2>Transit slip</h2>
          </td>
          <td>
            <h2><xsl:value-of select="notification_data/general_data/current_date"/></h2>
          </td>
        </tr>
          <!-- Hvis man skulle ønsker å teste på om boken skal sendes eller ikke:
            <xsl:if test="notification_data/destination = notification_data/organization_unit/name">
          -->
      </table>


      <!-- <xsl:attribute name="style"> -->
          <!-- <xsl:call-template name="bodyStyleCss" /> -->
          <!-- style.xsl -->

      <!--  </xsl:attribute> -->
        <!-- <xsl:call-template name="head" /> -->
        <!-- header.xsl -->
        <div class="messageArea">
          <div class="messageBody transitLetter">
            <table>
              <!--<tr>
                <td><b>@@print_date@@: </b>
                <xsl:value-of select="notification_data/request/create_date" /> -
                
                <xsl:value-of select="notification_data/request/create_time" /></td>
              </tr>
               -->
              <tr>
                <th>
                  <b>@@request_id@@: </b>
         </th>
         <td>
                  <img src="cid:request_id_barcode.png"
                  alt="Request Barcode" />
                </td>
              </tr>
              <tr>
                <th>
                  <b>@@item_barcode@@: </b>
        </th>
        <td>
                  <img src="cid:item_id_barcode.png"
                  alt="Item Barcode" />
                </td>
              </tr>
        <!--
              <tr>
                <td colspan="2">@@we_are_transferring_item_below@@</td>
              </tr>
        -->
<!--        <tr>
        <th><b>Tittel:</b></th>
        <td><xsl:call-template name="recordTitle"/></td>
        </tr>-->
        <xsl:if test="notification_data/phys_item_display/title">
          <tr>
          <th><b>Title: </b></th>
          <td>
          <xsl:value-of select="notification_data/phys_item_display/title" />
          </td>
          </tr>
        </xsl:if>
        <!--
              <tr>
                <th><b>@@transfer_date@@: </b></th>
        <td>
                <xsl:value-of select="notification_data/request/create_date" /> - 
             
               
                <xsl:value-of select="notification_data/request/create_time" /></td>
              </tr>
        -->
        <xsl:if test="notification_data/request/material_type_display">
          <tr>
          <th><b>@@material_type@@: </b></th>
          <td>
          <xsl:value-of select="notification_data/request/material_type_display" />
          </td>
          </tr>
        </xsl:if>
        <!--
              <xsl:if test="notification_data/user_for_printing/note">
                <tr>
                  <th>
                    <b>@@user_note@@:</b>
                  </th>
                  <td>
                    <xsl:value-of select="notification_data/user_for_printing/note" />
                  </td>
                </tr>
              </xsl:if>
        -->
       
              <xsl:if test="notification_data/request/system_notes">
                <tr>
                  <th>
                    <b>@@system_notes@@:</b>
                  </th>
                  <td>
                    <xsl:value-of select="notification_data/request/system_notes" />
                  </td>
               </tr>
              </xsl:if>
            <!--
        <xsl:if test="notification_data/user_for_printing/name">
                <tr>
                  <td>
                    <b>@@requested_for@@:</b>
                  </td>
                </tr>
                <tr>
                  <td>
                    <xsl:value-of select="notification_data/user_for_printing/name" />
                  </td>
                </tr>
                <xsl:if test="notification_data/user_for_printing/email">
                  <tr>
                    <td><b>@@email@@: </b>
                    <xsl:value-of select="notification_data/user_for_printing/email" /></td>
                  </tr>
                </xsl:if>
                <xsl:if test="notification_data/user_for_printing/phone">
                  <tr>
                    <td><b>@@tel@@: </b>
                    <xsl:value-of select="notification_data/user_for_printing/phone" /></td>
                  </tr>
                </xsl:if>
                <tr>
                  <td><b>@@request_date@@: </b>
                  <xsl:value-of select="notification_data/request/create_date" /></td>
                </tr>
                <xsl:if test="notification_data/request/lastInterestDate">
                  <tr>
                    <td><b>@@expiration_date@@: </b>
                    <xsl:value-of select="notification_data/request/lastInterestDate" /></td>
                  </tr>
                </xsl:if>
              </xsl:if>
        -->
        <!-- <xsl:if test="notification_data/phys_item_display/owning_library_name">
                  <tr>
                    <td><b>@@owning_library@@: </b>
                    <xsl:value-of select="notification_data/phys_item_display/owning_library_name" /></td>
                  </tr>
                </xsl:if>
        -->
            </table>
      <hr />
            <table>
              <tr>
                <th><b>@@from@@: </b>
        </th>
        <td>
                <xsl:value-of select="notification_data/request/assigned_unit_name" />
        </td>        
        </tr>
        <tr>
        <th><b>@@to@@: </b></th>
        <td>
                <xsl:value-of select="notification_data/request/calculated_destination_name" />
        </td>
              </tr>
            </table>
          </div>
        </div>
    
    
    

        <!-- recordTitle.xsl -->
 <!--       <xsl:call-template name="lastFooter" />
 -->
        <!-- footer.xsl -->
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>