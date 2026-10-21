package com.overtheear.dao;

import com.overtheear.models.Album;
import com.overtheear.models.Track;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AlbumDao {
    private static final String URL = getEnv("DB_URL", "jdbc:postgresql://localhost:5432/over_the_ear");
    private static final String USER = getEnv("DB_USER", "postgres");
    private static final String PASSWORD = getEnv("DB_PASSWORD", "Olatunde12#");

    private static final String TRACKS_QUERY =
            "SELECT id, album_id, track_number, title, duration FROM tracks WHERE album_id = ? ORDER BY track_number ASC";
    private static final String LEGACY_TRACKS_QUERY =
            "SELECT track_number, track_title, track_length FROM album_tracks WHERE album_id = ? ORDER BY track_number ASC";

    public int saveAlbumReview(Album album) {
        String query = "INSERT INTO album_reviews (album_title, artist_name, cover_image_path, dominant_color_hex, review_date, review_text, reviewer_name, credits, genres) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, album.getAlbumTitle());
            stmt.setString(2, album.getArtistName());
            stmt.setString(3, album.getCoverImagePath());
            stmt.setString(4, album.getDominantColorHex());
            stmt.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
            stmt.setString(6, album.getReviewText());
            stmt.setString(7, album.getReviewerName());
            stmt.setString(8, album.getCredits());
            stmt.setString(9, album.getGenres());

            int affected = stmt.executeUpdate();
            if (affected == 0) {
                return -1;
            }

            try (ResultSet keys = stmt.getGeneratedKeys()) {
                if (keys.next()) {
                    return keys.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return -1;
    }

    public void saveTrackList(int albumId, List<Track> tracks) {
        if (tracks == null || tracks.isEmpty()) {
            return;
        }

        String query = "INSERT INTO tracks (album_id, track_number, title, duration) VALUES (?, ?, ?, ?)";

        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(query)) {

            for (Track track : tracks) {
                stmt.setInt(1, albumId);
                stmt.setInt(2, track.getTrackNumber());
                stmt.setString(3, track.getTrackTitle());
                stmt.setString(4, track.getTrackLength());
                stmt.addBatch();
            }

            stmt.executeBatch();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Album> getLatestAlbums() {
        List<Album> albums = new ArrayList<>();
        String query = "SELECT id, album_title, artist_name, cover_image_path, dominant_color_hex, review_date FROM album_reviews ORDER BY review_date DESC";

        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                Album album = new Album();
                album.setId(rs.getInt("id"));
                album.setAlbumTitle(rs.getString("album_title"));
                album.setArtistName(rs.getString("artist_name"));
                album.setCoverImagePath(rs.getString("cover_image_path"));
                album.setDominantColorHex(rs.getString("dominant_color_hex"));
                album.setReviewDate(rs.getTimestamp("review_date"));
                albums.add(album);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return albums;
    }

    public Album getAlbumById(int albumId) {
        Album album = null;
        String albumQuery = "SELECT id, album_title, artist_name, cover_image_path, dominant_color_hex, review_date, review_text, reviewer_name, credits, genres FROM album_reviews WHERE id = ?";

        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement albumStmt = conn.prepareStatement(albumQuery)) {

            albumStmt.setInt(1, albumId);
            try (ResultSet rs = albumStmt.executeQuery()) {
                if (rs.next()) {
                    album = new Album();
                    album.setId(rs.getInt("id"));
                    album.setAlbumTitle(rs.getString("album_title"));
                    album.setArtistName(rs.getString("artist_name"));
                    album.setCoverImagePath(rs.getString("cover_image_path"));
                    album.setDominantColorHex(rs.getString("dominant_color_hex"));
                    album.setReviewDate(rs.getTimestamp("review_date"));
                    album.setReviewText(rs.getString("review_text"));
                    album.setReviewerName(rs.getString("reviewer_name"));
                    album.setCredits(rs.getString("credits"));
                    album.setGenres(rs.getString("genres"));
                }
            }

            if (album != null) {
                album.setTracks(getTracksByAlbumId(conn, albumId));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return album;
    }

    private static String getEnv(String key, String defaultValue) {
        String value = System.getenv(key);
        return value == null || value.trim().isEmpty() ? defaultValue : value.trim();
    }

    private List<Track> getTracksByAlbumId(Connection conn, int albumId) throws SQLException {
        List<Track> tracks = new ArrayList<>();

        try (PreparedStatement stmt = conn.prepareStatement(TRACKS_QUERY)) {
            stmt.setInt(1, albumId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Track track = new Track();
                    track.setId(rs.getInt("id"));
                    track.setAlbumId(rs.getInt("album_id"));
                    track.setTrackNumber(rs.getInt("track_number"));
                    track.setTrackTitle(rs.getString("title"));
                    track.setTrackLength(rs.getString("duration"));
                    tracks.add(track);
                }
            }
        } catch (SQLException e) {
            try (PreparedStatement legacyStmt = conn.prepareStatement(LEGACY_TRACKS_QUERY)) {
                legacyStmt.setInt(1, albumId);
                try (ResultSet legacyRs = legacyStmt.executeQuery()) {
                    while (legacyRs.next()) {
                        Track track = new Track();
                        track.setTrackNumber(legacyRs.getInt("track_number"));
                        track.setTrackTitle(legacyRs.getString("track_title"));
                        track.setTrackLength(legacyRs.getString("track_length"));
                        tracks.add(track);
                    }
                }
            }
        }

        return tracks;
    }
}