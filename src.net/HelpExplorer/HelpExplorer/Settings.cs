namespace HelpExplorer
{
    public class Settings
    {
        public bool ShowToolBar { get; set; }
        public string Title { get; set; }
        public string Homepage { get; set; }
        public int WindowWidth { get; set; }
        public int WindowHeight { get; set; }
        public int WindowLeft { get; set; }
        public int WindowTop { get; set; }
        public bool WindowCenter { get; set; }
        public bool StartMaximized { get; set; }
        
        public Settings()
        {
            ShowToolBar = true;
            Title = "Help Explorer";
            Homepage = "index.html";
            WindowWidth = 800;
            WindowHeight = 600;
            WindowLeft = 0;
            WindowTop = 0;
            WindowCenter = true;
            StartMaximized = false;
        }

        /**
         * Load settings from an INI file
         */
        public void LoadIni(string filename)
        {
            IniFile ini = new IniFile(filename);
            var showToolBar = ini.ReadString("ShowToolBar");
            if (showToolBar == "1")
            {
                ShowToolBar = true;
            }
            else if (showToolBar == "0")
            {
                ShowToolBar = false;
            }
            
            Title = ini.ReadString("Title");
            Homepage = ini.ReadString("Homepage");
            WindowWidth = int.Parse(ini.ReadString("WindowWidth"));
            WindowHeight = int.Parse(ini.ReadString("WindowHeight"));
            WindowLeft = int.Parse(ini.ReadString("WindowLeft"));
            WindowTop = int.Parse(ini.ReadString("WindowTop"));
            var windowCenter = ini.ReadString("WindowCenter");
            
            if (windowCenter == "1")
            {
                WindowCenter = true;
            }
            else if (windowCenter == "0")
            {
                WindowCenter = false;
            }
            
            var startMaximized = ini.ReadString("StartMaximized");
            
            if (startMaximized == "1")
            {
                StartMaximized = true;
            }
            else if (startMaximized == "0")
            {
                StartMaximized = false;
            }
        }
    }
}