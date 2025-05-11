using CsvHelper;
using CsvHelper.Configuration;
using CsvHelper.Configuration.Attributes;
using LumelTest.Models;
using Microsoft.EntityFrameworkCore;
using System.Formats.Asn1;
using System.Globalization;

namespace LumelTest.Services
{
    public class CSVLoaderService
    {
        private readonly ApplicationDbContext _context;
        private readonly ILogger<CSVLoaderService> _logger;

        public CSVLoaderService(ApplicationDbContext context, ILogger<CSVLoaderService> logger)
        {
            _context = context;
            _logger = logger;
        }

        public async Task RefreshDataAsync(string filePath)
        {
            using var transaction = await _context.Database.BeginTransactionAsync();

            try
            {
                using var reader = new StreamReader(filePath);
                using var csv = new CsvReader(reader, new CsvConfiguration(CultureInfo.InvariantCulture)
                {
                    HeaderValidated = null,
                    MissingFieldFound = null
                });

                var records = csv.GetRecords<CsvRecord>().ToList();

                foreach (var record in records)
                {
                    var orderId = record.OrderID;
                    if (_context.Orders.Any(o => o.OrderId == orderId)) continue;

                    string productId = record.ProductID;
                    var product = _context.Products.Local.Where(p => p.ProductId == productId).FirstOrDefault();
                    if (product == null)
                    {
                         product = new Product
                        {
                            ProductId = productId,
                            ProductName = record.ProductName,
                            Category = record.Category
                        };
                        _context.Products.Add(product);
                    }

                    string customerId = record.CustomerID;
                    var customer = _context.Customers.Local.Where(c =>c.CustomerId == customerId).FirstOrDefault();
                    if (customer == null)
                    {
                        customer = new Customer
                        {
                            CustomerId = customerId,
                            Name = record.CustomerName,
                            Email = record.CustomerEmail,
                            Address = record.CustomerAddress
                        };
                        _context.Customers.Add(customer);
                    }

                    var order = new Order
                    {
                        OrderId = orderId,
                        Product = product,
                        Customer = customer,
                        DateOfSale = DateTime.TryParse(record.DateOfSale, out var saleDate) ? saleDate : DateTime.MinValue,
                        QuantitySold = int.TryParse(record.QuantitySold, out var quantity) ? quantity : 0,
                        UnitPrice = decimal.TryParse(record.UnitPrice, out var unitPrice) ? unitPrice : 0m,
                        Discount = decimal.TryParse(record.Discount, out var discount) ? discount : 0m,
                        ShippingCost = decimal.TryParse(record.ShippingCost, out var shippingCost) ? shippingCost : 0m,
                        PaymentMethod = record.PaymentMethod,
                        Region = record.Region
                    };
                    _context.Orders.Add(order);
                }



                await _context.SaveChangesAsync();
                await transaction.CommitAsync();

                _context.DataRefreshLogs.Add(new DataRefreshLog { RefreshTime = DateTime.UtcNow, IsSuccess = true, Message = "Data loaded successfully" });
                await _context.SaveChangesAsync();
            }
            catch (Exception ex)
            {
                await transaction.RollbackAsync();
                _logger.LogError(ex, "CSV Load Failed");
                _context.DataRefreshLogs.Add(new DataRefreshLog { RefreshTime = DateTime.UtcNow, IsSuccess = false, Message = ex.Message });
                await _context.SaveChangesAsync();
                throw;
            }
        }
    }

}
public class CsvRecord
{
    [Name("Order ID")]
    public string OrderID { get; set; }

    [Name("Product ID")]
    public string ProductID { get; set; }

    [Name("Customer ID")]
    public string CustomerID { get; set; }

    [Name("Product Name")]
    public string ProductName { get; set; }

    [Name("Category")]
    public string Category { get; set; }

    [Name("Region")]
    public string Region { get; set; }

    [Name("Date of Sale")]
    public string DateOfSale { get; set; }

    [Name("Quantity Sold")]
    public string QuantitySold { get; set; }

    [Name("Unit Price")]
    public string UnitPrice { get; set; }

    [Name("Discount")]
    public string Discount { get; set; }

    [Name("Shipping Cost")]
    public string ShippingCost { get; set; }

    [Name("Payment Method")]
    public string PaymentMethod { get; set; }

    [Name("Customer Name")]
    public string CustomerName { get; set; }

    [Name("Customer Email")]
    public string CustomerEmail { get; set; }

    [Name("Customer Address")]
    public string CustomerAddress { get; set; }
}
