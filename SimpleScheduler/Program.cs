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
                // Call ProcessFiles method in every 1 Minute
                var timer = new Timer(e =>
                {
                    new FileTransformation().ProcessFiles();
                }, null, TimeSpan.Zero, TimeSpan.FromMinutes(1));

                //ProcessFiles();
            }
            catch (Exception e)
            {
                Console.WriteLine($"Unknown Error occured while reading files: {e.Message}");
            }

            Console.ReadKey();
        }
    }
}
