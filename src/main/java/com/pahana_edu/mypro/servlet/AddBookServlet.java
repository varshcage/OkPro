package com.pahana_edu.mypro.servlet;

import com.pahana_edu.mypro.DAO.BookDAO;
import com.pahana_edu.mypro.model.Book;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.text.SimpleDateFormat;

@WebServlet("/AddBookServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1,  // 1MB
        maxFileSize = 1024 * 1024 * 10,       // 10MB
        maxRequestSize = 1024 * 1024 * 15)    // 15MB
public class AddBookServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Book book = new Book();
            book.setTitle(request.getParameter("title"));
            book.setAuthor(request.getParameter("author"));
            book.setIsbn(request.getParameter("isbn"));
            book.setCategory(request.getParameter("category"));
            book.setPrice(Double.parseDouble(request.getParameter("price")));
            book.setQuantity(Integer.parseInt(request.getParameter("quantity")));
            book.setPublisher(request.getParameter("publisher"));
            book.setPublishedDate(LocalDate.parse(request.getParameter("publishedDate")));
            book.setDescription(request.getParameter("description"));

            // Handle file upload
            Part filePart = request.getPart("coverImage");
            String fileName = filePart.getSubmittedFileName();
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            String filePath = "uploads/" + fileName;
            if (fileName != null && !fileName.isEmpty()) {
                filePart.write(uploadPath + File.separator + fileName);
                book.setCoverImagePath(filePath);
            } else {
                book.setCoverImagePath(null);
            }

            BookDAO bookDAO = new BookDAO();
            bookDAO.addBook(book);

            HttpSession session = request.getSession();
            session.setAttribute("message", new Message("Book added successfully!", "success"));
            response.sendRedirect("Book.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("message", new Message("Database error: " + e.getMessage(), "error"));
            request.getRequestDispatcher("Book.jsp").forward(request, response);
        }
    }

    public static class Message {
        private String text;
        private String type;

        public Message(String text, String type) {
            this.text = text;
            this.type = type;
        }

        public String getText() { return text; }
/* <<<<<<<<<<<<<<  ✨ Windsurf Command ⭐ >>>>>>>>>>>>>>>> */
        /**
         * @return the type of the message (error/success)
         */
/* <<<<<<<<<<  27d22f5e-75de-46dd-8351-ec1cae419f5d  >>>>>>>>>>> */
        public String getType() { return type; }
    }
}
