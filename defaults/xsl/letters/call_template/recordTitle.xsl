<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:template name="recordTitle">
   <div class="recordTitle">
    <span class="spacer_after_1em"><xsl:value-of select="notification_data/phys_item_display/title"/></span>
   </div>
   <xsl:if test="notification_data/phys_item_display/author !=''">
    <div class="">
     <span class="spacer_after_1em">
      <span class="recordAuthor"><xsl:value-of select="notification_data/phys_item_display/author"/></span>
     </span>
    </div>
   </xsl:if>
   <xsl:if test="notification_data/phys_item_display/issue_level_description !=''">
    <div class="">
     <span class="spacer_after_1em">
      <span class="volumeIssue"><xsl:value-of select="notification_data/phys_item_display/issue_level_description"/></span>
     </span>
    </div>
   </xsl:if>

</xsl:template>

</xsl:stylesheet>