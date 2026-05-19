package com.blog.servlet.front;

import com.blog.dao.PhotoDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class PhotoAlbumServlet extends HttpServlet {

    private final PhotoDao photoDao = new PhotoDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String album = req.getParameter("album");
            if (album != null && !album.isEmpty()) {
                req.setAttribute("photos", photoDao.findByAlbum(album));
                req.setAttribute("currentAlbum", album);
            } else {
                req.setAttribute("photos", photoDao.findAll());
            }
            req.setAttribute("albums", photoDao.findAllAlbumNames());
            req.getRequestDispatcher("/photoAlbum.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
