<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <xsl:include href="header.xsl"/>
 <xsl:include href="senderReceiver.xsl"/>
 <xsl:include href="mailReason.xsl"/>
 <xsl:include href="footer.xsl"/>
 <xsl:include href="style.xsl"/>
 <xsl:include href="recordTitle.xsl"/>
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
    <xsl:call-template name="head"/>
    <!-- header.xsl -->
    <div class="messageArea">
     <div class="messageBody">

      <xsl:call-template name="toWhomIsConcerned"/>
      <!-- mailReason.xsl -->

      <xsl:if test="notification_data/item_loans/item_loan or notification_data/overdue_item_loans/item_loan">

       <p>
        @@reminder_message@@
        <!-- Under følger en oversikt over dine lån: -->
       </p>

       <xsl:if test="notification_data/overdue_item_loans/item_loan">

        <h3>@@overdue_loans@@</h3>

        <table cellpadding="5" class="listing">
         <xsl:attribute name="style">
          <xsl:call-template name="mainTableStyleCss"/>
          <!-- style.xsl -->
         </xsl:attribute>
         <tr>
          <th>@@title@@</th>
          <th>@@description@@</th>
          <th>@@author@@</th>
          <th>@@due_date@@</th>
          <th>@@fine@@</th>
          <th>@@library@@</th>
         </tr>
         <xsl:for-each select="notification_data/overdue_item_loans/item_loan">
          <tr>
           <td>
            <xsl:value-of select="title"/>
           </td>
           <td>
            <xsl:value-of select="description"/>
           </td>
           <td>
            <xsl:value-of select="author"/>
           </td>
           <td>
            <xsl:value-of select="due_date"/>
           </td>
           <td>
            <xsl:value-of select="fine"/>
           </td>
           <td>
            <xsl:value-of select="library_name"/>
           </td>
          </tr>
         </xsl:for-each>
        </table>
       </xsl:if>

       <xsl:if test="notification_data/item_loans/item_loan">

        <!-- Skip header if no overdue loans -->
        <xsl:if test="notification_data/overdue_item_loans/item_loan">
         <h3>@@loans@@</h3>
        </xsl:if>

        <table cellpadding="5" class="listing">
         <xsl:attribute name="style">
          <xsl:call-template name="mainTableStyleCss"/>
          <!-- style.xsl -->
         </xsl:attribute>
         <tr>
          <th>@@title@@</th>
          <th>@@due_date@@</th>
          <th>@@fine@@</th>
          <th>@@description@@</th>
         </tr>
         <xsl:for-each select="notification_data/item_loans/item_loan">
          <tr>
           <td>
            <xsl:value-of select="title"/>
           </td>
           <td>
            <xsl:value-of select="due_date"/>
           </td>
           <td>
            <xsl:value-of select="fine"/>
           </td>
           <td>
            <xsl:value-of select="description"/>
           </td>
          </tr>
         </xsl:for-each>
        </table>
       </xsl:if>
      </xsl:if>

      <xsl:if test="notification_data/organization_fee_list/string">
       <p>
        <h3>@@debt_message@@</h3>
       </p>
       <ul>
        <xsl:for-each select="notification_data/organization_fee_list/string">
         <li>
          <xsl:value-of select="."/>
         </li>
        </xsl:for-each>
       </ul>
       <p>
        <em>
         @@total@@ <xsl:value-of select="notification_data/total_fee"/>
        </em>
       </p>
       <p>
        @@please_pay_message@@
       </p>
      </xsl:if>
     </div>
    </div>
    <!-- footer.xsl -->
    <xsl:call-template name="lastFooter"/>
    <xsl:call-template name="myAccount"/>
    <xsl:call-template name="contactUs"/>
   </body>
  </html>
 </xsl:template>
</xsl:stylesheet>