# Rails Engine

## Intro

This project is an API sales data analysis tool. The return format for all endpoints is JSON.

The markdown for this project can be found [here](http://backend.turing.io/module3/projects/rails_engine)

### Collaborators

Chantal Justamond [github](https://github.com/chantal66)

Desislava Todorova [github](https://github.com/DesTodo)


## How to Get Started

Clone the repo in your terminal:
```
git clone https://github.com/DesTodo/rails_engine.git
```

Navigate into the project:
```
cd rails_engine
```

Bundle:
```
bundle install
```

Create, migrate, and seed your database:

```
rake db:{create,migrate}
rake import_csv:all
```

Run `rspec` in your terminal to ensure all tests are passing.

## Endpoints
You can visit these endpoints to see a JSON response.

In your terminal, start a local server: `rails s`

Open your browser to `localhost:3000`

### Record Endpoints

#### Merchants
- `/api/v1/merchants` returns all merchants
- `/api/v1/merchants/:id` returns a specific merchant based on id
- `/api/v1/merchants/random` returns a random merchant
- `/api/v1/merchants/find?params` returns the first merchant it finds based on `find` params.
- `/api/v1/merchants/find_all?params` returns all the merchants that match the find_all param. For merchants, you can search by:

| Parameter | Description |
| --- | --- |
| id | search based on the primary key |
| name | search based on the name attribute |
| created_at | search based on created_at timestamp |
| updated_at | search based on updated_at timestamp |


#### Customers
- `/api/v1/customers`
- `/api/v1/customers/:id`
- `/api/v1/customers/random`
- `/api/v1/customers/find?params` returns the first customer it finds based on `find` params.
- `/api/v1/customers/find_all?params` returns all the customers that match the find_all param. For customers, you can search by:

| Parameter | Description |
| --- | --- |
| id | search based on the primary key |
| first_name | search based on the first_name attribute |
| last_name | search based on the last_name attribute |
| created_at | search based on created_at timestamp |
| updated_at | search based on updated_at timestamp |

#### Items
- `/api/v1/items`
- `/api/v1/items/:id`
- `/api/v1/items/random`
- `/api/v1/items/find?params` returns the first item it finds based on `find` params.
- `/api/v1/items/find_all?params` returns all the item that match the find_all param. For items, you can search by:

| Parameter | Description |
| --- | --- |
| id | search based on the primary key |
| name | search based on the name attribute |
| description | search based on the description attribute |
| unit_price | search based on the unit_price attribute |
| merchant_id | search based on the merchant foreign key |
| created_at | search based on created_at timestamp |
| updated_at | search based on updated_at timestamp |

#### Invoices
- `/api/v1/invoices`
- `/api/v1/invoices/:id`
- `/api/v1/invoices/random`
- `/api/v1/invoices/find?params` returns the first invoices it finds based on `find` params.
- `/api/v1/invoices/find_all?params` returns all the invoices that match the find_all param. For invoices, you can search by:

| Parameter | Description |
| --- | --- |
| id | search based on the primary key |
| customer_id | search based on the customer foreign key |
| merchant_id | search based on the merchant foreign key |
| status | search based on the status attribute |
| created_at | search based on created_at timestamp |
| updated_at | search based on updated_at timestamp |

#### Invoice_Items
- `/api/v1/invoice_items`
- `/api/v1/invoice_items/:id`
- `/api/v1/invoice_items/random`
- `/api/v1/invoice_items/find?params` returns the first `invoice_item` it finds based on `find` params.
- `/api/v1/invoice_items/find_all?params` returns all the `invoice_items` that match the find_all param. For `invoice_items`, you can search by:

| Parameter | Description |
| --- | --- |
| id | search based on the primary key |
| item_id | search based on the item foreign key |
| invoice_id | search based on the invoice foreign key |
| quantity | search based on the quantity attribute |
| unit_price | search based on the unit_price attribute |
| created_at | search based on created_at timestamp |
| updated_at | search based on updated_at timestamp |

#### Transactions
- `/api/v1/transactions`
- `/api/v1/transactions/:id`
- `/api/v1/transactions/random`
- `/api/v1/transactions/find?params` returns the first transaction it finds based on `find` params.
- `/api/v1/transactions/find_all?params` returns all the transactions that match the find_all param. For transactions, you can search by:

| Parameter | Description |
| --- | --- |
| id | search based on the primary key |
| invoice_id | search based on the invoice foreign key |
| credit_ card_number | search based on the credit card number attribute |
| result | search based on the result attribute |
| created_at | search based on created_at timestamp |
| updated_at | search based on updated_at timestamp |

### Relationship Endpoints

#### Merchants

- `/api/v1/merchants/:id/items` returns a collection of items associated with that merchant
- `/api/v1/merchants/:id/invoices` returns a collection of invoices associated with that merchant from their known orders

#### Invoices

- `/api/v1/invoices/:id/transactions` returns a collection of associated transactions
- `/api/v1/invoices/:id/invoice_items` returns a collection of associated invoice items
- `/api/v1/invoices/:id/items` returns a collection of associated items
- `/api/v1/invoices/:id/customer` returns the associated customer
- `/api/v1/invoices/:id/merchant` returns the associated merchant

#### Invoice Items

- `/api/v1/invoice_items/:id/invoice` returns the associated invoice
- `/api/v1/invoice_items/:id/item` returns the associated item

#### Items

- `/api/v1/items/:id/invoice_items` returns a collection of associated invoice items
- `/api/v1/items/:id/merchant` returns the associated merchant
#### Transactions

- `/api/v1/transactions/:id/invoice` returns the associated invoice

#### Customers

- `/api/v1/customers/:id/invoices` returns a collection of associated invoices
- `/api/v1/customers/:id/transactions` returns a collection of associated transactions

### Business Intelligence Endpoints

#### Merchants

- ` /api/v1/merchants/:id/revenue` returns the total revenue for that merchant across all transactions
- ` /api/v1/merchants/:id/revenue?date=x` returns the total revenue for that merchant for a specific invoice date x
- `/api/v1/merchants/most_items?quantity=x` returns the top x merchants ranked by total number of items sold
- ` /api/v1/merchants/:id/favorite_customer` returns the customer who has conducted the most total number of successful transactions.
- `/api/v1/merchants/revenue?date=x` returns the total revenue for date x across all merchants
- `/api/v1/merchants/most_revenue?quantity=x` returns the top x merchants ranked by total revenue

#### Items

- `/api/v1/items/most_revenue?quantity=x` returns the top x items ranked by total revenue generated
- `/api/v1/items/most_items?quantity=x` returns the top x item instances ranked by total number sold
- `/api/v1/items/:id/best_day` returns the date with the most sales for the given item using the invoice date. If there are multiple days with equal number of sales, return the most recent day.

#### Customers

- `/api/v1/customers/:id/favorite_merchant` returns a merchant where the customer has conducted the most successful transactions

### Further Testing

* Clone down [rales engine spec harness](https://github.com/turingschool/rales_engine_spec_harness)
* Navigate into the rales_engine_spec_harness directory `cd rales_engine_spec_harness`
* If you haven't, run the setup instructions.
* Run `rails server`
* In a separate terminal window, navigate into rales_engine_spec_harness directory
* Run `rake`
