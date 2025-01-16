-- any ddl is auto-commit, i.e permanent changes, hence data work (DML) is earlier done and then object (views, triggers, etc) work is done
-- no effect of rollback on ddl

-- commit and rollback works only once 

-- No, **transactions are not the same as queries**, although they include queries as part of their operations. Let's break it down:

-- ---

-- ### **What is a Query?**
-- A **query** is a single SQL statement that retrieves, manipulates, or interacts with the database.
--  Examples include:
--   - `SELECT` to retrieve data.
--   - `UPDATE` to modify data.
--   - `DELETE` to remove data.

-- **Example of a Query:**
-- ```sql
-- UPDATE accounts SET balance = balance - 500 WHERE account_id = 1;
-- ```

-- ---

-- ### **What is a Transaction?**
-- - A **transaction** is a logical grouping of one or more queries that are executed together as a single unit of work.
-- - It ensures that all queries within the transaction succeed together or fail together.
-- - Transactions are **not individual queries**; they are a process that can include multiple queries with additional logic like `COMMIT` or `ROLLBACK`.

-- **Example of a Transaction:**
-- ```sql
-- START TRANSACTION;

-- -- Query 1: Deduct ₹500 from one account
-- UPDATE accounts SET balance = balance - 500 WHERE account_id = 1;

-- -- Query 2: Add ₹500 to another account
-- UPDATE accounts SET balance = balance + 500 WHERE account_id = 2;

-- -- Commit the changes if both queries succeed
-- COMMIT;
-- ```

-- ---

-- ### Key Differences

-- | Aspect             | Query                                         | Transaction                                             |
-- |---------------------|-----------------------------------------------|--------------------------------------------------------|
-- | **Definition**      | A single SQL command.                        | A group of SQL commands treated as a single unit.       |
-- | **Purpose**         | Executes a single operation on the database. | Ensures multiple operations succeed or fail together.  |
-- | **Control**         | Executes immediately (in most cases).        | Controlled by `START TRANSACTION`, `COMMIT`, and `ROLLBACK`. |
-- | **Behavior**        | Does not guarantee consistency.              | Ensures data consistency using ACID properties.        |

-- ---

-- ### Why Transactions Are More Than Queries
-- Transactions add additional layers of functionality to ensure:
-- 1. **Atomicity:** All operations in the transaction must succeed or be rolled back.
-- 2. **Consistency:** The database remains valid after the transaction.
-- 3. **Isolation:** Changes are not visible until committed.
-- 4. **Durability:** Once committed, changes are permanent.

-- **Without Transactions:**
-- If the second query fails in the following example:
-- ```sql
-- UPDATE accounts SET balance = balance - 500 WHERE account_id = 1;
-- UPDATE accounts SET balance = balance + 500 WHERE account_id = 2;
-- ```
-- The database could end up with an inconsistent state, where ₹500 is deducted but not added.

-- **With Transactions:**
-- ```sql
-- START TRANSACTION;
-- UPDATE accounts SET balance = balance - 500 WHERE account_id = 1;
-- UPDATE accounts SET balance = balance + 500 WHERE account_id = 2;
-- COMMIT; -- Only commit if both queries succeed
-- ```

-- If any query fails, the transaction can be rolled back to maintain consistency.

-- ---

-- ### Conclusion
-- A **query** is a single command, while a **transaction** is a collection of commands that work together to perform a cohesive operation, ensuring data integrity and consistency.

-- In MySQL, **transactions** are used to ensure data integrity by grouping multiple SQL statements into a single logical unit of work. Key commands in transaction management include `COMMIT`, `ROLLBACK`, and `SAVEPOINT`.

-- ---

-- ### 1. **COMMIT**
-- - **Purpose:** Saves all changes made during the current transaction to the database permanently.
-- - **When Used:** At the end of a successful transaction.
-- - **Behavior:**
--   - Makes changes permanent.
--   - Releases any locks held by the transaction.

-- **Example:**
-- ```sql
-- START TRANSACTION;
-- UPDATE accounts SET balance = balance - 500 WHERE account_id = 1;
-- UPDATE accounts SET balance = balance + 500 WHERE account_id = 2;
-- COMMIT; -- Saves the changes
-- ```

-- ---

-- ### 2. **ROLLBACK**
-- - **Purpose:** Undoes all changes made during the current transaction, restoring the database to its previous state.
-- - **When Used:** To cancel a transaction due to an error or failure.
-- - **Behavior:**
--   - Reverts changes since the last `COMMIT` or `ROLLBACK`.
--   - Releases any locks held by the transaction.

-- **Example:**
-- ```sql
-- START TRANSACTION;
-- UPDATE accounts SET balance = balance - 500 WHERE account_id = 1;
-- UPDATE accounts SET balance = balance + 500 WHERE account_id = 2;
-- ROLLBACK; -- Cancels the changes
-- ```

-- ---

-- ### 3. **SAVEPOINT**
-- - **Purpose:** Creates a point within a transaction to which you can later roll back.
-- - **When Used:** For partial rollbacks within a larger transaction.
-- - **Behavior:**
--   - Allows finer control over transactions.
--   - Does not release locks or affect changes before the `SAVEPOINT`.

-- **Example:**
-- ```sql
-- START TRANSACTION;
-- UPDATE accounts SET balance = balance - 500 WHERE account_id = 1;
-- SAVEPOINT before_transfer;
-- UPDATE accounts SET balance = balance + 500 WHERE account_id = 2;
-- ROLLBACK TO before_transfer; -- Reverts only the second update
-- COMMIT; -- Saves changes before the SAVEPOINT
-- ```

