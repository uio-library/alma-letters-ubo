<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:include href="header.xsl" />
 <xsl:include href="senderReceiver.xsl" />
 <xsl:include href="mailReason.xsl" />
 <xsl:include href="footer.xsl" />
 <xsl:include href="style.xsl" />
 <xsl:variable name="conta1">
  0
 </xsl:variable>
 <xsl:variable name="stepType"
  select="/notification_data/request/work_flow_entity/step_type" />
 <xsl:variable name="externalRequestId"
  select="/notification_data/external_request_id" />
 <xsl:variable name="externalSystem" select="/notification_data/external_system" />
 <xsl:template match="/">
  <table cellspacing="0" cellpadding="5" border="0">
   <tr>
    <td>
     <xsl:for-each select="notification_data">
      <h3>
       <strong>@@Dear_Publisher@@</strong>
       <br />


       <br />
       <br />
       <br />


      </h3>
     </xsl:for-each>
    </td>
   </tr>
  </table>
 </xsl:template>


 <xsl:template match="/">
  <html>
   <head>
    <xsl:call-template name="generalStyle" />
   </head>
   <body>
    <xsl:attribute name="style">
          <xsl:call-template name="bodyStyleCss" /><!-- style.xsl -->
        </xsl:attribute>

    <xsl:call-template name="head" /><!-- header.xsl -->
    <!-- <xsl:call-template name="senderReceiver" /> SenderReceiver.xsl -->

    <br />
    <!-- <xsl:call-template name="toWhomIsConcerned" /> mailReason.xsl -->

    <div class="messageArea">
     <div class="messageBody">

      <table cellspacing="0" cellpadding="5" border="0"
       style="width:100%; padding: 0px 25px 25px 25px; border-bottom: 2px solid #dce8eb; font-family: 'Source Sans Pro' !important;padding: 25px 0 15px 0;">

       <tr>
        <td style="font-size:30px;padding: 0px 0 5px 10px;">
         <b>

          <xsl:value-of select="notification_data/license/name" />
         </b>
         <br />
         <br />
        </td>
       </tr>
       <tr>
        <td style="font-size:18px;padding: 0px 0 5px 10px;">
         <b>
          @@licenseCode@@:
         </b>
         <xsl:value-of select="notification_data/license/code" />
         <br />
         <b>
          @@licenseType@@:
         </b>
         <xsl:value-of select="notification_data/license/type" />
         <br />
         <b>
          @@status@@:
         </b>
         <xsl:value-of select="notification_data/license/status" />
         <br />
         <b>
          @@signedBy@@:
         </b>
         <xsl:value-of select="notification_data/license/license_signedby" />
         <br />
         <b>
          @@SignedOn@@:
         </b>
         <xsl:value-of select="notification_data/license/license_signed" />
         <br />
         <b>
          @@startDate@@:
         </b>
         <xsl:value-of select="notification_data/license/license_begins" />
         <b>
          -
         </b>
         <xsl:value-of select="notification_data/license/license_ends" />
         <br />

         <b>
          @@licensor@@:
         </b>
         <xsl:value-of select="notification_data/license/licensor" />
         <br />
         <b>
          @@URI@@:
         </b>
         <xsl:value-of select="notification_data/license/uri" />
         <br />
         <br />
         <br />
        </td>
       </tr>
       <tr>
        <td style="font-size:18px;padding: 0px 0 0px 0px;">
         <b>@@group_settings@@:
         </b>
        </td>
       </tr>
       <br />
       <xsl:for-each
        select="notification_data/group_settings/license_af_management">
        <tr>
         <td style="font-size:18px">
          <b>@@group_name@@:</b>
          <xsl:value-of select="group_name" />
         </td>
        </tr>
       </xsl:for-each>
       <br />
       <br />


       <xsl:for-each select="notification_data/list/term_license">
        <tr>
         <td style="font-size:18px;padding: 0px 0 5px 10px;">
          <b>@@licenseTerms@@:
          </b>
         </td>
         <td style="padding: 0px 0px 0px 5px;">

          <xsl:value-of select="field_label" />
         </td>
         <td>
          <b>@@term_type_display@@:</b>
          <xsl:value-of select="comment" />
         </td>

        </tr>
       </xsl:for-each>
      </table>

      <br />

     </div>
    </div>


    <xsl:choose>
     <xsl:when test="notification_data/license/type='NEGOTIATION' ">

      <table cellspacing="0" cellpadding="5" border="0"
       style="width:100%;  padding: 0px 25px 25px 25px; border-bottom: 2px solid #dce8eb; font-family: 'Source Sans Pro' !important;padding: 25px 0 15px 0;">

       <tr>
        <td>

         <h3>
          <strong>@@negotiation_details@@</strong>
          <br />
         </h3>

         <xsl:for-each
          select="notification_data/neg_license_rep_list/neg_license_rep">
          <div>
           <h4>
            <strong>@@negotiation@@</strong>
            <br />
           </h4>
           <b>
            @@member_name@@
           </b>
           <xsl:value-of select="neg_license/member_name" />

           <br />


           <xsl:choose>
            <xsl:when test="/notification_data/license/multiyear='true' ">

             <b>@@price_per_year@@:</b>
             <xsl:value-of select="neg_license/price_per_year" />
             &#xA0;
             <xsl:value-of select="neg_license/currency" />
             <br />
             <b>@@price_increase@@:</b>
             <xsl:value-of select="neg_license/price_increase" />
            </xsl:when>
            <xsl:otherwise>
             <b>@@price@@:</b>
             <xsl:value-of select="neg_license/price" />
             &#xA0;
             <xsl:value-of select="neg_license/currency" />
            </xsl:otherwise>
           </xsl:choose>
           <!-- &#xA0;
           <xsl:value-of select="neg_license/currency" /> -->
           <br />
           <b>
            @@start_date@@:
           </b>
           <xsl:value-of select="neg_license/start_date" />
           <br />
           <b>
            @@end_date@@:
           </b>
           <xsl:value-of select="neg_license/end_date" />
           <br />
           <h4>
            <strong>@@contact_people@@</strong>
            <br />
           </h4>
           <xsl:for-each select="negotiation_contact_ui/negotiation_contact_ui">
            <b>
             @@fisrt_name@@:
            </b>
            <xsl:value-of select="first_name" />

            <br />
            <b>
             @@last_name@@:
            </b>
            <xsl:value-of select="last_name" />

            <br />
            <b>
             @@email@@:
            </b>
            <xsl:value-of select="mail" />

            <br />
            <br />


           </xsl:for-each>

          </div>
         </xsl:for-each>
        </td>
       </tr>
      </table>

     </xsl:when>
     <xsl:otherwise>

     </xsl:otherwise>
    </xsl:choose>

    <xsl:choose>
     <xsl:when test="notification_data/license/type='ADDENDUM' ">

      <table cellspacing="0" cellpadding="5" border="0"
       style="width:100%; padding: 0px 25px 25px 25px; border-bottom: 2px solid #dce8eb; font-family: 'Source Sans Pro' !important;padding: 25px 0 15px 0;">

       <tr>
        <td>

         <h3>
          <strong>@@parent_license@@</strong>
          <br />
         </h3>

         <b>
          @@parent_license_name@@:
          <xsl:value-of select="notification_data/license/base_license/name" />
         </b>
         <br />
        </td>
       </tr>
      </table>

     </xsl:when>
     <xsl:otherwise>

     </xsl:otherwise>
    </xsl:choose>

    <!-- footer.xsl -->
    <xsl:call-template name="lastFooter" />
   </body>
  </html>
 </xsl:template>
</xsl:stylesheet>