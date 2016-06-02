<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template name="senderReceiver">
    <table border="0" cellpadding="5" cellspacing="0" width="100%" style="font-family: Arial, Helvetica, sans-serif;font-size: 13px; color:#5F6163;">
      <tr>
        <td valign="top" width="50%">
          <xsl:choose>
            <xsl:when test="/notification_data/user_for_printing">
              <b><xsl:value-of select="/notification_data/user_for_printing/name"/></b>
              <br/>
              <xsl:value-of select="/notification_data/user_for_printing/address1"/>
              <br/>
              <xsl:value-of select="/notification_data/user_for_printing/postal_code"/>&#160;<xsl:value-of select="/notification_data/user_for_printing/city"/>
              <br/>
              <xsl:value-of select="/notification_data/user_for_printing/country"/>
            </xsl:when>
            <xsl:when test="/notification_data/receivers/receiver/user">
              <xsl:for-each select="/notification_data/receivers/receiver/user">
                <b><xsl:value-of select="first_name"/>&#160;<xsl:value-of select="last_name"/></b>
                <br/>
                <xsl:choose>
                  <xsl:when test="/notification_data/general_data/letter_type = 'OrderListLetter' or /notification_data/general_data/letter_type = 'POLineCancellationLetter' or /notification_data/general_data/letter_type = 'POLineRenewalLetter' ">
                    <xsl:value-of select="user_address_list/user_address/line2"/>
                    <br/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="user_address_list/user_address/line1"/>
                    <br/>
                  </xsl:otherwise>
                </xsl:choose>
                <xsl:value-of select="user_address_list/user_address/postal_code"/>&#160;<xsl:value-of select="user_address_list/user_address/city"/>
                <br/>
                <xsl:value-of select="user_address_list/user_address/country"/>
              </xsl:for-each>
            </xsl:when>
            <xsl:otherwise/>
          </xsl:choose>
        </td>
        <td align="right" valign="top" width="50%">
          <xsl:for-each select="/notification_data/organization_unit">
            <table cellpadding="0" cellspacing="0" style="font-family: Arial, Helvetica, sans-serif;font-size: 13px; color:#5F6163;"><tr><td>
            <b>
              <xsl:value-of select="name"/>
            </b>
            <br/>
            <xsl:value-of select="address/line1"/>
            <br/>
            <xsl:value-of select="address/postal_code"/>&#160;<xsl:value-of select="address/city"/>
          </td></tr></table>
          </xsl:for-each>
        </td>
      </tr>
    </table>
  </xsl:template>
</xsl:stylesheet>