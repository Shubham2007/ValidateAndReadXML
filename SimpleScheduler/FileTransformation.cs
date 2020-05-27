using System;
using System.Collections.Generic;
using System.Linq;

namespace SimpleScheduler
{
    public class FileTransformation
    {
        /// <summary>
        /// Watch folder periodically to validate and read pain.001 files
        /// </summary>
        public void ProcessFiles()
        {
            Console.WriteLine(string.Format("Watching Files at: {0}", DateTime.Now) + Environment.NewLine);

            // Gets all the xml filePaths
            var result = FileHelper.GetAllFilesPaths();

            if (!result.success)
            {
                Console.WriteLine(result.message);
                return;
            }

            // All pain.001 XML file paths
            IEnumerable<string> filePaths = result.filePaths.Where(filePath => !string.IsNullOrWhiteSpace(filePath));

            // Validate and read data from each XML file
            FileHelper.ValidateAndReadFiles(filePaths);

            Console.WriteLine(Environment.NewLine + string.Format("Successfully Watched Files at: {0}", DateTime.Now));
            Console.WriteLine("--------------------------------------------------------------------" + Environment.NewLine);
        }
    }
}
