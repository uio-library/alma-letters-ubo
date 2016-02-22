<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="generalStyle">
 <style>
 body {background-color:#fff}
 .listing td {border-bottom: 1px solid #eee}
 .listing tr:hover td {background-color:#eee}
 .listing th {background-color:#eeeeee; text-align:left; }
 .transitLetter th { text-align: right; vertical-align: top; }
 .transitLetter th, .transitLetter td { padding: 3px; }
h2 {
  margin: 0;
  padding: 0;
}
h3 {
   margin: 1em 0 .2em 0;
   padding: 0;
 }
 h4{line-height: 0.2em}
 #logoContainer img {
   max-width: 100%;
 }
 .messageBody, #lastFooter, #contactUs, #myAccount {
   padding: 0 1.8em;
 }
 </style>
</xsl:template>

<xsl:template name="bodyStyleCss">
font-family: arial; color:#333; margin:0; padding:0em; font-size:90% 
</xsl:template>

<xsl:template name="listStyleCss">
list-style: none; margin:0 0 0 1em; padding:0
</xsl:template>

<xsl:template name="mainTableStyleCss">
width:100%; text-align:left
</xsl:template>

<xsl:template name="headerLogoStyleCss">
background-color:#ffffff;  width:100%;
</xsl:template>

<xsl:template name="headerTableStyleCss">
background-color:#e8e8e8;  width:100%; height:30px; text-shadow:1px 1px 1px #fff;
</xsl:template>

<xsl:template name="footerTableStyleCss">
background-color:#444;  width:100%; text-shadow:1px 1px 1px #333; color:#fff; margin-top:1em;  font-weight:700; line-height:2em; font-size:150%;
</xsl:template>


</xsl:stylesheet>