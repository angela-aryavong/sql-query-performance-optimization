/*
SQL Query Performance Optimization

Author: Angela Aryavong

Purpose:
Evaluate SQL query performance before and after implementing a
nonclustered index on a large reservation table.

Tools:
Microsoft SQL Server, SQL Server Management Studio (SSMS)

Note:
This case study documents SQL originally executed in SSMS for a database
systems project. The original course database is no longer available, so
the queries and measured performance results are preserved from the
completed analysis.
*/
-- 1. Baseline Query
-- Retrieve reservation details for a specific guest and reservation date.

SET STATISTICS TIME ON;

SELECT
    g.guestid AS GuestID,
    CONCAT(g.fname, ' ', g.lname) AS GuestName,
    r.resid AS ReservationID,
    r.rdate AS ReservationDate,
    a.description AS Activity
FROM reservation2 AS r
INNER JOIN activity AS a
    ON r.actid = a.actid
INNER JOIN guest AS g
    ON g.guestid = r.guestid
WHERE g.guestid = 'G5'
    AND r.rdate = '2022-08-10';

SET STATISTICS TIME OFF;
-- 2. Query Optimization
-- Create a nonclustered index on the columns used to filter the reservation data.

CREATE NONCLUSTERED INDEX GuestID_RDate_IDX
ON Reservation2 (GuestID, RDate)
INCLUDE (ResID, ActID);
-- 3. Performance Result
-- Total execution time before indexing: 167 ms
-- Total execution time after indexing: 89 ms
-- Performance improvement: 46.7%

-- 4. Indexing Considerations
-- Advantages:
-- Indexes can improve data retrieval by reducing the need to scan an entire table.
-- They are especially useful for frequently filtered or joined columns in large datasets.
--
-- Tradeoffs:
-- Indexes require additional storage and maintenance.
-- INSERT, UPDATE, and DELETE operations may become more expensive because the index
-- must also be updated when the underlying data changes.
