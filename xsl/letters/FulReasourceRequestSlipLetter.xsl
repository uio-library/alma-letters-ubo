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

   <!-- DM 2016-01-13: Skriver ut libnummer i footer hvis mottaker er et bibliotek, slik
        at lappen også kan tjene som sendelapp.
        Ref.: https://trello.com/c/zNBDgUdg/5-pickup-from-shelf-lagt-inn-advarsel-obs-mottaker-er-et-bibliotek-pass-pa-at-dokumentet-ikke-havner-pa-hentehylla-hvis-mottaker-h
   -->
   <xsl:if test="contains(notification_data/user_for_printing/identifiers/code_value[1]/value, 'lib')">
    <xsl:element name="meta">
     <xsl:attribute name="name">libnummer</xsl:attribute>
     <xsl:attribute name="content">
      <xsl:value-of select="substring(notification_data/user_for_printing/identifiers/code_value[1]/value, 4, 3)"/>&#160;&#160;<xsl:value-of select="substring(notification_data/user_for_printing/identifiers/code_value[1]/value, 7, 4)"/>
     </xsl:attribute>
    </xsl:element>
   </xsl:if>
   <!-- SLUTT: DM 2016-01-13 -->

  </head>

   <body>

    <table width="100%">
    <tr>
     <!-- Fredriks tillegg: Hvis på hentehylle: Hentenr, konstruert av hentefrist og tre siste siffer i LTID. Hvis ikke hentehylle, skriv noe annet -->
     <xsl:choose>
      <xsl:when test="notification_data/request/work_flow_entity/step_type = 'ON_HOLD_SHELF'">
 
       <!-- Hentenummer: -->
       <xsl:if test="not(contains(notification_data/user_for_printing/identifiers/code_value[1]/value, 'lib'))">
        <td>
         <b><font size="12">
          <xsl:value-of select="substring-before(notification_data/request/work_flow_entity/expiration_date,'/')"/>-<xsl:value-of select="substring(notification_data/user_for_printing/identifiers/code_value/value, string-length(notification_data/user_for_printing/identifiers/code_value/value)-2)"/>
         </font></b>
        </td>
       </xsl:if>

      </xsl:when>
      <xsl:otherwise>
       <td>
        <h2>
         <xsl:choose>
          <xsl:when test="notification_data/request/work_flow_entity/step_type = 'PICKUP_FROM_SHELF'">
           Pickup From Shelf
          </xsl:when>
          <xsl:otherwise>
           Resource Request
          </xsl:otherwise>
         </xsl:choose>
        </h2>
       </td>
       <td align="right" valign="top">
        <tt>
         <xsl:call-template name="normalizedDate"><!-- header.xsl -->
                    <xsl:with-param name="value" select="notification_data/request/create_date"/>
                  </xsl:call-template>
                  &#160;<xsl:value-of select="notification_data/request/create_time"/>
        </tt>
       </td>
      </xsl:otherwise>
     </xsl:choose>
    </tr>
     <!-- Hvis man skulle ønsker å teste på om boken skal sendes eller ikke:
      <xsl:if test="notification_data/destination = notification_data/organization_unit/name">
     -->
   </table>
<!--
    <xsl:call-template name="head" />
