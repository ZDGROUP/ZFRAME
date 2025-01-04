
<%@page import="zdg.zframe.configuration.ApplicationInformation"%>
<%@page import="zdg.zframe.dal.structure.table.Sys_Object"%>
<%@page import="zdg.zframe.infrastructure.DataConvertor"%>
<%@page import="zdg.zframe.infrastructure.DataTable"%>
<%@page import="zdg.zframe.Dictionary"%>
<%@page import="zdg.zframe.infrastructure.Metadata_DataBase_Handler"%>
<%@page import="java.nio.file.Path"%>
<%@page import="java.nio.file.Paths"%>
<%@page import="java.io.IOException"%>
<%@page import="javax.imageio.IIOException"%>
<%@page import="java.nio.file.StandardCopyOption"%>
<%@page import="java.nio.file.CopyOption"%>
<%@page import="java.nio.file.Files"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<!DOCTYPE html PUBLIC " -//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@page import="com.stimulsoft.report.dictionary.databases.StiJsonDatabase"%>
<%@page import="com.stimulsoft.report.dictionary.databases.StiXmlDatabase"%>
<%@page import="com.stimulsoft.report.dictionary.databases.StiJDBCDatabase"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.net.URL"%>
<%@page import="com.stimulsoft.web.classes.StiRequestParams"%>
<%@page import="com.stimulsoft.webdesigner.StiWebDesigerHandler"%>
<%@page import="com.stimulsoft.webdesigner.StiWebDesignerOptions"%>
<%@page import="com.stimulsoft.webdesigner.enums.StiWebDesignerTheme"%>
<%@page import="java.io.File"%>
<%@page import="com.stimulsoft.report.StiSerializeManager"%>
<%@page import="com.stimulsoft.report.StiReport"%>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding = "UTF-8" %>
<%@taglib uri="http://stimulsoft.com/webdesigner" prefix = "stiwebdesigner" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Report.mrt - Designer</title>
<style type="text/css">
</style>
</head>
<body>
	<%
            
            
                     try {
                            String SessionIsAdmin = session.getAttribute("ISADMIN").toString();
                            if (!SessionIsAdmin.equals("1")) {
                                response.sendRedirect ( "Default.jsp");
                             }
                           } catch (Exception ex) {
                               response.sendRedirect ( "Default.jsp");
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
            
            // Sys_Object_ID    =  Main Form Sys_object_ID
            // Sys_Object_Report_ID =  Report Sys_object_ID
            
           final String ReportFileName ;
            if ( Sys_object_report_id == 0 )
                {
                    // Create New Report File 
                   Metadata_DataBase_Handler CSys = new Metadata_DataBase_Handler();
                   DataTable Ctable = CSys.executeDataTable ( " Select * from sys_object where sys_object_id ="+ Sys_object_id);
                   DataConvertor<Sys_Object> CConvertor = new DataConvertor<Sys_Object> ();                   
                   Sys_Object MainForm = CConvertor.convert ( Ctable, Sys_Object.class ).get ( 0);
                   
                   // copy Empty Report For This Sys_object 
                   ReportFileName = MainForm.Sys_Object_Name.trim ()+".mrt";
                 
                   try 
                       {
                    String source = request.getSession().getServletContext().getRealPath("/ReportRepository/stimul/ZMS.mrt");
                    String target  = request.getSession().getServletContext().getRealPath("/ReportRepository/stimul/");
                    target = target + "/" + ReportFileName;
                    Path FromFile = Paths.get ( source );
                    Path ToFile = Paths.get ( target );
                    Files.copy ( FromFile , ToFile , StandardCopyOption.REPLACE_EXISTING );
                       }
                   catch (Exception ex)
                       { 
                       String H = ex.getMessage ();
                       out.print ( H);
                       }
                        
                   
                }
            else
                {
                
                   Metadata_DataBase_Handler CSys = new Metadata_DataBase_Handler();
                   DataTable Ctable = CSys.executeDataTable ( " Select * from sys_object where RuleID ="+ Sys_object_report_id);
                   DataConvertor<Sys_Object> CConvertor = new DataConvertor<Sys_Object> ();                   
                    Sys_Object MainForm = CConvertor.convert ( Ctable, Sys_Object.class ).get ( 0);
                   
                   // copy Empty Report For This Sys_object 
                   ReportFileName = MainForm.DataBaseObjectName;
                 
                }
                   
                   
                
            
		final String reportPath = request.getSession().getServletContext().getRealPath("/ReportRepository/stimul/"+ReportFileName);		
		StiWebDesignerOptions options = new StiWebDesignerOptions();
		StiWebDesigerHandler handler = new StiWebDesigerHandler()
			{
			//Occurred on loading webdesinger. Must return edited StiReport
			public StiReport getEditedReport(HttpServletRequest request){
				try {
					StiReport report = StiSerializeManager.deserializeReport(new File(reportPath));
                                        report.setReportName ( ReportFileName.replace ( ".mrt", "" ) );
                                        
					return report;
				} catch (Exception e) {
					e.printStackTrace();
				}
				return null;
			}
			//Occurred on opening StiReport. Method intended for populate report data.
			public void onOpenReportTemplate(StiReport report, HttpServletRequest request) {
			}
			//Occurred on new StiReport. Method intended for populate report data.
			public void onNewReportTemplate(StiReport report, HttpServletRequest request) {
			}
			//Occurred on save StiReport. Method must implement saving StiReport
			public void onSaveReportTemplate(StiReport report, StiRequestParams requestParams, HttpServletRequest request) {
				try {
                                    
                                    
					FileOutputStream fos = new FileOutputStream(ApplicationInformation.ApplicationBaseAddressOnServer +"\\ReportRepository\\stimul\\" + requestParams.designer.fileName);
					if (requestParams.designer.password != null) {
						StiSerializeManager.serializeReport(report, fos, requestParams.designer.password);
					} else {
						StiSerializeManager.serializeReport(report, fos, true);
					}
					fos.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		};
		pageContext.setAttribute("handler", handler);
		pageContext.setAttribute("options", options);
	%>
	<stiwebdesigner:webdesigner handler = "${handler}" options="${options}" />
</body>
</html>