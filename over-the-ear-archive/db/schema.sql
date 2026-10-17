CREATE TABLE albums (
    id SERIAL PRIMARY KEY,
    album_title VARCHAR(255) NOT NULL,
    artist_name VARCHAR(255) NOT NULL,
    cover_image_path VARCHAR(255),
    dominant_color_hex CHAR(7),
    review_date TIMESTAMP,
    review_text TEXT,
    reviewer_name VARCHAR(255),
    credits TEXT,
    genres VARCHAR(255)
);

CREATE TABLE tracks (
    id SERIAL PRIMARY KEY,
    album_id INTEGER NOT NULL REFERENCES albums(id) ON DELETE CASCADE,
    track_number INTEGER NOT NULL,
    title VARCHAR(255) NOT NULL,
    duration VARCHAR(20) NOT NULL,
    UNIQUE (album_id, track_number)
);

-- Example usage:
-- SELECT * FROM tracks WHERE album_id = ? ORDER BY track_number ASC;
