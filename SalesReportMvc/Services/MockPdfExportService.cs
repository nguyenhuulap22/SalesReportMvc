using System.Text;

namespace SalesReportMvc.Services
{
    public class MockPdfExportService : IPdfExportService
    {
        public byte[] ExportToPdf<T>(string reportName, List<T> data, string title = "")
        {
            // Tạo nội dung PDF giả (text/html)
            var html = $@"
            <html>
            <head><meta charset='UTF-8'></head>
            <body>
                <h2>{title}</h2>
                <h3>Báo cáo: {reportName}</h3>
                <p>Thời gian xuất: {DateTime.Now:dd/MM/yyyy HH:mm:ss}</p>
                <p>Số lượng bản ghi: {data?.Count ?? 0}</p>
                <hr/>
                <table border='1' cellpadding='5' cellspacing='0'>
                    <tr><th>STT</th><th>Dữ liệu</th></tr>";

            if (data != null)
            {
                for (int i = 0; i < Math.Min(data.Count, 10); i++)
                {
                    html += $"<tr><td>{i + 1}</td><td>{data[i]?.ToString()}</td></tr>";
                }
            }

            html += @"</table><p><i>Đang chờ tích hợp RDLC...</i></p></body></html>";

            // Chuyển HTML thành bytes (tạm thời)
            return Encoding.UTF8.GetBytes(html);
        }
    }
}