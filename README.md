# LumelTest
This repository contains the backend API implementation for an e-commerce system built in .NET. It also includes SQL scripts for setting up the database schema.

## Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/Bharath0008/LumelTest
   ```

2. Set up the database using the SQL scripts in the `SalesData` directory.


## API Endpoints

- `GET https://localhost:44325/api/analysis/total-revenue?from=2023-12-15&to=2024-03-10~`: Revenue Calculations
- `POST https://localhost:44325/api/analysis/refresh`: Create CSV Data In DB
