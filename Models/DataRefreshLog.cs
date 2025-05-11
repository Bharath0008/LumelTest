namespace LumelTest.Models
{
    public class DataRefreshLog
    {
        public int Id { get; set; }
        public DateTime RefreshTime { get; set; }
        public bool IsSuccess { get; set; }
        public string Message { get; set; } = string.Empty;
    }
}
