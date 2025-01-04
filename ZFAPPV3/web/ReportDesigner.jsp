
<%@page import="com.stimulsoft.base.drawing.StiColorEnum;"%>
<%@page import="com.stimulsoft.base.drawing.StiColor;"%>
<%@page import="com.stimulsoft.webviewer.StiWebViewerOptions;"%>
<%@page import="com.stimulsoft.webviewer.StiWebViewer;"%>
<%@page import="java.io.File;"%>
<%@page import="com.stimulsoft.report.StiSerializeManager;"%>
<%@page import="com.stimulsoft.report.StiReport;"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://stimulsoft.com/webviewer" prefix="stiwebviewer"%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Report</title>
    </head>
    <body>
        <%
            try 
            {
        StiReport report = StiSerializeManager.deserializeReport(
            new File("C:\\Users\\Administrator\\Desktop\\NetSReport\\Dashboards.mrt"));
        report.render();
        StiWebViewerOptions options = new StiWebViewerOptions();
        options.getAppearance().setBackgroundColor(StiColorEnum.Aqua.color());
        pageContext.setAttribute("report", report);
        pageContext.setAttribute("options", options);
            }
            catch (Exception ex)
            {
                String H = ex.getMessage();
            }
                        
    %>
    <stiwebviewer:webviewer viewerID="mid" report="${report}" options="${options}" />
        
    </body>
</html>