-- ---

-- ### 4. **START TRANSACTION**
-- - **Purpose:** Begins a new transaction.
-- - **Behavior:**
--   - Changes made after this point are not visible to other sessions until a `COMMIT` is issued.
--   - A `ROLLBACK` will undo all changes made since the `START TRANSACTION`.

-- **Example:**
-- ```sql
-- START TRANSACTION;
-- -- Perform SQL operations
-- COMMIT; -- Finalize the transaction
-- ```

-- ---

-- ### 5. **SET AUTOCOMMIT**
-- - **Purpose:** Controls whether each SQL statement is automatically committed.
-- - **Behavior:**
--   - By default, `AUTOCOMMIT` is enabled (each statement is committed immediately).
--   - Disabling `AUTOCOMMIT` allows explicit control over `COMMIT` and `ROLLBACK`.

-- **Example:**
-- ```sql
-- SET AUTOCOMMIT = 0; -- Disable autocommit
-- START TRANSACTION;
-- UPDATE accounts SET balance = balance - 500 WHERE account_id = 1;
-- COMMIT; -- Manually commit the changes
-- ```

-- ---

-- ### Summary Table

-- | Command         | Description                                              | Behavior                                                                 |
-- |------------------|----------------------------------------------------------|-------------------------------------------------------------------------|
-- | **START TRANSACTION** | Begins a new transaction                                  | Changes not visible until `COMMIT` or reverted with `ROLLBACK`.         |
-- | **COMMIT**      | Saves all changes permanently                             | Finalizes the transaction, releasing locks.                             |
-- | **ROLLBACK**    | Undoes all changes made since the last `COMMIT` or `START TRANSACTION` | Cancels the transaction, reverting changes.                             |
-- | **SAVEPOINT**   | Creates a named point within a transaction for partial rollbacks | Allows `ROLLBACK` to a specific point without canceling the entire transaction. |
-- | **SET AUTOCOMMIT** | Enables or disables automatic committing of each statement | Controls whether changes are committed automatically.                   |

-- ---

-- ### Use Case: Bank Transfer
-- ```sql
-- START TRANSACTION;

-- -- Deduct from sender's account
-- UPDATE accounts SET balance = balance - 500 WHERE account_id = 1;

-- -- Add to receiver's account
-- UPDATE accounts SET balance = balance + 500 WHERE account_id = 2;

-- -- If everything is fine
-- COMMIT;

-- -- If an error occurs
-- ROLLBACK;
-- ``` 

-- Transactions ensure atomicity (all or nothing), consistency, isolation, and durability (ACID properties) in your database operations.

-- In the provided example, the `COMMIT` command **saves all the changes made up to the current point** in the transaction. Let's break this down step by step to clarify what happens:

---

### Step-by-Step Explanation of the Transaction

#### 1. **Start the Transaction**
-- ```sql
-- START TRANSACTION;
-- ```
-- - Begins a new transaction.
-- - Changes made from this point onward will not be permanent until explicitly committed.

-- #### 2. **First Update Query**
-- ```sql
-- UPDATE accounts SET balance = balance - 500 WHERE account_id = 1;
-- ```
-- - Deducts ₹500 from `account_id = 1`.
-- - This change is temporary and not yet permanent because the transaction is still active.

-- #### 3. **Create a Savepoint**
-- ```sql
-- SAVEPOINT before_transfer;
-- ```
-- - Creates a **checkpoint** within the transaction called `before_transfer`.
-- - You can roll back to this point if needed, without affecting earlier changes.

-- #### 4. **Second Update Query**
-- ```sql
-- UPDATE accounts SET balance = balance + 500 WHERE account_id = 2;
-- ```
-- - Adds ₹500 to `account_id = 2`.
-- - This change is also temporary and not yet permanent.

-- #### 5. **Rollback to the Savepoint**
-- ```sql
-- ROLLBACK TO before_transfer;
-- ```
-- - Reverts the changes made after the `SAVEPOINT before_transfer`, i.e., the addition of ₹500 to `account_id = 2`.
-- - The deduction of ₹500 from `account_id = 1` remains unaffected because it occurred **before** the savepoint.

-- #### 6. **Commit the Transaction**
-- ```sql
-- COMMIT;
-- ```
-- - Saves all the changes made **up to the point of the rollback**.
-- - In this case, only the deduction of ₹500 from `account_id = 1` is committed because the addition of ₹500 to `account_id = 2` was rolled back.

-- ---

-- ### **What Did `COMMIT` Do?**
-- 1. Made the deduction of ₹500 from `account_id = 1` permanent in the database.
-- 2. Did **not** save the addition of ₹500 to `account_id = 2`, as it was rolled back before committing.

-- ---

-- ### Final State of the Accounts
-- Assuming the initial balances are:
-- - `account_id = 1`: ₹10,000
-- - `account_id = 2`: ₹8,000

-- After this transaction:
-- - `account_id = 1`: ₹9,500 (₹500 deducted, and the change is committed).
-- - `account_id = 2`: ₹8,000 (no change, as the addition was rolled back).

-- ---

-- ### Key Points
-- 1. `COMMIT` makes all changes **since the start of the transaction** (or the most recent rollback) permanent in the database.
-- 2. Changes rolled back using `ROLLBACK TO` are excluded from the commit.
-- 3. Using `SAVEPOINT` allows you to selectively undo parts of a transaction while retaining earlier changes.