using LumelTest.Models;
using LumelTest.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace LumelTest.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AnalysisController : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly CSVLoaderService _loaderService;

        public AnalysisController(ApplicationDbContext context, CSVLoaderService loaderService)
        {
            _context = context;
            _loaderService = loaderService;
        }

        [HttpPost("refresh")]
        public async Task<IActionResult> Refresh()
        {
            var filePath = Path.Combine(Directory.GetCurrentDirectory(), "CSV", "sales_data.csv");
            await _loaderService.RefreshDataAsync(filePath);
            return Ok(new { message = "Data refreshed." });
        }

        [HttpGet("total-revenue")]
        public IActionResult GetRevenue([FromQuery] DateTime from, [FromQuery] DateTime to)
        {
            var revenue = _context.Orders
                .Where(o => o.DateOfSale >= from && o.DateOfSale <= to)
                .Sum(o => o.QuantitySold * o.UnitPrice * (1 - o.Discount));

            return Ok(new { from, to, revenue });
        }
        [HttpGet("customer-lifetime-value")]
        public async Task<IActionResult> GetCustomerLifetimeValue()
        {
            var result = await _context.Orders
            .Where(o => o.Customer.CustomerId != null && o.Product.ProductId != null)
            .Select(o => new
            {
                o.Customer.CustomerId,
                Revenue = o.UnitPrice * o.QuantitySold * (1 - o.Discount)
            })
            .GroupBy(x => x.CustomerId)
            .Select(g => new
            {
                CustomerId = g.Key,
                LifetimeValue = g.Sum(x => x.Revenue)
            })
            .ToListAsync();

            return Ok(result);
        }

    }
}
