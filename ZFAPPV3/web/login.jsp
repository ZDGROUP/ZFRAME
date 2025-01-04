
<%@page import="zdg.zframe.infrastructure.DataConvertor"%>
<%@page import="zdg.zframe.dal.structure.table.Sys_Language"%>
<%@page import="zdg.zframe.configuration.ApplicationInformation"%>
<%@page import="zdg.zframe.diagnostic.DiagnosticViewer"%>
<%@page import="zdg.zframe.diagnostic.UserSessionInformation"%>
<%@page import="zdg.zframe.application_utilities.PersianCalendar"%>
<%@page import="zdg.zframe.infrastructure.DataTable"%>
<%@page import="zdg.zframe.infrastructure.Metadata_DataBase_Handler"%>
<%@page import="zdg.zframe.Dictionary"%>
<%@page import="App.MLOCK"%>
<%@page import="BaseClass.GenerateCaptcha"%>
<%@page import="java.util.ArrayList"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isThreadSafe="false" %>



<!doctype html>
<html lang="fa" xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title> ورود به سامانه </title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
                <script src="ZJBPMS/zfjquery.js" type="text/javascript"></script> 
                <script src="ZJBPMS/zfjquery.ui.core.js" type="text/javascript"></script> 
                <link rel="stylesheet" href="NewWork/css/style.css">
                    <link href="Style/font/font-awesome.min.css" rel="stylesheet" type="text/css"/>
                    <link rel="icon" type="image/png" href="NewWork/images/logo.png" sizes="16x16">
                        <script src="ZJBPMS/zbpms.js" type="text/javascript"></script>


                        <style>
                            @font-face {
                                font-family: "Irancell";
                                src: url('NewWork/fonts/MTNIrancell-Light.ttf') format('truetype');
                            }

                            @font-face {
                                font-family: "Irancell-Light";
                                src: url('NewWork/fonts/MTNIrancell-ExtraLight.ttf') format('truetype');
                            }

                            @font-face {
                                font-family: "Irancell-Bold";
                                src: url('NewWork/fonts/MTNIrancell-Bold.ttf') format('truetype');
                            }

                            .checkbox-primary input:checked ~ .checkmark:after {
                                color: #2c2627;
                            }
                            .form-control{
                                color: #000 !important;
                                border: 1px solid #000;
                                background: rgba(244, 232, 209, 0.08);
                            }

                        </style>
                        </head>
                        <%

                            response.addHeader("X-Frame-Options", "DENY");
                            session.setAttribute("SESSION_ID", request.getSession().getId());
                            session.setAttribute("LID", 0);
                            String Lblmessage = "";

                            boolean NoRule = false;

                            MLOCK.VMlock.lock();
                            try {
                                if (request.getParameter("btn_Login") != null) {

                                    // On Login Click 
                                    Object CaptchaVAlue = session.getAttribute("CC");
                                    boolean TrueCaptcha = false;
                                    boolean LoginLdap = false;
                                    boolean CheckLdap = false;

                                    if (CaptchaVAlue != null) {
                                        String StrCaptcha = CaptchaVAlue.toString();
                                        String DataUserCaptcha = request.getParameter("txtcaptcha");
                                        if (DataUserCaptcha != null && StrCaptcha.equals(DataUserCaptcha)) {
                                            TrueCaptcha = true;
                                        }
                                    }

                                    String UserName = request.getParameter("tbx_UserName");
                                    String Password = request.getParameter("tbx_PassWord");
                                    String LanguageID = request.getParameter("languageid");

                                    String ERP_VENDOR_ID = "0";
                                    String ERP_STORE_ID = "0";
                                    String ERP_WORKER_ID = "0";

                                    if (LanguageID != null) {
                                        session.setAttribute("Language_ID", LanguageID);
                                        session.setAttribute("LID", LanguageID);
                                    }

                    
                                    if ((UserName != null) && (Password != null) && TrueCaptcha && (CheckLdap == LoginLdap)) {
                                        // Check User Validation 
                                        Metadata_DataBase_Handler CDataProvider = new Metadata_DataBase_Handler();
                                        ArrayList<Dictionary> Param = new ArrayList<Dictionary>();
                                        Param.add(new Dictionary("USERNAME", UserName.toLowerCase()));
                                        Param.add(new Dictionary("PASSWORD", Password));
                                        // DataTable Table = CDataProvider.executeDataTableByDictionery(" Select * from SYS_User Where  LOWER(UserName) = @STRUSERNAME and [Password] = HASHBYTES('SHA2_256', @STRPASSWORD )  ",Param ); // MSSQL WITH HASH 
                                        // DataTable Table = CDataProvider.executeDataTableByDictionery(" Select * from SYS_User Where  LOWER(UserName) = @STRUSERNAME and    ( Password =  HASH_MD5( @STRPASSWORD  ) or Password =   @STRPASSWORD  )  AND ACTIVE = 1  ",Param );  //ORACLE  
                                        DataTable Table = CDataProvider.executeDataTableByDictionery(" Select * from SYS_User Where  LOWER(UserName) = @STRUSERNAME and  Password =   @STRPASSWORD   ", Param);  // DEFUALT SYSTEM 

                                        if (Table != null) {
                                            if (Table.getRowCount() == 1) {
                                                if (1 == 1 || LoginLdap) {

                                                    String NowDate = PersianCalendar.getCurrentShamsidate();

                                                    // User Can Login                                                    
                                                    String UserID = Table.getDataRow(0).getColumnData(0).toString();
                                                    String ApplicationEntityID = Table.getDataRow(0).getColumnData(4).toString();

                                                    try {
                                                        ERP_VENDOR_ID = Table.getDataRow(0).getColumnData(12).toString();
                                                    } catch (Exception ex) {
                                                    }
                                                    try {
                                                        ERP_STORE_ID = Table.getDataRow(0).getColumnData(13).toString();
                                                    } catch (Exception ex) {
                                                    }

                                                    try {
                                                        ERP_WORKER_ID = Table.getDataRow(0).getColumnData(14).toString();
                                                    } catch (Exception ex) {
                                                    }

                                                    String remoteAddr = "";

                                                    if (request != null) {
                                                        remoteAddr = request.getHeader("X-FORWARDED-FOR");
                                                        if (remoteAddr == null || "".equals(remoteAddr)) {
                                                            remoteAddr = request.getRemoteAddr();
                                                        }
                                                    }

                                                    String IpAddress = remoteAddr;
                                                    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("HH:mm:ss");
                                                    LocalDateTime now = LocalDateTime.now();
                                                    String TimeV = dtf.format(now);

                                                    UserSessionInformation CSessionInformation = new UserSessionInformation();
                                                    CSessionInformation.EndFormView = "";
                                                    CSessionInformation.IpAddress = IpAddress;
                                                    CSessionInformation.LoginTime = TimeV;
                                                    CSessionInformation.SessionID = request.getSession().getId();
                                                    CSessionInformation.UserName = UserName;
                                                    CSessionInformation.UserID = UserID;
                                                    CSessionInformation.RequestCount = 0;

                                                    try {
                                                        CSessionInformation.WebBrowser = request.getHeader("User-Agent");
                                                    } catch (Exception ex) {
                                                        CSessionInformation.WebBrowser = "NotDefine";
                                                    }
                                                    DiagnosticViewer.addSessionInformation(CSessionInformation);

                                                    if (ApplicationInformation.ProjectDataBaseType == 2) {
                                                        String Query = " INSERT INTO Sys_Connection_Log ( SYS_CONNECTION_LOG_ID,SYS_User_ID, UserName,UserPass,Connection_Date,Connection_Time,IP_Address,Mac_Address,ExitDate,ExitTime) VALUES ";
                                                        Query += "(0 , " + UserID + ",'-','-','" + NowDate + "','" + TimeV + "','" + IpAddress + "','-','N','N') ";
                                                        CDataProvider.executeNoneQuery(Query);
                                                    } else {
                                                        String Query = " INSERT INTO Sys_Connection_Log ( SYS_User_ID, UserName,UserPass,Connection_Date,Connection_Time,IP_Address,Mac_Address,ExitDate,ExitTime) VALUES ";
                                                        Query += "(" + UserID + ",'-','-','" + NowDate + "','" + TimeV + "','" + IpAddress + "','-','N','N') ";
                                                        CDataProvider.executeNoneQuery(Query);
                                                    }

                                                    String MaxQ = "Select Max(Sys_Connection_Log_ID) From Sys_Connection_Log Where SYS_User_ID =" + UserID;
                                                    String LogID = CDataProvider.executeQueryForGetObject(MaxQ).toString();

                                                    DataTable UserAccessList = CDataProvider.executeDataTable("  SELECT * FROM SYS_USERGROUPLIST  WHERE SYS_USERGROUP_ID = 1  AND SYS_USER_ID =" + UserID);
                                                    if (UserAccessList.getRowCount() > 0) {
                                                        session.setAttribute("ISADMIN", "1");
                                                        session.setAttribute("BID", "1");
                                                        session.setAttribute("CID", "1");
                                                        session.setAttribute("PID", "1");
                                                        ;
                                                    } else {
                                                        session.setAttribute("ISADMIN", "0");
                                                        session.setAttribute("BID", "1");
                                                        session.setAttribute("CID", "1");
                                                        session.setAttribute("PID", "1");

                                                    }

                                                    session.setAttribute("UserName", UserName);

                                                    session.setAttribute("Connection_Log_ID", LogID);
                                                    session.setAttribute("ENTITY_ID", ApplicationEntityID);
                                                    session.setAttribute("USER_ID", UserID);
                                                    session.setAttribute("user_id", UserID);
                                                    session.setAttribute("User_ID", UserID);

                                                    if (LanguageID != null) {

                                                        DataTable TableLanguage = CDataProvider.executeDataTable("select * from Sys_Language  where Sys_Language_ID = " + LanguageID);
                                                        if (TableLanguage != null) {
                                                            if (TableLanguage.getRowCount() > 0) {
                                                                DataConvertor<Sys_Language> LConvertr = new DataConvertor<Sys_Language>();
                                                                ArrayList<Sys_Language> LanguageList = LConvertr.convert(TableLanguage, Sys_Language.class);
                                                                int Ltr = LanguageList.get(0).LTR;
                                                                session.setAttribute("LTR", Ltr);
                                                                session.setAttribute("Language_ID", LanguageID);
                                                                session.setAttribute("LNG", LanguageList.get(0));

                                                            }
                                                        }
                                                    }

                                                    String QueryCheckUserRule = "SELECT Sys_UserGroup_ID FROM Sys_UserGroupList  WHERE Sys_User_ID = @LNGUSERID ";
                                                    ArrayList<Dictionary> ParamRule = new ArrayList<Dictionary>();
                                                    ParamRule.add(new Dictionary("USERID", UserID));
                                                    DataTable CTableRule = CDataProvider.executeDataTableByDictionery(QueryCheckUserRule, ParamRule);
                                                    if (CTableRule != null) {
                                                        if (CTableRule.getRowCount() == 1) {
                                                            session.setAttribute("ROLE_ID", CTableRule.getDataRow(0).getColumnData(0).toString());
                                                            //    session.setAttribute("Language_ID", 2);
                                                            response.sendRedirect("Default.jsp");
                                                        } else if (CTableRule.getRowCount() > 1) {
                                                            response.sendRedirect("SelectRule.jsp");
                                                        } else {
                                                            NoRule = true;
                                                            Lblmessage = "در سامانه برای شما نقشی تعریف نشده است ";
                                                        }
                                                    }

                                                }
                                            }
                                        }
                                    }

                                    if (!NoRule) {
                                        Lblmessage = ".نام کاربری یا کلمه عبور اشتباه می باشد ";
                                    }

                                    if (!TrueCaptcha) {

                                        Lblmessage = "کد وارد شده در تصویر اشتباه میباشد ";
                                    }
                                }
                            } catch (Exception exx) {

                            } finally {
                                MLOCK.VMlock.unlock();
                            }


                        %>
                        <body  style="background-color: #024ca1" >



                            <br>


                                <div class="container" style="background-color: #fff;  ">
                                    <br>

                                        <h6 ID="lbl_Warning" Name="lbl_Warning" class="mb-4 text-center" style="font-family: 'Irancell-Bold';color: #2c2627;">
                                            <%  out.print(ApplicationInformation.ApplicationName);  %>
                                        </h6>


                                        <h6 class="mb-4 text-center" style="font-family: 'Irancell-Bold';color: #2c2627;">ورود کاربران</h6>


                                        <h6 ID="lbl_Warning" Name="lbl_Warning" class="mb-4 text-center" style="font-family: 'Irancell-Bold';color: #2c2627;">
                                            <%  out.print(Lblmessage);  %>
                                        </h6>

                                        <center> 
                                            <table style="border-radius:10px;border-color: #000;" >
                                                <tr>

                                                    <td align="right" style="vertical-align: middle">
                                                        <img src="Images/LeftLogin.png" >

                                                    </td>
                                                    <td style="width: 10px;">

                                                    </td>
                                                    <td align="left" style="vertical-align: middle">
                                                        <br>
                                                            <form id="frmLogin" method="post" class="signin-form">
                                                                <div class="form-group">
                                                                    <input type="text" class="form-control" style="direction: rtl;font-family: 'Irancell-Light';"  ID="tbx_UserName" name="tbx_UserName" placeholder="نام کاربری" required>
                                                                </div>
                                                                <div class="form-group">
                                                                    <input id="password-field" type="password" class="form-control" style="direction: rtl;font-family: 'Irancell-Light'; color: #f4e8da;" ID="tbx_PassWord" name="tbx_PassWord" placeholder="رمز عبور" required>
                                                                        <span toggle="#password-field" class="fa fa-fw fa-eye field-icon toggle-password" ></span>
                                                                </div>

                                                                <div class="form-group">
                                                                    <center>
                                                                        <%

                                                                            try {

                                                                                MLOCK.VMlock.lock();
                                                                                GenerateCaptcha CCh = new GenerateCaptcha();
                                                                                String CaptchValue = CCh.GenerateCaptchString();
                                                                                session.setAttribute("CC", CaptchValue);
                                                                                String data = CCh.GetImage(CaptchValue);
                                                                                out.print("<img style=\"width:300px;\" src=\"data:image/png;base64," + data + "\" alt=\"captcha\" />");
                                                                            } catch (Exception ex) {

                                                                            } finally {
                                                                                MLOCK.VMlock.unlock();
                                                                            }

                                                                        %>
                                                                    </center>
                                                                </div>

                                                                <div class="form-group">

                                                                    <input type="text" class="form-control" style="direction: rtl;font-family: 'Irancell-Light';"  ID="tbx_UserName" name="txtcaptcha" placeholder="کد تصویر " required>

                                                                </div>


                                                                <div class="form-group">
                                                                    <button type="submit" id="btn_Login"  name="btn_Login" value="ورود به سیستم" class="form-control btn submit px-3" style="font-family: 'Irancell';background-color: #000;border: 1px solid #ffc16c; color: #fff !important;">ورود</button>
                                                                </div>
                                                                <br>
                                                                    <br>

                                                                        </form>

                                                                        </td>


                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="3" style="text-align: left">
                                                                                <a href="http://zdgroup.ir" > <span class="Title" style="color:#000;"> POWERED BY ZFRAME </span> </a>
                                                                            </td>
                                                                        </tr>
                                                                        </table>

                                                                        </center>        

                                                                        <br>

                                                                            </div>
                                                                            </div>


                                                                            <script src="NewWork/js/popper.js"></script>
                                                                            <script src="NewWork/js/bootstrap.min.js"></script>



                                                                            </body>
                                                                            </html>

