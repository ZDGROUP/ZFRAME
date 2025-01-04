
<%@page import="zdg.zframe.relational_database.Manipulation"%>
<%@page import="zdg.zframe.dal.structure.table.Sys_Object"%>
<%@page import="zdg.zframe.infrastructure.DataConvertor"%>
<%@page import="zdg.zframe.infrastructure.DataTable"%>
<%@page import="zdg.zframe.infrastructure.Metadata_DataBase_Handler"%>
<%@page import="zdg.zframe.Dictionary"%>
<%@page import="com.stimulsoft.report.dictionary.databases.StiJDBCDatabase"%>

<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.stimulsoft.webviewer.enums.StiWebViewerTheme"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.stimulsoft.base.drawing.StiColorEnum;"%>
<%@page import="com.stimulsoft.base.drawing.StiColor;"%> 
<%@page import="com.stimulsoft.webviewer.StiWebViewerOptions;"%>
<%@page import="com.stimulsoft.webviewer.StiWebViewer;"%>
<%@page import="java.io.File;"%>
<%@page import="com.stimulsoft.report.StiSerializeManager;"%>
<%@page import="com.stimulsoft.report.StiReport;"%>
<%@ taglib uri="http://stimulsoft.com/webviewer" prefix="stiwebviewer"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Zframe Report Viewer C</title>
</head>
<body>
    <%
        
        request.setCharacterEncoding("UTF-8");
          
        
        
          com.stimulsoft.base.licenses.StiLicense.setKey("6vJhGtLLLz2GNviWmUTrhSqnOItdDwjBylQzQcAOiHl2AD0gPVknKsaW0un+3PuM6TTcPMUAWEURKXNso0e5OKW85jDYl/5L9HvG2WXhIuTUu6LHwjvA19MbJYIXk+xXeN1CuIYc6Bju+UXV4LqY64ii486flptUjJB+wR5ztkuJTMLJJVePV7+MYpeo5CvejO/lS6UfD88X7hxI8raj9eqjat6A6UQuoWS7Ai11xwIb/CWWq+eggIbV3MVZdeOM4sRjoBQM3EqFzRNWjJ/DYfzYqhIEVgAj1NsYqu8RYyaMWLVixGq12r8a8tS8XCMtXW1J/TABimDxQfMfJ/dIF63wKm6sPi7l+1/ed1Tf+1lQ7HvIAo7BdHoI/UAFhQOLjUZgOwi5IpOoa2ZXQl7LpQpdUN509yTfPbWM2EcDLk/aGVnhTKRZSAjvpTXbA58E5Jlchx8VFzZD/rEv5byLuJNBVFuLxXNQaiAX8USoVULYC0ysNv0HLlBXXTIjSMawXLtCcVfVY91yq1UbwKEI270xHJYR/x9wZvCNkEsafiREqW9SBHa9/MONaV7fmfNS");
          //com.stimulsoft.base.licenses.StiLicense.loadFromFile(request.getSession().getServletContext().getRealPath("/license/license.key"));

   
        
                                    try {
                                            String UserName = session.getAttribute("UserName").toString();
                                        } catch (Exception ex) {
                                           response.sendRedirect ( "login.jsp");

                                        }
                                
        
            long Sys_object_id = 0 ;
            long Sys_object_report_id = 0 ;
                
            Map<String, String[]> parameters = request.getParameterMap();
            int Counter = -1;
            ArrayList<Dictionary> QueryParamList = new ArrayList();
            for (String parameter : parameters.keySet()) {
                Counter++;
                String[] DataList = parameters.get(parameter);
                Dictionary CDec = new Dictionary();
                CDec.Name = parameter;
                CDec.Value = DataList[0];
                QueryParamList.add(CDec);
                
                if (CDec.Name.equals ( "Sys_Object_ID"))
                    {
                      Sys_object_id = Long.valueOf ( CDec.Value );
                    }
                if (CDec.Name.equals ( "Sys_Object_Report_ID"))
                    {
                      Sys_object_report_id = Long.valueOf ( CDec.Value );
                    }
                
            }
        
            
            if (Sys_object_report_id != 0 )
                {
                        
                 
                    try 
                        {
                        Metadata_DataBase_Handler CSys = new Metadata_DataBase_Handler();
                       
                        
                         String Query = " Select * from sys_object where RuleID = @lngid And Sys_Design_Pattern_ID = 3 ";                        
                        ArrayList<Dictionary> qParList = new ArrayList<Dictionary>();
                        qParList.add(new Dictionary("id", Sys_object_id));                                                
                        DataTable Ctable = CSys.executeDataTableByDictionery(Query, qParList);
                       
                        
                        DataConvertor<Sys_Object> CConvertor = new DataConvertor<Sys_Object> ();                   
                        Sys_Object MainReport = CConvertor.convert ( Ctable, Sys_Object.class ).get ( 0);
                        
                        String FileName = MainReport.DataBaseObjectName;
                        StiReport report = StiSerializeManager.deserializeReport(
                        new File(request.getSession().getServletContext().getRealPath("/ReportRepository/stimul/"+ FileName)));
                        
                        
                        
                        // Zone For Set DataBase Connection 
                        String DbName = "";
                        String Alias = "";
                        for (int a=0 ; a < report.dictionary.getDatabases ().size () ; a++ )
                            {
                               DbName =  report.dictionary.getDatabases ().get ( a).getName ();
                               Alias =  report.dictionary.getDatabases ().get ( a).getAlias ();
                            }
                        report.dictionary.getDatabases().clear ();
                        StiJDBCDatabase db =new StiJDBCDatabase(DbName,Alias,Manipulation.getDBConnection( MainReport.Sys_System_ID));                        
                        report.dictionary.getDatabases ().add ( db );
                        
                        // Zone For Set DataBase Connection 
                        
                        
                        for (int a=0 ; a < report.dictionary.getVariables ().size () ; a++)
                            {
                             for (int c=0 ; c < QueryParamList.size () ; c++)
                                 {
                                    if ( report.dictionary.getVariables ().get ( a).getName ().equals ( QueryParamList.get ( c).Name))
                                        {
                                            report.dictionary.getVariables().get ( a).setValue ( QueryParamList.get ( c).Value );
                                            break;
                                        }
                                  }
                            }
                        
                        report.render();                                                
                        StiWebViewerOptions options = new StiWebViewerOptions();        
                        options.setTheme(StiWebViewerTheme.Office2010Black);               
                        pageContext.setAttribute("report", report);
                        pageContext.setAttribute("options", options);
                        }
                    catch (Exception ex)
                        {}

                
                
                }
            
        
    %>
    
    
   


   
    <stiwebviewer:webviewer report="${report}" options="${options}"/>
</body>
</html>