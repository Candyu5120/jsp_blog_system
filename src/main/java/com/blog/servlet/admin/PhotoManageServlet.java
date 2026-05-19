package com.blog.servlet.admin;

import com.blog.dao.PhotoDao;
import com.blog.model.Photo;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

public class PhotoManageServlet extends HttpServlet {

    private final PhotoDao photoDao = new PhotoDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "upload":
                    req.setAttribute("albums", photoDao.findAllAlbumNames());
                    req.getRequestDispatcher("/admin/photoUpload.jsp").forward(req, resp);
                    break;
                default:
                    req.setAttribute("photos", photoDao.findAll());
                    req.setAttribute("totalCount", photoDao.getTotalCount());
                    req.getRequestDispatcher("/admin/photoList.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        try {
            if ("upload".equals(action)) {
                Part filePart = req.getPart("photo");
                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = UUID.randomUUID().toString() + getExtension(filePart.getSubmittedFileName());
                    String albumName = req.getParameter("albumName");
                    String description = req.getParameter("description");

                    // Save file
                    String uploadPath = getServletContext().getRealPath("/uploads/photos");
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) uploadDir.mkdirs();
                    filePart.write(uploadPath + File.separator + fileName);

                    // Save to database
                    Photo photo = new Photo();
                    photo.setAlbumName(albumName != null && !albumName.isEmpty() ? albumName : "默认相册");
                    photo.setPhotoPath("uploads/photos/" + fileName);
                    photo.setDescription(description);
                    photoDao.insert(photo);
                }
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                Photo photo = photoDao.findById(id);
                if (photo != null) {
                    // Delete file
                    String filePath = getServletContext().getRealPath("/" + photo.getPhotoPath());
                    File file = new File(filePath);
                    if (file.exists()) file.delete();
                    photoDao.delete(id);
                }
            }
            resp.sendRedirect(req.getContextPath() + "/admin/photo");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private String getExtension(String fileName) {
        if (fileName == null) return ".jpg";
        int idx = fileName.lastIndexOf('.');
        return idx >= 0 ? fileName.substring(idx) : ".jpg";
    }
}
