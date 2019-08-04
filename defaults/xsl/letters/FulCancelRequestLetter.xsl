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

<xsl:if test="notification_data/request/status_note= 'ConvertedToResourceSharingRequest'">
      <xsl:message terminate="yes">Converted to Resource Sharing Request - No automatic cancellation letter sent</xsl:message>
</xsl:if>
    <xsl:attribute name="style">
    <xsl:call-template name="bodyStyleCss" /> <!-- style.xsl -->
   </xsl:attribute>
    <xsl:call-template name="head" /> <!-- header.xsl -->
    <xsl:call-template name="senderReceiver" /> <!-- SenderReceiver.xsl -->
    <xsl:call-template name="toWhomIsConcerned" /> <!-- mailReason.xsl -->

    <div class="messageArea">
     <div class="messageBody">
      <table cellspacing="0" cellpadding="5" border="0">
       <tr>
        <td>
         @@on@@
         <xsl:value-of select="notification_data/general_data/current_date" />
         @@we_cancel_y_req_of@@
         <xsl:value-of select="notification_data/request/create_date" />
         @@detailed_below@@ :
        </td>
       </tr>
       <tr>
        <td>
         <xsl:call-template name="recordTitle" /> <!-- recordTitle.xsl -->
        </td>
       </tr>
       <!-- <xsl:if test="notification_data/metadata/title != ''">
        <tr>
         <td>
          <b>@@title@@: </b>
          <xsl:value-of select="notification_data/metadata/title" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/metadata/journal_title != ''">
        <tr>
         <td>
          <b> @@journal_title@@: </b>
          <xsl:value-of select="notification_data/metadata/journal_title" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/metadata/author != ''">
        <tr>
         <td>
          <b> @@author@@: </b>
          <xsl:value-of select="notification_data/metadata/author" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/metadata/author_initials != ''">
        <tr>
         <td>
          <b>@@author_initials@@: </b>
          <xsl:value-of select="notification_data/metadata/author_initials" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/metadata/edition != ''">
        <tr>
         <td>
          <b> @@edition@@: </b>
          <xsl:value-of select="notification_data/metadata/edition" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/metadata/identifier != ''">
        <tr>
         <td>
          <b>@@identifier@@: </b>
          <xsl:value-of select="notification_data/metadata/identifier" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/metadata/lccn != ''">
        <tr>
         <td>
          <b> @@lccn@@: </b>
          <xsl:value-of select="notification_data/metadata/lccn" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/metadata/issn != ''">
        <tr>
         <td>
          <b>@@issn@@: </b>
          <xsl:value-of select="notification_data/metadata/issn" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/metadata/isbn != ''">
        <tr>
         <td>
          <b> @@isbn@@: </b>
          <xsl:value-of select="notification_data/metadata/isbn" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/metadata/oclc_nr != ''">
        <tr>
         <td>
          <b> @@oclc_nr@@: </b>
          <xsl:value-of select="notification_data/metadata/oclc_nr" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/metadata/doi != ''">
        <tr>
         <td>
          <b>@@doi@@: </b>
          <xsl:value-of select="notification_data/metadata/doi" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/metadata/pmid != ''">
        <tr>
         <td>
          <b> @@pmid@@: </b>
          <xsl:value-of select="notification_data/metadata/pmid" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/metadata/publisher != ''">
        <tr>
         <td>
          <b> @@publisher@@: </b>
          <xsl:value-of select="notification_data/metadata/publisher" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/metadata/publication_date != ''">
        <tr>
         <td>
          <b>@@publication_date@@: </b>
          <xsl:value-of select="notification_data/metadata/publication_date" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/metadata/place_of_publication != ''">
        <tr>
         <td>
          <b> @@place_of_publication@@: </b>
          <xsl:value-of select="notification_data/metadata/place_of_publication" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/metadata/additional_person_name != ''">
        <tr>
         <td>
          <b> @@additional_person_name@@: </b>
          <xsl:value-of select="notification_data/metadata/additional_person_name" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/metadata/source != ''">
        <tr>
         <td>
          <b>@@source@@: </b>
          <xsl:value-of select="notification_data/metadata/source" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/metadata/series_title_number != ''">
        <tr>
         <td>
          <b> @@series_title_number@@: </b>
          <xsl:value-of select="notification_data/metadata/series_title_number" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/metadata/call_number != ''">
        <tr>
         <td>
          <b> @@call_number@@: </b>
          <xsl:value-of select="notification_data/metadata/call_number" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/metadata/volume != ''">
        <tr>
         <td>
          <b>@@volume@@: </b>
          <xsl:value-of select="notification_data/metadata/volume" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/metadata/part != ''">
        <tr>
         <td>
          <b> @@part@@: </b>
          <xsl:value-of select="notification_data/metadata/part" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/metadata/chapter != ''">
        <tr>
         <td>
          <b> @@chapter@@: </b>
          <xsl:value-of select="notification_data/metadata/chapter" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/metadata/pages != ''">
        <tr>
         <td>
          <b>@@pages@@: </b>
          <xsl:value-of select="notification_data/metadata/pages" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/metadata/start_page != ''">
        <tr>
         <td>
          <b> @@start_page@@: </b>
          <xsl:value-of select="notification_data/metadata/start_page" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/metadata/end_pagee != ''">
        <tr>
         <td>
          <b> @@end_page@@: </b>
          <xsl:value-of select="notification_data/metadata/end_page" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/metadata/issue != ''">
        <tr>
         <td>
          <b>@@issue@@: </b>
          <xsl:value-of select="notification_data/metadata/issue" />
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/metadata/note != ''">
        <tr>
         <td>
          <b> @@note@@: </b>
          <xsl:value-of select="notification_data/metadata/note" />
         </td>
        </tr>
       </xsl:if> -->


       <xsl:if test="notification_data/request/start_time != ''">
        <tr>
         <td>
          <b> @@start_time@@: </b>
          <xsl:value-of select="notification_data/booking_start_time_str" />
         </td>
        </tr>
       </xsl:if>
      <xsl:if test="notification_data/request/end_time != ''">
        <tr>
         <td>
          <b> @@end_time@@: </b>
          <xsl:value-of select="notification_data/booking_end_time_str" />
         </td>
        </tr>
       </xsl:if>
      <xsl:if test="notification_data/request/note != ''">
        <tr>
         <td>
          <b> @@request_note@@: </b>
          <xsl:value-of select="notification_data/request/note" />
         </td>
        </tr>
       </xsl:if>
       <tr>
        <td>
         <b> @@reason_deleting_request@@: </b>
         <xsl:value-of select="notification_data/request/status_note_display" />
        </td>
       </tr>
       <xsl:if test="notification_data/request/cancel_reason != ''">
        <tr>
         <td>
          <b> @@request_cancellation_note@@: </b>
          <xsl:value-of select="notification_data/request/cancel_reason" />
         </td>
        </tr>
       </xsl:if>
      </table>
      <br />
      <table>

       <tr>
        <td>@@sincerely@@</td>
       </tr>
       <tr>
        <td>@@department@@</td>
       </tr>

      </table>
     </div>
    </div>
    <xsl:call-template name="lastFooter" /> <!-- footer.xsl -->
    <xsl:call-template name="contactUs" />
   </body>
  </html>
 </xsl:template>
</xsl:stylesheet>