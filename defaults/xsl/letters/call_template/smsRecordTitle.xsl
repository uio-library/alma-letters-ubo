<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:template name="recordTitle">
   <xsl:value-of select="notification_data/phys_item_display/title"/> By: <xsl:value-of select="notification_data/phys_item_display/author"/> ( <xsl:value-of select="notification_data/phys_item_display/material_type"/> )
        
        <xsl:value-of select="notification_data/phys_item_display/publisher"/>  <xsl:value-of select="notification_data/phys_item_display/publication_place"/>  <xsl:value-of select="notification_data/phys_item_display/publication_date "/>
        )
       
    <xsl:if test="notification_data/phys_item_display/volumeIssue">
     Description: <xsl:value-of select="notification_data/phys_item_display/volumeIssue"/> <xsl:text disable-output-escaping="yes">&lt;/tr&gt;</xsl:text>
    </xsl:if>
   
</xsl:template>

</xsl:stylesheet>