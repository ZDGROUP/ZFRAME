<%-- 
    Document   : accessibility
    Created on : Feb 8, 2017, 10:10:06 AM
    Author     : pc
--%>


<%@page import="zdg.zframe.configuration.ApplicationInformation"%>
<%@page import="zdg.zframe.infrastructure.Metadata_DataBase_Handler"%>
<%@page import="zdg.zframe.infrastructure.DataTable"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="Style/Main.css" rel="stylesheet" type="text/css"/>
        <script src="ZJBPMS/zbpms.js" type="text/javascript"></script>
    </head>
    <body style="font-family:FontYekan; font-size: 13px;">
        
        
        
        <form method="POST" id="bpmform">

            <Table align="Center" style="width:100%; background: white;">
                <tr>                    
                    <td align="Center">

                        <div style="text-align: center; background-color: #07103C; color:#F2F2F2; width: 50%; height:25px; font-size: 16px; -webkit-border-top-left-radius: 5px;
                             -webkit-border-top-right-radius: 5px;
                             -moz-border-radius-topleft: 5px;
                             -moz-border-radius-topright: 5px;
                             border-top-left-radius: 5px;
                             border-top-right-radius: 5px;">
                            <h4 style="font-family:ZFRAMEFONT;" >فرم مدیریت دسترسی</h4>
                        </div>
                        <table style="text-align: center; border: 1px solid; border-color: #000; direction: rtl; width: 50%; -webkit-border-bottom-right-radius: 5px;
                               -webkit-border-bottom-left-radius: 5px;
                               -moz-border-radius-bottomright: 5px;
                               -moz-border-radius-bottomleft: 5px;
                               border-bottom-right-radius: 5px;
                               border-bottom-left-radius: 5px; " dir="rtl">
                            <tr>

                                <%
                                          Metadata_DataBase_Handler CDataProvider = new Metadata_DataBase_Handler();
                                          boolean UserAccess = false;
                                           //Check User Is Admin 
                   
                                         String SessionIsAdmin =  session.getAttribute("ISADMIN").toString();                                                      
                           
                                        if (SessionIsAdmin.equals("0"))
                                        {
                                            response.sendRedirect("login.jsp");
                                        }
  
                                    
                                    String SELECTOBJECTID = String.valueOf(Long.valueOf(request.getParameter("Sys_Object")));
                                    String SELECTGROUPID  = String.valueOf(Long.valueOf(request.getParameter("User_Group")));
                    
                                    String Sys_Accessibility_Level1_ID ="";
                    
                   
                                         DataTable Table = CDataProvider.executeDataTable ( "SELECT SYS_OBJECT_ID,SYS_OBJECT_CAPTION FROM SYS_OBJECT WHERE SYS_SYSTEM_ID =" +  ApplicationInformation.System_ID);
                    
              
                                        String mQuery = "SELECT  SYS_OBJECT_CONTROL.SYS_OBJECT_CONTROL_ID , SYS_OBJECT_CONTROL.CONTROL_CAPTION  FROM   SYS_OBJECT_CONTROL   WHERE   SYS_OBJECT_CONTROL.SYS_OBJECT_ID = " + SELECTOBJECTID;
                                        DataTable TableControls = CDataProvider.executeDataTable ( mQuery);
                    
                    
                       
                    
                                         zdg.zframe.infrastructure.DataTable Table3 = CDataProvider.executeDataTable ( "SELECT CANVIEW,CANEDIT,CANDELETE,CANINSERT,CANREPORT,CANEXPORT,SYS_ACCESSIBILITY_LEVEL1_ID FROM SYS_ACCESSIBILITY_LEVEL1 WHERE SYS_OBJECT_ID = " + SELECTOBJECTID + " AND SYS_USERGROUP_ID= " + SELECTGROUPID);
                         
                                         String CheckView = "";
                                         String CheckEdit = "";
                                         String CheckDelete = "";
                                         String CheckInsert = "";
                                         String CheckReport = "";
                                         String CheckExport = "";
                                         if (Table3 != null)
                                         {
                                              if (Table3.getRowCount() > 0 )
                                              {
                                                  String CanView = Table3.getDataRow(0).getColumnData(0).toString();
                                                  String CanEdit = Table3.getDataRow(0).getColumnData(1).toString();
                                                  String CanDelete = Table3.getDataRow(0).getColumnData(2).toString();
                                                  String CanInsert = Table3.getDataRow(0).getColumnData(3).toString();
                                                  String CanReport = Table3.getDataRow(0).getColumnData(4).toString();
                                                  String CanExport = Table3.getDataRow(0).getColumnData(5).toString();
                                                  
                                                  
                                                  Sys_Accessibility_Level1_ID =Table3.getDataRow(0).getColumnData(6).toString();
                                  
                                                  if (CanView.trim().equals("true")||CanView.trim().equals("1"))
                                                  {
                                                      CheckView = "checked";
                                                  }
                                                  if (CanEdit.trim().equals("true")||CanEdit.trim().equals("1"))
                                                  {
                                                      CheckEdit = "checked";
                                                  }
                                                  if (CanDelete.trim().equals("true")||CanDelete.trim().equals("1"))
                                                  {
                                                      CheckDelete = "checked";
                                                  }
                                                  if (CanInsert.trim().equals("true")||CanInsert.trim().equals("1"))
                                                  {
                                                      CheckInsert = "checked";
                                                  }
                                                  if (CanReport.trim().equals("true")||CanReport.trim().equals("1"))
                                                  {
                                                      CheckReport = "checked";
                                                  }
                                                   if (CanExport.trim().equals("true")||CanExport.trim().equals("1"))
                                                  {
                                                      CheckExport = "checked";
                                                  }                                                                      
                                              }
                                         }
                         

                         
                        
                         
                                %>
                                <td style="width:50%;font-family:ZFRAMEFONT">انتخاب فرم</td>
                                <td>

                                    <select id="Sys_Object" name="Sys_Object" onchange="__doPostBackOnly()" style="font-family:ZFRAMEFONT ; font-size:13px; width:255px; ">
                                        <%
                         
                                            out.print("<option value=\"0\">-</option>");
   
                                            for (int a=0 ; a < Table.getRowCount() ; a++)
                                            {
                                                if (Table.getDataRow(a).getColumnData(0).toString().trim().equals(SELECTOBJECTID))
                                                {
                                                 out.print("<option value=\""+Table.getDataRow(a).getColumnData(0).toString()+"\" selected>"+Table.getDataRow(a).getColumnData(1).toString() +"</option>");
                                                }
                                                else
                                                {
                                                    out.print("<option value=\""+Table.getDataRow(a).getColumnData(0).toString()+"\"  >"+Table.getDataRow(a).getColumnData(1).toString() +"</option>");
                                                }
                                            }
                                        %>                                                                                     
                                    </select style="width: 255px;">


                                </td>
                            </tr>
                            <tr>

                                <% 
                       
                     
                                      DataTable Table2 = CDataProvider.executeDataTable ( "SELECT SYS_USERGROUP_ID,USERGROUPNAME FROM SYS_USERGROUP");
                         
                                %>
