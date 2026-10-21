CREATE TABLE IF NOT EXISTS album_reviews (
    id SERIAL PRIMARY KEY,
    album_title VARCHAR(255) NOT NULL,
    artist_name VARCHAR(255) NOT NULL,
    cover_image_path VARCHAR(255),
    dominant_color_hex CHAR(7),
    review_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    review_text TEXT NOT NULL,
    reviewer_name VARCHAR(255) NOT NULL,
    credits TEXT,
    genres VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS tracks (
    id SERIAL PRIMARY KEY,
    album_id INTEGER NOT NULL REFERENCES album_reviews(id) ON DELETE CASCADE,
    track_number INTEGER NOT NULL,
    title VARCHAR(255) NOT NULL,
    duration VARCHAR(20) NOT NULL,
    UNIQUE (album_id, track_number)
);

-- Backward-compatible compatibility view if older schema references `albums`.
CREATE OR REPLACE VIEW albums AS
SELECT * FROM album_reviews;

-- Example usage:
-- SELECT * FROM tracks WHERE album_id = ? ORDER BY track_number ASC;
