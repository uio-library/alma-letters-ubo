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
  <xsl:call-template name="email-template"/><!-- header.xsl -->
</xsl:template>

<xsl:template match="/notification_data">

  <xsl:call-template name="email-logo"/><!-- header.xsl -->
  <!--<xsl:call-template name="toWhomIsConcerned"/>--><!-- mailReason.xsl -->

  <h3>@@header@@</h3>

  <p>
    <xsl:choose>
      <xsl:when test="request/needed_by !=''">
        @@requested_by@@:
        <xsl:value-of select="request/needed_by"/>
      </xsl:when>
      <xsl:otherwise>
        @@requested@@ <xsl:value-of select="request_sending_date" />:
      </xsl:otherwise>
    </xsl:choose>
  </p>

  <table width="100%" cellspacing="0" cellpadding="5" border="0" style="font-family: Arial, Helvetica, sans-serif;font-size: 13px; color:#5F6163; border: 1px solid #ddd;">
   <tr>
    <td>
     <b> @@format@@:  </b>
     <xsl:value-of select="request/display/material_type" />
    </td>
   </tr>
   <xsl:if test="request/display/title !=''">
    <tr>
     <td>
      <b> @@title@@: </b>
      <xsl:value-of select="request/display/title" />
     </td>
    </tr>
   </xsl:if>
   <xsl:if test="request/display/journal_title !=''">
    <tr>
     <td>
      <b> @@journal_title@@: </b>
      <xsl:value-of select="request/display/journal_title" />
     </td>
    </tr>
   </xsl:if>
   <xsl:if test="request/display/author !=''">
    <tr>
     <td>
      <b> @@author@@: </b>
      <xsl:value-of select="request/display/author" />
     </td>
    </tr>
   </xsl:if>
   <xsl:if test="request/display/autho_initials !=''">
    <tr>
     <td>
      <b> @@author_initials@@: </b>
      <xsl:value-of select="request/display/autho_initials" />
     </td>
    </tr>
   </xsl:if>
   <xsl:if test="request/display/publisher !=''">
    <tr>
     <td>
      <b> @@publisher@@: </b>
      <xsl:value-of select="request/display/publisher" />
     </td>
    </tr>
   </xsl:if>
   <xsl:if test="request/display/place_of_publication !=''">
    <tr>
     <td>
      <b> @@place_of_publication@@: </b>
      <xsl:value-of select="request/display/place_of_publication" />
     </td>
    </tr>
   </xsl:if>
   <xsl:if test="request/display/date !=''">
    <tr>
     <td>
      <b> @@publication_date@@: </b>
      <xsl:value-of select="request/display/date" />
     </td>
    </tr>
   </xsl:if>
   <xsl:if test="request/display/year !=''">
    <tr>
     <td>
      <b> @@year@@: </b>
      <xsl:value-of select="request/display/year" />
     </td>
    </tr>
   </xsl:if>
   <xsl:if test="request/display/edition !=''">
    <tr>
     <td>
      <b> @@edition@@: </b>
      <xsl:value-of select="request/display/edition" />
     </td>
    </tr>
   </xsl:if>
   <xsl:if test="request/display/call_number !=''">
    <tr>
     <td>
      <b> @@call_number@@: </b>
      <xsl:value-of select="request/display/call_number" />
     </td>
    </tr>
   </xsl:if>
   <xsl:if test="request/display/volume !=''">
    <tr>
     <td>
      <b> @@volume@@: </b>
      <xsl:value-of select="request/display/volume" />
     </td>
    </tr>
   </xsl:if>
   <xsl:if test="request/display/issue !=''">
    <tr>
     <td>
      <b> @@issue@@: </b>
      <xsl:value-of select="request/display/issue" />
     </td>
    </tr>
   </xsl:if>
   <xsl:if test="request/display/additional_person_name !=''">
    <tr>
     <td>
      <b> @@additional_person_name@@: </b>
      <xsl:value-of select="request/display/additional_person_name" />
     </td>
    </tr>
   </xsl:if>
   <xsl:if test="request/display/source !=''">
    <tr>
     <td>
      <b> @@source@@: </b>
      <xsl:value-of select="request/display/source" />
     </td>
    </tr>
   </xsl:if>
   <xsl:if test="request/display/series_title_number !=''">
    <tr>
     <td>
      <b> @@series_title_number@@: </b>
      <xsl:value-of select="request/display/series_title_number" />
     </td>
    </tr>
   </xsl:if>
   <xsl:if test="request/display/isbn !=''">
    <tr>
     <td>
      <b> @@isbn@@: </b>
      <xsl:value-of select="request/display/isbn" />
     </td>
    </tr>
   </xsl:if>
   <xsl:if test="request/display/issn !=''">
    <tr>
     <td>
      <b> @@issn@@: </b>
      <xsl:value-of select="request/display/issn" />
     </td>
    </tr>
   </xsl:if>
   <xsl:if test="request/display/doi !=''">
    <tr>
     <td>
      <b> @@doi@@: </b>
      <xsl:value-of select="request/display/doi" />
     </td>
    </tr>
   </xsl:if>
   <xsl:if test="request/display/pmid !=''">
    <tr>
     <td>
      <b> @@pmid@@: </b>
      <xsl:value-of select="request/display/pmid" />
     </td>
    </tr>
   </xsl:if>
   <xsl:if test="request/display/note !=''">
    <tr>
     <td>
      <b> @@note@@: </b>
      <xsl:value-of select="request/display/note" />
     </td>
    </tr>
   </xsl:if>
   <xsl:if test="request/display/chapter !=''">
    <tr>
     <td>
      <b> @@chapter@@: </b>
      <xsl:value-of select="request/display/chapter" />
     </td>
    </tr>
   </xsl:if>
   <xsl:if test="request/display/volume_bk !=''">
    <tr>
     <td>
      <b> @@volume@@: </b>
      <xsl:value-of select="request/display/volume_bk" />
     </td>
    </tr>
   </xsl:if>
   <xsl:if test="request/display/part !=''">
    <tr>
     <td>
      <b> @@part@@: </b>
      <xsl:value-of select="request/display/part" />
     </td>
    </tr>
   </xsl:if>
   <xsl:if test="request/display/pages !=''">
    <tr>
     <td>
      <b> @@pages@@: </b>
      <xsl:value-of select="request/display/pages" />
     </td>
    </tr>
   </xsl:if>
   <xsl:if test="request/display/start_page !=''">
    <tr>
     <td>
      <b> @@start_page@@: </b>
      <xsl:value-of select="request/display/start_page" />
     </td>
    </tr>
   </xsl:if>
   <xsl:if test="request/display/end_page !=''">
    <tr>
     <td>
      <b> @@end_page@@: </b>
      <xsl:value-of select="request/display/end_page" />
     </td>
    </tr>
   </xsl:if>
   <xsl:if test="request/note !=''">
    <tr>
     <td>
      <b> @@request_note@@: </b>
      <xsl:value-of select="request/note" />
     </td>
    </tr>
   </xsl:if>

   <tr>
    <td>
     <b> @@date@@: </b>
     <xsl:value-of select="general_data/current_date" />
    </td>
   </tr>
   <xsl:if test="request/external_request_id !=''">
    <tr>
     <td>
      <b> @@request_id@@: </b>
      <xsl:value-of select="request/external_request_id" />
     </td>
    </tr>
   </xsl:if>
   <tr>
    <td>
     <b> @@request_format@@: </b>
     <xsl:value-of select="request/format_display" />
    </td>
   </tr>

   <tr><td>&#xA0;</td></tr>

   <tr>
    <td>
     <b> @@note_to_partner@@: </b>
     <xsl:value-of select="note_to_partner" />

    </td>
   </tr>



   <xsl:choose>
    <xsl:when test="request/max_fee !=''">
     <tr>
      <td>
       <b>@@maximum_fee@@: </b>
       <xsl:value-of select="request/max_fee"/>
      </td>
     </tr>
    </xsl:when>
   </xsl:choose>


  </table>

  <br />

  <table cellspacing="0" cellpadding="5" border="0" style="font-family: Arial, Helvetica, sans-serif;font-size: 13px; color:#5F6163;">

   <tr>
    <td>@@signature@@</td>
   </tr>
   <tr>
    <td>
     <xsl:value-of select="library/name" />
    </td>
   </tr>
   <xsl:if test="library/address/line1 !=''">
    <tr>
     <td>
      <xsl:value-of select="library/address/line1" />
     </td>
    </tr>
   </xsl:if>
   <xsl:if test="library/address/line2 !=''">
    <tr>
     <td>
      <xsl:value-of select="library/address/line2" />
     </td>
    </tr>
   </xsl:if>
   <xsl:if test="library/address/line3 !=''">
    <tr>
     <td>
      <xsl:value-of select="library/address/line3" />
     </td>
    </tr>
   </xsl:if>
   <xsl:if test="library/address/line4 !=''">
    <tr>
     <td>
      <xsl:value-of select="library/address/line4" />
     </td>
    </tr>
   </xsl:if>
   <xsl:if test="library/address/line5 !=''">
    <tr>
     <td>
      <xsl:value-of select="library/address/line5" />
     </td>
    </tr>
   </xsl:if>
   <xsl:if test="library/address/city !=''">
    <tr>
     <td>
      <xsl:value-of select="library/address/city" />
     </td>
    </tr>
   </xsl:if>
   <xsl:if test="library/address/country !=''">
    <tr>
     <td>
      <xsl:value-of select="library/address/country" />
     </td>
    </tr>

   </xsl:if>
  </table>

</xsl:template>
</xsl:stylesheet>