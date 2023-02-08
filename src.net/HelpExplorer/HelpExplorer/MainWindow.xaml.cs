using System.Windows;
using System.Windows.Controls;

namespace HelpExplorer
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow
    {
        public MainWindow()
        {
            InitializeComponent();
            LoadIniFile();
        }

        private void LoadIniFile()
        {
            
        }

        private void ToolBar_Loaded(object sender, RoutedEventArgs e)
        {
            ToolBar toolBar = sender as ToolBar;
            if (toolBar.Template.FindName("OverflowGrid", toolBar) is FrameworkElement overflowGrid)
            {
                overflowGrid.Visibility = Visibility.Collapsed;
            }

            if (toolBar.Template.FindName("MainPanelBorder", toolBar) is FrameworkElement mainPanelBorder)
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