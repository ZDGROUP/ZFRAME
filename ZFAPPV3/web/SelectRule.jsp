


<%@page import="zdg.zframe.infrastructure.DataTable"%>
<%@page import="zdg.zframe.Dictionary"%>
<%@page import="zdg.zframe.infrastructure.Metadata_DataBase_Handler"%>
<%@page import="zdg.zframe.configuration.ApplicationInformation"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title> ورود به سامانه  </title>


            <script src="ZJBPMS/jquery-1.6.2.min.js" type="text/javascript"></script>
            <script src="ZJBPMS/jquery.ui.core.js" type="text/javascript"></script>
            <script src="ZJBPMS/jquery.ui.datepicker-cc-fa.js" type="text/javascript"></script>
            <script src="ZJBPMS/jquery.ui.datepicker-cc.js" type="text/javascript"></script>
            <script src="ZJBPMS/calendar.all.js" type="text/javascript"></script>
            <script src="ZJBPMS/calendar.js" type="text/javascript"></script>
            <script src="ZJBPMS/zbpms.js" type="text/javascript"></script> 
            
            <link type="text/css" href="Style/jquery-ui-1.8.14.css" rel="stylesheet" />
            <link href="Style/Main.css" rel="stylesheet" type="text/css"/> 
            <link rel="icon" href="Images/favicon/favicon.ico">

    </head>


    <% 
        session.setAttribute("SESSION_ID", request.getSession().getId());
         String Lblmessage= "";
    %>

    <style>
        
        
         /* The container must be positioned relative: */
.custom-select {
  position: relative;
  border: 0px  transparent !important;
 
}

.custom-select select {
  display: none; /*hide original SELECT element: */
}

.select-selected {
    background-color: #0066cc;
  
}

/* Style the arrow inside the select element: */
.select-selected:after {
  position: absolute;
  content: "";
  top: 14px;
  right: 10px;
  width: 0;
  height: 0;
  border: 6px solid transparent;
  border-color: #fff transparent transparent transparent;
}

/* Point the arrow upwards when the select box is open (active): */
.select-selected.select-arrow-active:after {
  border-color: transparent transparent #fff transparent;
  top: 7px;
}

/* style the items (options), including the selected item: */
.select-items div,.select-selected {
  color: #ffffff;
  padding: 8px 16px;
  border: 1px solid transparent;
  border-color: transparent transparent rgba(0, 0, 0, 0.1) transparent;
  cursor: pointer;
}

/* Style items (options): */
.select-items {
  position: absolute;
  background-color: DodgerBlue;
  top: 100%;
  left: 0;
  right: 0;
  z-index: 99;
}

/* Hide the items when the select box is closed: */
.select-hide {
  display: none;
}

