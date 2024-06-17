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

        String oldPassword = request.getParameter("oldPassword"); //사용자가 잆력한 비밀번호
        String password = (String)request.getSession().getAttribute("password"); //세션에 저장되어 있는 비밀번호

        //비밀번호 암호화
        oldPassword = Encrytor.encryptPassword(oldPassword, (String)request.getSession().getAttribute("salt"));

        int result = 0;

        PrintWriter out = response.getWriter();

        //기존 비밀번호와 사용자가 입력한 비밀번호를 비교
        if(oldPassword.equals(password))
            result = 1;

        out.write(result + "");
        out.flush();
        out.close();
    }
}
