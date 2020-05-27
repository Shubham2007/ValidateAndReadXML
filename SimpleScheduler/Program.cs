using System;
using System.Threading;

namespace SimpleScheduler
{
    class Program
    {
        static void Main(string[] args)
        {
            try
            {
                // Get the File Transformation instance from services
                var fileTransformationService = (IFileTransformation)DependencyHelper.ServiceProvider.GetService(typeof(IFileTransformation));

                // Call ProcessFiles method in every 1 Minute
                var timer = new Timer(e =>
                {
                    fileTransformationService.ProcessFiles();
                }, null, TimeSpan.Zero, TimeSpan.FromMinutes(1));
            }
            catch (Exception e)
            {
                Console.WriteLine($"Unknown Error occured while reading files: {e.Message}");
            }

            DependencyHelper.DisposeServices();

            Console.ReadKey();
        }
    }
}
