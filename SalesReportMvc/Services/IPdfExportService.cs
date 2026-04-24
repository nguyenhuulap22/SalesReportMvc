namespace SalesReportMvc.Services
{
    public interface IPdfExportService
    {
        byte[] ExportToPdf<T>(string reportName, List<T> data, string title = "");
    }
}