-->


   <div class="messageArea">
    <div class="messageBody">

     <table cellspacing="0" cellpadding="5" border="0" width="100%">


      <!-- S1: Infotekst til hentehyllelapp -->
      <xsl:if test="notification_data/request/work_flow_entity/step_type = 'ON_HOLD_SHELF'">
        <!-- Skulle gjerne testet språk, men det finnes ikke i XML-en -->
        <!--
        <xsl:choose>
         <xsl:when test="notification_data/receivers/receiver/preferred_language = 'no'">
          <h1>Til henting</h1>
          <h2>Lån ut eksemplaret til Dem selv på automaten</h2>
         </xsl:when>
        <xsl:otherwise>
         <h1>For pick-up</h1>
         <h2>Please check out the item on the machine</h2>
        </xsl:otherwise>
       </xsl:choose>
       -->
       <h1>Til henting / for pick-up</h1>
       <h2><ul>
        <li>Lån ut eksemplaret til Dem selv på automaten</li>
        <li>Please check out the item on the machine</li>
       </ul></h2>
       <hr/>
      </xsl:if>
      <!-- S1: SLUTT -->


       <!-- S2: Strekkoder, etc. Skjules for hentehylleseddel -->
      <xsl:if test="notification_data/request/work_flow_entity/step_type != 'ON_HOLD_SHELF'">
       <xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
       <tr>
        <td></td>
        <td><b>@@note_item_specified_request@@.</b></td>
       </tr>
       </xsl:if>
       <tr>
        <td valign="top" colspan="2" align="center">
         <font size="2">@@request_id@@:</font><br/>
         <img src="cid:request_id_barcode.png" alt="Request Barcode"/>
        </td>
       </tr>
       <xsl:if test="notification_data/request/selected_inventory_type='ITEM'" >
       <tr>
        <td valign="top" colspan="2" align="center">
         <font size="2">@@item_barcode@@:</font><br/>
         <img src="cid:item_id_barcode.png" alt="Item Barcode"/>
        </td>
       </tr>
       </xsl:if>
      </xsl:if>
      <!-- S2: SLUTT -->


      <!-- Horizontal line -->
      <tr><td colspan="2"><hr/></td></tr>


      <!-- S3: Grunnleggende metadata: tittel/forfatter m.m. Vises uansett brevtype-->
      <tr>
       <td><font color="#666666">Title:</font></td>
       <td>
        <xsl:value-of select="notification_data/phys_item_display/title_abcnph"/>
       </td>
      </tr>
      <tr>
       <td><font color="#666666">By:</font></td>
       <td>
        <xsl:value-of select="notification_data/phys_item_display/author"/>
       </td>
      </tr>
      <xsl:if test="notification_data/phys_item_display/isbn != ''">
       <tr>
        <td><font color="#666666">@@isbn@@:</font></td>
        <td>
         <xsl:value-of select="notification_data/phys_item_display/isbn"/>
        </td>
       </tr>
      </xsl:if>
      <xsl:if test="notification_data/phys_item_display/issn != ''">
       <tr>
        <td><font color="#666666">@@issn@@:</font></td>
        <td>
         <xsl:value-of select="notification_data/phys_item_display/issn"/>
        </td>
       </tr>
      </xsl:if>
      <tr>
       <td><font color="#666666">Edition/year:</font></td>
       <td>
        <xsl:value-of select="notification_data/phys_item_display/edition"/>
        <xsl:if test="notification_data/phys_item_display/edition != ''">
         &#160;
        </xsl:if>
        <xsl:value-of select="notification_data/phys_item_display/publication_date"/>
       </td>
      </tr>
      <xsl:if test="notification_data/request/record_display_section/series_small != ''" >
       <tr>
        <td><font color="#666666">Series:</font></td>
        <td>
         <xsl:value-of select="notification_data/request/record_display_section/series_small"/>
        </td>
       </tr>
      </xsl:if>
      <xsl:if  test="notification_data/request/manual_description != ''" >
       <tr>
        <td>
         <em><font color="#666666">Description: </font></em>
        </td>
        <td>
         <b>
          <xsl:value-of select="notification_data/request/manual_description"/>
         </b>
        </td>
       </tr>
      </xsl:if>
      <!--
      <xsl:if test="notification_data/phys_item_display/imprint != ''">
       <tr>
       <td>@@imprint@@: <xsl:value-of select="notification_data/phys_item_display/imprint"/></td>
       </tr>
      </xsl:if>
      <xsl:if test="notification_data/phys_item_display/edition != ''">
       <tr>
       <td>@@edition@@: <xsl:value-of select="notification_data/phys_item_display/edition"/></td>
       </tr>
      </xsl:if>
     -->
     <!-- S3: SLUTT -->

     <!-- S4: Skjules for hentehylleseddel -->
     <xsl:if test="notification_data/request/work_flow_entity/step_type != 'ON_HOLD_SHELF'">


      <!-- Horizontal line -->
      <tr><td colspan="2"><hr/></td></tr>


      <!-- Destination, request type, notes -->
      <tr>
       <td><font color="#666666">@@request_type@@:</font></td>
       <td>
        <xsl:value-of select="notification_data/request_type"/>
        (<xsl:value-of select="notification_data/request/request_type"/>)
       </td>
      </tr>
      <xsl:if test="notification_data/user_for_printing/name">
       <tr>
        <td valign="top">
         <font color="#666666">@@requested_for@@:</font>
        </td>
        <td>
         <xsl:value-of select="notification_data/user_for_printing/identifiers/code_value[1]/value"/>
         :
         <xsl:value-of select="notification_data/user_for_printing/name"/>

         <!-- Reference: user_group

          │1  Egne studenter                     15. Nasjonalbiblioteket               │
          │2  Egne studenter - høyere grad       16. Folkebiblioteksektoren            │
          │3  Egne fjernstudenter                17. Bibl. i grunn-/videregående skole │
          │4  Egne ansatte                       18.-19. Ikke i bruk                   │
          │5  Ekst. stipendiater egen inst.      20. Bibliotek og lign.inst. i Danmark │
          │6  Stud./stip./ans. andre utd.inst -  21. Bibliotek og lign.inst. i Sverige │
          │7  Enkeltpersoner                     22. Bibliotek og lign.inst. i Finland │
          │8  Bedrifter/inst. uten bibliotek     23. Bibliotek og lign.inst. i Island  │
          │9  Ikke i bruk                        24. Øvrige Europeiske bibliotek       │
          │10 Andre bibenheter innen samme inst. 25. Verden ellers                     │
          │11 Universitetsbibliotek i Norge      50. Bokbinder                         │
          │12 Høgskolebibliotek i Norge                                                │
          │13 Bedriftsbibliotek i Norge          55-99 Internt bruk v/bibliotekenheten │
          │14 Andre fag- og forskningsbibliotek                                        │
            └──────────────────────────────────────────────────────────────
         -->
         <xsl:if test="notification_data/request/user_group = '4'">
           (egne ansatte)
         </xsl:if>
        </td>
       </tr>
      </xsl:if>
      <xsl:if  test="notification_data/external_id != ''" >
       <tr>
        <td valign="top">
         <font color="#666666">@@external_id@@:</font>
        </td>
        <td>
         <xsl:value-of select="notification_data/external_id"/>
        </td>
       </tr>
      </xsl:if>
      <tr>
       <td><font color="#666666">@@move_to_library@@:</font></td>
       <td>
        <xsl:value-of select="notification_data/destination"/>
       </td>
      </tr>
      <xsl:if test="notification_data/request/system_notes != ''">
       <tr>
        <td><font color="#666666">@@system_notes@@:</font></td>
        <td>
         <xsl:value-of select="notification_data/request/system_notes"/>
        </td>
       </tr>
      </xsl:if>
      <xsl:if test="notification_data/request/note != ''">
       <tr>
        <td><font color="#666666"><em>@@request_note@@:</em></font></td>
        <td bgcolor="#EEEEEE">
         <b>
          <xsl:value-of select="notification_data/request/note"/>
         </b>
        </td>
       </tr>
      </xsl:if>


      <!-- Horizontal line -->
      <tr><td colspan="2"><hr/></td></tr>


      <!-- Physical location: Hvor man finner den der boka... -->
      <!-- Informasjonen er av og til misvisende. Det virker som den viser holding boka er bestilt på, uavhengig av hvilken holding som faktisk har ledige items. Eks: Bok bestilt på pensum, men ledig i boksamling - viser fortsatt pensum.. Så det virker 
      bedre å baserer seg på available_items  (under). Litt usikker på om vi burde ha en test på aksede bøker og andre spesialtilfeller...
       <tr>
        <td>
         <font color="#666666">Location (requested):</font>
        </td>
        <td bgcolor="#EEEEEE">
         <xsl:value-of select="notification_data/phys_item_display/location_name"/>
         <xsl:if test="notification_data/phys_item_display/call_number != ''">
          &#160;<xsl:value-of select="notification_data/phys_item_display/call_number"/>
         </xsl:if>
         <xsl:if test="notification_data/phys_item_display/accession_number != ''">
          &#160; - @@accession_number@@:
          <xsl:value-of select="notification_data/phys_item_display/accession_number"/>
         </xsl:if>
        </td>
       </tr>
       <xsl:if test="notification_data/phys_item_display/shelving_location/string" >
        <xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
         <tr>
          <td>
           <font color="#666666">@@shelving_location_for_item@@: </font>
          </td>
          <td>
           <xsl:for-each select="notification_data/phys_item_display/shelving_location/string">
            <xsl:value-of select="."/>
             &#160;
            </xsl:for-each>
          </td>
         </tr>
        </xsl:if>
        <xsl:if test="notification_data/request/selected_inventory_type='HOLDING'" >
         <tr>
          <td>
           <font color="#666666">@@shelving_locations_for_holding@@: </font>
          </td>
          <td>
           <xsl:for-each select="notification_data/phys_item_display/shelving_location/string">
            <xsl:value-of select="."/>
            &#160;
            </xsl:for-each>
          </td>
         </tr>
        </xsl:if>
        <xsl:if test="notification_data/request/selected_inventory_type='VIRTUAL_HOLDING'" >
         <tr>
          <td>
           <font color="#666666">@@shelving_locations_for_holding@@: </font>
          </td>
          <td>
           <xsl:for-each select="notification_data/phys_item_display/shelving_location/string">
            <xsl:value-of select="."/>
            &#160;
            </xsl:for-each>
          </td>
         </tr>
        </xsl:if>
       </xsl:if>
       <xsl:if test="notification_data/phys_item_display/display_alt_call_numbers/string" >
        <xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
         <tr>
          <td>
           <font color="#666666">@@alt_call_number@@: </font>
          </td>
          <td>
           <xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
            <xsl:value-of select="."/>
             &#160;
            </xsl:for-each>
          </td>
         </tr>
        </xsl:if>
        <xsl:if test="notification_data/request/selected_inventory_type='HOLDING'" >
        <tr>
         <td>
          <font color="#666666">@@alt_call_number@@: </font>
         </td>
         <td>
          <xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
           <xsl:value-of select="."/>
           &#160;
           </xsl:for-each>
         </td>
        </tr>
        </xsl:if>
        <xsl:if test="notification_data/request/selected_inventory_type='VIRTUAL_HOLDING'" >
        <tr>
         <td>
          <font color="#666666">@@alt_call_number@@: </font>
         </td>
         <td>
          <xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
           <xsl:value-of select="."/>
           &#160;
           </xsl:for-each>
         </td>
        </tr>
        </xsl:if>
       </xsl:if>
       -->

      <tr><td colspan="2">

       <!-- ITEM -->
       <xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
        <p>
         @@shelving_location_for_item@@:
        </p>
        <xsl:for-each select="notification_data/phys_item_display/shelving_location/string">
         <xsl:value-of select="."/>
         </xsl:for-each>
       </xsl:if>

       <xsl:if test="notification_data/request/selected_inventory_type='VIRTUAL_HOLDING'" >
        <p>
         @@shelving_locations_for_holding@@:
        </p>
        <p>
         <xsl:for-each select="notification_data/phys_item_display/shelving_location/string">
          <xsl:value-of select="."/>
          </xsl:for-each>
         </p>
       </xsl:if>

       <!-- DMOH 2016-01-04: Viser barcode for available items -->
       <xsl:if test="notification_data/request/selected_inventory_type='HOLDING'" >
        <xsl:if test="count(notification_data/phys_item_display/available_items/available_item[library_code=/notification_data/organization_unit/code]) != 0">
         <p>
          Available item(s):
         </p>
         <table>
          <xsl:for-each select="notification_data/phys_item_display/available_items/available_item[library_code=/notification_data/organization_unit/code]">
           <tr>
            <td>
             <font size="4"><xsl:value-of select="barcode"/></font>
            </td>
            <td>
             <font size="4"><xsl:value-of select="location_name"/></font>
            </td>
            <td>
             <u><font size="4"><xsl:value-of select="call_number"/></font></u>
            </td>
            <td>
             <xsl:value-of select="public_note"/>
            </td>
           </tr>
           </xsl:for-each>
         </table>
        </xsl:if>
         <xsl:if test="count(notification_data/phys_item_display/available_items/available_item[library_code=/notification_data/organization_unit/code]) = 0">
          <p>
           <strong>
             <xsl:value-of select="notification_data/phys_item_display/location_name"/>
           <xsl:if test="notification_data/phys_item_display/call_number != ''">
            &#160;<xsl:value-of select="notification_data/phys_item_display/call_number"/>
           </xsl:if>
           <xsl:if test="notification_data/phys_item_display/accession_number != ''">
            &#160; - @@accession_number@@:
            <xsl:value-of select="notification_data/phys_item_display/accession_number"/>
           </xsl:if>
          </strong>

          <xsl:for-each select="notification_data/phys_item_display/summary_holding_infos/summary_holding_info">
           <span>
             &#160;&#160;
             <xsl:value-of select="summary_holding"/>
             &#160;
             <xsl:value-of select="notes/string"/>
            </span>
          </xsl:for-each>
          </p>
         </xsl:if>
       </xsl:if>
       <!-- DMOH 2016-01-04 SLUTT -->
      </td></tr>

     </xsl:if>
     <!-- S4: SLUTT -->

     <tr><td colspan="2">

      <!-- DM 2016-01-13 -->
      <xsl:if test="contains(notification_data/user_for_printing/identifiers/code_value[1]/value, 'lib')">
       <p>
        <hr/>
        <strong>
         OBS!
        </strong>
        <em>Mottaker er et bibliotek. Pass på at dokumentet ikke ender på hentehylla, men blir lånt ut og sendt.</em>
       </p>
      </xsl:if>
      <!-- SLUTT: DM 2016-01-13 -->

     </td></tr>
    </table>

    </div>
   </div>


  <!-- SKRIPTOTEKETS TILLEGG -->
  <!--
  <xsl:if test="notification_data/request/work_flow_entity/step_type != 'ON_HOLD_SHELF'">
   <b><font size="120">
   <xsl:for-each select="notification_data">
                 <xsl:if test="destination='UiO Arkeologisk bibliotek'">
       103 &#160; 0011
     </xsl:if>
     <xsl:if test="destination='UiO Etnografisk bibliotek'">
       103 &#160; 0010
     </xsl:if>
     <xsl:if test="destination='UiO HumSam-biblioteket'">
       103 &#160; 0300
     </xsl:if>
     <xsl:if test="destination='UiO Ibsensenterets bibliotek'">
       103 &#160; 0104
     </xsl:if>
     <xsl:if test="destination='UiO Informatikkbiblioteket'">
       103 &#160; 0317
     </xsl:if>
     <xsl:if test="destination='UiO Juridisk bibliotek DB'">
       103 &#160; 0000
     </xsl:if>
     <xsl:if test="destination='UiO Kriminologibiblioteket'">
       103 &#160; 0002
     </xsl:if>
     <xsl:if test="destination='UiO Læringssenteret DN'">
       103 &#160; 0009
     </xsl:if>
     <xsl:if test="destination='UiO Medisinsk bibliotek'">
       103 &#160; 2300
     </xsl:if>
     <xsl:if test="destination='UiO Menneskerettighetsbiblioteket'">
       103 &#160; 0048
     </xsl:if>
     <xsl:if test="destination='UiO NSSF Selvmordsforskning/forebygging'">
       103 &#160; 2304
     </xsl:if>
     <xsl:if test="destination='UiO Naturhistorisk museum biblioteket'">
       103 &#160; 0500
     </xsl:if>
     <xsl:if test="destination='UiO Odontologisk bibliotek'">
       103 &#160; 0307
     </xsl:if>
     <xsl:if test="destination='UiO Offentligrettsbiblioteket'">
       103 &#160; 0003
     </xsl:if>
     <xsl:if test="destination='UiO Petroleums- og EU-rettsbiblioteket'">
       103 &#160; 0005
     </xsl:if>
     <xsl:if test="destination='UiO Privatrettsbiblioteket'">
       103 &#160; 0001
     </xsl:if>
     <xsl:if test="destination='UiO Realfagsbiblioteket'">
       103 &#160; 0310
     </xsl:if>
     <xsl:if test="destination='UiO Rettshistorisk samling'">
       103 &#160; 0015
     </xsl:if>
     <xsl:if test="destination='UiO Rettsinformatikkbiblioteket'">
       103 &#160; 0004
     </xsl:if>
     <xsl:if test="destination='UiO Sjørettsbiblioteket'">
       103 &#160; 0006
     </xsl:if>
     <xsl:if test="destination='UiO Sophus Bugge'">
       103 &#160; 0303
     </xsl:if>
     <xsl:if test="destination='UiO Teologisk bibliotek'">
       103 &#160; 0301
     </xsl:if>
    </xsl:for-each>
    </font>
   </b>
  </xsl:if>
 -->
<!-- SKRIPTOTEKETS TILLEGG SLUTT -->



   <!-- Footer til hentehyllelapp -->
   <!--

   <xsl:if test="notification_data/request/work_flow_entity/step_type = 'ON_HOLD_SHELF'">
    <xsl:call-template name="lastFooter" />
   </xsl:if>
  -->

  <!-- SLUTT Footer til hentehyllelapp -->


</body>
</html>


 </xsl:template>
</xsl:stylesheet>