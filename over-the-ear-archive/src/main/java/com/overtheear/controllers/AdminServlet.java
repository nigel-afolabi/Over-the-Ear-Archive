package com.overtheear.controllers;

import com.overtheear.dao.AlbumDao;
import com.overtheear.models.Album;
import com.overtheear.models.Track;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class AdminServlet extends HttpServlet {
    private static final String ADMIN_SESSION_KEY = "adminAuthenticated";
    private static final String DEFAULT_ADMIN_PASSWORD = "Olatunde12#";
    private AlbumDao albumDao;

    @Override
    public void init() {
        albumDao = new AlbumDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);

        if ("logout".equals(action)) {
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect(request.getContextPath() + "/admin");
            return;
        }

        if (isAuthenticated(session)) {
            request.setAttribute("loggedIn", true);
            request.setAttribute("message", request.getParameter("message"));
            request.getRequestDispatcher("/WEB-INF/views/admin.jsp").forward(request, response);
            return;
        }

        request.setAttribute("loggedIn", false);
        request.getRequestDispatcher("/WEB-INF/views/admin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        if ("login".equals(action)) {
            String password = request.getParameter("password");
            if (matchesPassword(password)) {
                session.setAttribute(ADMIN_SESSION_KEY, Boolean.TRUE);
                response.sendRedirect(request.getContextPath() + "/admin");
            } else {
                request.setAttribute("loggedIn", false);
                request.setAttribute("error", "Invalid admin password.");
                request.getRequestDispatcher("/WEB-INF/views/admin.jsp").forward(request, response);
            }
            return;
        }

        if (!isAuthenticated(session)) {
            response.sendRedirect(request.getContextPath() + "/admin");
            return;
        }

        if ("save-review".equals(action)) {
            Album album = new Album();
            album.setAlbumTitle(trimToNull(request.getParameter("albumTitle")));
            album.setArtistName(trimToNull(request.getParameter("artistName")));
            album.setCoverImagePath(trimToNull(request.getParameter("coverImagePath")));
            album.setDominantColorHex(trimToNull(request.getParameter("dominantColorHex")));
            album.setReviewText(trimToNull(request.getParameter("reviewText")));
            album.setReviewerName(trimToNull(request.getParameter("reviewerName")));
            album.setCredits(trimToNull(request.getParameter("credits")));
            album.setGenres(trimToNull(request.getParameter("genres")));

            if (album.getAlbumTitle() == null || album.getArtistName() == null || album.getReviewText() == null || album.getReviewerName() == null) {
                request.setAttribute("loggedIn", true);
                request.setAttribute("error", "Album title, artist, review text, and reviewer name are required.");
                request.getRequestDispatcher("/WEB-INF/views/admin.jsp").forward(request, response);
                return;
            }

            int newAlbumId = albumDao.saveAlbumReview(album);
            if (newAlbumId > 0) {
                String trackListText = request.getParameter("trackList");
                if (trackListText != null && !trackListText.trim().isEmpty()) {
                    List<Track> tracks = parseTrackList(trackListText);
                    if (!tracks.isEmpty()) {
                        albumDao.saveTrackList(newAlbumId, tracks);
                    }
                }

                response.sendRedirect(request.getContextPath() + "/admin?message=Review+saved+successfully");
            } else {
                request.setAttribute("loggedIn", true);
                request.setAttribute("error", "There was an error saving the review.");
                request.getRequestDispatcher("/WEB-INF/views/admin.jsp").forward(request, response);
            }
        }
    }

    private boolean isAuthenticated(HttpSession session) {
        return session != null && Boolean.TRUE.equals(session.getAttribute(ADMIN_SESSION_KEY));
    }

    private boolean matchesPassword(String password) {
        String expected = System.getenv("ADMIN_PASSWORD");
        if (expected == null || expected.trim().isEmpty()) {
            expected = getServletContext().getInitParameter("adminPassword");
        }
        String candidate = expected == null || expected.trim().isEmpty() ? DEFAULT_ADMIN_PASSWORD : expected.trim();
        String typed = password == null ? null : password.trim();
        return candidate.equals(typed);
    }

    private String trimToNull(String value) {
        if (value == null) {
            return null;
        }
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }

    private List<Track> parseTrackList(String rawTrackList) {
        List<Track> tracks = new ArrayList<>();
        if (rawTrackList == null || rawTrackList.trim().isEmpty()) {
            return tracks;
        }

        Pattern pattern = Pattern.compile("(?m)^(?:\\s*(?:\\d+)[\\.)-\\s]+)?\\s*(.+?)\\s*[-–—]\\s*(\\d{1,2}:\\d{2})\\s*$");
        String[] lines = rawTrackList.split("\\R");

        for (String line : lines) {
            if (line == null || line.trim().isEmpty()) {
                continue;
            }

            Matcher matcher = pattern.matcher(line.trim());
            if (matcher.matches()) {
                String title = matcher.group(1).trim();
                String duration = matcher.group(2).trim();
                if (title.isEmpty()) {
                    continue;
                }

                Track track = new Track();
                track.setTrackNumber(tracks.size() + 1);
                track.setTrackTitle(title);
                track.setTrackLength(duration);
                tracks.add(track);
            }
        }

        return tracks;
    }
}
