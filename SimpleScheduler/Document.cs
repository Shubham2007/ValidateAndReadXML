using System.Collections.Generic;
using System.Xml.Serialization;

namespace SimpleScheduler
{
    [XmlRoot(ElementName = "InitgPty", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
    public class InitgPty
    {
        [XmlElement(ElementName = "Nm", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public string Nm { get; set; }
    }

    [XmlRoot(ElementName = "GrpHdr", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
    public class GrpHdr
    {
        [XmlElement(ElementName = "MsgId", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public string MsgId { get; set; }
        [XmlElement(ElementName = "CreDtTm", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public string CreDtTm { get; set; }
        [XmlElement(ElementName = "NbOfTxs", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public string NbOfTxs { get; set; }
        [XmlElement(ElementName = "InitgPty", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public InitgPty InitgPty { get; set; }
    }

    [XmlRoot(ElementName = "LclInstrm", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
    public class LclInstrm
    {
        [XmlElement(ElementName = "Cd", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public string Cd { get; set; }
    }

    [XmlRoot(ElementName = "PmtTpInf", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
    public class PmtTpInf
    {
        [XmlElement(ElementName = "LclInstrm", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public LclInstrm LclInstrm { get; set; }
    }

    [XmlRoot(ElementName = "Othr", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
    public class Othr
    {
        [XmlElement(ElementName = "Id", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public string Id { get; set; }
    }

    [XmlRoot(ElementName = "OrgId", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
    public class OrgId
    {
        [XmlElement(ElementName = "Othr", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public Othr Othr { get; set; }
    }

    [XmlRoot(ElementName = "Id", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
    public class Id
    {
        [XmlElement(ElementName = "OrgId", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public OrgId OrgId { get; set; }
        [XmlElement(ElementName = "Othr", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public Othr Othr { get; set; }
    }

    [XmlRoot(ElementName = "Dbtr", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
    public class Dbtr
    {
        [XmlElement(ElementName = "Nm", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public string Nm { get; set; }
        [XmlElement(ElementName = "Id", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public Id Id { get; set; }
    }

    [XmlRoot(ElementName = "Tp", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
    public class Tp
    {
        [XmlElement(ElementName = "Cd", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public string Cd { get; set; }
        [XmlElement(ElementName = "CdOrPrtry", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public CdOrPrtry CdOrPrtry { get; set; }
    }

    [XmlRoot(ElementName = "DbtrAcct", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
    public class DbtrAcct
    {
        [XmlElement(ElementName = "Id", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public Id Id { get; set; }
        [XmlElement(ElementName = "Tp", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public Tp Tp { get; set; }
    }

    [XmlRoot(ElementName = "ClrSysId", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
    public class ClrSysId
    {
        [XmlElement(ElementName = "Cd", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public string Cd { get; set; }
    }

    [XmlRoot(ElementName = "ClrSysMmbId", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
    public class ClrSysMmbId
    {
        [XmlElement(ElementName = "ClrSysId", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public ClrSysId ClrSysId { get; set; }
        [XmlElement(ElementName = "MmbId", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public string MmbId { get; set; }
    }

    [XmlRoot(ElementName = "FinInstnId", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
    public class FinInstnId
    {
        [XmlElement(ElementName = "BIC", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public string BIC { get; set; }
        [XmlElement(ElementName = "ClrSysMmbId", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public ClrSysMmbId ClrSysMmbId { get; set; }
    }

    [XmlRoot(ElementName = "DbtrAgt", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
    public class DbtrAgt
    {
        [XmlElement(ElementName = "FinInstnId", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public FinInstnId FinInstnId { get; set; }
    }

    [XmlRoot(ElementName = "PmtId", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
    public class PmtId
    {
        [XmlElement(ElementName = "InstrId", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public string InstrId { get; set; }
        [XmlElement(ElementName = "EndToEndId", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public string EndToEndId { get; set; }
    }

    [XmlRoot(ElementName = "InstdAmt", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
    public class InstdAmt
    {
        [XmlAttribute(AttributeName = "Ccy")]
        public string Ccy { get; set; }
        [XmlText]
        public string Text { get; set; }
    }

    [XmlRoot(ElementName = "Amt", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
    public class Amt
    {
        [XmlElement(ElementName = "InstdAmt", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public InstdAmt InstdAmt { get; set; }
    }

    [XmlRoot(ElementName = "PstlAdr", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
    public class PstlAdr
    {
        [XmlElement(ElementName = "PstCd", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public string PstCd { get; set; }
        [XmlElement(ElementName = "TwnNm", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public string TwnNm { get; set; }
        [XmlElement(ElementName = "CtrySubDvsn", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public string CtrySubDvsn { get; set; }
        [XmlElement(ElementName = "Ctry", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public string Ctry { get; set; }
        [XmlElement(ElementName = "AdrLine", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public string AdrLine { get; set; }
    }

    [XmlRoot(ElementName = "Cdtr", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
    public class Cdtr
    {
        [XmlElement(ElementName = "Nm", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public string Nm { get; set; }
        [XmlElement(ElementName = "PstlAdr", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public PstlAdr PstlAdr { get; set; }
        [XmlElement(ElementName = "Id", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public Id Id { get; set; }
    }

    [XmlRoot(ElementName = "CdOrPrtry", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
    public class CdOrPrtry
    {
        [XmlElement(ElementName = "Cd", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public string Cd { get; set; }
    }

    [XmlRoot(ElementName = "RfrdDocInf", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
    public class RfrdDocInf
    {
        [XmlElement(ElementName = "Tp", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public Tp Tp { get; set; }
        [XmlElement(ElementName = "Nb", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public string Nb { get; set; }
    }

    [XmlRoot(ElementName = "CdtrRefInf", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
    public class CdtrRefInf
    {
        [XmlElement(ElementName = "Tp", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public Tp Tp { get; set; }
        [XmlElement(ElementName = "Ref", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public string Ref { get; set; }
    }

    [XmlRoot(ElementName = "Strd", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
    public class Strd
    {
        [XmlElement(ElementName = "RfrdDocInf", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public RfrdDocInf RfrdDocInf { get; set; }
        [XmlElement(ElementName = "CdtrRefInf", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public CdtrRefInf CdtrRefInf { get; set; }
    }

    [XmlRoot(ElementName = "RmtInf", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
    public class RmtInf
    {
        [XmlElement(ElementName = "Ustrd", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public List<string> Ustrd { get; set; }
        [XmlElement(ElementName = "Strd", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public Strd Strd { get; set; }
    }

    [XmlRoot(ElementName = "CdtTrfTxInf", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
    public class CdtTrfTxInf
    {
        [XmlElement(ElementName = "PmtId", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public PmtId PmtId { get; set; }
        [XmlElement(ElementName = "PmtTpInf", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public PmtTpInf PmtTpInf { get; set; }
        [XmlElement(ElementName = "Amt", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public Amt Amt { get; set; }
        [XmlElement(ElementName = "Cdtr", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public Cdtr Cdtr { get; set; }
        [XmlElement(ElementName = "RmtInf", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public RmtInf RmtInf { get; set; }
    }

    [XmlRoot(ElementName = "PmtInf", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
    public class PmtInf
    {
        [XmlElement(ElementName = "PmtInfId", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public string PmtInfId { get; set; }
        [XmlElement(ElementName = "PmtMtd", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public string PmtMtd { get; set; }
        [XmlElement(ElementName = "PmtTpInf", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public PmtTpInf PmtTpInf { get; set; }
        [XmlElement(ElementName = "ReqdExctnDt", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public string ReqdExctnDt { get; set; }
        [XmlElement(ElementName = "Dbtr", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public Dbtr Dbtr { get; set; }
        [XmlElement(ElementName = "DbtrAcct", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public DbtrAcct DbtrAcct { get; set; }
        [XmlElement(ElementName = "DbtrAgt", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public DbtrAgt DbtrAgt { get; set; }
        [XmlElement(ElementName = "CdtTrfTxInf", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public List<CdtTrfTxInf> CdtTrfTxInf { get; set; }
    }

    [XmlRoot(ElementName = "CstmrCdtTrfInitn", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
    public class CstmrCdtTrfInitn
    {
        [XmlElement(ElementName = "GrpHdr", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public GrpHdr GrpHdr { get; set; }
        [XmlElement(ElementName = "PmtInf", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public List<PmtInf> PmtInf { get; set; }
    }

    [XmlRoot(ElementName = "Document", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
    public class Document
    {
        [XmlElement(ElementName = "CstmrCdtTrfInitn", Namespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03")]
        public CstmrCdtTrfInitn CstmrCdtTrfInitn { get; set; }
        [XmlAttribute(AttributeName = "xsi", Namespace = "http://www.w3.org/2000/xmlns/")]
        public string Xsi { get; set; }
        [XmlAttribute(AttributeName = "xmlns")]
        public string Xmlns { get; set; }
    }

}
