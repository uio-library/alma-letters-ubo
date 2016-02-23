<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:variable name="counter" select="0"/>
  <xsl:include href="header.xsl"/>
  <xsl:include href="senderReceiver.xsl"/>
  <xsl:include href="mailReason.xsl"/>
  <xsl:include href="footer.xsl"/>
  <xsl:include href="style.xsl"/>
  <xsl:include href="recordTitle.xsl"/>

  <xsl:template name="id-info">
    <xsl:param name="line"/>
    <xsl:variable name="first" select="substring-before($line,'//')"/>
    <xsl:variable name="rest" select="substring-after($line,'//')"/>
    <xsl:if test="$first = '' and $rest = '' ">
      <!--br/-->
    </xsl:if>
    <xsl:if test="$rest != ''">
      <xsl:value-of select="$rest"/>
      <br/>
    </xsl:if>
    <xsl:if test="$rest = ''">
      <xsl:value-of select="$line"/>
      <br/>
    </xsl:if>
  </xsl:template>

  <xsl:template name="id-info-hdr">
    <xsl:call-template name="id-info">
      <xsl:with-param name="line" select="notification_data/incoming_request/external_request_id"/>
      <xsl:with-param name="label" select="'Bibliographic Information:'"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="/">

    <html>
      <head>
        <xsl:call-template name="generalStyle"/>
      </head>
      <body>
        <xsl:attribute name="style">
          <xsl:call-template name="bodyStyleCss"/>
          <!-- style.xsl -->
        </xsl:attribute>

        <xsl:call-template name="head_without_logo"/><!-- Defined in header.xsl -->

        <div class="messageArea">
          <div class="messageBody">

            <p align="center">
              <img alt="externalId" src="externalId.png"/>
            </p>

            <table border="0" cellpadding="5" cellspacing="0">

              <tr>
                <td>@@format@@:</td>
                <td>
                  <xsl:value-of select="notification_data/incoming_request/format"/>
                </td>
              </tr>

              <tr>
                <td>@@supplied_to@@: </td>
                <td>
                  <xsl:value-of select="notification_data/partner_name"/>(
                  <xsl:value-of select="notification_data/incoming_request/requester_email"/>
                  )</td>
              </tr>

              <!--
                 <tr><td>@@borrower_reference@@:</td><td><xsl:call-template name="id-info-hdr"/></td></tr>
              -->

              <xsl:if test="notification_data/incoming_request/create_date_str != ''">
                <tr>
                  <td>Request created:</td>
                  <td>
                    <xsl:call-template name="normalizedDate"><!-- Defined in header.xsl -->
                      <xsl:with-param name="value" select="notification_data/incoming_request/create_date_str"/>
                    </xsl:call-template>
                    <xsl:if test="notification_data/incoming_request/create_date_str != notification_data/incoming_request/modification_date_str">(updated
                      <xsl:call-template name="normalizedDate">
                        <!-- header.xsl -->
                        <xsl:with-param name="value" select="notification_data/incoming_request/modification_date_str"/></xsl:call-template>)
                    </xsl:if>
                  </td>
                </tr>
              </xsl:if>

              <xsl:if test="notification_data/incoming_request/needed_by != ''">
                <tr>
                  <td>@@date_needed_by@@:</td>
                  <td>
                    <xsl:value-of select="notification_data/incoming_request/needed_by"/>
                  </td>
                </tr>
              </xsl:if>

              <xsl:if test="notification_data/assignee != ''">
                <tr>
                  <td>@@assignee@@: </td>
                  <td>
                    <xsl:value-of select="notification_data/assignee"/>
                  </td>
                </tr>
              </xsl:if>

              <xsl:if test="notification_data/level_of_service !=''">
                <tr>
                  <td>@@level_of_service@@:</td>
                  <td>
                    <xsl:value-of select="notification_data/level_of_service"/>
                  </td>
                </tr>
              </xsl:if>

              <xsl:if test="notification_data/incoming_request/note != ''">
                <tr>
                  <td>@@request_note@@: </td>
                  <td>
                    <xsl:value-of select="notification_data/incoming_request/note"/>
                  </td>
                </tr>
              </xsl:if>

              <tr>
                <td valign="top">Metadata:</td>
                <td>
                  <xsl:if test="notification_data/metadata/material_type != ''">
                    <em>Type: </em>
                    <xsl:value-of select="notification_data/metadata/material_type"/>
                  </xsl:if>
                  <xsl:if test="notification_data/metadata/title != ''">
                    <em>Tittel: </em>
                    <xsl:value-of select="notification_data/metadata/title"/>
                  </xsl:if>
                  <xsl:if test="notification_data/metadata/author != ''">
                    <em>Forfatter: </em>
                    <xsl:value-of select="notification_data/metadata/author"/>
                  </xsl:if>
                  <xsl:if test="notification_data/metadata/journal_title != ''">
                    <em>Tidsskr.: </em>
                    <xsl:value-of select="notification_data/metadata/journal_title"/>
                  </xsl:if>
                  <xsl:if test="notification_data/metadata/volume != ''">
                    <em>Bind: </em>
                    <xsl:value-of select="notification_data/metadata/volume"/>
                  </xsl:if>
                  <xsl:if test="notification_data/metadata/issue != ''">
                    <em>Hefte: </em>
                    <xsl:value-of select="notification_data/metadata/issue"/>
                  </xsl:if>
                  <xsl:if test="notification_data/metadata/start_page != ''">
                    <em>S.: </em>
                    <xsl:value-of select="notification_data/metadata/start_page"/>
                  </xsl:if>
                  <xsl:if test="notification_data/metadata/start_page = '' and notification_data/metadata/pages != ''">
                    <em>S.: </em>
                    <xsl:value-of select="notification_data/metadata/pages"/>
                  </xsl:if>
                  <xsl:if test="notification_data/metadata/publication_date != ''">
                    <em>Publiseringsdato: </em>
                    <xsl:value-of select="notification_data/metadata/publication_date"/>
                  </xsl:if>
                </td>
              </tr>

              <xsl:if test="notification_data/incoming_request/display/availability != ''">
                <tr>
                  <td valign="top">Availability:</td>
                  <td>
                    <xsl:call-template name="string-replace"><!-- Defined in header.xsl -->
                      <xsl:with-param name="string" select="notification_data/incoming_request/display/availability"/>
                      <xsl:with-param name="replace" select="'Availability:'"/>
                      <xsl:with-param name="with" select="''"/>
                    </xsl:call-template>
                  </td>
                </tr>
              </xsl:if>

            </table>

            <hr/>

            <!-- Available items -->
            <xsl:if test="count(notification_data/items/physical_item_display_for_printing/available_items/available_item) != 0">
              <h3>Available items:</h3>
              <table>
                <th>@@item_barcode@@</th>
                <th>@@location@@</th>
                <th>@@call_number@@</th>
                <th>@@shelving_location_for_item@@</th>
                <!-- ITEMS -->
                <xsl:for-each select="notification_data/items/physical_item_display_for_printing/available_items/available_item">
                  <tr>
                    <td>
                      <xsl:value-of select="barcode"/>
                    </td>
                    <td>
                      <xsl:value-of select="location_name"/>
                    </td>
                    <td>
                      <xsl:value-of select="call_number"/>
                    </td>
                    <xsl:if test="shelving_location/string">
                      <td>
                        <xsl:for-each select="shelving_location/string">
                          <xsl:value-of select="."/>
                        </xsl:for-each>
                      </td>
                    </xsl:if>
                  </tr>
                </xsl:for-each>
              </table>
            </xsl:if>
          </div>
        </div>


      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>