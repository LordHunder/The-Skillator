---
name: database-sql-optimizer
description: >
  Database design and SQL optimization skill. Activates for tasks involving schema
  design, query optimization, indexing strategies, EXPLAIN ANALYZE interpretation,
  N+1 query detection, migration planning, connection pooling, and database
  performance tuning. Covers PostgreSQL, MySQL, SQLite, Supabase, and PlanetScale.
  Use when the user needs to design tables, fix slow queries, add indexes, or
  plan database migrations.
risk: safe
source: custom
date_added: "2026-07-04"
---

# Database & SQL Optimizer

## When to Use
- Designing database schemas (normalization, denormalization trade-offs).
- Optimizing slow SQL queries using EXPLAIN ANALYZE.
- Creating indexing strategies (B-tree, GiST, GIN, partial, composite indexes).
- Detecting and fixing N+1 query problems.
- Planning zero-downtime database migrations.
- Setting up connection pooling (PgBouncer, Supabase pooler).
- Choosing between PostgreSQL, MySQL, SQLite, or managed services (Supabase, PlanetScale, Neon).

## 🎯 Core Mission

Build database architectures that perform under load, scale gracefully, and never surprise you at 3am. Every query has a plan, every foreign key has an index, every migration is reversible, and every slow query gets optimized.

## 🚨 Critical Rules

1. **EXPLAIN ANALYZE before guessing.** Never optimize a query without reading its execution plan first. Intuition lies; query plans don't.
2. **Index foreign keys always.** Every foreign key column gets an index. No exceptions. JOIN performance depends on it.
3. **Partial indexes for common patterns.** If a query filters on `WHERE status = 'active'`, create a partial index. Don't index the full table when only 5% of rows matter.
4. **Migrations must be reversible.** Every `UP` has a `DOWN`. No destructive changes without a safety net.
5. **Never `SELECT *` in production.** Select only the columns you need. Excess columns waste I/O, memory, and network bandwidth.
6. **Connection pooling is mandatory.** Direct connections to the database don't scale. Use PgBouncer, Supabase pooler, or equivalent.
7. **Test with production-like data volumes.** A query that's fast on 1K rows may be catastrophic on 1M rows. Always test at scale.

## 📋 Technical Deliverables

### Schema Design Patterns
```sql
-- ✅ Good: Indexed foreign keys, appropriate constraints, partial indexes
CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'active',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE posts (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    title VARCHAR(500) NOT NULL,
    content TEXT,
    status VARCHAR(20) NOT NULL DEFAULT 'draft',
    published_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Index foreign key for JOIN performance
CREATE INDEX idx_posts_user_id ON posts(user_id);

-- Partial index: only published posts (common query pattern)
CREATE INDEX idx_posts_published
ON posts(published_at DESC)
WHERE status = 'published';

-- Composite index for filtering + sorting
CREATE INDEX idx_posts_status_created
ON posts(status, created_at DESC);
```

### Query Optimization Workflow
```sql
-- Step 1: Identify the slow query
-- Step 2: Run EXPLAIN ANALYZE
EXPLAIN (ANALYZE, BUFFERS, FORMAT TEXT)
SELECT p.id, p.title, u.email
FROM posts p
JOIN users u ON u.id = p.user_id
WHERE p.status = 'published'
ORDER BY p.published_at DESC
LIMIT 20;

-- Step 3: Look for these red flags in the plan:
--   ❌ Seq Scan on large tables (missing index)
--   ❌ Nested Loop with high row counts (missing JOIN index)
--   ❌ Sort with high memory usage (missing ORDER BY index)
--   ❌ Hash Join with huge hash table (consider index-based join)

-- Step 4: Add targeted index and re-run EXPLAIN
```

### N+1 Query Detection & Fix
```sql
-- ❌ N+1 Problem: 1 query + N additional queries
SELECT * FROM posts WHERE user_id = 123;
-- Then for EACH post: SELECT * FROM comments WHERE post_id = ?;

-- ✅ Fixed: Single query with JOIN + aggregation
SELECT
    p.id, p.title,
    json_agg(json_build_object(
        'id', c.id, 'content', c.content
    )) AS comments
FROM posts p
LEFT JOIN comments c ON c.post_id = p.id
WHERE p.user_id = 123
GROUP BY p.id;
```

### Index Strategy Decision Table
| Query Pattern | Index Type | Example |
|--------------|------------|---------|
| Exact match (`WHERE col = ?`) | B-tree | `CREATE INDEX idx ON t(col)` |
| Range (`WHERE col > ? AND col < ?`) | B-tree | `CREATE INDEX idx ON t(col)` |
| Pattern match (`WHERE col LIKE '%term%'`) | GIN + pg_trgm | `CREATE INDEX idx ON t USING gin(col gin_trgm_ops)` |
| Full-text search | GIN + tsvector | `CREATE INDEX idx ON t USING gin(to_tsvector('english', col))` |
| JSON field access | GIN | `CREATE INDEX idx ON t USING gin(data jsonb_path_ops)` |
| Geospatial queries | GiST | `CREATE INDEX idx ON t USING gist(location)` |
| Filtered subset | Partial B-tree | `CREATE INDEX idx ON t(col) WHERE status = 'active'` |
| Multi-column filter + sort | Composite | `CREATE INDEX idx ON t(status, created_at DESC)` |

### Migration Safety Checklist
- [ ] Migration has both UP and DOWN.
- [ ] No `DROP COLUMN` without backup verification.
- [ ] New columns are `NULL` or have `DEFAULT` (avoid table lock on large tables).
- [ ] Index creation uses `CONCURRENTLY` (PostgreSQL) to avoid locking.
- [ ] Tested on a copy of production data.
- [ ] Estimated execution time documented.

## ⚙️ Performance Monitoring Queries
```sql
-- Top 10 slowest queries (pg_stat_statements)
SELECT query, calls, mean_exec_time, total_exec_time
FROM pg_stat_statements
ORDER BY mean_exec_time DESC
LIMIT 10;

-- Unused indexes (candidates for removal)
SELECT indexrelname, idx_scan, pg_size_pretty(pg_relation_size(indexrelid))
FROM pg_stat_user_indexes
WHERE idx_scan = 0
ORDER BY pg_relation_size(indexrelid) DESC;

-- Table bloat estimation
SELECT relname, n_dead_tup, n_live_tup,
       round(n_dead_tup::numeric / NULLIF(n_live_tup, 0) * 100, 2) AS dead_pct
FROM pg_stat_user_tables
WHERE n_dead_tup > 1000
ORDER BY n_dead_tup DESC;
```

## Limitations
- Use this skill only when the task involves database design, SQL optimization, or data architecture.
- Recommendations are general best practices; always validate against your specific workload and data distribution.
- Stop and ask for clarification if the database engine, data volume, or access patterns are unclear.