<td style="width:50%;font-family:ZFRAMEFONT">                               انتخاب گروه کاری</td>
                                <td>
                                    <select id="User_Group" name="User_Group" style="width: 255px;" onchange="__doPostBackOnly()" style="font-family:ZFRAMEFONT; font-size:13px; width:255px; ">
                                        <%
                            
                                          out.print("<option value=\"0\"  >-</option>");
                          
                                           for (int a=0 ; a < Table2.getRowCount() ; a++)
                                           if (Table2.getDataRow(a).getColumnData(0).toString().trim().equals(SELECTGROUPID))
                                               {
                                                out.print("<option value=\""+Table2.getDataRow(a).getColumnData(0).toString()+"\" selected>"+Table2.getDataRow(a).getColumnData(1).toString() +"</option>");
                                               }
                                               else
                                               {
                                                   out.print("<option value=\""+Table2.getDataRow(a).getColumnData(0).toString()+"\"  >"+Table2.getDataRow(a).getColumnData(1).toString() +"</option>");
                                               }
                                        %>
                                    </select>
                                </td>

                            </tr>
                        </table>
                        <div style="text-align: center; background-color: #07103C; color:#F2F2F2; width: 50%; height:25px; font-size: 16px; -webkit-border-top-left-radius: 5px;
                             -webkit-border-top-right-radius: 5px;
                             -moz-border-radius-topleft: 5px;
                             -moz-border-radius-topright: 5px;
                             border-top-left-radius: 5px;
                             border-top-right-radius: 5px;">
                            <h4 style="font-family:ZFRAMEFONT" >دسترسی های اولیه به فرم</h4>
                        </div>
                        <table style="text-align: center; border: 1px solid; border-color: #000; direction: rtl; width: 50%; -webkit-border-bottom-right-radius: 5px;
                               -webkit-border-bottom-left-radius: 5px;
                               -moz-border-radius-bottomright: 5px;
                               -moz-border-radius-bottomleft: 5px;
                               border-bottom-right-radius: 5px;
                               border-bottom-left-radius: 5px; ">
                            <tr style="background-color: #ddd;">

                                <td style="font-family:ZFRAMEFONT">قابلیت نمایش</td>

                                <td style="font-family:ZFRAMEFONT">قابلیت ویرایش</td>
                                <td style="font-family:ZFRAMEFONT">قابلیت حذف</td>
                                <td style="font-family:ZFRAMEFONT">قابلیت اضافه نمودن</td>
                                <td style="font-family:ZFRAMEFONT">قابلیت گزارش گیری</td>
                                <td style="font-family:ZFRAMEFONT">قابلیت گرفتن خروجی</td>
                            </tr>
                            <tr>

                                <td><input type="checkbox" name="abl_display" id="abl_display" <% out.print(CheckView); %> ></td>


                                <td><input type="checkbox" name="abl_edit" id="abl_edit" <% out.print(CheckEdit); %> ></td>
                                <td><input type="checkbox" name="abl_remove" id="abl_remove" <% out.print(CheckDelete); %> ></td>
                                <td><input type="checkbox" name="abl_addin" id="abl_addin" <% out.print(CheckInsert); %> ></td>
                                <td><input type="checkbox" name="abl_report" id="abl_report" <% out.print(CheckReport); %> ></td>
                                <td><input type="checkbox" name="abl_export" id="abl_export" <% out.print(CheckExport); %> ></td>
                            </tr>
                        </table>
                        <div style="text-align: center; background-color:#07103C; color:#F2F2F2; width: 50%; height:25px; font-size: 16px; -webkit-border-top-left-radius: 5px;
                             -webkit-border-top-right-radius: 5px;
                             -moz-border-radius-topleft: 5px;
                             -moz-border-radius-topright: 5px;
                             border-top-left-radius: 5px;
                             border-top-right-radius: 5px;">
                            <h4 style="font-family:ZFRAMEFONT">دسترسی به کنترل های فرم</h4>
                        </div>
                        <table style="text-align: center; border: 1px solid; border-color: #000; direction: rtl; width: 50%; -webkit-border-bottom-right-radius: 5px;
                               -webkit-border-bottom-left-radius: 5px;
                               -moz-border-radius-bottomright: 5px;
                               -moz-border-radius-bottomleft: 5px;
                               border-bottom-right-radius: 5px;
                               border-bottom-left-radius: 5px;">
                            <tr>
                                <td><input type="submit" id="btn_NotAccess" name="btn_NotAccess" value="ثبت عدم دسترسی" style="width: 150px; font-family:ZFRAMEFONT; height: 40px; background-color: #CC0000; color:#fafafa;  font-size: 12px; " /></td>
                                    <% 
                                    if (request.getParameter("btn_NotAccess") != null) 
                                    {
                      
                                         // Not save 
                    
                    
                            
                            
                                       if (Sys_Accessibility_Level1_ID.trim().length() == 0 )
                                        {
                                            if (ApplicationInformation.ProjectDataBaseType == 2) // Oracle
                                            {
                                              CDataProvider.executeNoneQuery("INSERT INTO SYS_ACCESSIBILITY_LEVEL1 (SYS_ACCESSIBILITY_LEVEL1_ID,SYS_OBJECT_ID,SYS_USERGROUP_ID, CANVIEW,CanEdit,CanDelete,CanInsert,CanReport,CanExport) VALUES (0,"+SELECTOBJECTID+","+SELECTGROUPID+",0,0,0,0,0,0)");  
                                            }
                                            else
                                            {
                                                CDataProvider.executeNoneQuery("INSERT INTO SYS_ACCESSIBILITY_LEVEL1 (SYS_OBJECT_ID,SYS_USERGROUP_ID, CANVIEW,CanEdit,CanDelete,CanInsert,CanReport,CanExport) VALUES ("+SELECTOBJECTID+","+SELECTGROUPID+",0,0,0,0,0,0)");  
                                                
                                            }
                                           String GetIDAfterInsertQuery  =  " SELECT SYS_ACCESSIBILITY_LEVEL1_ID FROM SYS_ACCESSIBILITY_LEVEL1 WHERE SYS_OBJECT_ID = "+SELECTOBJECTID +" AND SYS_USERGROUP_ID = "+ SELECTGROUPID ;
                                           DataTable GetID = CDataProvider.executeDataTable(GetIDAfterInsertQuery);
                                           if (GetID != null)
                                           {
                                                if (GetID.getRowCount() > 0 )                          
                                                {
                                                          Sys_Accessibility_Level1_ID = GetID.getDataRow(0).getColumnData(0).toString();
                                                }
                                           }
                       
                                        }
                                        else
                                        {
                                            CDataProvider.executeNoneQuery("UPDATE  SYS_ACCESSIBILITY_LEVEL1 SET SYS_OBJECT_ID = "+SELECTOBJECTID+" ,SYS_USERGROUP_ID = "+SELECTGROUPID+" , CANVIEW = 0,CanEdit = 0,CanDelete = 0,CanInsert = 0,CanReport = 0,CanExport = 0 WHERE SYS_ACCESSIBILITY_LEVEL1_ID ="+Sys_Accessibility_Level1_ID );  
                                        }
                    
                  
                                        if (TableControls.getRowCount() > 0 )
                                         {
                                             for (int a=0 ; a < TableControls.getRowCount() ; a++)

                                             {     

                                                   String ControlID = TableControls.getDataRow(a).getColumnData(0).toString();
                                                   DataTable AcLevel2Table= CDataProvider.executeDataTable(" SELECT * FROM SYS_ACCESSIBILITY_LEVEL2 WHERE SYS_ACCESSIBILITY_LEVEL1_ID = "+Sys_Accessibility_Level1_ID +" AND SYS_OBJECT_CONTROL_ID = "+ControlID);
                             
                                                        String ACLV2ID =  "";
                                                        if (AcLevel2Table != null)
                                                        {
                                                            if (AcLevel2Table.getRowCount() > 0)
                                                            {
                                                                ACLV2ID = AcLevel2Table.getDataRow(0).getColumnData(0).toString();
                                                            }
                                                        }
                             
                                                 if ((ACLV2ID.trim().length() > 0  ))
                                                 {
                                                     try 
                                                     {
                                                      long SYS_ACCESSIBILITY_LEVEL2_ID = Long.valueOf(ACLV2ID);
                                  
                                                      CDataProvider.executeNoneQuery("Delete FROM SYS_ACCESSIBILITY_LEVEL2 WHERE SYS_ACCESSIBILITY_LEVEL2_ID ="+ String.valueOf(SYS_ACCESSIBILITY_LEVEL2_ID));
                                                     }
                                                     catch (Exception ex){}
                                 
                                                 }
                             
                             
                             
                                                 String Name1 = "Vcheck"+ControlID.trim();
                                                 String Name2 = "Echeck"+ControlID.trim();
                                                 String VCHECK = request.getParameter(Name1);
                                                 String ECHECK = request.getParameter(Name2);
                   
                                                 String CanView1 = "0";
                                                 String CanEdit1 = "0";
                             
                           
                                
                                             if (ApplicationInformation.ProjectDataBaseType == 2) //oracle
                                             {
                                                String Q1 = "INSERT INTO SYS_ACCESSIBILITY_LEVEL2 (SYS_ACCESSIBILITY_LEVEL2_ID,SYS_ACCESSIBILITY_LEVEL1_ID,SYS_OBJECT_CONTROL_ID,CANVIEW,CANEDIT) VALUES (0 ,";   
                                                Q1  += Sys_Accessibility_Level1_ID +",";
                                                Q1  += ControlID +",";
                                                Q1 +=  CanView1; 
                                                Q1 +=  "," + CanEdit1 + ")";
                                                CDataProvider.executeNoneQuery (Q1);
                                             }
                                             else
                                             {
                                                String Q1 = "INSERT INTO SYS_ACCESSIBILITY_LEVEL2 (SYS_ACCESSIBILITY_LEVEL1_ID,SYS_OBJECT_CONTROL_ID,CANVIEW,CANEDIT) VALUES (";
                                                Q1  += Sys_Accessibility_Level1_ID +",";
                                                Q1  += ControlID +",";
                                                Q1 +=  CanView1; 
                                                Q1 +=  "," + CanEdit1 + ")";
                                                CDataProvider.executeNoneQuery (Q1);
                                             }
                               
                               
                             
                             
                                             }
                                         }
                      
                       
                       
                    
                
                    
                                 
                                    }
                              
                              
                                    %>
                                <td><input type="submit" id="btn_CustomAccess" name="btn_CustomAccess" value="ثبت دسترسی سفارشی" style=" font-family:ZFRAMEFONT;width: 180px; height: 40px; background-color: #0066FF; color:#fafafa; font-size: 12px; " /></td>

                                <% 
                                if (request.getParameter("btn_CustomAccess") != null) 
                                {
                    
                     
                                  // manual save 
                    
                    
                                            String CV = "abl_display";
                                            String CView =  ( request.getParameter(CV)!= null ?"1":"0");
                                            String CE = "abl_edit";
                                            String CEdit = ( request.getParameter(CE)!= null ?"1":"0");
                                            String CD = "abl_remove";
                                            String CDelete = ( request.getParameter(CD)!= null ?"1":"0");
                                            String CI = "abl_addin";
                                            String CInsert = ( request.getParameter(CI)!= null ?"1":"0");
                                            String CR = "abl_report";
                                            String CReport = ( request.getParameter(CR)!= null ?"1":"0");
                                            String CX = "abl_export";
                                            String CExport = ( request.getParameter(CX)!= null ?"1":"0");
                    
                            
                            
                                   if (Sys_Accessibility_Level1_ID.trim().length() == 0 )
                                    {
                                        if (ApplicationInformation.ProjectDataBaseType == 2) //Oracle
                                        {
                                            CDataProvider.executeNoneQuery("INSERT INTO SYS_ACCESSIBILITY_LEVEL1 (SYS_ACCESSIBILITY_LEVEL1_ID, SYS_OBJECT_ID,SYS_USERGROUP_ID, CANVIEW,CanEdit,CanDelete,CanInsert,CanReport,CanExport) VALUES (0,"+SELECTOBJECTID+","+SELECTGROUPID+","+CView+","+CEdit+","+CDelete+","+CInsert+","+CReport+","+CExport+")");  
                                        }
                                        else
                                        {
                                            CDataProvider.executeNoneQuery("INSERT INTO SYS_ACCESSIBILITY_LEVEL1 (SYS_OBJECT_ID,SYS_USERGROUP_ID, CANVIEW,CanEdit,CanDelete,CanInsert,CanReport,CanExport) VALUES ("+SELECTOBJECTID+","+SELECTGROUPID+","+CView+","+CEdit+","+CDelete+","+CInsert+","+CReport+","+CExport+")");  
                                        }
                                       String GetIDAfterInsertQuery  =  " SELECT SYS_ACCESSIBILITY_LEVEL1_ID FROM SYS_ACCESSIBILITY_LEVEL1 WHERE SYS_OBJECT_ID = "+SELECTOBJECTID +" AND SYS_USERGROUP_ID = "+ SELECTGROUPID ;
                                       DataTable GetID = CDataProvider.executeDataTable(GetIDAfterInsertQuery);
                                       if (GetID != null)
                                       {
                                            if (GetID.getRowCount() > 0 )                          
                                            {
                                                      Sys_Accessibility_Level1_ID = GetID.getDataRow(0).getColumnData(0).toString();
                                            }
                                       }
                       
                                    }
                                    else
                                    {
                                        CDataProvider.executeNoneQuery("UPDATE  SYS_ACCESSIBILITY_LEVEL1 SET SYS_OBJECT_ID = "+SELECTOBJECTID+" ,SYS_USERGROUP_ID = "+SELECTGROUPID+" , CANVIEW = "+CView+",CanEdit = "+CEdit+",CanDelete = "+CDelete+",CanInsert = "+CInsert+",CanReport = "+CReport+",CanExport = "+CExport+" WHERE SYS_ACCESSIBILITY_LEVEL1_ID ="+Sys_Accessibility_Level1_ID );  
                                    }
                    
                  
                                    if (TableControls.getRowCount() > 0 )
                                     {
                                         for (int a=0 ; a < TableControls.getRowCount() ; a++)

                                         {     

                                             String ControlID = TableControls.getDataRow(a).getColumnData(0).toString();
                                             DataTable AcLevel2Table= CDataProvider.executeDataTable(" SELECT * FROM SYS_ACCESSIBILITY_LEVEL2 WHERE SYS_ACCESSIBILITY_LEVEL1_ID = "+Sys_Accessibility_Level1_ID +" AND SYS_OBJECT_CONTROL_ID = "+ControlID);
                             
                                             String ACLV2ID =  "";
                                             if (AcLevel2Table != null)
                                             {
                                                 if (AcLevel2Table.getRowCount() > 0)
                                                 {
                                                     ACLV2ID = AcLevel2Table.getDataRow(0).getColumnData(0).toString();
                                                 }
                                             }
                             
                     
                             
                                             if ((ACLV2ID.trim().length() > 0  ))
                                             {
                                                 try 
                                                 {
                                                  long SYS_ACCESSIBILITY_LEVEL2_ID = Long.valueOf(ACLV2ID);
                                  
                                                  CDataProvider.executeNoneQuery("Delete FROM SYS_ACCESSIBILITY_LEVEL2 WHERE SYS_ACCESSIBILITY_LEVEL2_ID ="+ String.valueOf(SYS_ACCESSIBILITY_LEVEL2_ID));
                                                 }
                                                 catch (Exception ex){}
                                 
                                             }
                             
                             
                             
                                             String Name1 = "Vcheck"+ControlID.trim();
                                             String Name2 = "Echeck"+ControlID.trim();
                                             String VCHECK = request.getParameter(Name1);
                                             String ECHECK = request.getParameter(Name2);
                   
                                             String CanView1 = "0";
                                             String CanEdit1 = "0";
                             
                                             if (VCHECK != null)
                                             {
                                                if (VCHECK.equals("on"))
                                                {
                                                    CanView1 = "1";
                                                }  
                                             }
                             
                                             if (ECHECK != null)
                                             {
                                                if (ECHECK.equals("on"))
                                                {
                                                    CanEdit1 = "1";
                                                }
                                             }
                             
                                             
                                             if (ApplicationInformation.ProjectDataBaseType == 2) //oracle
                                             {
                                                String Q1 = "INSERT INTO SYS_ACCESSIBILITY_LEVEL2 (SYS_ACCESSIBILITY_LEVEL2_ID,SYS_ACCESSIBILITY_LEVEL1_ID,SYS_OBJECT_CONTROL_ID,CANVIEW,CANEDIT) VALUES (0 ,";   
                                                Q1  += Sys_Accessibility_Level1_ID +",";
                                                Q1  += ControlID +",";
                                                Q1 +=  CanView1; 
                                                Q1 +=  "," + CanEdit1 + ")";
                                                CDataProvider.executeNoneQuery (Q1);
                                             }
                                             else
                                             {
                                                String Q1 = "INSERT INTO SYS_ACCESSIBILITY_LEVEL2 (SYS_ACCESSIBILITY_LEVEL1_ID,SYS_OBJECT_CONTROL_ID,CANVIEW,CANEDIT) VALUES (";
                                                Q1  += Sys_Accessibility_Level1_ID +",";
                                                Q1  += ControlID +",";
                                                Q1 +=  CanView1; 
                                                Q1 +=  "," + CanEdit1 + ")";
                                                CDataProvider.executeNoneQuery (Q1);
                                             }
                               
                             
                             
                             
                          
                             
                            
                           
                             
                             
                                         }
                                     }
                      
                      
                       
                    
                  
                                }         
                              
                                %>

                                <td><input type="submit" id="btn_FullAccess" name="btn_FullAccess" value="ثبت دسترسی کامل" style="font-family:ZFRAMEFONT;width: 150px; height: 40px; background-color: #387038; color:#fafafa; font-size: 12px;" /></td>
                                    <% 
                    
                                    if (request.getParameter("btn_FullAccess") != null) 
                                    {
                  
                                         // Full save 
                    
                    
                            
                            
                                       if (Sys_Accessibility_Level1_ID.trim().length() == 0 )
                                        {
                                            
                                            if (ApplicationInformation.ProjectDataBaseType == 2) //Oracle
                                            {
                                                CDataProvider.executeNoneQuery("INSERT INTO SYS_ACCESSIBILITY_LEVEL1 (Sys_Accessibility_Level1_ID,SYS_OBJECT_ID,SYS_USERGROUP_ID, CANVIEW,CanEdit,CanDelete,CanInsert,CanReport,CanExport) VALUES (0,"+SELECTOBJECTID+","+SELECTGROUPID+",1,1,1,1,1,1)");  
                                            }
                                            else
                                            {
                                                CDataProvider.executeNoneQuery("INSERT INTO SYS_ACCESSIBILITY_LEVEL1 (SYS_OBJECT_ID,SYS_USERGROUP_ID, CANVIEW,CanEdit,CanDelete,CanInsert,CanReport,CanExport) VALUES ("+SELECTOBJECTID+","+SELECTGROUPID+",1,1,1,1,1,1)");  
                                            }
                                           String GetIDAfterInsertQuery  =  " SELECT SYS_ACCESSIBILITY_LEVEL1_ID FROM SYS_ACCESSIBILITY_LEVEL1 WHERE SYS_OBJECT_ID = "+SELECTOBJECTID +" AND SYS_USERGROUP_ID = "+ SELECTGROUPID ;
                                           DataTable GetID = CDataProvider.executeDataTable(GetIDAfterInsertQuery);
                                           if (GetID != null)
                                           {
                                                if (GetID.getRowCount() > 0 )                          
                                                {
                                                          Sys_Accessibility_Level1_ID = GetID.getDataRow(0).getColumnData(0).toString();
                                                }
                                           }
                       
                                        }
                                        else
                                        {
                                            CDataProvider.executeNoneQuery("UPDATE  SYS_ACCESSIBILITY_LEVEL1 SET SYS_OBJECT_ID = "+SELECTOBJECTID+" ,SYS_USERGROUP_ID = "+SELECTGROUPID+" , CANVIEW = 1,CanEdit = 1,CanDelete = 1,CanInsert = 1,CanReport = 1,CanExport = 1 WHERE SYS_ACCESSIBILITY_LEVEL1_ID ="+Sys_Accessibility_Level1_ID );  
                                        }
                    
                  
                                        if (TableControls.getRowCount() > 0 )
                                         {
                                             for (int a=0 ; a < TableControls.getRowCount() ; a++)

                                             {     

                                                 String ControlID = TableControls.getDataRow(a).getColumnData(0).toString();
                                                 DataTable AcLevel2Table= CDataProvider.executeDataTable(" SELECT * FROM SYS_ACCESSIBILITY_LEVEL2 WHERE SYS_ACCESSIBILITY_LEVEL1_ID = "+Sys_Accessibility_Level1_ID +" AND SYS_OBJECT_CONTROL_ID = "+ControlID);
                             
                                                 String ACLV2ID =  "";
                                                 if (AcLevel2Table != null)
                                                 {
                                                     if (AcLevel2Table.getRowCount() > 0)
                                                     {
                                                         ACLV2ID = AcLevel2Table.getDataRow(0).getColumnData(0).toString();
                                                     }
                                                 }
                             
                             
                                                 if ((ACLV2ID.trim().length() > 0  ))
                                                 {
                                                     try 
                                                     {
                                                      long SYS_ACCESSIBILITY_LEVEL2_ID = Long.valueOf(ACLV2ID);
                                  
                                                      CDataProvider.executeNoneQuery("Delete FROM SYS_ACCESSIBILITY_LEVEL2 WHERE SYS_ACCESSIBILITY_LEVEL2_ID ="+ String.valueOf(SYS_ACCESSIBILITY_LEVEL2_ID));
                                                     }
                                                     catch (Exception ex){}
                                 
                                                 }
                             
                             
                             
                                                 String Name1 = "Vcheck"+ControlID.trim();
                                                 String Name2 = "Echeck"+ControlID.trim();
                                                 String VCHECK = request.getParameter(Name1);
                                                 String ECHECK = request.getParameter(Name2);
                   
                                                 String CanView1 = "1";
                                                 String CanEdit1 = "1";
                             
                           
                             
                                                 if (ApplicationInformation.ProjectDataBaseType == 2)
                                                 {
                                                 
                                                     String Q1 = "INSERT INTO SYS_ACCESSIBILITY_LEVEL2 (SYS_ACCESSIBILITY_LEVEL2_ID,SYS_ACCESSIBILITY_LEVEL1_ID,SYS_OBJECT_CONTROL_ID,CANVIEW,CANEDIT) VALUES (0 ,";
                                                        Q1  += Sys_Accessibility_Level1_ID +",";
                                                        Q1  += ControlID +",";
                                                        Q1 +=  CanView1; 
                                                        Q1 +=  "," + CanEdit1 + ")";
                                                        CDataProvider.executeNoneQuery (Q1);
                                                 }
                                                 else
                                                 {
                                                        String Q1 = "INSERT INTO SYS_ACCESSIBILITY_LEVEL2 (SYS_ACCESSIBILITY_LEVEL1_ID,SYS_OBJECT_CONTROL_ID,CANVIEW,CANEDIT) VALUES (";
                                                        Q1  += Sys_Accessibility_Level1_ID +",";
                                                        Q1  += ControlID +",";
                                                        Q1 +=  CanView1; 
                                                        Q1 +=  "," + CanEdit1 + ")";
                                                        CDataProvider.executeNoneQuery (Q1);
                                                 }
                               
                             
                             
                                             }
                                         }
                      
                        
                    
                
                    
                  
                                    }  
                                    %>
                            </tr>

                        </table>
                        <br>
                        <table style="text-align: center; border: 1px solid; border-color: #000; direction: rtl; width: 50%; border-radius:5px; ">
                            <tr style="background-color: #07103C; color: #fafafa;">
                                <td style="font-family:ZFRAMEFONT">ردیف</td>
                                <td style="font-family:ZFRAMEFONT">نام کنترل</td>
                                <td style="font-family:ZFRAMEFONT">قابل مشاهده</td>
                                <td style="font-family:ZFRAMEFONT">قابل ویرایش</td>
                            </tr>


                            <% 
                   
                             if (TableControls.getRowCount() > 0 )
                             {
                                 for (int a=0 ; a < TableControls.getRowCount() ; a++)
                     
                                 {     
                         
                                     String ControlID = TableControls.getDataRow(a).getColumnData(0).toString();
                                     String CanView = "false";
                                     String CanEdit = "false";
                         
                                      DataTable AcLevel2Table= CDataProvider.executeDataTable(" SELECT * FROM SYS_ACCESSIBILITY_LEVEL2 WHERE SYS_ACCESSIBILITY_LEVEL1_ID = "+Sys_Accessibility_Level1_ID +" AND SYS_OBJECT_CONTROL_ID = "+ControlID);
                             
                                         String ACLV2ID =  "";
                                         if (AcLevel2Table != null)
                                         {
                                             if (AcLevel2Table.getRowCount() > 0)
                                             {
                                                 ACLV2ID = AcLevel2Table.getDataRow(0).getColumnData(0).toString();
                                                 CanView = AcLevel2Table.getDataRow(0).getColumnData(3).toString();
                                                 CanEdit = AcLevel2Table.getDataRow(0).getColumnData(4).toString();
                                             }
                                         }
                         
                         
                                     String ACheckView =" " ;
                                     String ACheckEdit =" ";
                         
                                     if (CanEdit.trim().length() > 0 )
                                     {
                                            if (Boolean.valueOf(CanView)|| CanView.equals("1"))
                                            {
                                                ACheckView = "checked";
                                            }

                                            if (Boolean.valueOf(CanEdit)|| CanEdit.equals("1"))
                                            {
                                                ACheckEdit = "checked";
                                            }
                                     }
                         
                                    out.println("<tr>"); 
                                    out.println("<td style=\"font-family:ZFRAMEFONT\">"+ String.valueOf(a+1)  +"</td>");
                                    out.println("<td style=\"font-family:ZFRAMEFONT\">"+TableControls.getDataRow(a).getColumnData(1).toString()+"</td>");                        
                                    out.println("<td>"+"<input type=\"checkbox\" name=\"Vcheck"+ControlID.trim()+"\" id=\"VCheck"+ControlID.trim()+"\"  "+ACheckView+" >"+"</td>");
                                    out.println("<td>"+"<input type=\"checkbox\" name=\"Echeck"+ControlID.trim()+"\" id=\"ECheck"+ControlID.trim()+"\"  "+ACheckEdit+"  >"+"</td>");
                                    out.println("</tr>"); 
                        
                                 }
                             }
                            %>



                        </table>


                        <%
                            if (request.getParameter("btn_CustomAccess") != null) 
                    {
                        out.println("");
                        out.println("<br />");
                        out.println("<div style=\"width: 50%; height: 30px; background-color: #06F; color: #fafafa; text-align: center; font-family: FontYekan; font-size: 20px; border-radius:5px; \">");
                
                    
                                out.println("<span style=\"font-family:ZFRAMEFONT;\" >");
                                out.println("ثبت دسترسی سفارشی با موفقیت انجام گردید");
                                out.println("</span>");
                         
                                out.println("</div>");
                    }
                        
                        %>
                        <%
                        if (request.getParameter("btn_FullAccess") != null) 
                {
                    out.println("");
                    out.println("<br />");
                    out.println("<div style=\"width: 50%; height: 30px; background-color: #387038; color: #fafafa; text-align: center; font-family: FontYekan; font-size: 20px; border-radius:5px; \">");
                
                    
                            out.println("<span  style=\"font-family:ZFRAMEFONT;\" >");
                            out.println("ثبت دسترسی کامل با موفقیت انجام گردید");
                            out.println("</span>");
                         
                            out.println("</div>");
                }
                        
                        %>
                        <%
                        if (request.getParameter("btn_NotAccess") != null) 
                {
                    out.println("");
                    out.println("<br />");
                    out.println("<div style=\"width: 50%; height: 30px; background-color: #CC0000; color: #fafafa; text-align: center; font-family: FontYekan; font-size: 20px; border-radius:5px; \">");
                
                    
                            out.println("<span style=\"font-family:ZFRAMEFONT;\">");
                            out.println("ثبت عدم دسترسی با موفقیت انجام گردید");
                            out.println("</span>");
                         
                            out.println("</div>");
                }
                        
                        %>


                    </td>
                </tr>
            </table>
        </form>
    </body>
</html>
