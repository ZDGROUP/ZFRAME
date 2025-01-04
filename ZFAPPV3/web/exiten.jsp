<%-- 
    Document   : exit
    Created on : Feb 2, 2017, 9:53:21 AM
    Author     : Administrator
--%>

<%@page import="zdg.zframe.infrastructure.Metadata_DataBase_Handler"%>
<%@page import="zdg.zframe.application_utilities.PersianCalendar"%>
<%@page import="zdg.zframe.concurrency.ConcurrencyManagement"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>EXIT Z-WEB-CORE</title>
    </head>
    <body>
        <%                               
                try 
                    {
                        int Sys_User_ID =  Integer.parseInt (session.getAttribute ( "USER_ID" ).toString ());
                        ConcurrencyManagement CConcurrency = new  ConcurrencyManagement ();
                         CConcurrency.deleteConcurrencyDataWithUseronly ( Sys_User_ID);
                         
                         
                          String ConnectionLog =  session.getAttribute("Connection_Log_ID").toString();
                         if (ConnectionLog != null) 
                         {
                             if (ConnectionLog.trim().length() > 0 )
                             {
                                 String NowDate = PersianCalendar.getCurrentShamsidate ();
                                 DateTimeFormatter dtf = DateTimeFormatter.ofPattern("HH:mm:ss");
                                    LocalDateTime now = LocalDateTime.now();
                                    String TimeV = dtf.format(now);
                                    
                                    Metadata_DataBase_Handler CDP = new Metadata_DataBase_Handler();
                                    String Query = " UPDATE SYS_CONNECTION_LOG  SET EXITDATE =  '"+NowDate+"' , EXITTIME = '"+TimeV+"' WHERE SYS_CONNECTION_LOG_ID = "+ConnectionLog;
                                    CDP.executeNoneQuery(Query );                                                                                        
                             }
                         }
                    }
                catch (Exception ex){}
            
          session.invalidate();
        %>
        <h1>
            Exit Success 
            <%
                response.sendRedirect("loginen.jsp");
            %>
        </h1>
    </body>
</html>
