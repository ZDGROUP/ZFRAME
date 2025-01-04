<%-- 
    Document   : mobile
    Created on : Aug 11, 2019, 9:34:09 AM
    Author     : S_Rafiei
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>


<html lang="en">
<head>
  <meta charset="utf-8">
  <title>
      
  </title>
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <meta content="" name="keywords">
  <meta content="" name="description">
  <link href="img/PublicParkingIcon.jpg" rel="icon">
  <link href="img/PublicParkingIcon.jpg" rel="apple-touch-icon">
  
  <link href="lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">  
  <link href="lib/animate/animate.min.css" rel="stylesheet">
  <link href="lib/font-awesome/css/font-awesome.min.css" rel="stylesheet">
  <link href="lib/ionicons/css/ionicons.min.css" rel="stylesheet">
  <link href="lib/magnific-popup/magnific-popup.css" rel="stylesheet"> 
  <link href="css/style.css" rel="stylesheet">
  <script src="../ZJBPMS/zbpms.js" type="text/javascript"></script> 

</head>

<body style="background-color: #333333;">

 <form id="form1" runat="server">
  
  <header id="header">
      
    <div class="container">

      <div id="logo" class="pull-right">
        <h1><a href="#intro" class="scrollto">   </a></h1>        
      </div>

      <nav id="nav-menu-container">
          <Center>
          <img src="../Images/AppLogo.jpg">
          </Center>
        <ul class="nav-menu">
                              

                                     <%
                                            try {
                                                session.setAttribute("LTR", "0");
                                                Z_Facade.TreeViewManagementBootstrap  CTreeView = new Z_Facade.TreeViewManagementBootstrap(request, response);
                                                String UserID = session.getAttribute("User_ID").toString();
                                                out.write(CTreeView.loadWorkFlowListInTreeView(Integer.valueOf(UserID), __Configuration.__Infromation.Direction));
                                            } catch (Exception ex) {
                                                response.sendRedirect("../login.jsp");
                                            }
                                        %> 
          
        </ul>
      </nav><!-- #nav-menu-container -->
    </div>                                                                                
  </header><!-- #header -->
  <br>
  <br>
  <div class="MainView" style="width:100%;height:90%;">
                                        <iframe id="FormViewer"  class="MainView" src="../UserInformation.jsp"   runat="server" style="width:100%;height:100%;">
                                        </iframe>
</div>                                     
  
  <script src="lib/jquery/jquery.min.js"></script>
  <script src="lib/jquery/jquery-migrate.min.js"></script>
  <script src="lib/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="lib/easing/easing.min.js"></script>
  <script src="lib/wow/wow.min.js"></script>
  <script src="lib/superfish/hoverIntent.js"></script>
  <script src="lib/superfish/superfish.min.js"></script>
  <script src="lib/magnific-popup/magnific-popup.min.js"></script>  
  <script src="contactform/contactform.js"></script>
  <script src="js/main.js"></script>  
  
    </form>
    </body>
        
</html>