.select-items div:hover, .same-as-selected {
  background-color: rgba(0, 0, 0, 0.1);
} 

    </style>
    
    <script>
        
        function GotoLogin() {
            window.location.replace('login.jsp');
        }


          
        </script>
    
    <body style=" background-color:#000 !important; background-repeat: no-repeat;
    background-attachment: fixed;
    background-position: center; ">

        <div >
            <div >


                <form id="frmLogin" method="post"  >
                    <table style="width:100%;height:100%; ">
                        <tr > 
                            <td align="Center" style="height:150px; "  >
                             
                        </tr>  
                        <tr>
                            <td align="Center" style="vertical-align: top">

                               
                          
                                <table style="height:300px;background-color:#FFF;box-shadow: 5px 5px 18px #000;" >
                                    <tr style="height: 50px;">
                                        <td colspan="2" align="center" style="background-color:#ff6633;">
                                            <span class="Title" style="color:#000;font-weight:bold;font-size: 14px; height:80px; " > 
                                                                                                                                                 <%                 
                                                    out.write(  ApplicationInformation.ApplicationName);                
                                                %>


                                            </span>
                                             
                                        </td>
                                        
                                    </tr>
                                    <tr>
                                        
                                        <td style="width:250px;background-color:#fff;  ">
                                                
                                            <img src="NewWork/images/Login.jpg" style="width:600px;" alt=""/>
                                                
                                            </td>
                                        <td style="vertical-align:top; ;vertical-align: top;" >
                                            
                                <table style="height:200px; width:408px;" >
                                    <tr>
                                        <td colspan="2" align="Center"   style="height:50px; ">                                            
                                            <span class="Title" style="color:#000000;font-size: 14px; height:50px; " >
                                                برای شما در سامانه چندین نقش تعریف شده است
                                                <br>
                                               برای ورود به سامانه نقش خود را انتخاب نمایید 
                                               
                                            
                                            </span>
                                        </td>
                                    </tr>                                    
                                    
                                    
                                    <%
                                        
                                        try {

                                        
                                        String UserID = session.getAttribute("User_ID").toString();
                                        if (UserID == null)
                                        {
                                                   out.print ( "<script> GotoLogin()</script>");
                                        }
                                        
                                    } catch (Exception ex) {
                                       out.print ( "<script> GotoLogin()</script>");
                                    }

                                                   Metadata_DataBase_Handler CLanguageDataProvider = new Metadata_DataBase_Handler();
                                                   String QuerySys_UserGroup_LIst = "select DISTINCT  UG.Sys_UserGroup_ID , UG.UserGroupName from Sys_UserGroupList UGL inner join Sys_UserGroup UG on UG.Sys_UserGroup_ID = UGL.Sys_UserGroup_ID where UGL.Sys_User_ID = @LNGUSERID" ;
                                                   ArrayList<zdg.zframe.Dictionary> ParamList = new ArrayList<zdg.zframe.Dictionary>();
                                                   String User_ID =  session.getAttribute("User_ID").toString();    
                                                   ParamList.add(new Dictionary("USERID", User_ID));
                                                   DataTable TableLanguage =  CLanguageDataProvider.executeDataTableByDictionery(QuerySys_UserGroup_LIst,ParamList);
                                                   
                                        

                                                 out.print("<tr>");
                                                 out.print("<td align=\"center\" dir=\"rtl\"> <div class=\"custom-select\" >");
                                                 out.print("<select id=\"ruleid\" name=\"ruleid\">");
                                                 String LanguageID =    request.getParameter("languageid");
                                                  if (LanguageID == null)
                                                  {
                                                      LanguageID = TableLanguage.getDataRow(0).getColumnData(0).toString();
                                                  }
                                                  for (int a=0 ; a < TableLanguage.getRowCount() ; a++)
                                                  {
                                                      if ( LanguageID.equals(TableLanguage.getDataRow(a).getColumnData(0).toString()))
                                                      {
                                                        out.print("<option value=\""+TableLanguage.getDataRow(a).getColumnData(0).toString()+"\" selected>"+TableLanguage.getDataRow(a).getColumnData(1).toString()+"</option>");          
                                                      }
                                                      else
                                                      {
                                                        out.print("<option value=\""+TableLanguage.getDataRow(a).getColumnData(0).toString()+"\">"+TableLanguage.getDataRow(a).getColumnData(1).toString()+"</option>");          
                                                      }


                                                  }
                                                out.print("</select>");
                                                out.print("</div> </td>");
                                              
     
     
     

