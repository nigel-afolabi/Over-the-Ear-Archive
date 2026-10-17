package com.overtheear.models;

import java.util.Date;
import java.util.List;

public class Album {
    private int id;
    private String albumTitle;
    private String artistName;
    private String coverImagePath;
    private String dominantColorHex;
    private Date reviewDate;
    private String reviewText;
    private String reviewerName;
    private String credits;
    private String genres;
    private List<Track> tracks;

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getAlbumTitle() { return albumTitle; }
    public void setAlbumTitle(String albumTitle) { this.albumTitle = albumTitle; }

    public String getArtistName() { return artistName; }
    public void setArtistName(String artistName) { this.artistName = artistName; }

    public String getCoverImagePath() { return coverImagePath; }
    public void setCoverImagePath(String coverImagePath) { this.coverImagePath = coverImagePath; }

    public String getDominantColorHex() { return dominantColorHex; }
    public void setDominantColorHex(String dominantColorHex) { this.dominantColorHex = dominantColorHex; }

    public Date getReviewDate() { return reviewDate; }
    public void setReviewDate(Date reviewDate) { this.reviewDate = reviewDate; }

    public String getReviewText() { return reviewText; }
    public void setReviewText(String reviewText) { this.reviewText = reviewText; }

    public String getReviewerName() { return reviewerName; }
    public void setReviewerName(String reviewerName) { this.reviewerName = reviewerName; }

    public String getCredits() { return credits; }
    public void setCredits(String credits) { this.credits = credits; }

    public String getGenres() { return genres; }
    public void setGenres(String genres) { this.genres = genres; }

    public List<Track> getTracks() { return tracks; }
    public void setTracks(List<Track> tracks) { this.tracks = tracks; }
}