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

    <xsl:element name="meta">
     <xsl:attribute name="name">libnummer</xsl:attribute>
     <xsl:attribute name="content">

      <xsl:for-each select="notification_data/partner_shipping_info_list/partner_shipping_info[1]/address5">
              <xsl:value-of select="substring(., 4,3)"/>&#160;&#160;<xsl:value-of select="substring(., 7,4)"/>
      </xsl:for-each>

          </xsl:attribute>
    </xsl:element>

   </head>
   <body>
    <xsl:attribute name="style">
     <xsl:call-template name="bodyStyleCss"/>
     <!-- style.xsl -->
    </xsl:attribute>
    <xsl:call-template name="head_without_logo"/>
    <!-- header.xsl -->
    <div class="messageArea">
     <div class="messageBody">

      <p align="center">
       <!--<img alt="externalId" src="externalId.png"/>--><!-- External identifier, used by sender -->
       <img alt="group_qualifier" src="group_qualifier.png"/><!-- Borrower reference, used by receiver -->
      </p>

      <table border="0" cellpadding="5" cellspacing="0">

       <tr>
        <td valign="top">
         Receiver:
        </td>
        <td>
         <xsl:value-of select="notification_data/partner_name"/>
         (<xsl:value-of select="notification_data/email"/> / <xsl:value-of select="notification_data/phone"/>)

         <table><tr>
         <xsl:for-each select="notification_data/partner_shipping_info_list/partner_shipping_info">
          <td>
          <xsl:if test="address1">
           <div><xsl:value-of select="address1"/></div>
          </xsl:if>
          <xsl:if test="address2">
           <div><xsl:value-of select="address2"/></div>
          </xsl:if>
          <xsl:if test="address4">
           <div><xsl:value-of select="address4"/></div>
          </xsl:if>
          <xsl:if test="address5">
           <div><xsl:value-of select="address5"/></div>
          </xsl:if>
          <div><xsl:value-of select="postal_code"/> <xsl:value-of select="city"/> </div>
          <div><xsl:value-of select="state"/> <xsl:value-of select="country"/> </div>
          </td>
         </xsl:for-each>
         </tr></table>
        </td>
       </tr>

       <!-- Commented out since this is already covered by the barcode
       <tr>
        <td>
         @@borrower_reference@@:
        </td>
        <td>
         <xsl:call-template name="id-info-hdr"/>
        </td>
       </tr>
       -->

       <!--
       <xsl:if test="notification_data/qualifier">
        <tr>
         <td>
          <b>@@qualifier@@: </b>
          <img alt="qualifier" src="qualifier.png"/>
         </td>
        </tr>
       </xsl:if>
       -->
       <!--
       <xsl:if test="notification_data/group_qualifier">
        <tr>
         <td valign="top">
          <b>@@group_qualifier@@: </b>
         </td><td>
          <img alt="group_qualifier" src="group_qualifier.png"/>
         </td>
        </tr>
       </xsl:if>
      -->
       <tr>
        <td>
         @@format@@:
        </td><td>
         <xsl:value-of select="notification_data/incoming_request/format"/>
        </td>
       </tr>
       <xsl:if test="notification_data/incoming_request/needed_by != ''">
        <tr>
         <td>
          @@date_needed_by@@:
         </td><td>
          <xsl:value-of select="notification_data/incoming_request/needed_by"/>
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/incoming_request/note != ''">
        <tr>
         <td>
          @@request_note@@:
         </td><td>
          <xsl:value-of select="notification_data/incoming_request/note"/>
         </td>
        </tr>
       </xsl:if>
       <!--
       <xsl:if test="notification_data/incoming_request/requester_email">
        <tr>
         <td>
          <b>@@requester_email@@: </b>
         </td><td>
          <xsl:value-of select="notification_data/incoming_request/requester_email"/>
         </td>
        </tr>
       </xsl:if>
      -->
       <!--
      <xsl:if  test="notification_data/assignee != ''" ><tr><td><b>@@assignee@@: </b><xsl:value-of select="notification_data/assignee"/></td></tr></xsl:if>-->
       <xsl:if test="notification_data/incoming_request/create_date_str != ''">
        <tr>
         <td>Request created:</td>
         <td>
             <xsl:call-template name="normalizedDate"><!-- header.xsl -->
                     <xsl:with-param name="value" select="notification_data/incoming_request/create_date_str"/>
                   </xsl:call-template>

          <xsl:if test="notification_data/incoming_request/create_date_str != notification_data/incoming_request/modification_date_str">
           &#160;(updated <xsl:call-template name="normalizedDate"><!-- header.xsl -->
                      <xsl:with-param name="value" select="notification_data/incoming_request/modification_date_str"/>
                    </xsl:call-template>)
          </xsl:if>
         </td>
        </tr>
       </xsl:if>

       <xsl:if test="notification_data/item/barcode != ''">
        <tr>
          <td>Item:</td>
          <td>
            <xsl:value-of select="notification_data/item/barcode"/>
          </td>
        </tr>
       </xsl:if>

       <xsl:if test="notification_data/incoming_request/item_sent_date != ''">
        <tr>
         <td>Item sent:</td>
         <td>
             <xsl:call-template name="normalizedDate"><!-- header.xsl -->
                     <xsl:with-param name="value" select="notification_data/incoming_request/item_sent_date"/>
                   </xsl:call-template>

                   &#160;from&#160;

                   <!--
                   <xsl:value-of select="notification_data/organization_unit/name"/>&#160;
                   -->
                   <xsl:value-of select="notification_data/item/library_name"/>&#160;
                   <xsl:value-of select="notification_data/item/location_name"/>
         </td>
        </tr>
       </xsl:if>
       <!--
       <xsl:if test="notification_data/item">
        <xsl:if test="notification_data/item/library_name != ''">
         <tr>
          <td>
           @@library@@:
          </td><td>
           <xsl:value-of select="notification_data/item/library_name"/>
          </td>
         </tr>
        </xsl:if>
        <xsl:if test="notification_data/item/location_name != ''">
         <tr>
          <td>
           @@location@@:
          </td><td>
           <xsl:value-of select="notification_data/item/location_name"/>
          </td>
         </tr>
        </xsl:if>
        <xsl:if test="call_number">
         <tr>
          <td>
           @@call_number@@:
          </td><td>
           <xsl:value-of select="notification_data/item/call_number"/>
          </td>
         </tr>
        </xsl:if>
        <xsl:if test="shelving_location/string">
         <tr>
          <td>
           @@shelving_location_for_item@@:
          </td><td>
           <xsl:for-each select="shelving_location/string">
            <xsl:value-of select="."/> </xsl:for-each>
          </td>
         </tr>
        </xsl:if>
       </xsl:if>
      -->
       <tr>
        <td valign="top">
         Metadata:
        </td><td>

          <table>

            <xsl:if test="notification_data/metadata/material_type != ''">
              <tr>
                <td align="right">
                  <em>Type:</em>
                </td>
                <td>
                  <xsl:value-of select="notification_data/metadata/material_type"/>
                </td>
              </tr>
            </xsl:if>

            <xsl:if test="notification_data/metadata/title != ''">
              <tr>
                <td align="right">
                  <em>Title:</em>
                </td>
                <td>
                  <xsl:value-of select="notification_data/metadata/title"/>
                </td>
              </tr>
            </xsl:if>

            <xsl:if test="notification_data/metadata/chapter != ''">
              <tr>
                <td align="right">
                  <em>Chapter:</em>
                </td>
                <td>
                  <xsl:value-of select="notification_data/metadata/chapter"/>
                </td>
              </tr>
            </xsl:if>

            <xsl:if test="notification_data/metadata/author != ''">
              <tr>
                <td align="right">
                  <em>Author:</em>
                </td>
                <td>
                  <xsl:value-of select="notification_data/metadata/author"/>
                </td>
              </tr>
            </xsl:if>

            <xsl:if test="notification_data/metadata/journal_title != ''">
              <tr>
                <td align="right">
                  <em>Journal:</em>
                </td>
                <td>
                  <xsl:value-of select="notification_data/metadata/journal_title"/>
                </td>
              </tr>
            </xsl:if>

            <xsl:if test="notification_data/metadata/volume != ''">
              <tr>
                <td align="right">
                  <em>Vol.:</em>
                </td>
                <td>
                  <xsl:value-of select="notification_data/metadata/volume"/>
                </td>
              </tr>
            </xsl:if>

            <xsl:if test="notification_data/metadata/issue != ''">
              <tr>
                <td align="right">
                  <em>Issue:</em>
                </td>
                <td>
                  <xsl:value-of select="notification_data/metadata/issue"/>
                </td>
              </tr>
            </xsl:if>

            <xsl:if test="notification_data/metadata/start_page != ''">
              <tr>
                <td align="right">
                  <em>Start page:</em>
                </td>
                <td>
                  <xsl:value-of select="notification_data/metadata/start_page"/>
                </td>
              </tr>
            </xsl:if>

            <xsl:if test="notification_data/metadata/pages != ''">
              <tr>
                <td align="right">
                  <em>Pages:</em>
                </td>
                <td>
                  <xsl:value-of select="notification_data/metadata/pages"/>
                </td>
              </tr>
            </xsl:if>

            <xsl:if test="notification_data/metadata/publication_date != ''">
              <tr>
                <td align="right">
                  <em>Date:</em>
                </td>
                <td>
                  <xsl:value-of select="notification_data/metadata/publication_date"/>
                </td>
              </tr>
            </xsl:if>

          </table>

        </td>
       </tr>
      </table>
     </div>
    </div>

    <!--
  <xsl:call-template name="lastFooter" />-->
    <!-- footer.xsl -->
   </body>
  </html>
 </xsl:template>
</xsl:stylesheet>