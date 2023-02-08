using System.IO;

namespace HelpExplorer
{
    /// <summary>
    /// A very simple ini file parser for the settings.ini file
    /// </summary>
    public class IniFile
    {
        /// <summary>
        /// The content of the ini file
        /// </summary>
        private string[] _content;

        public IniFile(string filename)
        {
            _content = File.ReadAllLines(filename);
        }

        /// <summary>
        /// Reads the given key from the file
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        public string ReadString(string key)
        {
            var result = "";

            foreach (var s in _content)
            {
                if (!s.StartsWith(key + "=")) continue;
                result = s.Substring(key.Length + 1);
                break;
            }

            return result;
        }
    }
}