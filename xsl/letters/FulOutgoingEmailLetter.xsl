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

  <xsl:call-template name="emailLogo"/><!-- mailReason.xsl -->

  <p>
    <xsl:choose>
      <xsl:when test="/notification_data/request/needed_by !=''">
        @@requested_by@@: <xsl:value-of select="/notification_data/request/needed_by"/>
      </xsl:when>
      <xsl:otherwise>
        @@requested@@:
      </xsl:otherwise>
    </xsl:choose>
  </p>

  <table cellpadding="5" cellspacing="0" class="listing" width="100%">
    <tr>
      <td>@@format@@:</td>
      <td>
        <xsl:value-of select="/notification_data/request/display/material_type" />
      </td>
    </tr>
    <xsl:if test="/notification_data/request/display/title !=''">
      <tr>
        <td>@@title@@:</td>
        <td>
          <xsl:value-of select="/notification_data/request/display/title" />
        </td>
      </tr>
    </xsl:if>
    <xsl:if test="/notification_data/request/display/journal_title !=''">
      <tr>
        <td>@@journal_title@@:</td>
        <td>
          <xsl:value-of select="/notification_data/request/display/journal_title" />
        </td>
      </tr>
    </xsl:if>
    <xsl:if test="/notification_data/request/display/author !=''">
      <tr>
        <td>@@author@@:</td>
        <td>
          <xsl:value-of select="/notification_data/request/display/author" />
       </td>
      </tr>
    </xsl:if>
    <xsl:if test="/notification_data/request/display/autho_initials !=''">
      <tr>
        <td>@@author_initials@@:</td>
        <td>
          <xsl:value-of select="/notification_data/request/display/autho_initials" />
        </td>
      </tr>
    </xsl:if>
    <xsl:if test="/notification_data/request/display/publisher !=''">
      <tr>
        <td>@@publisher@@:</td>
        <td>
          <xsl:value-of select="/notification_data/request/display/publisher" />
        </td>
      </tr>
    </xsl:if>
    <xsl:if test="/notification_data/request/display/place_of_publication !=''">
      <tr>
        <td>@@place_of_publication@@:</td>
        <td>
          <xsl:value-of select="/notification_data/request/display/place_of_publication" />
        </td>
      </tr>
    </xsl:if>
    <xsl:if test="/notification_data/request/display/publication_date !=''">
      <tr>
        <td>@@publication_date@@:</td>
        <td>
          <xsl:value-of select="/notification_data/request/display/publication_date" />
        </td>
      </tr>
    </xsl:if>
    <xsl:if test="/notification_data/request/display/year !=''">
      <tr>
        <td>@@year@@:</td>
        <td>
          <xsl:value-of select="/notification_data/request/display/year" />
        </td>
      </tr>
    </xsl:if>
    <xsl:if test="/notification_data/request/display/edition !=''">
      <tr>
        <td>@@edition@@:</td>
        <td>
          <xsl:value-of select="/notification_data/request/display/edition" />
        </td>
      </tr>
    </xsl:if>
    <xsl:if test="/notification_data/request/display/call_number !=''">
      <tr>
        <td>@@call_number@@:</td>
        <td>
          <xsl:value-of select="/notification_data/request/display/call_number" />
        </td>
      </tr>
    </xsl:if>
    <xsl:if test="/notification_data/request/display/volume !=''">
      <tr>
        <td>@@volume@@:</td>
        <td>
          <xsl:value-of select="/notification_data/request/display/volume" />
        </td>
      </tr>
    </xsl:if>
    <xsl:if test="/notification_data/request/display/issue !=''">
      <tr>
        <td>@@issue@@:</td>
        <td>
          <xsl:value-of select="/notification_data/request/display/issue" />
        </td>
      </tr>
    </xsl:if>
    <xsl:if test="/notification_data/request/display/additional_person_name !=''">
      <tr>
        <td>@@additional_person_name@@:</td>
        <td>
          <xsl:value-of select="/notification_data/request/display/additional_person_name" />
        </td>
      </tr>
    </xsl:if>
    <xsl:if test="/notification_data/request/display/source !=''">
      <tr>
        <td>@@source@@:</td>
        <td>
          <xsl:value-of select="/notification_data/request/display/source" />
        </td>
      </tr>
    </xsl:if>
    <xsl:if test="/notification_data/request/display/series_title_number !=''">
      <tr>
        <td>@@series_title_number@@:</td>
        <td>
          <xsl:value-of select="/notification_data/request/display/series_title_number" />
        </td>
      </tr>
    </xsl:if>
    <xsl:if test="/notification_data/request/display/isbn !=''">
      <tr>
        <td>@@isbn@@:</td>
        <td>
          <xsl:value-of select="/notification_data/request/display/isbn" />
        </td>
      </tr>
    </xsl:if>
    <xsl:if test="/notification_data/request/display/issn !=''">
      <tr>
        <td>@@issn@@:</td>
        <td>
          <xsl:value-of select="/notification_data/request/display/issn" />
        </td>
      </tr>
    </xsl:if>
    <xsl:if test="/notification_data/request/display/doi !=''">
      <tr>
        <td>@@doi@@:</td>
        <td>
          <xsl:value-of select="/notification_data/request/display/doi" />
        </td>
      </tr>
    </xsl:if>
    <xsl:if test="/notification_data/request/display/pmid !=''">
      <tr>
        <td>@@pmid@@:</td>
        <td>
          <xsl:value-of select="/notification_data/request/display/pmid" />
        </td>
      </tr>
    </xsl:if>
    <xsl:if test="/notification_data/request/display/note !=''">
      <tr>
        <td>@@note@@:</td>
        <td>
          <xsl:value-of select="/notification_data/request/display/note" />
        </td>
      </tr>
    </xsl:if>
    <xsl:if test="/notification_data/request/display/chapter !=''">
      <tr>
        <td>@@chapter@@:</td>
        <td>
          <xsl:value-of select="/notification_data/request/display/chapter" />
        </td>
      </tr>
    </xsl:if>
    <xsl:if test="/notification_data/request/display/volume_bk !=''">
      <tr>
        <td>@@volume@@:</td>
        <td>
          <xsl:value-of select="/notification_data/request/display/volume_bk" />
        </td>
      </tr>
    </xsl:if>
    <xsl:if test="/notification_data/request/display/part !=''">
      <tr>
        <td>@@part@@:</td>
        <td>
          <xsl:value-of select="/notification_data/request/display/part" />
        </td>
      </tr>
    </xsl:if>
    <xsl:if test="/notification_data/request/display/pages !=''">
      <tr>
        <td>@@pages@@:</td>
        <td>
          <xsl:value-of select="/notification_data/request/display/pages" />
        </td>
      </tr>
    </xsl:if>
    <xsl:if test="/notification_data/request/display/start_page !=''">
      <tr>
        <td>@@start_page@@:</td>
        <td>
          <xsl:value-of select="/notification_data/request/display/start_page" />
        </td>
      </tr>
    </xsl:if>
    <xsl:if test="/notification_data/request/display/end_page !=''">
      <tr>
        <td>@@end_page@@:</td>
        <td>
          <xsl:value-of select="/notification_data/request/display/end_page" />
        </td>
      </tr>
    </xsl:if>
    <xsl:if test="/notification_data/request/note !=''">
      <tr>
        <td>@@request_note@@:</td>
        <td>
          <xsl:value-of select="/notification_data/request/note" />
        </td>
      </tr>
    </xsl:if>

    <tr>
      <td>@@date@@:</td>
      <td>
        <xsl:value-of select="/notification_data/general_data/current_date" />
      </td>
    </tr>
    <xsl:if test="/notification_data/request/external_request_id !=''">
      <tr>
        <td>@@request_id@@:</td>
        <td>
          <xsl:value-of select="/notification_data/request/external_request_id" />
        </td>
      </tr>
    </xsl:if>
    <tr>
      <td>@@request_format@@:</td>
      <td>
        <xsl:value-of select="/notification_data/request/format_display" />
      </td>
    </tr>

    <xsl:if test="/notification_data/request/max_fee !=''">
      <tr>
        <td>@maximum_fee@@:</td>
        <td>
          <xsl:value-of select="/notification_data/request/max_fee"/>
        </td>
      </tr>
    </xsl:if>

    <xsl:if test="/notification_data/level_of_service !=''">
      <tr>
        <td>@level_of_service@@:</td>
        <td>
          <xsl:value-of select="/notification_data/level_of_service"/>
        </td>
      </tr>
    </xsl:if>

  </table>

  <p>
    @@signature@@
    <br />
    <xsl:value-of select="/notification_data/library/name" />
    <br />
    <xsl:if test="/notification_data/library/address/line1 !=''">
      <xsl:value-of select="/notification_data/library/address/line1" />
      <br />
    </xsl:if>
    <xsl:if test="/notification_data/library/address/line2 !=''">
      <xsl:value-of select="/notification_data/library/address/line2" />
      <br />
    </xsl:if>
    <xsl:if test="/notification_data/library/address/line3 !=''">
      <xsl:value-of select="/notification_data/library/address/line3" />
      <br />
    </xsl:if>
    <xsl:if test="/notification_data/library/address/line4 !=''">
      <xsl:value-of select="/notification_data/library/address/line4" />
      <br />
    </xsl:if>
    <xsl:if test="/notification_data/library/address/line5 !=''">
      <xsl:value-of select="/notification_data/library/address/line5" />
      <br />
    </xsl:if>
    <xsl:if test="/notification_data/library/address/city !=''">
      <xsl:value-of select="/notification_data/library/address/postal_code" />&#160;<xsl:value-of select="/notification_data/library/address/city" />
      <br />
    </xsl:if>
    <xsl:if test="/notification_data/library/address/country !=''">
      <xsl:value-of select="/notification_data/library/address/country" />
    </xsl:if>
  </p>

</xsl:template>
</xsl:stylesheet>