-- Yêu cầu 1: Tạo chỉ mục cho author (ILIKE) và genre
CREATE EXTENSION IF NOT EXISTS pg_trgm;
CREATE INDEX idx_book_author_gin ON book USING GIN (author gin_trgm_ops);
CREATE INDEX idx_book_genre ON book USING BTREE (genre);

-- Yêu cầu 2: So sánh trước/sau Index
EXPLAIN ANALYZE SELECT * FROM book WHERE author ILIKE '%Rowling%';
EXPLAIN ANALYZE SELECT * FROM book WHERE genre = 'Fantasy';

-- Yêu cầu 3a: B-tree cho genre (đã tạo ở trên)

-- Yêu cầu 3b: GIN cho title/description (full-text)
CREATE INDEX idx_book_title_fts ON book USING GIN (to_tsvector('english', title));
CREATE INDEX idx_book_desc_fts ON book USING GIN (to_tsvector('english', description));

-- Yêu cầu 4: Clustered Index theo genre
CLUSTER book USING idx_book_genre;
EXPLAIN ANALYZE SELECT * FROM book WHERE genre = 'Fantasy';