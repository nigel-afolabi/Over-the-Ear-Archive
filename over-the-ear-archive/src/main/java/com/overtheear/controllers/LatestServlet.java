package com.overtheear.controllers;

import com.overtheear.dao.AlbumDao;
import com.overtheear.models.Album;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class LatestServlet extends HttpServlet {
    private AlbumDao albumDao;

    @Override
    public void init() {
        albumDao = new AlbumDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Album> latestAlbums = albumDao.getLatestAlbums();
        request.setAttribute("albums", latestAlbums);
        
        // Forward the data to your latest view
        request.getRequestDispatcher("/WEB-INF/views/latest.jsp").forward(request, response);
    }
}