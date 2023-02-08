using System.Windows;
using System.Windows.Controls;

namespace HelpExplorer
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow
    {
        private readonly Settings _settings = new Settings();
        
        public MainWindow()
        {
            InitializeComponent();
            LoadIniFile();
            
            var obj = WebBrowser.Document as dynamic;
                    }

        /// <summary>
        /// Load settings from ini and apply
        /// </summary>
        private void LoadIniFile()
        {
            _settings.LoadIni(Common.GetApplicationPath() + "\\settings.ini");
            Title = _settings.Title;
            WebBrowser.Navigate(Common.GetApplicationPath() + "\\" + _settings.Homepage);
            ToolBar.Visibility = _settings.ShowToolBar ? Visibility.Visible : Visibility.Collapsed;
            Width = _settings.WindowWidth;
            Height = _settings.WindowHeight;
            if (_settings.WindowCenter)
            {
                //Center window
                Left = (SystemParameters.PrimaryScreenWidth - Width) / 2;
                Top = (SystemParameters.PrimaryScreenHeight - Height) / 2;
            }
            else
            {
                Left = _settings.WindowLeft;
                Top = _settings.WindowTop;
            }
            
            if (_settings.StartMaximized)
            {
                WindowState = WindowState.Maximized;
            }
        }

        private void ToolBar_Loaded(object sender, RoutedEventArgs e)
        {
            var toolBar = sender as ToolBar;
            if (toolBar != null && toolBar.Template.FindName("OverflowGrid", toolBar) is FrameworkElement overflowGrid)
            {
                overflowGrid.Visibility = Visibility.Collapsed;
            }

            if (toolBar != null && toolBar.Template.FindName("MainPanelBorder", toolBar) is FrameworkElement mainPanelBorder)
            {
                mainPanelBorder.Margin = new Thickness();
            }
        }

        private void ButtonBack_OnClick(object sender, RoutedEventArgs e)
        {
            WebBrowser.GoBack();
        }

        private void ButtonForward_OnClick(object sender, RoutedEventArgs e)
        {
            WebBrowser.GoForward();
        }

        private void Exit_OnClick(object sender, RoutedEventArgs e)
        {
            Close();
        }
    }
}