<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="smsRecordTitle.xsl" />
 <xsl:template match="/">

<xsl:value-of select="notification_data/receivers/sms_receiver/phone_list_str"/> : <xsl:value-of select="notification_data/organization_unit/name"/>.
@@hi@@ <xsl:value-of select="notification_data/user_for_printing/name"/>,
<xsl:if test="notification_data/message='RECALL_DUEDATE_CHANGE'">@@recall_and_date_change@@<xsl:for-each select="notification_data/item_loans/item_loan">
@@title@@: <xsl:value-of select="title" />
@@old_due_date@@: <xsl:value-of select="old_due_date_str" />
@@new_due_date@@: <xsl:value-of select="new_due_date_str" />
</xsl:for-each>
</xsl:if>
<xsl:if test="notification_data/message='RECALL_ONLY'">@@recall_and_no_date_change@@<xsl:for-each select="notification_data/item_loans/item_loan">
@@title@@: <xsl:value-of select="title" />
@@due_date@@: <xsl:value-of select="new_due_date_str" />
</xsl:for-each>
</xsl:if>
<xsl:if test="notification_data/message='DUE_DATE_CHANGE_ONLY'">@@due_date_change_only@@<xsl:for-each select="notification_data/item_loans/item_loan">
@@title@@: <xsl:value-of select="title" />
@@new_due_date@@: <xsl:value-of select="new_due_date_str" />
</xsl:for-each>
</xsl:if>
<xsl:if test="notification_data/message='RECALL_CANCEL_RESTORE_ORIGINAL_DUEDATE'">@@cancel_recall_date_change@@<xsl:for-each select="notification_data/item_loans/item_loan">
@@title@@: <xsl:value-of select="title" />
@@new_due_date@@: <xsl:value-of select="new_due_date_str" />
</xsl:for-each>
</xsl:if>
<xsl:if test="notification_data/message='RECALL_CANCEL_ITEM_RENEWED'">@@cancel_recall_renew@@<xsl:for-each select="notification_data/item_loans/item_loan">
@@title@@: <xsl:value-of select="title" />
@@new_due_date@@: <xsl:value-of select="new_due_date_str" />
</xsl:for-each>
</xsl:if>
<xsl:if test="notification_data/message='RECALL_CANCEL_NO_CHANGE'">@@cancel_recall_no_date_change@@<xsl:for-each select="notification_data/item_loans/item_loan">
@@title@@: <xsl:value-of select="title" />
@@due_date@@: <xsl:value-of select="new_due_date_str" />
</xsl:for-each>
</xsl:if>
@@pleaseContact@@.
 </xsl:template>
</xsl:stylesheet>