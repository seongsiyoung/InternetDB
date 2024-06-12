package com.InternetDB.servlet;

import com.InternetDB.DAO.MemberDAO;
import com.InternetDB.util.Encrytor;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet("/member/password")
public class PasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws  IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String oldPassword = request.getParameter("oldPassword");
        String password = (String)request.getSession().getAttribute("password");
        oldPassword = Encrytor.encryptPassword(oldPassword, (String)request.getSession().getAttribute("salt"));
        int result = 0;

        PrintWriter out = response.getWriter();

        if(oldPassword.equals(password))
            result = 1;

        out.write(result + "");

    }
}
