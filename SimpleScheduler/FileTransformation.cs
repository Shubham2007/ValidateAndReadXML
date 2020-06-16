using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Xml;
using System.Xml.Schema;

namespace SimpleScheduler
{
    /// <summary>
    /// Class used to transform XMLs to C# objects after validation against schema
    /// </summary>
    public class FileTransformation : IFileTransformation
    {
        #region Fields

        // Schema path to validate the XMLs
        private readonly string schemaPath = AppContext.BaseDirectory.Substring(0, AppContext.BaseDirectory.IndexOf("bin")) + "\\pain.001.001.03.xsd";

        // Path for XSLT
        private readonly string xsltPath = AppContext.BaseDirectory.Substring(0, AppContext.BaseDirectory.IndexOf("bin")) + "\\ISO-XML-To-EDI.xslt";

        private const string targetSchemaNamespace = "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03";

        // API endpoint to post data
        private const string APIUrl = "";

        #endregion

        #region Public Methods

        /// <summary>
        /// Watch folder periodically to validate and read pain.001 files
        /// </summary>
        public void ProcessFiles()
        {
            Console.WriteLine(string.Format("Watching Files at: {0}", DateTime.Now) + Environment.NewLine);

            // Gets all the XML filePaths
            var result = FileHelper.GetAllFilesPaths();

            if (!result.success)
            {
                Console.WriteLine(result.message);
                return;
            }

            // All pain.001 XML file paths
            IEnumerable<string> filePaths = result.filePaths.Where(filePath => !string.IsNullOrWhiteSpace(filePath));

            ReadAndValidateFiles(filePaths);           

            Console.WriteLine(Environment.NewLine + string.Format("Successfully Watched Files at: {0}", DateTime.Now));
            Console.WriteLine("--------------------------------------------------------------------" + Environment.NewLine);
        }

        #endregion

        #region Private Methods

        /// <summary>
        /// Validate and read XML files
        /// </summary>
        /// <param name="filePaths"></param>
        private void ReadAndValidateFiles(IEnumerable<string> filePaths)
        {
            // Validate and read data from each XML file
            foreach (string filePath in filePaths)
            {
                try
                {
                    // Validate each XML file before processing
                    FileHelper.ValidateXMLFile(filePath, schemaPath, targetSchemaNamespace);

                    // Get filename from filepath
                    string fileName = Path.GetFileName(filePath);

                    // Convert ISO-XML to EDI
                    var objFileXsltSettings = new System.Xml.Xsl.XsltSettings();
                    var objFileXsltTrnsfrm = new System.Xml.Xsl.XslCompiledTransform();
                    System.Xml.Xsl.XsltArgumentList xslArgs = new System.Xml.Xsl.XsltArgumentList();

                    using (var objFileXmlWriter = new XmlTextWriter(@"C:\Users\shubham.chauhan\Desktop\EDIFiles\" + fileName + "-EDI.txt", Encoding.Default))
                    {
                        objFileXsltSettings.EnableScript = true;
                        objFileXsltTrnsfrm.Load(xsltPath, objFileXsltSettings, null);
                        xslArgs.AddParam("fileid", "", "1");
                        objFileXsltTrnsfrm.Transform(filePath, xslArgs, objFileXmlWriter);
                    }

                    // Read XML File in C# objects
                    Document document = FileHelper.ReadXMLFile<Document>(filePath);

                    // Send XML data to API
                    //SendXMLData<Document>(fileName, document);

                    Console.WriteLine($"FileName = {fileName}, MessageId = {document.CstmrCdtTrfInitn.GrpHdr.MsgId}");
                }
                catch (XmlSchemaValidationException ex)
                {
                    Console.WriteLine($"Unable to process file: {filePath} due to below error");
                    Console.WriteLine(ex.Message);
                    continue;
                }
                catch (Exception e)
                {
                    Console.WriteLine($"Error occured while processing the file: {filePath}");
                    Console.WriteLine(e.Message);
                    continue;
                }
            }
        }

        /// <summary>
        /// Send the XML pain.001 data to API
        /// </summary>
        /// <param name="fileName"></param>
        /// <param name="document"></param>
        /// <returns></returns>
        private static void SendXMLData<T>(string fileName, T document) where T : XMLDocument
        {
            using (var httpClient = new HttpClient())
            {
                var jsonContent = JsonConvert.SerializeObject(document);
                StringContent stringContent = new StringContent(jsonContent, Encoding.UTF8, "application/json");

                // Make http call to post data
                var response = httpClient.PostAsync(APIUrl, stringContent).Result;

                response.EnsureSuccessStatusCode();
                var serializedData = response.Content.ReadAsStringAsync().Result;
                string data = JsonConvert.DeserializeObject<string>(serializedData);
            }
        }

        #endregion
    }
}
