package com.InternetDB.util;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class Alert {

    //알림창을 띄우는 메소드
    public static void alert(HttpServletResponse response, String msg) throws IOException {
        try {
            response.setContentType("text/html; charset=utf-8");
            PrintWriter w = response.getWriter();
            w.write("<script> alert('"+msg+"'); </script>");
            w.flush();
            w.close();
        } catch(Exception e) {
            e.printStackTrace();
            response.sendRedirect("/temp/temperror.jsp");
        }
    }

    //알림창을 띄우고 난 다음 닫는 메소드
    public static void alertAndClose(HttpServletResponse response, String msg) throws IOException {
        try {
            response.setContentType("text/html; charset=utf-8");
            PrintWriter w = response.getWriter();
            w.write("<script> alert('"+msg+"');window.close(); </script>");
            w.flush();
            w.close();
        } catch(Exception e) {
            e.printStackTrace();
            response.sendRedirect("/temp/temperror.jsp");

        }
    }

    //알림창을 띄우고 이전 페이지로 이동
    public static void alertAndBack(HttpServletResponse response, String msg) throws IOException {
        try {
            response.setContentType("text/html; charset=utf-8");
            PrintWriter w = response.getWriter();
            w.write("<script> alert('"+msg+"');history.go(-1); </script>");
            w.flush();
            w.close();
        } catch(Exception e) {
            e.printStackTrace();
            response.sendRedirect("/temp/temperror.jsp");

        }
    }

    //알림창을 띄우고 정한 url로 이동
    public static void alertAndMove(HttpServletResponse response, String msg, String url) throws IOException {
        try {
            response.setContentType("text/html; charset=utf-8");
            PrintWriter w = response.getWriter();
            w.write("<script> alert('"+msg+"');location.href='"+url+"'; </script>");
            w.flush();
            w.close();
        } catch(Exception e) {
            e.printStackTrace();
            response.sendRedirect("/temp/temperror.jsp");
        }
    }
}
