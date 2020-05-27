using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Schema;
using System.Xml.Serialization;

namespace SimpleScheduler
{
    public static class FileHelper
    {
        #region Fields

        // Directory path to lookup for XML files
        private const string defaultDirectory = @"C:\Users\shubham.chauhan\Desktop\XMlFiles";

        // API endpoint to post data
        private const string APIUrl = "";

        #endregion

        #region Public Methods

        /// <summary>
        /// Returns all the xml filenames from the directory
        /// </summary>
        /// <returns></returns>
        public static (bool success, string message, IEnumerable<string> filePaths) GetAllFilesPaths(string directory = null)
        {
            directory = directory ?? defaultDirectory;

            // Checks if directory path is entered
            if (string.IsNullOrWhiteSpace(directory))
            {
                return (false, "Please enter the directory path first before proceeding further", null);
            }

            // Checks if directory exists
            if (!Directory.Exists(directory))
            {
                return (false, "Directory does not exist", null);
            }

            // Get all files with .xml extension
            IEnumerable<string> files = Directory.EnumerateFiles(directory, "*.xml");

            // Checks if xml files exists in the directory
            if (files == null || files.ToList().Count < 1)
            {
                return (false, "No xml files exists yet", null);
            }

            return (success: true, message: string.Empty, filePaths: files);
        }

        /// <summary>
        /// Validate and read data from XML files
        /// </summary>
        /// <param name="filePaths"></param>
        public static void ValidateAndReadFiles(IEnumerable<string> filePaths)
        {
            var serializer = new XmlSerializer(typeof(Document));

            foreach (var filePath in filePaths)
            {
                try
                {
                    ValidateFile(filePath);

                    // Read each XML file
                    using (FileStream file = File.OpenRead(filePath))
                    {
                        // Convert XML to C# Object
                        var document = (Document)serializer.Deserialize(file);

                        // Get filename from filepath
                        string fileName = Path.GetFileName(filePath);

                        // Send XML data to API
                        // SendXMLData(fileName, document);

                        Console.WriteLine($"FileName = {fileName}, MessageId = {document.CstmrCdtTrfInitn.GrpHdr.MsgId}");
                    }
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

        #endregion

        #region Private Methods

        /// <summary>
        /// Send the XML pain.001 data to API
        /// </summary>
        /// <param name="fileName"></param>
        /// <param name="document"></param>
        /// <returns></returns>
        private static void SendXMLData(string fileName, Document document)
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

        /// <summary>
        /// Validate the xml file against pain.001.001.03.xsd schema
        /// </summary>
        /// <param name="filePath"></param>
        private static void ValidateFile(string filePath)
        {
            // Get path of schema to validate xml
            var path = AppContext.BaseDirectory.Substring(0, AppContext.BaseDirectory.IndexOf("bin"));
            XmlSchemaSet schema = new XmlSchemaSet();

            schema.Add("urn:iso:std:iso:20022:tech:xsd:pain.001.001.03", path + "\\pain.001.001.03.xsd");
            XmlReader reader = XmlReader.Create(filePath);
            XDocument doc = XDocument.Load(reader);
            doc.Validate(schema, ValidationEventHandler);
        }

        /// <summary>
        /// Event method that occurs only when the XML reader encounters validation errors
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private static void ValidationEventHandler(object sender, ValidationEventArgs e)
        {
            switch (e.Severity)
            {
                case XmlSeverityType.Error:
                    throw new XmlSchemaValidationException(e.Message);

                case XmlSeverityType.Warning:
                    Console.WriteLine("Warning {0}", e.Message);
                    break;
            }
        }

        #endregion
    }
}
