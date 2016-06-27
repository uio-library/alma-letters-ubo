<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="recordTitle">
 <xsl:for-each select="/notification_data/phys_item_display">
  <div>
   <xsl:if test="title !=''">
    <em><span class="recordTitle spacer_after_1em"><xsl:value-of select="title"/>.&#160;</span></em>
   </xsl:if>

   <xsl:if test="author !=''">
    <span class="spacer_after_1em">
     <span class="recordAuthor">
      <xsl:value-of select="author"/>.&#160;
     </span>
    </span>
   </xsl:if>

   <xsl:if test="imprint !=''">
    <span class="spacer_after_1em">
     <xsl:value-of select="imprint"/>.&#160;
    </span>
   </xsl:if>

   <xsl:if test="issue_level_description !=''">
    <div class="">
     <span class="spacer_after_1em">
      <span class="volumeIssue">Description: <xsl:value-of select="issue_level_description"/></span>.&#160;
     </span>
    </div>
   </xsl:if>

  </div>
 </xsl:for-each>
</xsl:template>
</xsl:stylesheet>