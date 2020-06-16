<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:userVB="http://schemas.microsoft.com" xmlns:pain="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">

  <!--xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"-->
  <xsl:output method="text" omit-xml-declaration="yes"/>
  
  <xsl:param name="fileid"></xsl:param>
  <xsl:variable name="ElementDelim" select="'*'"></xsl:variable>
  <xsl:variable name="SegmentDelim" select="'\&#13;&#10;'"></xsl:variable>

  <!--Root-->
  <xsl:template match="/">


    <xsl:call-template name="ISA"></xsl:call-template>
   
    <xsl:apply-templates select="pain:Document/pain:CstmrCdtTrfInitn/pain:PmtInf"></xsl:apply-templates>   
    
    <xsl:call-template name="IEA"></xsl:call-template>

  </xsl:template>


  <!--ISA-->
  <xsl:template name="ISA">

    <xsl:text>ISA</xsl:text>
    <xsl:value-of select="$ElementDelim"/>

    <!-- ISA01 -->    
    <xsl:text>00</xsl:text>   
    
    <xsl:value-of select="$ElementDelim"/>

    <!-- ISA02 -->
    
      <xsl:text>          </xsl:text>
    
    <xsl:value-of select="$ElementDelim"/>

    <!-- ISA03 -->
    
      <xsl:text>00</xsl:text>
    
    <xsl:value-of select="$ElementDelim"/>

    <!-- ISA04 -->
    
      <xsl:text>          </xsl:text>
    
    <xsl:value-of select="$ElementDelim"/>

    <!-- ISA05 -->
    <xsl:text>ZZ</xsl:text>
    <xsl:value-of select="$ElementDelim"/>

    <!-- ISA06 -->
    <xsl:text>VENDORIN       </xsl:text>
    <xsl:value-of select="$ElementDelim"/>

    <!-- ISA07 -->
    <xsl:text>ZZ</xsl:text>
    <xsl:value-of select="$ElementDelim"/>

    <!-- ISA08 -->
    <xsl:text>CITIBANKDEL-EDI</xsl:text>
    <xsl:value-of select="$ElementDelim"/>

    <!-- ISA09 -->
    <xsl:value-of select="userVB:DateYYMMDD()"/>
    <xsl:value-of select="$ElementDelim"/>

    <!-- ISA10 -->
    <xsl:value-of select="userVB:Time()"/>
    <xsl:value-of select="$ElementDelim"/>

    <!-- ISA11 -->
    <xsl:text>U</xsl:text>
    <xsl:value-of select="$ElementDelim"/>

    <!-- ISA12 -->
    <xsl:text>00400</xsl:text>
    <xsl:value-of select="$ElementDelim"/>

    <!-- ISA13 -->
    <xsl:variable name ="iTCNCount" select ="string-length($fileid)"></xsl:variable>
    <xsl:call-template name="AppendLeadingZeros">
      <xsl:with-param name="count" select="9-($iTCNCount)"/>
    </xsl:call-template>
    
    <xsl:value-of select="$fileid"/>    
    <xsl:value-of select="$ElementDelim"/>

    <!-- ISA14 -->
    <xsl:text>0</xsl:text>
    <xsl:value-of select="$ElementDelim"/>

    <!-- ISA15 -->
    <xsl:text>T</xsl:text>
    <xsl:value-of select="$ElementDelim"/>

    <!-- ISA16 -->
    <xsl:text>:</xsl:text>
    <xsl:value-of select="$SegmentDelim"/>


  </xsl:template>

  <!--GS-->
  <xsl:template name="GS">

    <xsl:text>GS</xsl:text>
    <xsl:value-of select="$ElementDelim"/>

    <xsl:text>RA</xsl:text>
    <xsl:value-of select="$ElementDelim"/>



    <xsl:text>CPEX-EFT1</xsl:text>
    <xsl:value-of select="$ElementDelim"/>

    <xsl:text>CPEX-ACHA</xsl:text>
    <xsl:value-of select="$ElementDelim"/>

    <xsl:value-of select="userVB:DateYYYYMMDD()"/>
    <xsl:value-of select="$ElementDelim"/>

    <!--<xsl:text>1810</xsl:text>-->
    <xsl:value-of select="userVB:Time()"/>
    <xsl:value-of select="$ElementDelim"/>

    <xsl:value-of select="userVB:GroupNumberGet()"/>
    <xsl:value-of select="$ElementDelim"/>

    <xsl:text>X</xsl:text>
    <xsl:value-of select="$ElementDelim"/>

    <xsl:text>004010</xsl:text>
    <xsl:value-of select="$SegmentDelim"/>


  </xsl:template>
  
  
  <!--Payments-->
  <xsl:template match="pain:Document/pain:CstmrCdtTrfInitn/pain:PmtInf">
    <xsl:call-template name="GS"></xsl:call-template>
    
    <xsl:apply-templates select="pain:CdtTrfTxInf"></xsl:apply-templates>
    
    <xsl:call-template name="GE"></xsl:call-template>
    <!--<xsl:call-template name="Payment"></xsl:call-template>-->
  </xsl:template>

  <!--Payments-->
  <xsl:template match="pain:CdtTrfTxInf">    

      <xsl:call-template name="ST"></xsl:call-template>
      

      <xsl:call-template name="BPR"></xsl:call-template>

    <xsl:call-template name="CUR"></xsl:call-template>
    
    <xsl:call-template name="REF"></xsl:call-template>

    <xsl:call-template name="REFOther"></xsl:call-template>

    <xsl:call-template name="REFQQ"></xsl:call-template>
    
    <xsl:call-template name="N1Payer"></xsl:call-template>

    <xsl:call-template name="N1Payee"></xsl:call-template>

    <xsl:call-template name="N-Address"></xsl:call-template>
    
    <xsl:call-template name="N4"></xsl:call-template>
    
    
    <xsl:call-template name="ENT"></xsl:call-template>

    <xsl:call-template name="RMR"></xsl:call-template>

      <!--<xsl:call-template name="TRN"></xsl:call-template>
      
      <xsl:call-template name="REF"></xsl:call-template>
      
      <xsl:call-template name="DTM"></xsl:call-template>-->
      
      <xsl:call-template name="SE"></xsl:call-template>    

  </xsl:template>

  <!--ST-->
  <xsl:template name="ST">

    <xsl:value-of select="userVB:incrementSegment()  "/>

    <xsl:text>ST</xsl:text>
    <xsl:value-of select="$ElementDelim"/>

    <xsl:text>820</xsl:text>    
    <xsl:value-of select="$ElementDelim"/>

    <xsl:variable name ="iTCNCount" select ="string-length(userVB:PaymentNumberGet())"></xsl:variable>
    <xsl:call-template name="AppendLeadingZeros">
      <xsl:with-param name="count" select="4-($iTCNCount)"/>
    </xsl:call-template>
    <xsl:value-of select="normalize-space(userVB:PaymentNumberReturn())"/>
    <xsl:value-of select="$SegmentDelim"/>

  </xsl:template>
  

  <!--BPR-->
  <xsl:template name="BPR">

    <xsl:value-of select="userVB:incrementSegment()"/>
    <xsl:text>BPR</xsl:text>
    <xsl:value-of select="$ElementDelim"/>

    <xsl:text>X</xsl:text>
    <xsl:value-of select="$ElementDelim"/>

    <!-- Amount display validation for decimal points-->
    <xsl:if test="round(pain:Amt/pain:InstdAmt/text())= (pain:Amt/pain:InstdAmt/text())">
      <xsl:if test="string(pain:Amt/pain:InstdAmt/text())!=''">
        <xsl:value-of select='round(pain:Amt/pain:InstdAmt/text())'></xsl:value-of>
      </xsl:if>
    </xsl:if>
    <xsl:if test='round(pain:Amt/pain:InstdAmt/text())!=(pain:Amt/pain:InstdAmt/text())'>
      <xsl:if test="string(pain:Amt/pain:InstdAmt/text())!=''">
        <xsl:value-of select='format-number(round(100*(pain:Amt/pain:InstdAmt/text())) div 100 ,"##.00" )'></xsl:value-of>
      </xsl:if>
    </xsl:if>
    <xsl:value-of select="$ElementDelim"/>

    <xsl:text>C</xsl:text>
    <xsl:value-of select="$ElementDelim"/>
    
    <xsl:choose>
      <xsl:when test="../pain:PmtMtd/text()='CHK'">CHK</xsl:when>
      <xsl:when test="../pain:PmtMtd/text()='TRF' and (../pain:PmtTpInf/pain:SvcLvl/pain:Cd/text()='NURG' or pain:PmtTpInf/pain:SvcLvl/pain:Cd/text()='NURG')">ACH</xsl:when>
      <xsl:when test="../pain:PmtMtd/text()='TRF' and (../pain:PmtTpInf/pain:LclInstrm/pain:Cd/text()='VCA' or pain:PmtTpInf/pain:LclInstrm/pain:Cd/text()='VCA')">VCA</xsl:when>
      <xsl:when test="../pain:PmtMtd/text()='TRF' and (../pain:PmtTpInf/pain:LclInstrm/pain:Cd/text()='CDM' or pain:PmtTpInf/pain:LclInstrm/pain:Cd/text()='CDM')='CDM'">CDM</xsl:when>
    </xsl:choose>
    <xsl:value-of select="$ElementDelim"/>

    <!-- BPR05-->
    <xsl:text></xsl:text>
    <xsl:value-of select="$ElementDelim"/>

    <!-- BPR06-->
    <xsl:choose>
      <!-- ABA  CHK Payments-->
      <xsl:when test="(../pain:PmtMtd/text()='CHK') and ((../pain:DbtrAgt/pain:FinInstnId/pain:ClrSysMmbId/pain:ClrSysId/pain:Cd/text()='USFW') or (../pain:DbtrAgt/pain:FinInstnId/pain:ClrSysMmbId/pain:ClrSysId/pain:Cd/text()='USABA'))">
        <xsl:text>01</xsl:text>
      </xsl:when>

      <!-- ABA other than CHK Payment-->
      <xsl:when test="../pain:PmtMtd/text()='TRF'">
        <xsl:text>01</xsl:text>
      </xsl:when>
      
      <!-- other than ABA-->
      <xsl:otherwise>
        <xsl:text></xsl:text>
      </xsl:otherwise>
      
      <!-- CHIP-->
      <!--<xsl:when test="(../pain:DbtrAgt/pain:FinInstnId/pain:ClrSysMmbId/pain:ClrSysId/pain:Cd/text()='USCH') or (../pain:DbtrAgt/pain:FinInstnId/pain:ClrSysMmbId/pain:ClrSysId/pain:Cd/text()='USPID')">
        <xsl:text>02</xsl:text>
      </xsl:when>-->
      
      <!-- CHIPUN-->
      <!--<xsl:when test="(../pain:DbtrAgt/pain:FinInstnId/pain:ClrSysMmbId/pain:ClrSysId/pain:Cd/text()='USCHU')">
        <xsl:text>03</xsl:text>
      </xsl:when>-->
    </xsl:choose>    
    <xsl:value-of select="$ElementDelim"/>
    
    <!-- BPR07-->
    <xsl:value-of select="../pain:DbtrAgt/pain:FinInstnId/pain:ClrSysMmbId/pain:MmbId/text()" disable-output-escaping="yes"/>
    <xsl:value-of select="$ElementDelim"/>
    
    <!-- BPR08-->
    <xsl:choose>
      <xsl:when test="(../pain:PmtMtd/text()='CHK') and (../pain:DbtrAcct/pain:Tp/pain:Cd/text()='CACC')">
        <xsl:text>DA</xsl:text>
      </xsl:when>
      <xsl:when test="../pain:PmtMtd/text()='TRF'">
        <xsl:text>DA</xsl:text>
      </xsl:when>
      <xsl:otherwise >
        <xsl:text></xsl:text>
      </xsl:otherwise>
      <!--<xsl:when test="../pain:DbtrAcct/pain:Tp/pain:Cd/text()='CACC'">
        <xsl:text>SG</xsl:text>
      </xsl:when>-->
    </xsl:choose>    
    <xsl:value-of select="$ElementDelim"/>
    
    <!-- BPR09-->
    <xsl:value-of select="../pain:DbtrAcct/pain:Id/pain:Othr/pain:Id/text()" disable-output-escaping="yes"/>
    <xsl:value-of select="$ElementDelim"/>

    <!-- BPR10-->
    <xsl:value-of select="../pain:Dbtr/pain:Id/pain:OrgId/pain:Othr/pain:Id/text()" disable-output-escaping="yes"/>

    <xsl:if test="../pain:ReqdExctnDt/text()!=''">
      <xsl:value-of select="$ElementDelim"/>
      <xsl:value-of select="$ElementDelim"/>
      <xsl:value-of select="$ElementDelim"/>
      <xsl:value-of select="$ElementDelim"/>
      <xsl:value-of select="$ElementDelim"/>
      <xsl:value-of select="$ElementDelim"/>
      <xsl:value-of select="userVB:StringDateTime(../pain:ReqdExctnDt/text())"/>
    </xsl:if>
    
    <xsl:value-of select="$SegmentDelim"/>  
    
  </xsl:template>

  <!--CUR-->
  <xsl:template name="CUR">
    <xsl:if test="pain:Amt/pain:InstdAmt/@Ccy !=''">
      <xsl:value-of select="userVB:incrementSegment()"/>

      <xsl:text>CUR</xsl:text>
      <xsl:value-of select="$ElementDelim"/>
      
      <xsl:text>PE</xsl:text>
      <xsl:value-of select="$ElementDelim"/>

      <xsl:value-of select="pain:Amt/pain:InstdAmt/@Ccy"/>      
      <xsl:value-of select="$SegmentDelim"/>

    </xsl:if>

  </xsl:template>
  
  <!--REF-->
  <xsl:template name="REF">
    <xsl:value-of select="userVB:ReferenceDataConcatenate('','True')"/>
    <xsl:choose>
      <xsl:when test="(../pain:PmtMtd/text()='TRF') and ((../pain:PmtTpInf/pain:SvcLvl/pain:Cd/text()='NURG' or pain:PmtTpInf/pain:SvcLvl/pain:Cd/text()='NURG') or (../pain:PmtTpInf/pain:LclInstrm/pain:Cd/text()='VCA' or pain:PmtTpInf/pain:LclInstrm/pain:Cd/text()='VCA') or(../pain:PmtTpInf/pain:LclInstrm/pain:Cd/text()='CDM' or pain:PmtTpInf/pain:LclInstrm/pain:Cd/text()='CDM') )">
        <xsl:value-of select="userVB:incrementSegment()"/>
       
        <xsl:text>REF</xsl:text>
        <xsl:value-of select="$ElementDelim"/>
        <xsl:text>TN</xsl:text>
        <xsl:value-of select="$ElementDelim"/>

        <xsl:value-of select="pain:PmtId/pain:EndToEndId/text()"/>

        
        <xsl:for-each select="pain:RmtInf/pain:Ustrd">
          <xsl:if test="not(contains(., '/'))">
            <xsl:value-of select="userVB:ReferenceDataConcatenate(.,'False')"/>            
          </xsl:if>
        </xsl:for-each>
        <xsl:if test="userVB:ReferenceDataConcatenateGet(62)!=''">
          <xsl:value-of select="$ElementDelim"/>
          <xsl:value-of select="userVB:ReferenceDataConcatenateGet(62)" disable-output-escaping="yes"/>
        </xsl:if>
        <xsl:value-of select="$SegmentDelim"/>
        
      </xsl:when>
      <xsl:when test="../pain:PmtMtd/text()='CHK'">
        <xsl:value-of select="userVB:incrementSegment()"/>

        <xsl:text>REF</xsl:text>
        <xsl:value-of select="$ElementDelim"/>
        <xsl:text>CK</xsl:text>
        <xsl:value-of select="$ElementDelim"/>

        <xsl:value-of select="pain:ChqInstr/pain:ChqNb/text()"/>

        <xsl:for-each select="pain:RmtInf/pain:Ustrd/text()">
          <xsl:if test="not(contains(., '/'))">
            <xsl:value-of select="userVB:ReferenceDataConcatenate(.,'False')"/>
          </xsl:if>
        </xsl:for-each>
        <xsl:if test="userVB:ReferenceDataConcatenateGet(62)!=''">
          <xsl:value-of select="$ElementDelim"/>
          <xsl:value-of select="userVB:ReferenceDataConcatenateGet(62)" disable-output-escaping="yes"/>
        </xsl:if>
        <xsl:value-of select="$SegmentDelim"/>
      </xsl:when>
    </xsl:choose>    
  </xsl:template>

  <!--REF Other-->
  <xsl:template name="REFOther">
   
    
    <xsl:for-each select="pain:RmtInf/pain:Ustrd">
      <xsl:choose>
        <xsl:when test="(starts-with(string(.),'/NAAT/'))">
          <xsl:value-of select="userVB:incrementSegment()"/>

          <xsl:value-of select="userVB:RefFiFlagSet()"/>
          
          <xsl:text>REF</xsl:text>
          <xsl:value-of select="$ElementDelim"/>
          <xsl:text>FI</xsl:text>
          <xsl:value-of select="$ElementDelim"/>
          <xsl:value-of select="substring-after(string(.),'/NAAT/')" disable-output-escaping="yes"/>

          <xsl:for-each select="../pain:Ustrd/text()">
            <xsl:choose>
              <xsl:when test="(contains(.,'/NASH/'))">
                <xsl:value-of select="$ElementDelim"/>
                <xsl:value-of select="translate(string(.),'/NASH/','')" disable-output-escaping="yes"/>
              </xsl:when>
            </xsl:choose>
          </xsl:for-each>
          
          <xsl:value-of select="$SegmentDelim"/>
        </xsl:when>

        <xsl:when test="userVB:RefFiFlagGet()=0 and (starts-with(., '/NASH/'))">
          <xsl:value-of select="userVB:incrementSegment()"/>
          
          <xsl:text>REF</xsl:text>
          <xsl:value-of select="$ElementDelim"/>
          <xsl:text>FI</xsl:text>
          <xsl:value-of select="$ElementDelim"/>

          <xsl:text></xsl:text>
          <xsl:value-of select="$ElementDelim"/>
          
          <xsl:value-of select="substring-after(string(.),'/NASH/')" disable-output-escaping="yes"/>
          <xsl:value-of select="$SegmentDelim"/>
        </xsl:when>

        <xsl:when test="(starts-with(., '/NAAL/'))">
          <xsl:value-of select="userVB:incrementSegment()"/>
          
          <xsl:text>REF</xsl:text>
          <xsl:value-of select="$ElementDelim"/>
          <xsl:text>RA</xsl:text>
          <xsl:value-of select="$ElementDelim"/>

          <xsl:text></xsl:text>
          <xsl:value-of select="$ElementDelim"/>

          <xsl:text></xsl:text>
          <xsl:value-of select="$ElementDelim"/>
          
          <xsl:value-of select="substring-after(string(.),'/NAAL/')" disable-output-escaping="yes"/>
          <xsl:value-of select="$SegmentDelim"/>
        </xsl:when>

        <xsl:when test="(starts-with(., '/NATM/'))">
          <xsl:choose>
            <xsl:when test="substring-after(string(.),'/NATM/')!=''">
              <xsl:value-of select="userVB:incrementSegment()"/>

              <xsl:text>REF</xsl:text>
              <xsl:value-of select="$ElementDelim"/>
              <xsl:text>M1</xsl:text>
              <xsl:value-of select="$ElementDelim"/>
              <xsl:value-of select="$ElementDelim"/>

              <xsl:value-of select="substring-after(string(.),'/NATM/')" disable-output-escaping="yes"/>
              <xsl:value-of select="$SegmentDelim"/>
            </xsl:when>
          </xsl:choose>          
        </xsl:when>
        
      </xsl:choose>      
    </xsl:for-each>    
    
    
  </xsl:template>

  <!--REF Other-->
  <xsl:template name="REFQQ">
    <xsl:if test="pain:ChqInstr/pain:MemoFld/text()!='' and string-length(pain:ChqInstr/pain:MemoFld/text())> 0">
      <xsl:text>REF</xsl:text>
      <xsl:value-of select="$ElementDelim"/>
      <xsl:text>QQ</xsl:text>
      <xsl:value-of select="$ElementDelim"/>

      <xsl:variable name="R01" select="substring(pain:ChqInstr/pain:MemoFld/text(),0,14)"/>
      <xsl:variable name="R02" select="substring(pain:ChqInstr/pain:MemoFld/text(),14,string-length(pain:ChqInstr/pain:MemoFld/text()))"/>
      
      <xsl:value-of select="$R01" disable-output-escaping="yes"/>
      <xsl:if test="string-length($R02)>0">
        <xsl:value-of select="$ElementDelim"/>
        <xsl:value-of select="$R02" disable-output-escaping="yes"/>
      </xsl:if>
      <xsl:value-of select="$SegmentDelim"/>
    </xsl:if>

  </xsl:template>
  
  <!--N1Payer-->
  <xsl:template name="N1Payer">

    <xsl:value-of select="userVB:incrementSegment()"/>

    <xsl:text>N1</xsl:text>
    <xsl:value-of select="$ElementDelim"/>

    <xsl:text>PR</xsl:text>
    <xsl:value-of select="$ElementDelim"/>

    <xsl:value-of select="../pain:Dbtr/pain:Nm/text()" disable-output-escaping="yes"/>

    <!--<xsl:if test="(normalize-space(@PRID)!='')">
      <xsl:value-of select="$ElementDelim"/>
      <xsl:value-of select="//pain:EDISettingDetails/@N103"/>
      <xsl:value-of select="$ElementDelim"/>
      <xsl:value-of select="@PRID" disable-output-escaping="yes"/>
    </xsl:if>-->
    <xsl:value-of select="$SegmentDelim"/>

  </xsl:template>

  <!--N1Payee-->
  <xsl:template name="N1Payee">

    <xsl:value-of select="userVB:incrementSegment()"/>

    <xsl:text>N1</xsl:text>
    <xsl:value-of select="$ElementDelim"/>
    
    <xsl:text>PE</xsl:text>
    <xsl:value-of select="$ElementDelim"/>

    <xsl:value-of select="userVB:MaxLength40(pain:Cdtr/pain:Nm/text())" disable-output-escaping="yes"/>
    <xsl:value-of select="$ElementDelim"/>

    <xsl:text>93</xsl:text>
    <xsl:value-of select="$ElementDelim"/>

    <xsl:value-of select="pain:Cdtr/pain:Id/pain:OrgId/pain:Othr/pain:Id/text()"/>
    <xsl:value-of select="$SegmentDelim"/>
  </xsl:template>

  <!--N-Address-->
  <xsl:template name="N-Address">
    
    
    <xsl:if test="../pain:PmtMtd/text()='CHK'">
      
      <xsl:variable name="AddressCount" select="count(pain:Cdtr/pain:PstlAdr/pain:AdrLine/text())" />
      
      
      <xsl:for-each select="pain:Cdtr/pain:PstlAdr/pain:AdrLine/text()">

        
        
        <xsl:choose>
          <xsl:when test="position()='1'">
            <xsl:value-of select="userVB:incrementSegment()"/>
            <xsl:text>N2</xsl:text>
            <xsl:value-of select="$ElementDelim"/>

            <xsl:value-of select="." disable-output-escaping="yes"/>
            <xsl:value-of select="$SegmentDelim"/>

          </xsl:when>
          <xsl:when test="position()='2' or position()='3'">
            
            <xsl:if test="position()='2'">
              <xsl:value-of select="userVB:incrementSegment()"/>
              <xsl:text>N3</xsl:text>
              <xsl:value-of select="$ElementDelim"/>

              <xsl:value-of select="." disable-output-escaping="yes"/>
              <xsl:choose>
                <xsl:when test="position()='2' and $AddressCount>2">
                  <xsl:value-of select="$ElementDelim"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$SegmentDelim"/>
                </xsl:otherwise>
              </xsl:choose>              
            </xsl:if>
            <xsl:if test="position()='3'">
              <xsl:value-of select="." disable-output-escaping="yes"/>
              <xsl:value-of select="$SegmentDelim"/>
            </xsl:if>
            
          </xsl:when>
          <xsl:when test="position()='4'">
            <xsl:value-of select="userVB:incrementSegment()"/>
            <xsl:text>N3</xsl:text>
            <xsl:value-of select="$ElementDelim"/>

            <xsl:value-of select="." disable-output-escaping="yes"/>
            <xsl:value-of select="$SegmentDelim"/>

          </xsl:when>
        </xsl:choose>
          
        
        
      </xsl:for-each>
      
    </xsl:if>

  </xsl:template>
  
  <!--N4-->
  <xsl:template name="N4">

    <xsl:if test="../pain:PmtMtd/text()='CHK'">
      <xsl:value-of select="userVB:incrementSegment()"/>

      <xsl:text>N4</xsl:text>
      <xsl:value-of select="$ElementDelim"/>
      
      <xsl:value-of select="pain:Cdtr/pain:PstlAdr/pain:TwnNm/text()" disable-output-escaping="yes"/>
      <xsl:value-of select="$ElementDelim"/>
      
      <xsl:value-of select="pain:Cdtr/pain:PstlAdr/pain:CtrySubDvsn/text()" disable-output-escaping="yes"/>
      <xsl:value-of select="$ElementDelim"/>

      <xsl:value-of select="pain:Cdtr/pain:PstlAdr/pain:PstCd/text()"/>
      <xsl:value-of select="$ElementDelim"/>      

      <xsl:value-of select="pain:Cdtr/pain:PstlAdr/pain:Ctry/text()"/>
      <xsl:value-of select="$SegmentDelim"/>  
    </xsl:if>
    
  </xsl:template>

  <!--ENT-->
  <xsl:template name="ENT">
    <xsl:value-of select="userVB:incrementSegment()"/>
    <xsl:text>ENT</xsl:text>
    <xsl:value-of select="$ElementDelim"/>
    <xsl:text>1</xsl:text>
    <xsl:value-of select="$SegmentDelim"/>
  </xsl:template>

  <!--RMR Remittance Record-->
  <xsl:template name="RMR">
    <xsl:for-each select="pain:RmtInf/pain:Strd">

      <xsl:choose>
        <xsl:when test="pain:RfrdDocAmt/pain:TaxAmt/text()!=''">

          <xsl:value-of select="userVB:incrementSegment()"/>
          <xsl:text>RMR</xsl:text>
          <xsl:value-of select="$ElementDelim"/>

          <xsl:text>IV</xsl:text>
          <xsl:value-of select="$ElementDelim"/>

          <xsl:value-of select="pain:RfrdDocInf/pain:Nb/text()" disable-output-escaping="yes"/>
          <xsl:value-of select="$ElementDelim"/>

          <xsl:text></xsl:text>
          <xsl:value-of select="$ElementDelim"/>

          <!-- rund off need to check net amt-->
          <xsl:value-of select="pain:RfrdDocAmt/pain:RmtdAmt/text()"/>
          <xsl:value-of select="$ElementDelim"/>

          <!-- rund off need to check gross amt -->
          <xsl:value-of select="pain:RfrdDocAmt/pain:DuePyblAmt/text()"/>
          <xsl:value-of select="$ElementDelim"/>

          <!-- rund off need to check discount amt-->
          <xsl:value-of select="pain:RfrdDocAmt/pain:DscntApldAmt/text()"/>
          <xsl:value-of select="$ElementDelim"/>

          <xsl:value-of select="$ElementDelim"/>
          
          <xsl:value-of select="pain:RfrdDocAmt/pain:TaxAmt/text()"/>
          <xsl:value-of select="$SegmentDelim"/>

          <xsl:call-template name="RMTREF"></xsl:call-template>

          <xsl:call-template name="RMTDTM"></xsl:call-template>
        </xsl:when>
        
        <xsl:when test="pain:RfrdDocAmt/pain:DscntApldAmt/text()!=''">
          
          <xsl:value-of select="userVB:incrementSegment()"/>
          <xsl:text>RMR</xsl:text>
          <xsl:value-of select="$ElementDelim"/>

          <xsl:text>IV</xsl:text>
          <xsl:value-of select="$ElementDelim"/>

          <xsl:value-of select="pain:RfrdDocInf/pain:Nb/text()" disable-output-escaping="yes"/>
          <xsl:value-of select="$ElementDelim"/>

          <xsl:text></xsl:text>
          <xsl:value-of select="$ElementDelim"/>

          <!-- rund off need to check net amt-->
          <xsl:value-of select="pain:RfrdDocAmt/pain:RmtdAmt/text()"/>
          <xsl:value-of select="$ElementDelim"/>

          <!-- rund off need to check gross amt -->
          <xsl:value-of select="pain:RfrdDocAmt/pain:DuePyblAmt/text()"/>
          <xsl:value-of select="$ElementDelim"/>

          <!-- rund off need to check discount amt-->
          <xsl:value-of select="pain:RfrdDocAmt/pain:DscntApldAmt/text()"/>

          <xsl:value-of select="$SegmentDelim"/>

          <xsl:call-template name="RMTREF"></xsl:call-template>

          <xsl:call-template name="RMTDTM"></xsl:call-template>
        </xsl:when>


        <xsl:when test="pain:RfrdDocAmt/pain:DuePyblAmt/text()!=''">

          <xsl:value-of select="userVB:incrementSegment()"/>
          <xsl:text>RMR</xsl:text>
          <xsl:value-of select="$ElementDelim"/>

          <xsl:text>IV</xsl:text>
          <xsl:value-of select="$ElementDelim"/>

          <xsl:value-of select="pain:RfrdDocInf/pain:Nb/text()" disable-output-escaping="yes"/>
          <xsl:value-of select="$ElementDelim"/>

          <xsl:text></xsl:text>
          <xsl:value-of select="$ElementDelim"/>

          <!-- rund off need to check net amt-->
          <xsl:value-of select="pain:RfrdDocAmt/pain:RmtdAmt/text()"/>
          <xsl:value-of select="$ElementDelim"/>

          <!-- rund off need to check gross amt -->
          <xsl:value-of select="pain:RfrdDocAmt/pain:DuePyblAmt/text()"/>
          
          <xsl:value-of select="$SegmentDelim"/>

          <xsl:call-template name="RMTREF"></xsl:call-template>

          <xsl:call-template name="RMTDTM"></xsl:call-template>
        </xsl:when>

        <xsl:when test="pain:RfrdDocAmt/pain:RmtdAmt/text()!=''">

          <xsl:value-of select="userVB:incrementSegment()"/>
          <xsl:text>RMR</xsl:text>
          <xsl:value-of select="$ElementDelim"/>

          <xsl:text>IV</xsl:text>
          <xsl:value-of select="$ElementDelim"/>

          <xsl:value-of select="pain:RfrdDocInf/pain:Nb/text()" disable-output-escaping="yes"/>
          <xsl:value-of select="$ElementDelim"/>

          <xsl:text></xsl:text>
          <xsl:value-of select="$ElementDelim"/>

          <!-- rund off need to check net amt-->
          <xsl:value-of select="pain:RfrdDocAmt/pain:RmtdAmt/text()"/>          

          <xsl:value-of select="$SegmentDelim"/>

          <xsl:call-template name="RMTREF"></xsl:call-template>

          <xsl:call-template name="RMTDTM"></xsl:call-template>
        </xsl:when>


        <xsl:when test="pain:RfrdDocInf/pain:Nb/text()!=''">

          <xsl:value-of select="userVB:incrementSegment()"/>
          <xsl:text>RMR</xsl:text>
          <xsl:value-of select="$ElementDelim"/>

          <xsl:text>IV</xsl:text>
          <xsl:value-of select="$ElementDelim"/>

          <xsl:value-of select="pain:RfrdDocInf/pain:Nb/text()" disable-output-escaping="yes"/>          

          <xsl:value-of select="$SegmentDelim"/>

          <xsl:call-template name="RMTREF"></xsl:call-template>

          <xsl:call-template name="RMTDTM"></xsl:call-template>
        </xsl:when>

      </xsl:choose>
      
      
    </xsl:for-each>
      
  </xsl:template>

  <!--RMTREF-->
  <xsl:template name="RMTREF">
    <xsl:choose>
      <xsl:when test="pain:CdtrRefInf/pain:Tp/pain:CdOrPrtry/pain:Cd/text()='PUOR'">
        <xsl:value-of select="userVB:incrementSegment()"/>
        <xsl:text>REF</xsl:text>
        <xsl:value-of select="$ElementDelim"/>
        <xsl:text>PO</xsl:text>
        <xsl:value-of select="$ElementDelim"/>

        <xsl:value-of select="pain:CdtrRefInf/pain:Ref/text()"/>

        <xsl:if test="pain:AddtlRmtInf/text()!=''">
          <xsl:value-of select="$ElementDelim"/>
          <xsl:value-of select="pain:AddtlRmtInf/text()" disable-output-escaping="yes"/>
        </xsl:if>
        
        <xsl:value-of select="$SegmentDelim"/>
      </xsl:when>
      <xsl:when test="pain:CdtrRefInf/pain:Tp/pain:CdOrPrtry/pain:Cd/text()='RPIN'">
        <xsl:value-of select="userVB:incrementSegment()"/>
        <xsl:text>REF</xsl:text>
        <xsl:value-of select="$ElementDelim"/>
        <xsl:text>VV</xsl:text>
        <xsl:value-of select="$ElementDelim"/>

        <xsl:value-of select="pain:CdtrRefInf/pain:Ref/text()"/>

        <xsl:if test="pain:AddtlRmtInf/text()!=''">
          <xsl:value-of select="$ElementDelim"/>
          <xsl:value-of select="pain:AddtlRmtInf/text()" disable-output-escaping="yes"/>
        </xsl:if>
        
        <xsl:value-of select="$SegmentDelim"/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <!--RMTDTM-->
  <xsl:template name="RMTDTM">
    <xsl:if test="normalize-space(pain:RfrdDocInf/pain:RltdDt/text())!=''">

      <xsl:value-of select="userVB:incrementSegment()"/>

      <xsl:text>DTM</xsl:text>
      <xsl:value-of select="$ElementDelim"/>
      <xsl:text>003</xsl:text>
      <xsl:value-of select="$ElementDelim"/>

      <xsl:value-of select="translate(string(pain:RfrdDocInf/pain:RltdDt/text()),'-','')"/>
      <xsl:value-of select="$SegmentDelim"/>      
    </xsl:if>

  </xsl:template>
  
  <!--SE-->
  <xsl:template name="SE">

    <xsl:value-of select="userVB:incrementSegment()"/>

    <xsl:text>SE</xsl:text>
    <xsl:value-of select="$ElementDelim"/>

    <xsl:value-of select="userVB:SegmentCount()"/>
    <xsl:value-of select="$ElementDelim"/>

    <xsl:variable name ="iTCNCount" select ="string-length(userVB:PaymentNumberReturn())"></xsl:variable>
    <xsl:call-template name="AppendLeadingZeros">
      <xsl:with-param name="count" select="4-($iTCNCount)"/>
    </xsl:call-template>
    <xsl:value-of select="normalize-space(userVB:PaymentNumberReturn())"/>
    <xsl:value-of select="$SegmentDelim"/>
  </xsl:template>

  <!--GE-->
  <xsl:template name="GE">
    <xsl:text>GE</xsl:text>
    <xsl:value-of select="$ElementDelim"/>

    <xsl:text>1</xsl:text>
    <xsl:value-of select="$ElementDelim"/>

    <xsl:value-of select="userVB:GroupNumberReturn()"/>
    <xsl:value-of select="$SegmentDelim"/>

  </xsl:template>

  <!--IEA-->
  <xsl:template name="IEA">
    <xsl:text>IEA</xsl:text>
    <xsl:value-of select="$ElementDelim"/>

    <xsl:text>1</xsl:text>
    <xsl:value-of select="$ElementDelim"/>

    <xsl:variable name ="iTCNCount" select ="string-length($fileid)"></xsl:variable>
    <xsl:call-template name="AppendLeadingZeros">
      <xsl:with-param name="count" select="9-($iTCNCount)"/>
    </xsl:call-template>

    <xsl:value-of select="$fileid"/>
    <xsl:value-of select="$SegmentDelim"/>


  </xsl:template>

  <xsl:template name ="AppendLeadingZeros">
    <xsl:param name="count" select="1"/>
    <xsl:if test="$count > 0">
      <xsl:text>0</xsl:text>
      <xsl:call-template name="AppendLeadingZeros">
        <xsl:with-param name="count" select="($count)-1"/>
      </xsl:call-template>

    </xsl:if>
  </xsl:template>
  
  <!--VB Functions code-->
  <msxsl:script language="vb" implements-prefix="userVB">
    <![CDATA[
      Public Function DateYYMMDD() As String
            Return date.today().toString("yyMMdd")
      End Function
      Public Function DateYYYYMMDD() As String
            Return date.today().toString("yyyyMMdd")
      End Function
      
      Public Function Time() As String
            Return date.Now().toString("HHmm")
      End Function
      
      
    Dim _intSegCount as Integer = 0
    public Sub incrementSegment()
      _intSegCount=_intSegCount+1
    End Sub
    
    public Function SegmentCount() as Integer 
      dim _intSetCountTemp as integer
      _intSetCountTemp=_intSegCount
      _intSegCount=0
      Return _intSetCountTemp
      
    End Function
    
    Dim _bRefFIFlag as Integer = 0
    public Sub RefFiFlagSet()
      _bRefFIFlag=1
    End Sub
    
    public Function RefFiFlagGet() as Integer
      Return _bRefFIFlag
    End Function
    
    Public Function Delimiter(ByVal Delim as Integer) As String
      Return Chr(Delim)
    End Function
     
    Dim _intGroupNumber as Integer = 0
    public Function GroupNumberGet() as Integer
      _intGroupNumber=_intGroupNumber+1      
      Return _intGroupNumber
    End Function
    public Function GroupNumberReturn() as Integer     
      Return _intGroupNumber
    End Function
    
    
    
    Dim _intPaymentNumber as Integer = 0
    public Function PaymentNumberGet() as Integer
      _intPaymentNumber=_intPaymentNumber+1
      
      Return _intPaymentNumber
    End Function
    
    public Function PaymentNumberReturn() as Integer     
      Return _intPaymentNumber
    End Function
    
    
    
    Dim _sReferenceData as string = ""
    public Sub ReferenceDataConcatenate(ByVal Data as string, ByVal bReset as Boolean)
      If bReset Then
         _sReferenceData = ""
      End If
      _sReferenceData=_sReferenceData & Data      
    End Sub
    
    public Function ReferenceDataConcatenateGet(ByVal length as integer) as string
     If _sReferenceData.Length > length Then
        Return _sReferenceData.Substring(0, length)
     else
        Return _sReferenceData
     End If
      
    End Function
    
    public Function StringDateTime(ByVal str as String) as String
        Try
            Return Convert.ToDateTime(str).ToString("yyyyMMdd")
        Catch ex As Exception
            Return STR.Replace("-", "")
        End Try
      
    End Function
    
    Public Function MaxLength40(ByVal strData As String) As String
    If strData.length > 40 Then
    Return strData.Substring(0,40) 
    else
        Return strData
        END IF
    End Function 
    ]]>
  </msxsl:script>
</xsl:stylesheet>
