using System;
using System.IO;
using System.Web;

namespace QuanLyBanHang
{
    public static class ErrorLogger
    {
        private static string LogFilePath => Path.Combine(HttpContext.Current.Server.MapPath("~/App_Data/"), "error_log.txt");

        public static void Log(Exception ex, string context = "")
        {
            try
            {
                string logMessage = $"[{DateTime.Now:yyyy-MM-dd HH:mm:ss}] {context}\nError: {ex.Message}\nStackTrace: {ex.StackTrace}\n{new string('-', 50)}\n";

                if (!Directory.Exists(Path.GetDirectoryName(LogFilePath)))
                    Directory.CreateDirectory(Path.GetDirectoryName(LogFilePath));

                File.AppendAllText(LogFilePath, logMessage);
            }
            catch { }
        }

        public static string GetUserFriendlyMessage(string exceptionMessage)
        {
            if (exceptionMessage.Contains("Timeout"))
                return "⏱️ Yêu cầu timed out. Vui lòng thử lại.";
            if (exceptionMessage.Contains("Connection"))
                return "🔌 Lỗi kết nối database. Vui lòng thử lại sau.";
            if (exceptionMessage.Contains("Duplicate"))
                return "⚠️ Dữ liệu này đã tồn tại.";
            if (exceptionMessage.Contains("Foreign Key"))
                return "⚠️ Không thể xóa dữ liệu này vì nó được sử dụng.";
            return "❌ Có lỗi xảy ra. Vui lòng thử lại sau.";
        }
    }
}
