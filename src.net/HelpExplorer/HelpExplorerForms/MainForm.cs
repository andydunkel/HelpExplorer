using System;
using System.ComponentModel;
using System.Windows.Forms;

namespace HelpExplorerForms
{
    public partial class MainForm : Form
    {
        private readonly Settings _settings = new Settings();
        private HtmlElement _currentElement;
        
        public MainForm()
        {
            InitializeComponent();
            LoadIniFile();
            if (webBrowser.Document != null) webBrowser.Document.MouseMove += Document_MouseMove;
        }

        private void Document_MouseMove(object sender, HtmlElementEventArgs e)
        {
            if (webBrowser.Document != null)
                _currentElement = webBrowser.Document.GetElementFromPoint(e.ClientMousePosition);
        }

        /// <summary>
        /// Load settings from ini and apply
        /// </summary>
        private void LoadIniFile()
        {
            _settings.LoadIni(Common.GetApplicationPath() + "\\settings.ini");
            Text = _settings.Title;
            
            GoHome();

            toolStrip.Visible = _settings.ShowToolBar;
                
            Width = _settings.WindowWidth;
            Height = _settings.WindowHeight;
            if (_settings.WindowCenter)
            {
                //Center window
                var rect = Screen.FromControl(this).Bounds;
                Left = (rect.Width - Width) / 2;
                Top = (rect.Height - Height) / 2;
            }
            else
            {
                Left = _settings.WindowLeft;
                Top = _settings.WindowTop;
            }
            
            if (_settings.StartMaximized)
            {
                WindowState = FormWindowState.Maximized;
            }
        }

        private void GoHome()
        {
            webBrowser.Navigate(Common.GetApplicationPath() + "\\" + _settings.Homepage);
        }

        private void buttonBack_Click(object sender, EventArgs e)
        {
            webBrowser.GoBack();
        }

        private void buttonForward_Click(object sender, EventArgs e)
        {
            webBrowser.GoForward();
        }

        private void buttonExit_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void webBrowser_Navigating(object sender, WebBrowserNavigatingEventArgs e)
        {
            if (e.Url.ToString().StartsWith("http://") || e.Url.ToString().StartsWith("https://"))
            {
                e.Cancel = true;
                OpenExternalLink(e.Url.ToString());
            }
        }

        private void webBrowser_NewWindow(object sender, CancelEventArgs e)
        {
            e.Cancel = true;
            if (_currentElement != null && _currentElement.TagName == "A")
            {
                var href = _currentElement.GetAttribute("href");
                var target = _currentElement.GetAttribute("target");

                if (href.StartsWith("http://") || href.StartsWith("https://"))
                {
                    OpenExternalLink(href);
                    return;
                }
                
                if (target == "_blank")
                {
                    OpenExternalLink(href);
                }
            }
        }

        private void OpenExternalLink(string href)
        {
            System.Diagnostics.Process.Start(href);    
        }
    }
}