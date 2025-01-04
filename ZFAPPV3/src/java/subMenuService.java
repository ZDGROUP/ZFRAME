/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import zdg.zframe.dal.structure.table.Sys_Object;
import zdg.zframe.dal.structure.table.Sys_WorkFlow;

import zdg.zframe.Dictionary;
import  zdg.zframe.infrastructure.DataConvertor;
import  zdg.zframe.infrastructure.DataTable;
import  zdg.zframe.infrastructure.Metadata_DataBase_Handler;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.UUID;
import javax.servlet.AsyncContext;
import javax.servlet.AsyncEvent;
import javax.servlet.AsyncListener;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import myReport.TestServlet;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import zdg.zframe.aspect.log.LIB_ASPECT;
import zdg.zframe.configuration.ApplicationInformation;
import zdg.zframe.diagnostic.CacheManagement;
import zdg.zframe.diagnostic.Debuging;
import zdg.zframe.engine_interface_rule.Engine_Form_Access_Rule;
import zdg.zframe.gatway.web.servlet.API;
import zdg.zframe.multilingual.LanguageDictionary;
import zdg.zframe.presentation_layer.UIFromFactory;
import zdg.zframe.presentation_layer.web.ZWebPage;

/**
 *
 * @author Siavash
 */
@WebServlet(asyncSupported = true, urlPatterns = {"/subMenuService"})
@MultipartConfig
public class subMenuService
        extends HttpServlet {

    private Metadata_DataBase_Handler CDataProvider;
    private int Language_ID = 0;
    private ArrayList<zdg.zframe.dal.structure.table.Sys_Object> SYS_OBJECT_LIST = null;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response, int type)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        int Http_Success_Message = 200;
        int Http_Internal_error = 500;
        int Http_Access_error = 400;

        ZWebPage ChannelContext = new  ZWebPage (request, response);

        CDataProvider = new Metadata_DataBase_Handler();
         zdg.zframe.infrastructure.DataTable RestFunctionlistTable = null;
        ArrayList<zdg.zframe.dal.structure.table.Sys_REST_Function> FunctionList = null;
        CacheManagement CCacheManagement = new CacheManagement();
        String StartRequest = API.getCurrentTimeStamp();
        String OldValidOTP = "";
        String NewValidOTP = "";
        String ClientOtpSendValue = "";
        boolean OTPValidation = true;
        JSONObject jo = null;
        String JsonPassData = "";
        String Data = ChannelContext.getRequestData();
        JsonPassData = Data;
        if (Data == null) {
            Data = "";
        }

        if (Data.length() > 0) {

            try {
                LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Information, Data, 50, "REST_API body For Sub Menu  "); // view for data log (input data ) Add In version  4001-57
                Object obj = new JSONParser().parse(Data);
                jo = (JSONObject) obj;
                String ParentMenuID = (String) jo.get("pid");
                String MenuType = (String) jo.get("tid"); // Vertical horizontal

                String Q_LoadWorkFlowListByUserID = "  select DISTINCT WF.* From Sys_WorkFlow   WF "
                        + "  Inner Join Sys_WorkflowUserGroup  WFUG on  WF.Sys_Workflow_ID = WFUG.Sys_Workflow_ID  "
                        + "  inner join Sys_UserGroupList  UGL  on UGL.Sys_UserGroup_ID = WFUG.Sys_UserGroup_ID  Where WF.Active = 1 And Parent_ID = @LNGPARENTID   And SYS_User_ID =   @LNGUSERID   Order by IndexNumber ";

                String Q_WorkFlowInformation = " select * from  Sys_WorkFlow where sys_workFlow_ID = @LNGPARENTID ";
                
                ArrayList<zdg.zframe.Dictionary> ParamList = new ArrayList<>();
                ParamList.add(new Dictionary("USERID", ChannelContext.getTokenValue("USER_ID").toString()));
                ParamList.add(new Dictionary("PARENTID", ParentMenuID));
                DataTable TableWorkFlowList = CDataProvider.executeDataTableByDictionery(Q_LoadWorkFlowListByUserID, ParamList);
                DataTable TblInfo = CDataProvider.executeDataTableByDictionery(Q_WorkFlowInformation, ParamList);
                
                
                DataConvertor<zdg.zframe.dal.structure.table.Sys_WorkFlow> Convert = new DataConvertor<>();
                ArrayList<zdg.zframe.dal.structure.table.Sys_WorkFlow> WorkFlowList = Convert.convert(TableWorkFlowList, zdg.zframe.dal.structure.table.Sys_WorkFlow.class);
                ArrayList<zdg.zframe.dal.structure.table.Sys_WorkFlow> WorkFlowListinfo = Convert.convert(TblInfo, zdg.zframe.dal.structure.table.Sys_WorkFlow.class);
                
                
                StringBuilder MainContent = new StringBuilder();
                MainContent.append("<div id=\"mainsubmenu\" class=\"submenu\">");
                MainContent.append("<table style=\"width:100%;\"><tr><td><span class=\"topmenulabel\">"+WorkFlowListinfo.get(0).FormName +"</span></td></tr></table>");
                MainContent.append("<table style=\"width:100%;\"><tr>");
                for (int a = 0; a < WorkFlowList.size(); a++) 
                {
                        MainContent.append("<td>");
                          MainContent.append("<table style=\"width:100%\">");
                                MainContent.append("<tr>");
                                     MainContent.append("<td style=\"width:100%\">");
                                        MainContent.append("<span >"+ WorkFlowList.get(a).FormName +"</span>");
                                     MainContent.append("</td>");
                                MainContent.append("</tr>");
                                
                                 StringBuilder Sbf = new StringBuilder();
                                 AddChildFormToWorkFlowList(Sbf,WorkFlowList.get(a).Sys_Workflow_ID,ChannelContext);
                                  
                                 if (Sbf.toString().trim().length() >0 )
                                  {
                                        MainContent.append("<tr>");
                                             MainContent.append("<td style=\"width:100%\">");
                                                 MainContent.append(Sbf.toString());    
                                             MainContent.append("</td>");
                                        MainContent.append("</tr>");
                                  }
                                  
                                MainContent.append("<tr>");
                                     MainContent.append("<td style=\"width:100%\">");
                                     StringBuilder Sb = new StringBuilder();
                                       AddChildWorkFlow(Sb,WorkFlowList.get(a),ChannelContext);
                                       MainContent.append(Sb.toString());
                                     MainContent.append("</td>");
                                MainContent.append("</tr>");
                                
                          MainContent.append("</table>");
                        MainContent.append("</td>");
                }
                
                StringBuilder SbtopForm = new StringBuilder();
                 AddChildFormToWorkFlowList(SbtopForm,Integer.valueOf(ParentMenuID),ChannelContext);
                MainContent.append(SbtopForm.toString());
                MainContent.append("</tr></table>");
                MainContent.append("</div>");
                
                ChannelContext.getHttpServletResponse().getWriter().write(MainContent.toString());
            } catch (Exception ex) {
                LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Error, ex.getMessage(), 100, ex);
            }
        }

    }

    private void AddChildWorkFlow(StringBuilder MainContent, Sys_WorkFlow WorkFlow, ZWebPage Context) {
        
         String Q_LoadWorkFlowListByUserID = "  select DISTINCT WF.* From Sys_WorkFlow   WF "
                        + "  Inner Join Sys_WorkflowUserGroup  WFUG on  WF.Sys_Workflow_ID = WFUG.Sys_Workflow_ID  "
                        + "  inner join Sys_UserGroupList  UGL  on UGL.Sys_UserGroup_ID = WFUG.Sys_UserGroup_ID  Where WF.Active = 1 And Parent_ID = @LNGPARENTID   And SYS_User_ID =   @LNGUSERID   Order by IndexNumber ";

                ArrayList<zdg.zframe.Dictionary> ParamList = new ArrayList<>();
                ParamList.add(new Dictionary("USERID", Context.getTokenValue("USER_ID").toString()));
                ParamList.add(new Dictionary("PARENTID", WorkFlow.Sys_Workflow_ID));
                DataTable TableWorkFlowList = CDataProvider.executeDataTableByDictionery(Q_LoadWorkFlowListByUserID, ParamList);
                DataConvertor<zdg.zframe.dal.structure.table.Sys_WorkFlow> Convert = new DataConvertor<>();
                ArrayList<zdg.zframe.dal.structure.table.Sys_WorkFlow> WorkFlowList = Convert.convert(TableWorkFlowList, zdg.zframe.dal.structure.table.Sys_WorkFlow.class);
                
                if (WorkFlowList.size() > 0)
                {
                    MainContent.append("<div id=\"mainsubmenu\" class=\"submenu\">");
                    MainContent.append("<table style=\"width:100%;\"><tr>");
                    for (int a = 0; a < WorkFlowList.size(); a++) 
                    {
                            MainContent.append("<td>");
                              MainContent.append("<table style=\"width:100%\">");
                                    MainContent.append("<tr>");
                                         MainContent.append("<td style=\"width:100%\">");
                                            MainContent.append("<span>"+ WorkFlowList.get(a).Name +"</span>");
                                         MainContent.append("</td>");
                                    MainContent.append("</tr>");

                                     StringBuilder Sbf = new StringBuilder();
                                     AddChildFormToWorkFlowList(Sbf,WorkFlowList.get(a).Sys_Workflow_ID,Context);

                                     if (Sbf.toString().trim().length() >0 )
                                      {
                                            MainContent.append("<tr>");
                                                 MainContent.append("<td style=\"width:100%\">");
                                                     MainContent.append(Sbf.toString());    
                                                 MainContent.append("</td>");
                                            MainContent.append("</tr>");
                                      }

                                    MainContent.append("<tr>");
                                         MainContent.append("<td style=\"width:100%\">");
                                         StringBuilder Sb = new StringBuilder();
                                           AddChildWorkFlow(Sb,WorkFlowList.get(a),Context);
                                           MainContent.append(Sb.toString());
                                         MainContent.append("</td>");
                                    MainContent.append("</tr>");

                              MainContent.append("</table>");
                            MainContent.append("</td>");
                    }
                    MainContent.append("</tr></table>");
                    MainContent.append("</div>");
                }

    }

    private void AddChildFormToWorkFlowList(StringBuilder ContextData, int Sys_WorkFlow_ID  , ZWebPage Context) {
        
        boolean HaveCHild = false;
        DataTable FormTableList = CDataProvider.executeDataTableWithoutLog(" select * from Sys_WorkflowForm Where Sys_Workflow_ID = " + String.valueOf(Sys_WorkFlow_ID) + " And Active = 1  Order By IndexNumber ");
        if (FormTableList != null && FormTableList.getRowCount() > 0) {
            DataConvertor<zdg.zframe.dal.structure.table.Sys_WorkflowForm> WorkFlowFormList = new DataConvertor<>();
            ArrayList<zdg.zframe.dal.structure.table.Sys_WorkflowForm> FormList = WorkFlowFormList.convert(FormTableList, zdg.zframe.dal.structure.table.Sys_WorkflowForm.class);
           
            ContextData.append("<Table style=\"width:100%\"><tr>");
            for (int a = 0; a < FormList.size(); a++) {

                boolean UserHaveAccess = false;
                DataTable CountTable = CDataProvider.executeDataTableWithoutLog(" SELECT SYS_OBJECT_ID FROM SYS_OBJECT WHERE SYS_OBJECT_ID = " + String.valueOf(FormList.get(a).Sys_Object_ID) + " AND AUTHENTICATION = 0 ");
                if (CountTable != null) {
                    if (CountTable.getRowCount() > 0) {
                        UserHaveAccess = true;
                    }
                }

                if (!UserHaveAccess) {

                    ///Start  Check With Service 
                    // Check Data in Cash 
                    boolean Call_Custom_Service = false;
                    if (UIFromFactory.Custom_Security_Management_Rule != null) {
                        try {
                            Object CashData = Context.getTokenValue("M_CCF" + FormList.get(a).Sys_Object_ID);
                            if (CashData == null) {
                                Call_Custom_Service = true;
                            }
                        } catch (Exception exxx) {
                            Call_Custom_Service = true;
                        }

                        if (Call_Custom_Service) {
                            if (UIFromFactory.Custom_Security_Management_Rule != null) {
                                try {
                                    UIFromFactory CFactory = new UIFromFactory();
                                    Sys_Object PassObject = new Sys_Object();
                                    PassObject.Sys_Object_ID = FormList.get(a).Sys_Object_ID;
                                    CFactory.Sys_Object = PassObject;
                                    Engine_Form_Access_Rule.Form_Security_Policy_Struct Service_Security_Data = UIFromFactory.Custom_Security_Management_Rule.manageSecurityPolicy(CFactory, true);
                                    // Check Condition 
                                    if (Service_Security_Data.Level1 != null) {
                                        if (Service_Security_Data.Level1.CanView) {
                                            UserHaveAccess = true;
                                        }
                                    }

                                } catch (Exception exxx) {
                                    LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Error, Context.IPAddress + "Error :" + exxx.getMessage(), 1001, "UI_FORM_FACTOTY : Custom Security Management Rule  " + " Workflow Viewer  ", exxx);
                                }
                            }
                        }
                    }

                    // End 
                    if (!UserHaveAccess) {
                        // Check by SYS_ACCESSIBILITY_LEVEL1_ID
                        String QueryForCheck = "Select  Sys_Accessibility_Level1.Sys_Accessibility_Level1_ID  from Sys_Accessibility_Level1 \n"
                                + "Inner join Sys_UserGroupList On Sys_UserGroupList.Sys_UserGroup_ID = Sys_Accessibility_Level1.Sys_UserGroup_ID\n"
                                + "where  Sys_Accessibility_Level1.Sys_Object_ID = " + String.valueOf(FormList.get(a).Sys_Object_ID) + " and Sys_UserGroupList.Sys_User_ID = " + String.valueOf(Context.getTokenValue("USER_ID").toString()) + " and Sys_Accessibility_Level1.CanView = 1";

                        DataTable CheckAuthentication = CDataProvider.executeDataTableWithoutLog(QueryForCheck);
                        if (CheckAuthentication != null) {
                            if (CheckAuthentication.getRowCount() > 0) {
                                UserHaveAccess = true;
                            }
                        }

                    }
                }

                // Check condiation For Add Child 
                if (UserHaveAccess) {

                    ContextData.append("<td>");
                    HaveCHild = true;
                    String NameCaption = LanguageDictionary.getTranslateText(Language_ID, 3, FormList.get(a).Sys_WorkflowForm_ID);
                    if (NameCaption != null) {
                        FormList.get(a).PanelID = NameCaption;
                    }

                    if (SYS_OBJECT_LIST != null) {
                        for (int q = 0; q < SYS_OBJECT_LIST.size(); q++) {
                            if (SYS_OBJECT_LIST.get(q).Sys_Object_ID == FormList.get(a).Sys_Object_ID) {
                                if (SYS_OBJECT_LIST.get(q).ConcurrencyMode > 0) {
                                    break;
                                }
                            }
                        }
                    }

                    String Img = ApplicationInformation.DomainAddressOnWebServer + "Images/WorkFlow/img-form.png";

                    String ImagePath = ApplicationInformation.ApplicationBaseAddressOnServer + "/Images/UserData/WorkFlowForm/" + String.valueOf(FormList.get(a).Sys_WorkflowForm_ID) + ".jpg";
                    File f = new File(ImagePath);
                    if (f.exists() && !f.isDirectory()) {
                        Img = ApplicationInformation.DomainAddressOnWebServer + "Images/UserData/WorkFlowForm/" + String.valueOf(FormList.get(a).Sys_WorkflowForm_ID) + ".jpg";
                    }

                    ContextData.append("<table>");
                        ContextData.append("<tr>");
                          ContextData.append("<td>");
                            ContextData.append("<img src=\""+Img+"\">");
                          ContextData.append("</td>");
                          ContextData.append("<td>");
                           ContextData.append("<a href=\"javascript:openWindowsInNewTabNavigation('"+FormList.get(a).Sys_Object_ID+"','tabidfrom"+FormList.get(a).Sys_Object_ID+"','"+NameCaption+"',this);HiddenDivTop();\" >"+NameCaption+"</a>");
                          ContextData.append("</td>");
                        ContextData.append("</tr>");
                    ContextData.append("</table>");
                    ContextData.append("</td>");
                }

            }
            
            ContextData.append("</tr></table>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        final AsyncContext asyncContext = request.startAsync();
        asyncContext.setTimeout(ApplicationInformation.ServiceTimeOut);
        asyncContext.addListener(new AsyncListener() {

            @Override
            public void onTimeout(AsyncEvent arg0) throws IOException {
               LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Default, "  onTimeout... Get ", 100, " AsyncListener SubMenuProcess ");
            }

            @Override
            public void onStartAsync(AsyncEvent arg0) throws IOException {
                LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Default, "onStartAsync... Get ", 100, " AsyncListener SubMenuProcess  ");
            }

            @Override
            public void onError(AsyncEvent arg0) throws IOException {
                LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Error, "onError... Get ", 100, " AsyncListener SubMenuProcess ");
            }

            @Override
            public void onComplete(AsyncEvent arg0) throws IOException {
                LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Default, "onComplete... Get ", 100, " AsyncListener  SubMenuProcess ");

            }
        });

        asyncContext.start(new Runnable() {
            @Override
            public void run() {

                Thread.currentThread().setName("CHAIN_" + UUID.randomUUID().toString());
                //===================================================================================
                String T1 = "";
                String T2 = "";
                if (!CacheManagement.CacheUsing) {
                    T1 = API.getCurrentTimeStamp();
                }
                //===================================================================================

                try {

                    HttpServletRequest Arequest = (HttpServletRequest) asyncContext.getRequest();
                    HttpServletResponse Aresponse = (HttpServletResponse) asyncContext.getResponse();
                    String PageAddress = Arequest.getRequestURI();
                    LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Default, "Start Request  :" + PageAddress, 100, " AsyncSupported Request Get  ");

                    Aresponse.setContentType("text/html;charset=UTF-8");
                    Arequest.setCharacterEncoding("UTF-8");
                    Aresponse.setCharacterEncoding("UTF-8");

                    //String clientOrigin = request.getHeader("origin");
                    //response.setHeader("Access-Control-Allow-Origin", clientOrigin);
                    Aresponse.setHeader("Access-Control-Allow-Origin", "*");
                    Aresponse.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, PUT, DELETE, HEAD");
                    Aresponse.setHeader("Access-Control-Allow-Headers", "x-requested-with,X-PINGOTHER ,Content-Type, origin, authorization, accept, client-security-token");
                    Aresponse.setHeader("Access-Control-Max-Age", "1728000");
                    processRequest(Arequest, Aresponse, 1);

                    // finish asynchronous 
                    //===================================================================================
                    if (!CacheManagement.CacheUsing) {
                        T2 = TestServlet.getCurrentTimeStamp();
                        long Def = TestServlet.differenceTime(T1, T2);
                        String Code = UUID.randomUUID().toString();

                        Debuging.DebugList.put(Code, "<tr> <td style=\"background-color:#ff0;width:300px\"> <span class=\"Title\"  >" + T2 + "</span></td><td style=\"background-color:" + TestServlet.getHtmlColorFromMilisecond(Def) + ";width:90%;\" > <span class=\"Title\"  > Page Load Get [" + String.valueOf(Def) + "]:milliseconds Execute " + PageAddress + "</span></td></tr>");
                    }
                    //===================================================================================

                } catch (Exception e) {
                    LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Error, "Error :" + e.getMessage() + " :" + request.getRequestURI().toLowerCase(), 100, " AsyncSupported Request Get *ZJS ", e);

                }
                asyncContext.complete();
            }
        });

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        final AsyncContext asyncContext = request.startAsync();
        asyncContext.setTimeout(ApplicationInformation.ServiceTimeOut);
        asyncContext.addListener(new AsyncListener() {

            @Override
            public void onTimeout(AsyncEvent arg0) throws IOException {
               LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Default, "  onTimeout... Post ", 100, " AsyncListener SubMenuProcess ");
            }

            @Override
            public void onStartAsync(AsyncEvent arg0) throws IOException {
               LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Default, "onStartAsync... Post ", 100, " AsyncListener SubMenuProcess  ");
            }

            @Override
            public void onError(AsyncEvent arg0) throws IOException {
               LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Error, "onError... Post ", 100, " AsyncListener SubMenuProcess ");
            }

            @Override
            public void onComplete(AsyncEvent arg0) throws IOException {
                LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Default, "onComplete... Post ", 100, " AsyncListener  SubMenuProcess ");

            }
        });

        asyncContext.start(new Runnable() {
            @Override
            public void run() {

                Thread.currentThread().setName("CHAIN_" + UUID.randomUUID().toString());
                //===================================================================================
                String T1 = "";
                String T2 = "";
                if (! CacheManagement.CacheUsing) {
                    T1 = TestServlet.getCurrentTimeStamp();
                }
                //===================================================================================

                try {

                    HttpServletRequest Arequest = (HttpServletRequest) asyncContext.getRequest();
                    HttpServletResponse Aresponse = (HttpServletResponse) asyncContext.getResponse();
                    String PageAddress = Arequest.getRequestURI();
                    LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Default, "Start Request  :" + PageAddress, 100, " AsyncSupported Request Post  ");

                    Aresponse.setContentType("text/html;charset=UTF-8");
                    Arequest.setCharacterEncoding("UTF-8");
                    Aresponse.setCharacterEncoding("UTF-8");

                    // List<String> incomingURLs = Arrays.asList(getServletContext().getInitParameter("incomingURLs").trim().split(","));
                    Aresponse.setHeader("Access-Control-Allow-Origin", "*");
                    Aresponse.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, PUT, DELETE, HEAD");
                    Aresponse.setHeader("Access-Control-Allow-Headers", "x-requested-with,X-PINGOTHER ,Content-Type, origin, authorization, accept, client-security-token");
                    Aresponse.setHeader("Access-Control-Max-Age", "1728000");

                    processRequest(Arequest, Aresponse, 2);

                    // finish asynchronous 
                    //===================================================================================
                    if (!CacheManagement.CacheUsing) {
                        T2 = TestServlet.getCurrentTimeStamp();
                        long Def = TestServlet.differenceTime(T1, T2);
                        String Code = UUID.randomUUID().toString();

                        Debuging.DebugList.put(Code, "<tr> <td style=\"background-color:#ff0;width:300px\"> <span class=\"Title\"  >" + T2 + "</span></td><td style=\"background-color:" + TestServlet.getHtmlColorFromMilisecond(Def) + ";width:90%;\" > <span class=\"Title\"  > Page Load Get [" + String.valueOf(Def) + "]:milliseconds Execute " + PageAddress + "</span></td></tr>");
                    }
                    //===================================================================================

                } catch (Exception e) {
                    LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Error, "Error :" + e.getMessage() + " :" + request.getRequestURI().toLowerCase(), 100, " AsyncSupported Request POST *ZJS ", e);

                }
                asyncContext.complete();
            }
        });

    }

    @Override
    public String getServletInfo() {
        return "sub menu information ";
    }// </editor-fold>

}
