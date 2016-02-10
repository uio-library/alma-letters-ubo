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
     <xsl:call-template name="bodyStyleCss" />
     <!-- style.xsl -->
    </xsl:attribute>
    <xsl:call-template name="head" />
    <!-- header.xsl -->

    <table cellspacing="0" cellpadding="5" border="0">
     <tr>
      <td>

       <h3>@@header@@</h3>

      </td>
     </tr>
    </table>

    <div class="messageArea">
     <div class="messageBody">
      <table cellspacing="0" cellpadding="5" border="0">
       <xsl:choose>
        <xsl:when test="notification_data/request/needed_by !=''">
         <tr>
          <td>
           <b>@@requested_by@@: </b>
           <xsl:value-of select="notification_data/request/needed_by"/>
          </td>

         </tr>
        </xsl:when>
        <xsl:otherwise>
         <tr>
          <td>
           <b>@@requested@@ </b>

          </td>
          <td>
              <xsl:value-of select="notification_data/request_sending_date" />
          </td>

         </tr>
        </xsl:otherwise>
       </xsl:choose>
      </table>
      <table cellspacing="0" cellpadding="5" border="0">

       <xsl:attribute name="style">
        <xsl:call-template name="listStyleCss" />
       </xsl:attribute>

       <tr>
        <td>
         <b> @@format@@:  </b>
         <xsl:value-of select="notification_data/request/display/material_type" />
        </td>
       </tr>
       <xsl:if test="notification_data/request/display/title !=''">
        <tr>
         <td>
          <b> @@title@@: </b>
          <xsl:value-of select="notification_data/request/display/title" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/request/display/journal_title !=''">
        <tr>
         <td>
          <b> @@journal_title@@: </b>
          <xsl:value-of select="notification_data/request/display/journal_title" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/request/display/author !=''">
        <tr>
         <td>
          <b> @@author@@: </b>
          <xsl:value-of select="notification_data/request/display/author" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/request/display/autho_initials !=''">
        <tr>
         <td>
          <b> @@author_initials@@: </b>
          <xsl:value-of select="notification_data/request/display/autho_initials" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/request/display/publisher !=''">
        <tr>
         <td>
          <b> @@publisher@@: </b>
          <xsl:value-of select="notification_data/request/display/publisher" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/request/display/place_of_publication !=''">
        <tr>
         <td>
          <b> @@place_of_publication@@: </b>
          <xsl:value-of select="notification_data/request/display/place_of_publication" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/request/display/date !=''">
        <tr>
         <td>
          <b> @@publication_date@@: </b>
          <xsl:value-of select="notification_data/request/display/date" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/request/display/year !=''">
        <tr>
         <td>
          <b> @@year@@: </b>
          <xsl:value-of select="notification_data/request/display/year" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/request/display/edition !=''">
        <tr>
         <td>
          <b> @@edition@@: </b>
          <xsl:value-of select="notification_data/request/display/edition" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/request/display/call_number !=''">
        <tr>
         <td>
          <b> @@call_number@@: </b>
          <xsl:value-of select="notification_data/request/display/call_number" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/request/display/volume !=''">
        <tr>
         <td>
          <b> @@volume@@: </b>
          <xsl:value-of select="notification_data/request/display/volume" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/request/display/issue !=''">
        <tr>
         <td>
          <b> @@issue@@: </b>
          <xsl:value-of select="notification_data/request/display/issue" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/request/display/additional_person_name !=''">
        <tr>
         <td>
          <b> @@additional_person_name@@: </b>
          <xsl:value-of select="notification_data/request/display/additional_person_name" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/request/display/source !=''">
        <tr>
         <td>
          <b> @@source@@: </b>
          <xsl:value-of select="notification_data/request/display/source" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/request/display/series_title_number !=''">
        <tr>
         <td>
          <b> @@series_title_number@@: </b>
          <xsl:value-of select="notification_data/request/display/series_title_number" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/request/display/isbn !=''">
        <tr>
         <td>
          <b> @@isbn@@: </b>
          <xsl:value-of select="notification_data/request/display/isbn" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/request/display/issn !=''">
        <tr>
         <td>
          <b> @@issn@@: </b>
          <xsl:value-of select="notification_data/request/display/issn" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/request/display/doi !=''">
        <tr>
         <td>
          <b> @@doi@@: </b>
          <xsl:value-of select="notification_data/request/display/doi" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/request/display/pmid !=''">
        <tr>
         <td>
          <b> @@pmid@@: </b>
          <xsl:value-of select="notification_data/request/display/pmid" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/request/display/note !=''">
        <tr>
         <td>
          <b> @@note@@: </b>
          <xsl:value-of select="notification_data/request/display/note" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/request/display/chapter !=''">
        <tr>
         <td>
          <b> @@chapter@@: </b>
          <xsl:value-of select="notification_data/request/display/chapter" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/request/display/volume_bk !=''">
        <tr>
         <td>
          <b> @@volume@@: </b>
          <xsl:value-of select="notification_data/request/display/volume_bk" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/request/display/part !=''">
        <tr>
         <td>
          <b> @@part@@: </b>
          <xsl:value-of select="notification_data/request/display/part" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/request/display/pages !=''">
        <tr>
         <td>
          <b> @@pages@@: </b>
          <xsl:value-of select="notification_data/request/display/pages" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/request/display/start_page !=''">
        <tr>
         <td>
          <b> @@start_page@@: </b>
          <xsl:value-of select="notification_data/request/display/start_page" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/request/display/end_page !=''">
        <tr>
         <td>
          <b> @@end_page@@: </b>
          <xsl:value-of select="notification_data/request/display/end_page" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/request/note !=''">
        <tr>
         <td>
          <b> @@request_note@@: </b>
          <xsl:value-of select="notification_data/request/note" />
         </td>
        </tr>
       </xsl:if>

       <tr>
        <td>
         <b> @@date@@: </b>
         <xsl:value-of select="notification_data/general_data/current_date" />
        </td>
       </tr>
       <xsl:if test="notification_data/request/external_request_id !=''">
        <tr>
         <td>
          <b> @@request_id@@: </b>
          <xsl:value-of select="notification_data/request/external_request_id" />
         </td>
        </tr>
       </xsl:if>
       <tr>
        <td>
         <b> @@request_format@@: </b>
         <xsl:value-of select="notification_data/request/format_display" />
        </td>
       </tr>

       <tr><td>&#xA0;</td></tr>

       <tr>
        <td>
         <b> @@note_to_partner@@: </b>
         <xsl:value-of select="notification_data/note_to_partner" />

        </td>
       </tr>



       <xsl:choose>
        <xsl:when test="notification_data/request/max_fee !=''">
         <tr>
          <td>
           <b>@@maximum_fee@@: </b>
           <xsl:value-of select="notification_data/request/max_fee"/>
          </td>
         </tr>
        </xsl:when>
       </xsl:choose>


      </table>
      <br />
      <table>

       <tr>
        <td>@@signature@@</td>
       </tr>
       <tr>
        <td>
         <xsl:value-of select="notification_data/library/name" />
        </td>
       </tr>
       <xsl:if test="notification_data/library/address/line1 !=''">
        <tr>
         <td>
          <xsl:value-of select="notification_data/library/address/line1" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/library/address/line2 !=''">
        <tr>
         <td>
          <xsl:value-of select="notification_data/library/address/line2" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/library/address/line3 !=''">
        <tr>
         <td>
          <xsl:value-of select="notification_data/library/address/line3" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/library/address/line4 !=''">
        <tr>
         <td>
          <xsl:value-of select="notification_data/library/address/line4" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/library/address/line5 !=''">
        <tr>
         <td>
          <xsl:value-of select="notification_data/library/address/line5" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/library/address/city !=''">
        <tr>
         <td>
          <xsl:value-of select="notification_data/library/address/city" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/library/address/country !=''">
        <tr>
         <td>
          <xsl:value-of select="notification_data/library/address/country" />
         </td>
        </tr>

       </xsl:if>
      </table>
     </div>
    </div>
    <xsl:call-template name="lastFooter" />
    <!-- footer.xsl -->
   </body>
  </html>
 </xsl:template>
</xsl:stylesheet>