%>
                                   
                                    
                                    <tr>
                                        <td colspan="2" align="center">
                                            <input type="submit" id="btn_Login"  name="btn_Login" value="ورود به سیستم" Class="LoginEnter" >
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center">
                                            <span class="Title"  ID="lbl_Warning" Name="lbl_Warning"  style="color:#FF0000;"   >
                                               
                                            </span>                                            
                                        </td>
                                    </tr>
                                    <!--  <tr>
                                        <td colspan="2" align="Center" style="background-color:#999999">
                                            <br />
                                            <Span class="Title" style="color: #FFFFFF;font-weight:bold;" >                                            

                                                <%                 
                                                    out.write( ApplicationInformation.ApplicationName);                
                                                %>
                                            </span>
                                            <br />
                                            <br />

                                        </td>
                                    </tr>
                                            -->

                                            <tr>
                                                <td>
                                                   
                                                    
                                                </td>
                                                
                                            </tr>
                                </table>
                                        </td>
                                           
                                            </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center">
                                <label style="font-size: 11px;color: white">

                                </label>
                            </td>                       
                        </tr>

                    </table>
                     <%
  

                                            
                                           if (request.getParameter("btn_Login") != null) 
                                                {
                                                    String ruleid = request.getParameter("ruleid");
                                                     if (ruleid != null)
                                                        {
                                                             session.setAttribute("RULE_ID",ruleid);
                                                             response.sendRedirect("Default.jsp");
                                                        }
                                                }
                                           

                                       
 
                                %>
                </form><!-- /form -->

            </div><!-- /card-container -->
        </div><!-- /container -->  
        <%--<iframe src="RefreshRule.aspx"  style="position:absolute; top:-1000px; left:-1000px; height:0px; width:0px;">

    </iframe>--%>

        <script>
            
              var x, i, j, l, ll, selElmnt, a, b, c;
            /* Look for any elements with the class "custom-select": */
            x = document.getElementsByClassName("custom-select");
            l = x.length;
            for (i = 0; i < l; i++) {
              selElmnt = x[i].getElementsByTagName("select")[0];
              ll = selElmnt.length;
              /* For each element, create a new DIV that will act as the selected item: */
              a = document.createElement("DIV");
              a.setAttribute("class", "select-selected");
              a.innerHTML = selElmnt.options[selElmnt.selectedIndex].innerHTML;
              x[i].appendChild(a);
              /* For each element, create a new DIV that will contain the option list: */
              b = document.createElement("DIV");
              b.setAttribute("class", "select-items select-hide");
              for (j = 1; j < ll; j++) {
                /* For each option in the original select element,
                create a new DIV that will act as an option item: */
                c = document.createElement("DIV");
                c.innerHTML = selElmnt.options[j].innerHTML;
                c.addEventListener("click", function(e) {
                    /* When an item is clicked, update the original select box,
                    and the selected item: */
                    var y, i, k, s, h, sl, yl;
                    s = this.parentNode.parentNode.getElementsByTagName("select")[0];
                    sl = s.length;
                    h = this.parentNode.previousSibling;
                    for (i = 0; i < sl; i++) {
                      if (s.options[i].innerHTML == this.innerHTML) {
                        s.selectedIndex = i;
                        h.innerHTML = this.innerHTML;
                        y = this.parentNode.getElementsByClassName("same-as-selected");
                        yl = y.length;
                        for (k = 0; k < yl; k++) {
                          y[k].removeAttribute("class");
                        }
                        this.setAttribute("class", "same-as-selected");
                        break;
                      }
                    }
                    h.click();
                });
                b.appendChild(c);
              }
              x[i].appendChild(b);
              a.addEventListener("click", function(e) {
                /* When the select box is clicked, close any other select boxes,
                and open/close the current select box: */
                e.stopPropagation();
                closeAllSelect(this);
                this.nextSibling.classList.toggle("select-hide");
                this.classList.toggle("select-arrow-active");
              });
            }

            function closeAllSelect(elmnt) {
              /* A function that will close all select boxes in the document,
              except the current select box: */
              var x, y, i, xl, yl, arrNo = [];
              x = document.getElementsByClassName("select-items");
              y = document.getElementsByClassName("select-selected");
              xl = x.length;
              yl = y.length;
              for (i = 0; i < yl; i++) {
                if (elmnt == y[i]) {
                  arrNo.push(i)
                } else {
                  y[i].classList.remove("select-arrow-active");
                }
              }
              for (i = 0; i < xl; i++) {
                if (arrNo.indexOf(i)) {
                  x[i].classList.add("select-hide");
                }
              }
            }

            /* If the user clicks anywhere outside the select box,
            then close all select boxes: */
            document.addEventListener("click", closeAllSelect);
            
        </script>

    </body>
</html>
