<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >

	<xsl:output method="xml" encoding="utf-8" indent="yes"/>

    <!-- Identity template : copy all text nodes, elements and attributes -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>

    <!-- Anonymization -->

	<!-- Name -->
    <xsl:template match="user_for_printing/name/text()">Normalbakke, Sølvi</xsl:template>
    <xsl:template match="first_name/text()">Sølvi</xsl:template>
    <xsl:template match="last_name/text()">Normalbakke</xsl:template>
    <xsl:template match="user/duplicate_user_name/text()">Sølvi Normalbakke</xsl:template>

	<!-- Email -->
    <xsl:template match="address_from/text()">example-library@example.com</xsl:template>
    <xsl:template match="address_from/text()">example-library@example.com</xsl:template>
    <xsl:template match="email_receiver/mail_address/text()">example@example.com</xsl:template>
    <xsl:template match="email/email/text()">example-library@example.com</xsl:template>
    <xsl:template match="user_email/email/text()">example-patron@example.com</xsl:template>
    <xsl:template match="user_for_printing/email/text()">example-patron@example.com</xsl:template>

	<!-- Phone -->
    <xsl:template match="phone/text()">12345678</xsl:template>
    <xsl:template match="phone_list_str/text()">12345678</xsl:template>

    <!-- Physical address -->
    <xsl:template match="city/text()">Lahti</xsl:template>

    <xsl:template match="user_address/line1/text()">Matkakeskus 1234</xsl:template>
    <xsl:template match="user_for_printing/address1/text()">Matkakeskus 1234</xsl:template>

    <xsl:template match="user_address/line2/text()"></xsl:template>
    <xsl:template match="user_for_printing/address2/text()"></xsl:template>

    <xsl:template match="user_address/line3/text()"></xsl:template>
    <xsl:template match="user_for_printing/address3/text()"></xsl:template>

    <xsl:template match="user_address/line4/text()"></xsl:template>
    <xsl:template match="user_for_printing/address4/text()"></xsl:template>

    <xsl:template match="user_address/line5/text()"></xsl:template>
    <xsl:template match="user_for_printing/address5/text()"></xsl:template>

    <xsl:template match="user_address/note/text()"></xsl:template>
    <xsl:template match="user_for_printing/address6/text()"></xsl:template>

    <xsl:template match="user_address/postal_code/text()">1234</xsl:template>
    <xsl:template match="user_for_printing/postal_code/text()"></xsl:template>

	<!-- Identifiers -->
    <xsl:template match="user_name/text()">ub1234567</xsl:template>
    <xsl:template match="user_id/text()">123456789</xsl:template>
    <xsl:template match="user_for_printing/identifiers/code_value/value/text()">ub1234567</xsl:template>
    <xsl:template match="original_id/text()">12345678</xsl:template>
    <xsl:template match="item_loan_id/text()">123456789</xsl:template>

	<!-- Birth date -->
    <xsl:template match="birth_date/text()">01/01/2000</xsl:template>
    <xsl:template match="birth_date_dummy"></xsl:template>

	<!-- Other stuff -->
    <xsl:template match="sms_receiver"></xsl:template>
    <xsl:template match="webhook_data"></xsl:template>

</xsl:stylesheet>