# SQL Query Performance Optimization

**SQL Server | Query Optimization | Indexing | Execution Plans | Performance Analysis**

## Project Overview

This project evaluates the impact of database indexing on SQL query performance using Microsoft SQL Server. The analysis compared query execution before and after the implementation of a nonclustered index on a reservation table with more than 1 million records.

Using SQL Server execution statistics and query plans, I identified an indexing opportunity, implemented the recommended index, and measured the resulting change in query performance.

## Optimization Approach

The baseline query joined reservation, activity, and guest data to retrieve reservation details for a specific guest and date. I used SQL Server execution statistics and the query execution plan to evaluate its performance.

The execution plan identified an indexing opportunity on the `GuestID` and `RDate` columns. To improve data retrieval, I created a nonclustered index on these columns, including `ResID` and `ActID`.

```sql
CREATE NONCLUSTERED INDEX GuestID_RDate_IDX
ON Reservation2 (GuestID, RDate)
INCLUDE (ResID, ActID);
```

## Performance Results

After implementing the nonclustered index, I reran the same query and compared the execution statistics.

| Performance Measure | Before Index | After Index |
|---|---:|---:|
| Total Execution Time | 167 ms | 89 ms |
| Improvement | — | **46.7% faster** |

### Key Result

The nonclustered index reduced total execution time from **167 ms to 89 ms**, representing a **46.7% improvement**.

## Indexing Considerations

The performance improvement demonstrates the value of indexing frequently filtered columns in large datasets. However, indexes also introduce trade-offs.

**Advantages**
- Faster retrieval by reducing the need to scan the full table
- Improved performance for frequently filtered and joined columns
- Greater performance benefits as datasets grow

**Tradeoffs**
- Additional storage requirements
- Increased index maintenance
- Potentially slower `INSERT`, `UPDATE`, and `DELETE` operations because indexes must also be updated

## Source Code

[View SQL Query Optimization Code](query_optimization.sql)

## Project Context

This project was completed for CIS 407 – Business Database Systems at Arizona State University. The original course database is no longer available, so the repository preserves the SQL queries and measured performance results from the completed analysis.

The original analysis was performed in Microsoft SQL Server Management Studio (SSMS) using execution plans, client statistics, and execution-time measurements to evaluate the impact of indexing.
