namespace HelpExplorer
{
    public class Common
    {
        /**
         * Returns the path of the application
         */
        public static string GetApplicationPath()
        {
            return System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location);
        }
    }
}