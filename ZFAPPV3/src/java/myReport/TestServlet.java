package myReport;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.util.ArrayList;
import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;
import java.io.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.AsyncContext;
import javax.servlet.AsyncEvent;
import javax.servlet.AsyncListener;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import zdg.zframe.aspect.log.LIB_ASPECT;
import zdg.zframe.configuration.ApplicationInformation;
import zdg.zframe.diagnostic.CacheManagement;
import zdg.zframe.diagnostic.Debuging;



/**
 *
 * @author Administrator
 */
@WebServlet(asyncSupported = true, urlPatterns
        = {
            "*.ttt"
        })
public class TestServlet
        extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     *
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) {

        
        
        
        try {
            response.getWriter().write("Test Servlet");
        } catch (IOException ex) {
            Logger.getLogger(TestServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        
        
        

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        final AsyncContext asyncContext = request.startAsync();
        asyncContext.setTimeout(ApplicationInformation.PageLoadTimeOut);
        asyncContext.addListener(new AsyncListener() {

            @Override
            public void onTimeout(AsyncEvent arg0) throws IOException {
                LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Default, "onTimeout... Get ", 100, " AsyncListener ReportViewer.jsp");
            }

            @Override
            public void onStartAsync(AsyncEvent arg0) throws IOException {
                LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Default, "onStartAsync... Get ", 100, " AsyncListener ReportViewer.jsp");
            }

            @Override
            public void onError(AsyncEvent arg0) throws IOException {
                LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Error, "onError... Get ", 100, " AsyncListener ReportViewer.jsp");
            }

            @Override
            public void onComplete(AsyncEvent arg0) throws IOException {
                LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Default, "onComplete... Get ", 100, " AsyncListener ReportViewer.jsp");

            }
        });

        asyncContext.start(new Runnable() {
            @Override
            public void run() {

                Thread.currentThread().setName("CHAIN_"+ UUID.randomUUID().toString());
                //===================================================================================
                String T1 = "";
                String T2 = "";
                if (!CacheManagement.CacheUsing) {
                    T1 = getCurrentTimeStamp();
                }
                //===================================================================================

                try {

                    HttpServletRequest Arequest = (HttpServletRequest) asyncContext.getRequest();
                    HttpServletResponse Aresponse = (HttpServletResponse) asyncContext.getResponse();
                    String PageAddress = Arequest.getRequestURI();
                    LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Default, "Start Request  :" + PageAddress, 100, " AsyncSupported Request Get ReportViewer.jsp");

                    processRequest(Arequest, Aresponse);

                    //===================================================================================
                    if (!CacheManagement.CacheUsing) {
                        T2 = getCurrentTimeStamp();
                        long Def = differenceTime(T1, T2);
                        String Code = UUID.randomUUID().toString();

                        Debuging.DebugList.put(Code, "<tr> <td style=\"background-color:#ff0;width:300px\"> <span class=\"Title\"  >" + T2 + "</span></td><td style=\"background-color:" + getHtmlColorFromMilisecond(Def) + ";width:90%;\" > <span class=\"Title\"  > Page Load Get [" + String.valueOf(Def) + "]:milliseconds Execute " + PageAddress + "</span></td></tr>");
                    }
                    //===================================================================================

                } catch (Exception e) {
                    LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Error, "Error :" + e.getMessage() + " :" + request.getRequestURI().toLowerCase(), 100, " AsyncSupported Request Get ReportViewer.jsp",e);

                }
                asyncContext.complete();
            }
        });

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        final AsyncContext asyncContext = request.startAsync();
        asyncContext.setTimeout(ApplicationInformation.PageLoadTimeOut);
        asyncContext.addListener(new AsyncListener() {

            @Override
            public void onTimeout(AsyncEvent arg0) throws IOException {
                LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Default, "onTimeout... Post ", 100, " AsyncListener  ReportViewer.jsp");
            }

            @Override
            public void onStartAsync(AsyncEvent arg0) throws IOException {
                LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Default, "onStartAsync... Post ", 100, " AsyncListener ReportViewer.jsp ");
            }

            @Override
            public void onError(AsyncEvent arg0) throws IOException {
                LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Error, "onError... Post ", 100, " AsyncListener ReportViewer.jsp ");
            }

            @Override
            public void onComplete(AsyncEvent arg0) throws IOException {
                LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Default, "onComplete... Post ", 100, " AsyncListener ReportViewer.jsp ");
            }
        });

        asyncContext.start(new Runnable() {
            @Override
            public void run() {
                try {
                    // print request and response outside this thread
                    //System.out.println("Request thread: " + req.getParameter("threadNumber"));
                    //System.out.println("Response: " + resp);

                    Thread.currentThread().setName("CHAIN_"+ UUID.randomUUID().toString());
                    //===================================================================================
                    String T1 = "";
                    String T2 = "";
                    if (!CacheManagement.CacheUsing) {
                        T1 = getCurrentTimeStamp();
                    }
                    //===================================================================================

                    HttpServletRequest Arequest = (HttpServletRequest) asyncContext.getRequest();
                    HttpServletResponse Aresponse = (HttpServletResponse) asyncContext.getResponse();
                    String PageAddress = Arequest.getRequestURI();
                    LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Default, "Start Request  :" + PageAddress, 100, " AsyncSupported Request Get ReportViewer.jsp");
                    processRequest(Arequest, Aresponse);

                    //===================================================================================
                    if (!CacheManagement.CacheUsing) {
                        T2 = getCurrentTimeStamp();
                        long Def = differenceTime(T1, T2);
                        String Code = UUID.randomUUID().toString();

                        Debuging.DebugList.put(Code, "<tr> <td style=\"background-color:#ff0;width:300px\"> <span class=\"Title\"  >" + T2 + "</span></td><td style=\"background-color:" + getHtmlColorFromMilisecond(Def) + ";width:90%;\" > <span class=\"Title\"  > Page Load Post [" + String.valueOf(Def) + "]:milliseconds Execute " + PageAddress + "</span></td></tr>");
                    }
                    //===================================================================================

                    // finish asynchronous 
                } catch (Exception e) {
                    LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Error, "Error :" + e.getMessage() + " :" + request.getRequestURI().toLowerCase(), 100, " AsyncSupported Request Post  ReportViewer.jsp",e);
                }

                asyncContext.complete();
            }
        });
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Remove Concurrency";
    }

    public static String getCurrentTimeStamp() {
        SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");//dd/MM/yyyy
        Date now = new Date();
        String strDate = sdfDate.format(now);
        return strDate;
    }

    public static long differenceTime(String DateTime1, String DateTime2) {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
        Date date1;
        Date date2;
        long difference = 0;
        try {
            date1 = format.parse(DateTime1);
            date2 = format.parse(DateTime2);
            difference = date2.getTime() - date1.getTime();
        } catch (java.text.ParseException ex) {

        }
        return difference;
    }

    public static String getHtmlColorFromMilisecond(long value) {
        if (value < 10) {
            return "#FFF";
        }
        if (value < 100) {
            return "#F99";
        }

        if (value < 1000) {
            return "#F55";
        }
        if (value < 10000) {
            return "#F33";
        }
        return "#F00";
    }

}
