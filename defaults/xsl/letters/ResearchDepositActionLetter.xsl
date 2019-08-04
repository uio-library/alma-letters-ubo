<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <xsl:include href="esploroHeader.xsl" />
 <xsl:include href="esploroSenderReceiver.xsl" />
 <xsl:include href="esploroFooter.xsl" />
 <xsl:include href="esploroStyle.xsl" />

 <xsl:template match="/">
  <html>
   <head>
    <xsl:call-template name="generalStyle" />
   </head>
   <body>
    <xsl:attribute name="style">
     <xsl:call-template name="bodyStyleCss" /><!-- style.xsl -->
    </xsl:attribute>
    <xsl:call-template name="head" /> <!-- header.xsl -->
    <xsl:call-template name="senderReceiver" /> <!-- SenderReceiver.xsl -->
    <br />
    <table cellspacing="0" cellpadding="5" border="0">
     <tr>
      <td>
       <xsl:for-each select="notification_data">
        <h3>@@dear@@&#160;<xsl:value-of select="receivers/receiver/user/user_title"/>&#160;<xsl:value-of select="receivers/receiver/user/last_name"/></h3>
       </xsl:for-each>
      </td>
     </tr>
    </table>

    <div class="messageArea">
     <div class="messageBody">
      <table cellspacing="0" cellpadding="5" border="0">
       <tr>
        <td>
         <xsl:if test="notification_data/type='CONTACT_RESEARCHER'">
         @@CONTACT_RESEARCHER_1@@ &quot;<xsl:value-of select="notification_data/esploro_record/title"/>&quot; @@CONTACT_RESEARCHER_2@@
         </xsl:if>
         <xsl:if test="notification_data/type='RESEARCHER_DEPOSIT_SUBMITTED'">
         @@RESEARCHER_DEPOSIT_SUBMITTED_status_1@@ &quot;<xsl:value-of select="notification_data/esploro_record/title"/>&quot; @@RESEARCHER_DEPOSIT_SUBMITTED_status_2@@
         </xsl:if>
         <xsl:if test="notification_data/type='RESEARCHER_DEPOSIT_APPROVED'">
         @@RESEARCHER_DEPOSIT_APPROVED_status_1@@ &quot;<xsl:value-of select="notification_data/esploro_record/title"/>&quot; @@RESEARCHER_DEPOSIT_APPROVED_status_2@@
         </xsl:if>
         <xsl:if test="notification_data/type='MEDIATED_DEPOSIT_APPROVED'">
         @@MEDIATED_DEPOSIT_APPROVED_status_1@@ &quot;<xsl:value-of select="notification_data/esploro_record/title"/>&quot; @@MEDIATED_DEPOSIT_APPROVED_status_2@@
         </xsl:if>
         <xsl:if test="notification_data/type='RESEARCHER_DEPOSIT_DECLINED'">
         @@RESEARCHER_DEPOSIT_DECLINED_status_1@@ &quot;<xsl:value-of select="notification_data/esploro_record/title"/>&quot; @@RESEARCHER_DEPOSIT_DECLINED_status_2@@
         </xsl:if>
         <xsl:if test="notification_data/type='RESEARCHER_DEPOSIT_RETURNED'">
         @@RESEARCHER_DEPOSIT_RETURNED_status_1@@ &quot;<xsl:value-of select="notification_data/esploro_record/title"/>&quot; @@RESEARCHER_DEPOSIT_RETURNED_status_2@@
         </xsl:if>
         <xsl:if test="notification_data/type='RESEARCHER_DEPOSIT_RESUBMITTED'">
         @@RESEARCHER_DEPOSIT_RESUBMITTED_status_1@@ &quot;<xsl:value-of select="notification_data/esploro_record/title"/>&quot;  @@RESEARCHER_DEPOSIT_RESUBMITTED_status_2@@
         </xsl:if>
        </td>
       </tr>
       <xsl:if test="notification_data/reason !=''">
        <tr>
         <td>
          @@reason@@: <xsl:value-of select="notification_data/reason"/>
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/note !=''">
        <tr>
         <td>
          <xsl:value-of select="notification_data/note"/>
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/asset_id !='-1'">
        <tr>
         <td>
          @@assetId@@ <xsl:value-of select="notification_data/asset_id"/>.
         </td>
        </tr>
       </xsl:if>
       <xsl:if test="notification_data/has_attachment !=''">
        <tr>
         <td>
          @@attached@@
         </td>
        </tr>
       </xsl:if>
       <br></br>
       <tr>
        <td>
         @@submitted_assets_link_prefix@@ <a>
                  <xsl:attribute name="href"><xsl:value-of select="notification_data/participant_url"/></xsl:attribute>
                  @@submitted_assets_link@@
                 </a>
         @@submitted_assets_link_suffix@@
        </td>
       </tr>
       <br></br>
       <xsl:choose>
        <xsl:when test="notification_data/type='RESEARCHER_DEPOSIT_SUBMITTED'">
         <tr>
          <td>@@contactInfo@@</td>
         </tr>
        </xsl:when>
        <xsl:otherwise>
         <tr>
          <td>
          @@contactInfo_1@@ <xsl:value-of select="notification_data/assignee_user/first_name"/>&#160;<xsl:value-of select="notification_data/assignee_user/last_name"/> @@contactInfo_2@@
          </td>
         </tr>
        </xsl:otherwise>
       </xsl:choose>
       <xsl:if test="notification_data/assignee_user/first_name !=''">
        <br></br>
        <tr>
         <td>
          @@sincerely@@,
         </td>
        </tr>
        <tr>
         <td>
          <xsl:value-of select="notification_data/assignee_user/first_name"/>&#160;<xsl:value-of select="notification_data/assignee_user/last_name"/>
         </td>
        </tr>
        <xsl:if test="notification_data/job_title_description !=''">
        <tr>
         <td>
          <xsl:value-of select="notification_data/job_title_description"/>
         </td>
        </tr>
        </xsl:if>
        <xsl:if test="notification_data/assignee_preferred_email !=''">
        <tr>
         <td>
          <xsl:value-of select="notification_data/assignee_preferred_email"/>
         </td>
        </tr>
        </xsl:if>
       </xsl:if>
      </table>
                        <br/>
      <br/><br/>
     </div>
    </div>
    <xsl:call-template name="lastFooter" /><!-- footer.xsl -->
    <xsl:call-template name="contactUs" /><!-- footer.xsl -->
   </body>
  </html>
 </xsl:template>
</xsl:stylesheet>