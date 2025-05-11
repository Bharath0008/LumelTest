namespace LumelTest.Models
{
    public class Order
    {
        public int Id { get; set; }
        public string OrderId { get; set; } = string.Empty;
        public DateTime DateOfSale { get; set; }
        public string Region { get; set; } = string.Empty;
        public int QuantitySold { get; set; }
        public decimal UnitPrice { get; set; }
        public decimal Discount { get; set; }
        public decimal ShippingCost { get; set; }
        public string PaymentMethod { get; set; } = string.Empty;

        public Product? Product { get; set; }

        public Customer? Customer { get; set; }
    }
}
