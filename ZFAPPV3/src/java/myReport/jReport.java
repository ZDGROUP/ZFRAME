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
import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.util.*;
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


import net.sf.jasperreports.engine.query.QueryExecuterFactory;
import zdg.zframe.aspect.log.LIB_ASPECT;
import zdg.zframe.configuration.ApplicationInformation;
import zdg.zframe.dal.structure.table.Sys_Object;
import zdg.zframe.diagnostic.CacheManagement;
import zdg.zframe.diagnostic.Debuging;
import zdg.zframe.infrastructure.DataConvertor;
import zdg.zframe.infrastructure.DataTable;
import zdg.zframe.infrastructure.Metadata_DataBase_Handler;
import zdg.zframe.relational_database.Manipulation;
import zdg.zframe.xlsx.CustomExcelReport;

/**
 *
 * @author Administrator
 */
@WebServlet(asyncSupported = true, urlPatterns
        = {
            "*.vrp"
        })
public class jReport
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

        
        
        if (ApplicationInformation.ZFrameDisableFormGenerator != 0) 
        {
            try 
            {
                response.sendError(404, " HTTP 404, 404 Not Found HTTP ");
            } catch (IOException ex) {
                Logger.getLogger(jReport.class.getName()).log(Level.SEVERE, null, ex);
            }
            LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Error, " Block Server Response Config Form Generator Off ", 100, " BPM_Servlet ");
            return;
        }

        if (ApplicationInformation.ZFrameOTP != 0) 
        {
            if (ApplicationInformation.ZFrameOTPCheck != 0) 
            {
                try 
                {
                    response.sendError(404, " HTTP 404, 404 Not Found HTTP ");
                } catch (IOException ex) 
                {
                    Logger.getLogger(jReport.class.getName()).log(Level.SEVERE, null, ex);
                }
                LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Error, " Block Server Response Config ZFrameOTPCheck ", 100, " BPM_Servlet ");
                return;
            }
        }

        //java.awt.headless=true;
        String DB_DRIVERRERPORT = ApplicationInformation.SystemDataDriver;
        String DB_CONNECTION = ApplicationInformation.SystemConnectionString;
        String DB_USER = ApplicationInformation.SystemDataBaseUserName;
        String DB_PASSWORD =  ApplicationInformation.SystemDataPassPassword;
        //Object cl =  net.sf.jasperreports.engine.util.JRStyledTextParser.getInstance();
        System.setProperty("java.awt.headless", "true");
        //net.sf.jasperreports.extensions.
        Map<String, String[]> parameters = request.getParameterMap();

        int Counter = -1;
        ArrayList<zdg.zframe.Dictionary> QueryParamList = new ArrayList();
        for (String parameter : parameters.keySet()) {
            Counter++;
            String[] DataList = parameters.get(parameter);
            zdg.zframe.Dictionary CDec = new zdg.zframe.Dictionary();
            CDec.Name = parameter;
            CDec.Value = DataList[0];
            QueryParamList.add(CDec);
        }

        boolean ISJASPER = true;
        int Rule_ID = 0;
        if (QueryParamList.size() > 0) {
            if (QueryParamList.get(0).Value.contains("X")) {
                ISJASPER = false;
                Rule_ID = Integer.valueOf(QueryParamList.get(0).Value.replace("X", ""));
            } else {
                Rule_ID = Integer.valueOf(QueryParamList.get(0).Value);
            }

        }

        if (ISJASPER) {
            Metadata_DataBase_Handler CDataProvider = new Metadata_DataBase_Handler();
            DataTable SysObjectTable = CDataProvider.executeDataTable(" SELECT * FROM SYS_OBJECT WHERE RULEID = " + String.valueOf(Rule_ID));
            if (SysObjectTable != null) {
                if (SysObjectTable.getRowCount() > 0) {

                    Connection conn = null;
                    try {

                        zdg.zframe.dal.structure.table.Sys_Object CSysObjectReport = new Sys_Object();
                        CSysObjectReport.fill(SysObjectTable.getDataRow(0));

                        conn = Manipulation.getDBConnection(CSysObjectReport.Sys_System_ID);

                        String FileAddress = ApplicationInformation.ApplicationBaseAddressOnServer + "ReportRepository\\" + CSysObjectReport.DataBaseObjectName; //.replace ( "jasper" , "jrxml");                                          
                        File reportFile = new File(FileAddress);//your report_name.jasper file
                        boolean Exsit = reportFile.exists();
                        Map<String, Object> parametersReport = new HashMap();

                        DataTable SysObjectControl = CDataProvider.executeDataTable(" SELECT * FROM SYS_OBJECT_CONTROL WHERE SYS_OBJECT_ID = " + String.valueOf(CSysObjectReport.Sys_Object_ID));
                        ArrayList<zdg.zframe.dal.structure.table.Sys_Object_Control> ControlParameterList = new ArrayList<>();
                        if (SysObjectControl != null) {
                            if (SysObjectControl.getRowCount() > 0) {
                                DataConvertor<zdg.zframe.dal.structure.table.Sys_Object_Control> ControlConvert = new DataConvertor<>();
                                ControlParameterList = ControlConvert.convert(SysObjectControl, zdg.zframe.dal.structure.table.Sys_Object_Control.class);

                            }
                        }
                        // zdg.zframe.dal.structure.table.Sys_Object_Control 
                        /*


                                                                             1	String    
                                                                             2	boolean 
                                                                             3	BigDecimal
                                                                             4	byte      
                                                                             5	short     
                                                                             6	int       
                                                                             7	long      
                                                                             8	float     
                                                                             9	double    
                                                                             10	byte[ ]   
                                                                             11	Date      
                                                                             12	Time      
                                                                             13	Timestamp 
                                                                             14	Clob      
                                                                             15	Blob      
                                                                             16	Array     
                                                                             17	Ref       
                                                                             18	Struct    

                         */
                        for (int a = 1; a < QueryParamList.size(); a++) {
                            for (int c = 0; c < ControlParameterList.size(); c++) {
                                if (QueryParamList.get(a).Name.trim().equals(ControlParameterList.get(c).Control_Name)) {
                                    Object ValuePort = new Object();

                                    if (ControlParameterList.get(c).Sys_Data_Type_ID == 1) {
                                        String Value = QueryParamList.get(a).Value;
                                        parametersReport.put(QueryParamList.get(a).Name, QueryParamList.get(a).Value);
                                    } else if (ControlParameterList.get(c).Sys_Data_Type_ID == 2) {
                                        Boolean value = Boolean.valueOf(QueryParamList.get(a).Value);
                                        parametersReport.put(QueryParamList.get(a).Name, value);
                                    } else if (ControlParameterList.get(c).Sys_Data_Type_ID == 3) {
                                        java.math.BigDecimal value = java.math.BigDecimal.valueOf(Long.parseLong(QueryParamList.get(a).Value));
                                        parametersReport.put(QueryParamList.get(a).Name, value);
                                    } else if (ControlParameterList.get(c).Sys_Data_Type_ID == 7) {
                                        java.lang.Long value = java.lang.Long.valueOf(QueryParamList.get(a).Value);
                                        parametersReport.put(QueryParamList.get(a).Name, value);
                                    } else if (ControlParameterList.get(c).Sys_Data_Type_ID == 8) {
                                        java.lang.Float value = java.lang.Float.valueOf(QueryParamList.get(a).Value);
                                        parametersReport.put(QueryParamList.get(a).Name, value);
                                    } else if (ControlParameterList.get(c).Sys_Data_Type_ID == 6) {
                                        java.lang.Integer value = java.lang.Integer.valueOf(QueryParamList.get(a).Value);
                                        parametersReport.put(QueryParamList.get(a).Name, value);
                                    }

                                    break;
                                }

                            }
                        }

                        //set input and output stream
                        JasperReport report = null;

                        try {
                            report = (JasperReport) JRLoader.loadObjectFromFile(FileAddress);
                        } catch (Exception ex) {
                            String s = ex.getMessage();
                            System.out.println("error in loading report " + s);

                        }
                        if (report != null) {

                            for (int a = 0; a < ApplicationInformation.SystemList.size(); a++) {
                                
                                if ( ApplicationInformation.SystemList.get(a).Sys_System_ID == CSysObjectReport.Sys_System_ID)
                                {
                                    if ( ApplicationInformation.SystemList.get(a).Sys_DataBase_Type_ID == 2)
                                    {
                                        // Oracle Data Base 
                                        //com.jaspersoft.jrx.query.PlSqlQueryExecuterFactory Cl = new PlSqlQueryExecuterFactory();
                                        //net.sf.jasperreports.engine.query.
                                        //net.sf.jasperreports.query.executer.factory.pls                                        
                                         //net.sf.jasperreports.engine.query.PlSqlQueryExecuterFactory 
                                        report.setProperty("net.sf.jasperreports.query.executer.factory.plsql","net.sf.jasperreports.engine.query.PlSqlQueryExecuterFactory");
                                        report.setProperty( QueryExecuterFactory.QUERY_EXECUTER_FACTORY_PREFIX+"plsql" ,"net.sf.jasperreports.engine.query.PlSqlQueryExecuterFactory");
                                                            
                                        
                                        //report.setProperty( "net.sf.jasperreports.query.executer.factory.plsql","com.jaspersoft.jrx.query.PlSqlQueryExecuterFactory");
                                        //Maybe this too, but not positive
                                        //  report.setProperty( JRQueryExecuterFactory.QUERY_EXECUTER_FACTORY_PREFIX+"plsql","com.jaspersoft.jrx.query.PlSqlQueryExecuterFactory");
                                        break;
                                    }
                                    
                                }
                            }
                            
                            
                            
                            
                ServletOutputStream servletOutputStream = response.getOutputStream();
                //net.sf.jasperreports.engine.fonts.SimpleFontExtensionHelper
                        
                            try {
                                
                                JasperPrint print = JasperFillManager.fillReport(report, parametersReport, conn);
                                
                                response.setContentType("application/pdf");
                                JasperExportManager.exportReportToPdfStream(print, servletOutputStream);
                                
                            } catch (Exception ex1) {
                                  Logger.getLogger ( jReport.class.getName() ).log ( Level.SEVERE , null , ex1 );
                            }

                            // get report location
                            ServletContext context = getServletContext();
                            String reportLocation = context.getRealPath("WEB-INF");

                            servletOutputStream.flush();
                            servletOutputStream.close();

                        }

                    
                        //   Logger.getLogger ( ReportViewer.class.getName() ).log(Level.SEVERE , null , ex);
                    } catch (Exception ex) {
                        try {
                            response.setContentType("text/html;charset=UTF-8");
                            ex.printStackTrace();
                            response.getWriter().write("Zframe : "+ ex.getMessage().replace("\n", "<br>"));
                            System.out.println("Zframe : error in loading report " + ex.getMessage());

                        } catch (IOException ex1) {
                            //    Logger.getLogger ( ReportViewer.class.getName() ).log ( Level.SEVERE , null , ex1 );
                        }
                    }

                    if (conn != null) {
                        Manipulation.removeConnectionFormInUseList(conn);
                    }

                }

            }
        } else {

            //  String.valueOf(Rule_ID) In This Scope Is Sys_Object_ID
            Metadata_DataBase_Handler CDataProvider = new Metadata_DataBase_Handler();
            DataTable SysObjectTable = CDataProvider.executeDataTable(" SELECT * FROM SYS_OBJECT WHERE Sys_Object_ID = " + String.valueOf(Rule_ID));
            if (SysObjectTable != null) {
                if (SysObjectTable.getRowCount() > 0) {

                    try {

                        zdg.zframe.dal.structure.table.Sys_Object CSysObjectReport = new Sys_Object();
                        CSysObjectReport.fill(SysObjectTable.getDataRow(0));
                        DataTable DataSetListTable = CDataProvider.executeDataTable(" Select * from Sys_Report_DataSet Where  Sys_Object_ID = " + String.valueOf(Rule_ID));
                        ArrayList<DataTable> TblList = new ArrayList<>();
                        ArrayList<zdg.zframe.dal.structure.table.Sys_Report_DataSet> DataSetList = new ArrayList<>();
                        DataConvertor<zdg.zframe.dal.structure.table.Sys_Report_DataSet> ControlConvert = new DataConvertor<>();
                        DataSetList = ControlConvert.convert(DataSetListTable, zdg.zframe.dal.structure.table.Sys_Report_DataSet.class);
                        int SysID = CSysObjectReport.Sys_System_ID;
                        Manipulation CM = new Manipulation();
                        CM.SystemID = SysID;
                        for (int a = 0; a < DataSetList.size(); a++) {
                            DataTable NowC = CM.executeDataTableByDictionery(DataSetList.get(a).LoadQuery, QueryParamList);
                            NowC.setName(DataSetList.get(a).DatasetName);
                            TblList.add(NowC);
                        }

                        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
                        request.setCharacterEncoding("UTF-8");
                        response.setCharacterEncoding("UTF-8");
                        String TemplateFileAddress = ApplicationInformation.ApplicationBaseAddressOnServer + "ReportRepository\\" + CSysObjectReport.DataBaseObjectName; //.replace ( "jasper" , "jrxml");                                          
                        CustomExcelReport CER = new CustomExcelReport();
                        CER.insertDataSet(TblList, QueryParamList, TemplateFileAddress, response.getOutputStream());
                        LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Success, "Success Generate Report", 100, " Generate Report ");
                    } catch (Exception ex) {

                        String S = ex.getMessage();
                        System.out.println("error in loading report spreadsheetml.sheet " + S);
                        LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Error, ex.getMessage(), 100, " Error In Generate Report ");

                    }

                }

            }
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
