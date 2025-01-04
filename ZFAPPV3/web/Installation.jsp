<%-- 
    Document   : Installation
    Created on : Jan 25, 2017, 12:11:01 PM
    Author     : Administrator
--%>


<%@page import="zdg.zframe.presentation_layer.interface_rule.CommandRuleManagement"%>
<%@page import="zdg.zframe.configuration.ApplicationInformation"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.BufferedReader"%>


<%@page import="java.io.FileReader"%>


<%@page import="java.text.Normalizer.Form"%>
<%@page import="oracle.net.aso.a"%>
<%@page import="java.io.OutputStream"%>

<%@page import="java.nio.file.StandardCopyOption"%>
<%@page import="java.io.InputStream"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.nio.charset.Charset"%>
<%@page import="java.nio.file.Files"%>
<%@page import="java.nio.file.Paths"%>
<%@page import="java.nio.file.Path"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.PrintWriter"%>

<%@page import="javax.servlet.ServletException"%>
<%@page import=" javax.servlet.annotation.MultipartConfig"%>
<%@page import=" javax.servlet.annotation.WebServlet"%>
<%@page import=" javax.servlet.http.HttpServlet"%>
<%@page import=" javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>
<%@page import="javax.servlet.http.Part"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Z-WEB-CORE-Configuration</title>
    </head>

    <%
      try 
      {
            String AccessID = session.getAttribute ( "UserAccess").toString ();
            if (AccessID.equals("0"))
            {
                response.sendRedirect("setup.jsp");
            }
                
            ApplicationInformation.readDataFromConfigFile();
                
                
      }
      catch (Exception ex)
      {
          response.sendRedirect("setup.jsp");
      }
        
    %>
    <style>
        .InsTable
        {
            border: 1px solid #c5c5c5;    
            margin: 0px 32% 0px 32%;
            font-size: 18px;
            background-color: rgb(221, 223, 224);
            padding: 10px;
            border-bottom-color: black;
            border-top-color: black;
        }

    </style>


    <style type="text/css">
        .form-style-2{
            max-width: 500px;
            padding: 20px 12px 10px 20px;
            font: 15px Arial, Helvetica, sans-serif;
            margin-left:30%;
        }
        .form-style-2-heading{
            font-weight: bold;
            font-style: italic;
            border-bottom: 2px solid #ddd;
            margin-bottom: 20px;
            font-size: 15px;
            padding-bottom: 3px;
        }
        .form-style-2 label{
            display: block;
            margin: 0px 0px 15px 0px;
        }
        .form-style-2 label > span{
            width: 100px;
            font-weight: bold;
            float: left;
            padding-top: 8px;
            padding-right: 5px;
        }
        .form-style-2 span.required{
            color:red;
        }
        .form-style-2 .tel-number-field{
            width: 300px;

        }
        .form-style-2 input.input-field{
            width: 48%;

        }

        .form-style-2 input.input-field, 
        .form-style-2 .tel-number-field, 
        .form-style-2 .textarea-field, 
        .form-style-2 .select-field{
            box-sizing: border-box;
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            border: 1px solid #C2C2C2;
            box-shadow: 1px 1px 4px #EBEBEB;
            -moz-box-shadow: 1px 1px 4px #EBEBEB;
            -webkit-box-shadow: 1px 1px 4px #EBEBEB;
            border-radius: 3px;
            -webkit-border-radius: 3px;
            -moz-border-radius: 3px;
            padding: 7px;
            outline: none;
        }
        .form-style-2 .input-field:focus, 
        .form-style-2 .tel-number-field:focus, 
        .form-style-2 .textarea-field:focus,  
        .form-style-2 .select-field:focus{
            border: 1px solid #0C0;
        }
        .form-style-2 .textarea-field{
            height:100px;
            width: 55%;
        }
        .form-style-2 input[type=submit],
        .form-style-2 input[type=button]{
            border: none;
            padding: 8px 15px 8px 15px;
            background: #3498DB;
            color: #fff;
            box-shadow: 1px 1px 4px #DADADA;
            -moz-box-shadow: 1px 1px 4px #DADADA;
            -webkit-box-shadow: 1px 1px 4px #DADADA;
            border-radius: 3px;
            -webkit-border-radius: 3px;
            -moz-border-radius: 3px;
        }
        .form-style-2 input[type=submit]:hover,
        .form-style-2 input[type=button]:hover{
            background: #024069;
            color: #fff;
        }
        .header{
            background-color: #3498DB;
            width:100%;
            height:30px;
            border-radius:10%;
        }
    </style>

    <body style="background-color: #fafafa;">
        <div class="header"></div>
        <div class="form-style-2">
            <div class="form-style-2-heading"><h1> ZFrame  Configuration </h1></div>
            <table style="width:600px; ">
                <form action="" method="post"  >


                    <% 
           
                              ApplicationInformation.ApplicationBaseAddressOnServer = getServletContext ().getRealPath ("/");                     
                              ApplicationInformation.readDataFromConfigFile();

                              if (!CommandRuleManagement.RuleExist)
                              {
                                   CommandRuleManagement.clearRule();
                                   ;
                              }
          
                    %>

                    <tr>
                        <td><span>Metadata Database Type : <span class="required">*</span></span></td>
                        <td> <select class="tel-number-field" name="DataType" id="DataType" style="    width: 173px;    " value="<% out.println( ApplicationInformation.DataBaseTypeID); %>">
                                <option class="tel-number-field" value="1">MSSQL Server</option>
                                <option class="tel-number-field" value="2">Oracle</option>
                                <option class="tel-number-field" value="3">IBM DB2</option>

                            </select></td>
                    </tr>
                    <tr>

                        <td><span>Metadata Database Jdbc Address : <span class="required">*</span></span></td>
                        <td><input class="tel-number-field" type="text"  name="JDBCadd" id="JDBCadd" value="<% out.println( ApplicationInformation.ProjectConnectionString); %>"/></td>
                    </tr>
                    <tr>
                        <td><span>Metadata Database UserName : <span class="required">*</span></span></td>
                        <td><input class="tel-number-field"  type="text"  name="DataUser" id="DataUser" value="<% out.println( ApplicationInformation.ProjectDataBaseUserName); %>"/></td>
                    </tr>
                    <tr>
                        <td><span>Metadata Database Password : <span class="required">*</span></span></td>
                        <td><input class="tel-number-field"  type="password" name="DataPass" id="DataPass" value="<% out.println(ApplicationInformation.ProjectDataPassPassword); %>"/></td>
                    </tr>
                    <tr>
                        <td><span> Active System ID : <span class="required">*</span></span></td>
                        <td><input class="tel-number-field"  type="text" name="ActiveSystemID" id="ActiveSystemID" value="<% out.println( ApplicationInformation.System_ID); %>"/></td>
                    </tr>
                    <tr>
                        <td><span> Application Web Address : <span class="required">*</span></span></td>
                        <td><input class="tel-number-field"  type="text" name="AppWebAdd" id="AppWebAdd" value="<% out.println(ApplicationInformation.DomainAddressOnWebServer); %>" /></td>
                    </tr>
                    <tr>
                        <td><span> Application Physical address  : <span class="required">*</span></span></td>
                        <td><input class="tel-number-field"  type="text" name="AppPhAdd" id="AppPhAdd" value="<% out.println( getServletContext().getRealPath("/")); %>" disabled="disabled" value="<% out.println(ApplicationInformation.ApplicationBaseAddressOnServer); %>"/></td>
                    </tr>
                    <tr>
                        <td><span>Setup UserName : <span class="required">*</span></span></td>
                        <td><input class="tel-number-field"  type="text" name="SetupUser" id="SetupUser" value="<% out.println( ApplicationInformation.SetupUserName); %>"/></td>
                    </tr>
                    <tr>
                        <td><span>Setup Password : <span class="required">*</span></span></td>
                        <td> <input class="tel-number-field"  type="text" name="SetupPass" id="SetupPass" value="<% out.println(ApplicationInformation.SetupPassword); %>"/></td>
                    </tr>


                    <tr>
                        <td><input type="submit" 
                                   name="btnOK"
                                   id="btnOK"
                                   value="OK"
                                   /></td>
                        <td> 

                        </td>

                    </tr>

                    <td>
                    <td colspan="2"> 



                        <%

                                     String Lblmessage= "";
                                   if (request.getParameter("btnOK") != null) 
                                        {
                                            // On Login Click 
                        
                        
                                                String DataType = request.getParameter("DataType");
                                                String JDBCadd = request.getParameter("JDBCadd");
                                                String DataUser = request.getParameter("DataUser");
                                                String DataPass = request.getParameter("DataPass");
                                                String ActiveSystemID = request.getParameter("ActiveSystemID");
                                                String AppWebAdd = request.getParameter("AppWebAdd");             
                                                String SetupUser = request.getParameter("SetupUser");
                                                String SetupPass = request.getParameter("SetupPass");
                                                //String fileToUpload = request.getParameter("fileToUpload");
                        
                        
                        
                                                if (((DataType != null)&&(JDBCadd != null)&&(DataUser != null)&&(DataPass != null)
                                                        &&(ActiveSystemID != null)&&(AppWebAdd != null)&&(SetupUser != null)
                                                        &&(SetupPass != null)))
                                                    {
                                                    try{
                                                        String BasePath = getServletContext().getRealPath("/");                                
                                                        BasePath +=  "Config.xml";
                                
                                                        BufferedWriter mFile = new BufferedWriter(new FileWriter(BasePath));                
                                                        mFile.write("DataBaseTypeID ="+DataType+"\n");
                                                        mFile.write("DBUserName ="+DataUser+"\n");
                                                        mFile.write("DBPassword ="+DataPass+"\n");
                                                        mFile.write("ProjectConnectionString ="+JDBCadd+"\n");
                                                        mFile.write("System_ID ="+ActiveSystemID+"\n");
                                                        mFile.write("DomainAddressOnWebServer ="+AppWebAdd+"\n");
                                                        mFile.write("ApplicationBaseAddressOnServer ="+BasePath+"\n");
                                                        mFile.write("SetupUserName = "+SetupUser+"\n");
                                                        mFile.write("SetupPassword ="+SetupPass+"\n");
                                                      //  mFile.write(fileToUpload+"\n");
                                                        mFile.close();    
                                                          out.println("<span>Save Config Success</span>");
                                                    } catch (IOException e) {
                                                          // do something
                                                          String s = e.getMessage();
                                                          out.println(s);
                                  
                                                   }
                                             
                                            }

                                        }
        
                        %>

                    </td>

                    </tr> 

                </form>
            </table>
        </div><br>
        <div class="header"></div>

</html>
