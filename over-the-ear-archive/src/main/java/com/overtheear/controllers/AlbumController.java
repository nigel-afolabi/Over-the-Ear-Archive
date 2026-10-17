package com.overtheear.controllers;

import com.overtheear.dao.AlbumDao;
import com.overtheear.models.Album;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AlbumController extends HttpServlet {
    private AlbumDao albumDao;

    @Override
    public void init() {
        albumDao = new AlbumDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null) {
            try {
                int albumId = Integer.parseInt(idParam);
                Album album = albumDao.getAlbumById(albumId);
                if (album != null) {
                    request.setAttribute("album", album);
                    request.getRequestDispatcher("/WEB-INF/views/album-detail.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                // Invalid ID format
            }
        }
        response.sendRedirect(request.getContextPath() + "/latest");
    }
}