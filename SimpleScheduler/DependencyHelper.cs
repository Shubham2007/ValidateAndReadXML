using Microsoft.Extensions.DependencyInjection;
using System;

namespace SimpleScheduler
{
    /// <summary>
    /// Class used to resolve dependencies
    /// </summary>
    public static class DependencyHelper
    {
        // Service provider to get the services
        public static ServiceProvider ServiceProvider
            => RegisterAndBuildServices();

        /// <summary>
        /// Register and build services
        /// </summary>
        /// <returns></returns>
        private static ServiceProvider RegisterAndBuildServices()
        {
            var services = new ServiceCollection();
            services.AddSingleton<IFileTransformation, FileTransformation>();
            return services.BuildServiceProvider(true);
        }

        /// <summary>
        /// Call this method to Dispose the services on application exit
        /// </summary>
        public static void DisposeServices()
        {
            if (ServiceProvider == null)
            {
                return;
            }
            if (ServiceProvider is IDisposable)
            {
                ((IDisposable)ServiceProvider).Dispose();
            }
        }
    }
}
