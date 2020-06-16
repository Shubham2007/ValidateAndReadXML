using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Schema;
using System.Xml.Serialization;

namespace SimpleScheduler
{
    /// <summary>
    /// Helper class used for common file operations
    /// </summary>
    public static class FileHelper
    {
        #region Fields

        // Directory path to lookup for XML files
        private const string defaultDirectory = @"C:\Users\shubham.chauhan\Desktop\XMlFiles";  

        #endregion

        #region Public Methods

        /// <summary>
        /// Returns all the xml filepaths from the directory
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
        /// Validate the xml file against pain.001.001.03.xsd schema
        /// </summary>
        /// <param name="filePath"></param>
        public static void ValidateXMLFile(string filePath, string schemaPath, string targetNamespace)
        {
            if (string.IsNullOrWhiteSpace(filePath))
                throw new ArgumentNullException(nameof(filePath));

            if (string.IsNullOrWhiteSpace(schemaPath))
                throw new ArgumentNullException(nameof(schemaPath));

            XmlSchemaSet schema = new XmlSchemaSet();

            schema.Add(targetNamespace, schemaPath);
            XmlReader reader = XmlReader.Create(filePath);
            XDocument doc = XDocument.Load(reader);
            doc.Validate(schema, ValidationEventHandler);
        }

        /// <summary>
        /// Validate and read data from XML files
        /// </summary>
        /// <typeparam name="T">T: Type of C# class to parse XML doument</typeparam>
        /// <param name="filePath"></param>
        public static T ReadXMLFile<T>(string filePath) where T : XMLDocument
        {
            if (string.IsNullOrWhiteSpace(filePath))
                throw new ArgumentNullException(nameof(filePath));

            var serializer = new XmlSerializer(typeof(T));

            // Read each XML file
            using (FileStream file = File.OpenRead(filePath))
            {
                // Convert XML to C# Object
                T instance = (T)serializer.Deserialize(file);

                return instance;           
            }
        }  

        #endregion

        #region Private Methods

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
