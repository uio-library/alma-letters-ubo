<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="header.xsl"/>
<xsl:include href="senderReceiver.xsl"/>
<xsl:include href="mailReason.xsl"/>
<xsl:include href="footer.xsl"/>
<xsl:include href="style.xsl"/>
<xsl:include href="recordTitle.xsl"/>

<xsl:template match="/">
  <xsl:call-template name="email-template"/><!-- header.xsl -->
</xsl:template>

<xsl:template match="/notification_data">

  <xsl:call-template name="emailLogo"/><!-- mailReason.xsl -->
  <xsl:call-template name="toWhomIsConcerned"/><!-- mailReason.xsl -->

  <p>
    @@dear@@
  </p>

  <p>
    @@please_find_below@@
  </p>

  <xsl:if test="/notification_data/non_active_requests/ful_request_interpated">
    <h3>@@not_active@@</h3>
    <p>
      @@not_active_description@@
    </p>
    <table>
      <xsl:attribute name="style">
        <xsl:call-template name="mainTableStyleCss" /> <!-- style.xsl -->
       </xsl:attribute>
        <tr>
        <xsl:attribute name="style">
         <xsl:call-template name="headerTableStyleCss" /> <!-- style.xsl -->
        </xsl:attribute>
         <th>@@type@@</th>
         <th>@@title@@</th>
         <th>@@author@@</th>
         <th>@@place_in_queue@@</th>
         <th>@@pickup_location@@</th>
        </tr>
        <xsl:for-each select="/notification_data/non_active_requests/ful_request_interpated">
        <tr>
         <td><xsl:value-of select="request_type_display"/></td>
         <td><xsl:value-of select="title_display"/></td>
         <td><xsl:value-of select="author_display"/></td>
         <td><xsl:value-of select="place_in_queue"/></td>
         <td><xsl:value-of select="pickup_location_display"/></td>
        </tr>
        </xsl:for-each>
    </table>
    <hr />
  </xsl:if>

  <xsl:if test="/notification_data/process_requests/ful_request_interpated">
    <h3>
      @@in_process@@
    </h3>
    <p>
      @@in_process_description@@
    </p>
    <table>
      <xsl:attribute name="style">
        <xsl:call-template name="mainTableStyleCss" /> <!-- style.xsl -->
      </xsl:attribute>
      <tr>
        <xsl:attribute name="style">
         <xsl:call-template name="headerTableStyleCss" /> <!-- style.xsl -->
        </xsl:attribute>
         <th>@@type@@</th>
         <th>@@title@@</th>
         <th>@@author@@</th>
         <th>@@status@@</th>
         <th>@@pickup_location@@</th>
        </tr>
        <xsl:for-each select="/notification_data/process_requests/ful_request_interpated">
        <tr>
         <td><xsl:value-of select="request_type_display"/></td>
         <td><xsl:value-of select="title_display"/></td>
         <td><xsl:value-of select="author_display"/></td>
         <td><xsl:value-of select="request_status_display"/></td>
         <td><xsl:value-of select="pickup_location_display"/></td>
        </tr>
        </xsl:for-each>
    </table>
    <hr/>
  </xsl:if>


  <xsl:if test="/notification_data/hold_shelf_requests/ful_request_interpated">
    <h3>
      @@on_hold_shelf@@
    </h3>
    <p>
      @@on_hold_shelf_description@@
    </p>
    <table>
      <xsl:attribute name="style">
        <xsl:call-template name="mainTableStyleCss" /> <!-- style.xsl -->
       </xsl:attribute>
        <tr>
        <xsl:attribute name="style">
         <xsl:call-template name="headerTableStyleCss" /> <!-- style.xsl -->
        </xsl:attribute>
         <th >@@type@@</th>
         <th>@@title@@</th>
         <th>@@author@@</th>
         <th>@@status@@</th>
         <th>@@pickup_location@@</th>
        </tr>
        <xsl:for-each select="/notification_data/hold_shelf_requests/ful_request_interpated">
        <tr>
         <td><xsl:value-of select="request_type_display"/></td>
         <td><xsl:value-of select="title_display"/></td>
         <td><xsl:value-of select="author_display"/></td>
         <td><xsl:value-of select="request_status_display"/></td>
         <td><xsl:value-of select="pickup_location_display"/></td>
        </tr>
        </xsl:for-each>
    </table>
    <hr/>
  </xsl:if>

  <xsl:call-template name="email-footer"/><!-- footer.xsl -->
  <xsl:call-template name="myAccount"/>
  <xsl:call-template name="contactUs" /><!-- footer.xsl -->

</xsl:template>
</xsl:stylesheet>
