<%@page import="zdg.zframe.facade.TreeViewManagementPartial"%>
<%@page import="zdg.zframe.facade.TreeViewManagement" %>
<%@page import="zdg.zframe.application_utilities.PersianCalendar" %>
<%@page import="zdg.zframe.configuration.ApplicationInformation" %>
<%@page import="java.time.LocalDateTime" %>
<%@page import="java.time.format.DateTimeFormatter" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8" %>

<%
    response.addHeader("X-Frame-Options", "DENY");
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="Style/font/font-awesome.css" rel="stylesheet" type="text/css"/>
    <title>

           <%
                session.setAttribute("LTR",0);
                out.println(ApplicationInformation.ApplicationName);
            %>


    </title>

    <link rel="icon" type="image/png" href="NewWork/images/logo.png" sizes="32x32">
    <link rel="icon" type="image/png" href="NewWork/images/logo.png" sizes="16x16">
<!--    <link href="Style/scss.scss" rel='stylesheet' type='text/css'>-->
<META HTTP-EQUIV="Access-Control-Allow-Origin" CONTENT="<% out.println(ApplicationInformation.DomainAddressOnWebServer); %>">


    
    <script src="ZJBPMS/calendar.all.js" type="text/javascript"></script>
    <script src="ZJBPMS/calendar.js" type="text/javascript"></script>
    <script src="ZJBPMS/zfjquery.js" type="text/javascript"></script>
    <script src="ZJBPMS/zfjquery.ui.core.js" type="text/javascript"></script>
    <script src="ZJBPMS/jquery.ui.datepicker-cc-ar.js" type="text/javascript"></script>
    <script src="ZJBPMS/jquery.ui.datepicker-cc-fa.js" type="text/javascript"></script>
    <script src="ZJBPMS/jquery.ui.datepicker-cc.js" type="text/javascript"></script>
    <script src="ZJBPMS/jquery-confirm.min.js" type="text/javascript"></script>
    <script src="ZJBPMS/zbpms.js" type="text/javascript"></script>
    <script src="ZJBPMS/Application.js" type="text/javascript"></script>
    <script src="ZJBPMS/html2canvas.js" type="text/javascript"></script>
    <script src="ZJBPMS/icb.mcb.js" type="text/javascript"></script>

      <script language="Javascript">
        var b = 1;
        shortcut.add("ctrl+f2", function () {
            Showshortcut();
        });

        function Showshortcut() {
            if (b == 1) {
                b = 2;
                var c = $.dialog({
                    title: ' جستجوی فرم ',
                    content: 'url:navigation.jsp',
                    boxWidth: '500px',
                    useBootstrap: false,
                    draggable: true,
                    theme: 'dark',

                    rtl: true,
                    backgroundDismiss: true,
                    onDestroy: function () {
                        b = 1;
                    }
                });


            }
        }


        function showcartabl() {
            openWindowsInNewTabNavigationUrl('ZBPMS.bpm?ID=37', 'folder', 'کارتابل');
        }


        function showsetting() {
            openWindowsInNewTabNavigationUrl('ZBPMS.bpm?ID=241', 'accessibility', 'تنظیمات امنیتی');
        }

        function changePassword() {
            openWindowsInNewTabNavigationUrl('ZBPMS.bpm?ID=241', 'changepassword', 'تغییر کلمه عبور');
        }

        function GotoLogin() {
            window.location.replace('login.jsp');
        }


    </script>

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
</style>



<style>
*, ::after, ::before {
	box-sizing: border-box;
}
.navbar {
  overflow: hidden;
  background-color: #11100f;
 
  top: 0;
  height: 60px !important;
  width: 100%;
}


footer {
    margin-bottom: unset !important;
    height: 35px !important;
    position: fixed;
    background-color: #fff !important;
    bottom: 0;
    left: 0;
    right: 0;
    border-top: 1px solid #ddd;
}

footer.max {
    right: 0 !important;
}

footer .date-area {
    /*background-color: #4bcffa;*/
    height: 45px;
    /*margin-top: -9px;*/
    padding: 9px;
    border-radius: 2px;
    width: 300px;
    margin: -5px 10px;
}

footer .date-area span {
    color: #3a3a3a;
    font-size: 9pt !important;
}

footer .date-area b {
    color: #3a3a3a;
    font-size: 9pt;
}


.navbar a {
  float: right;
  display: block;
  color: #f2f2f2;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  font-size: 20px;
}

.navbar i {
  float: left;
  display: block;
  color: #f2f2f2;
  text-align: center;
  padding: 16px 16px;
  text-decoration: none;
  font-size: 24px;
}
.navbar img {
  float: left;
  display: block;
  color: #f2f2f2;
  text-align: center;
  padding-top: 5px;
  padding-bottom: 5px;
  padding-right: 5px;
  padding-left: 5px;
  width: 60px;
  height: 60px;
  text-decoration: none;
}
.main {
  margin-right: 65px;
  margin-left: 0px;
  background-color: #faf9f8;
}
.top_navbar{
	position: fixed;
	top: 0;
	right: 0;
	width: 100%;
	height: 60px;
	background: #323233;
	box-shadow: 1px 0 2px rgba(0,0,0,0.125);
	display: flex;
	align-items: center;
}

.top_navbar .logo{
	width: 250px;
	font-size: 25px;
	font-weight: 700;
	padding: 0 25px;
	color: white;
	letter-spacing: 2px;
	text-transform: uppercase;
	border-right: 1px solid #f5f5f5;
}



.top_navbar .menu{
	width: calc(100% - 250px);
	padding: 0 25px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}


/* Now I have determined what the sidebar will look like for a responsive device */
.hover_collapse .sidebar{
	width: 65px;
  transition: width ease 0.2s;
}

.hover_collapse .sidebar ul li a .text{
	display: none;
 
}

.sidebar{
	position: fixed;
	top: 60px;
	right: 0;
	width: 310px;
	height: 100% !important; 
	background: #f3f2f1;
  border-left: 1px solid #bebbb8;
  transition: width ease 0.2s;
}


.sidebar ul li .panel{
  padding-right: 45px;
  padding: 0 18px;
  background-color: white;
  max-height: 0;
  overflow: hidden;
  transition: max-height 0.2s ease-out;

}
/*
.hide .sidebar ul li .panel{
  display:none;
  
}*/

.hide .sidebar div{
  display:none;
  
}

.sidebar ul li button .text{
  font-family:'Irancell-Bold';
}

.sidebar ul li button .text{
  display:none;
}
.sidebar ul li button .hidden-icon{
  display:none;
}

.hide-icon .sidebar ul li button div .icon{
  display:none;
}


 .show .sidebar ul li button .text {
    display:block;
  }

.sidebar ul li button {
	float: Right;
	display: block;
	padding: 16px 25px;
	background-color: #f3f2f1 !important;
	outline-offset: .6em;
	font-size: 16px;
	border: 0;
	width: 100%;
	height: 58.1833px;
	cursor: pointer;
	font-family: 'IRANCELL-Bold';
	text-align: right;
}
.ButtonImage{
  cursor: pointer;

}
.LinkLabelTree:hover,span.ButtonLable:hover {
  color: #4c77e4;
}


.sidebar ul li button:hover, .sidebar ul li button:focus-visible{
  outline-offset: .05em;
}

.sidebar ul li button:active {
  color: #373B44;
}




.sidebar ul li a{
	display: block;
	padding: 16px 25px;
  text-align: right;

}

.sidebar ul li a .icon{
  font-size: 18px;
  color: #201f1e;
	vertical-align: middle;
  text-align: right;
}

.sidebar ul li a .hidden-icon {
  display: none;
  font-size: 20px;
  color: #201f1e;
  vertical-align: middle;
  text-align: left;
  float:left;
  margin-top: 6px;
}

.sidebar ul li a .show-icon {
  display:block;
}

.sidebar ul li a .text{
    vertical-align: middle;
	  margin-right: 16px;
	  color: #201f1e;
    font-family: sans-serif;
    font-size: 18px;
    justify-content: center;
    align-items: center;
}

.sidebar ul li a:hover{
	border: 1px solid #2266e3;
}


*{
  font-family: 'Irancell';
  font-weight: normal;
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	list-style: none;
	text-decoration: none;
}
.navbar .hamburger{
	font-size: 25px;
	cursor: pointer;
	color: white;
}

.navbar .hamburger:hover{
	color: #007dc3;
}

.navbar2 .hamburger{
	font-size: 25px;
	cursor: pointer;
	color: white;
}

.navbar2 .hamburger:hover{
    color: #000000;
}
</style>

<style>
.navbar2 {
 
  background-color: #ffffff; 
  border-bottom: 1px solid #bebbb8;

}



.navbar2 a {
  font-family: 'Irancell'!important;
  float: right;
  font-size: 13px;
  color: #201f66;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  font-family: 'Malgun Gothic';
}

.navbar2 span {
  float: left;
  display: block;
  color: #f2f2f2;
  text-align: center;
  padding: 16px 16px;
  text-decoration: none;
  font-size: 24px;
}

.subnav {
  float: right;
  overflow: hidden;
}

.subnav .subnavbtn {
  font-size: 16px;  
  font-family: 'Malgun Gothic';
  border: none;
  outline: none;
  color: #201f66;
  padding: 14px 16px;
  background-color: inherit;
  margin: 0;
}

.navbar2 a:hover, .subnav:hover .subnavbtn {
  border-bottom: 4px solid #2266e3;
  
}

.subnav-content {
  display: none;
  position: absolute;
  right: 0;
  background-color: #ffffff; 
  width: 100%;
  z-index: 1;
  margin-right: 65px;
  border-bottom: 1px solid #bebbb8;
}

.subnav-content a {
  float: right;
  color: black;
  text-decoration: none;
}

.subnav-content a:hover {
  background-color: #eee;
  color: black;
}

.subnav:hover .subnav-content {
  display: block;
}

.LinkLabelTree, .ButtonLable{
  	font-family: 'Irancell';
    font-weight: normal;
    font-size: 14px;
    cursor: pointer;
    padding: 8px;
}



div.ShowPanel {
    
    height: 100%;    
    z-index: 12;
    top: 0;    
    visibility: visible;
    width: 100%;
    left: 0;    
    position: fixed;
    background-color: #00818180;
    height: 100%;
    text-align: center; 
    align-items: center;
    display: table-cell;
    vertical-align: middle;
    display: flex;
    justify-content: center;
    align-items: center; 
}



</style>    




<style>
#cmdtabidfrom0 {
	cursor: pointer;
	display: inline-block;
	width: 35px !important;
	padding: 9px;
}
.col-2 {
	-ms-flex: 0 0 16.666667%;
	flex: 0 0 16.666667%;
	max-width: 16.666667%;
}
.col, .col-1, .col-10, .col-11, .col-12, .col-2, .col-3, .col-4, .col-5, .col-6, .col-7, .col-8, .col-9, .col-auto, .col-lg, .col-lg-1, .col-lg-10, .col-lg-11, .col-lg-12, .col-lg-2, .col-lg-3, .col-lg-4, .col-lg-5, .col-lg-6, .col-lg-7, .col-lg-8, .col-lg-9, .col-lg-auto, .col-md, .col-md-1, .col-md-10, .col-md-11, .col-md-12, .col-md-2, .col-md-3, .col-md-4, .col-md-5, .col-md-6, .col-md-7, .col-md-8, .col-md-9, .col-md-auto, .col-sm, .col-sm-1, .col-sm-10, .col-sm-11, .col-sm-12, .col-sm-2, .col-sm-3, .col-sm-4, .col-sm-5, .col-sm-6, .col-sm-7, .col-sm-8, .col-sm-9, .col-sm-auto, .col-xl, .col-xl-1, .col-xl-10, .col-xl-11, .col-xl-12, .col-xl-2, .col-xl-3, .col-xl-4, .col-xl-5, .col-xl-6, .col-xl-7, .col-xl-8, .col-xl-9, .col-xl-auto {
	position: relative;
	width: 100%;
	padding-right: 15px;
	padding-left: 15px;
}
.card {
	position: relative;
	display: -ms-flexbox;
	display: flex;
	-ms-flex-direction: column;
	flex-direction: column;
	min-width: 0;
	word-wrap: break-word;
	background-color: #fff;
	background-clip: border-box;
	border: 1px solid rgba(0,0,0,.125);
	border-radius: .25rem;
}
a:not([href]):not([tabindex]) {
	color: inherit;
	text-decoration: none;
}
.dashboard-container .fav-area .content .card {
	margin: 10px;
	width: 100%;
	height: 90px;
	border-top: 5px solid #0FBCF9;
	cursor: pointer;
	transition: 0.3s;
}
body.blue .dashboard-container .fav-area .content .card {
	border-top: 5px solid #0FBCF9;
}
.card-header {
	padding: .75rem 1.25rem;
	margin-bottom: 0;
	color: inherit;
	background-color: rgba(0,0,0,.03);
	border-bottom: 1px solid rgba(0,0,0,.125);
}
.card-header:first-child {
	border-radius: calc(.25rem - 1px) calc(.25rem - 1px) 0 0;
}
.dashboard-container .fav-area .content .card .card-header {
	background: unset !important;
	border: unset !important;
	text-align: left;
	padding: 5px 15px;
}
.dashboard-container .fav-area .content .card .card-header .card-header-action {
	color: #3a3a3a;
	font-size: 9pt !important;
}
.dashboard-container .fav-area .content .card span.title {
	color: #3a3a3a;
	text-align: center;
	margin: 0px;
	font-size: 10pt;
	height: 100%;
}
span {
	-webkit-touch-callout: none;
	-webkit-user-select: none;
	-khtml-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
}
.dashboard-container .fav-area .content .card:hover .title, .dashboard-container .fav-area .content .card:hover .card-header-action {
	color: #fff !important;
}
body.blue .dashboard-container .fav-area .content .card:hover {
	background-color: #0FBCF9;
}
body.blue .dashboard-container .fav-area .content .card {
	border-top: 5px solid #373B44;
}
.dashboard-container .fav-area .content .card:hover {
	background-color: #2266E3;
}
</style>

<style>

.dashboard-container {
	padding: 10px;
	background-color: #E6E6E6;
}
a:not([href]):not([tabindex]) {
	color: inherit;
	text-decoration: none;
}
.dashboard-container .fav-area .header {
	padding: 10px;
	background-color: #F2F2F2;
}
.dashboard-container .fav-area .header .title {
  color: #3a3a3a;
  text-align: right;
}
.dashboard-container .fav-area .content {
	text-align: right;
	direction: rtl;
	border: 1px solid #F2F2F2;
	margin: 0;
	padding: 0 10px;
}
.row {
	display: -ms-flexbox;
	display: flex;
	-ms-flex-wrap: wrap;
	flex-wrap: wrap;
	margin-right: -15px;
	margin-left: -15px;
}
.dashboard-container .fav-area .content .empty-fav-message {
	padding: 10px;
	text-align: center;
	width: 100%;
	color: #2156BB;
	font-size: 14px !important;
} 
.tab{
      
	box-sizing: border-box;
	position: static;
	font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol";
	font-size: 12px;
	height: 46px;
	padding: 8px 3px 4px 3px;
	background: #E6E6E6;
	border-radius: 5px 5px 0 0;
	overflow: hidden;
}
.main .tab .tablinksNormal {
    	font-family: 'Irancell';
    font-weight: normal;
    font-size: 14px;
  font-size: 10pt !important;
	background: #E6E6E6 !important;
	border: unset !important;
	height: 38px !important;
	width: 200px !important;
	border-radius: 10px 10px 0 0px !important;
	color: #3a3a3a !important;

}
input.tablinksNormal {
	background-color: inherit;
	border: none;
	outline: none;
	cursor: pointer;
	padding: 5px;
	border: 1px solid #67757b;
	width: 200px;
	height: 30px;
	border-style: solid solid solid none;
	color: #fff;
	border-radius: 0px 15px 0px 0px;
	/* background: -webkit-gradient(linear,left top, left bottom,from(white),to(#67757b),color-stop(0.03, #67757b)); */
	background-color: #adadad;
}
.main .tab .tablinks {
    	font-family: 'Irancell';
    font-weight: normal;
    font-size: 14px;
	font-size: 10pt !important;
	background: #E6E6E6 !important;
	border: unset !important;
	height: 38px !important;
	width: 200px !important;
	border-radius: 10px 10px 0 0px !important;
	color: #3a3a3a !important;
  background: #fff !important;
	color: #3a3a3a !important;
}
.main .tab .tablinksclose {
	position: relative !important;
	top: 1px !important;
	background: unset !important;
	border: unset !important;
	border-radius: unset !important;
	height: 32px !important;
	font-size: 11px !important;
	left: 25px;
	margin-left: -22px;
	color: #3c3c3c !important;
}
input.tablinksclose {
	background-color: inherit;
	border: none;
	outline: none;
	cursor: pointer;
	padding: 5px;
	border: 1px solid #67757b;
	width: 20px;
	height: 30px;
	/* background: #3b7ba8; */
	background: linear-gradient(to left, #000000 , #333333);
	/* background: -webkit-gradient(linear,left top, left bottom,from(white),to(#006666),color-stop(0.03, #009999)); */
	color: black;
}
.tablinksNormal .tablinks:not([active]) {
  transition: opacity 0.2s ease;
  opacity: 0;
}


.navbar .setting-area {
	position: absolute;
  left: 451px;
  top: -14px;
	width: 35px;
	/* background-color: #4bcffa; */
	height: 45px;
	padding: 10px 9px;
	border-radius: 2px;
	transition: 0.3s;
}
.navbar  i {
	display: block;
	cursor: pointer;
	color: #fff !important;
}
.navbar  .setting-area-content {

	display: flex;
	flex-direction: column;
	background-color: #11100f;
	color: transparent;
	/* padding: 5px; */
	position: fixed;
	top: 61px;
	direction: rtl;
	width: 150px;
	left: 136px;
	height: 0px;
  border-radius: 0 0 0.5rem 0.5rem;
	box-shadow: 0 10px 15px -3px rgba(46, 41, 51, 0.08), 0 4px 6px -2px rgba(71, 63, 79, 0.16);
transition: position ease 0.2s,height ease 0.2s,color ease 0.2s,padding ease 0.2s;
}
.navbar  .setting-area-content.show {

	/* display: flex; */
	text-align: right !important;
	height: 107px;
  transition: position ease 0.2s,height ease 0.2s,color ease 0.2s,padding ease 0.2s;
	padding: 5px;
	color: #fff;


}
.navbar  .setting-area-content a span.title {
	font-size: 10px !important;

}
.navbar  .setting-area-content a {
	padding: 0px 0px;
}
.navbar   a.title {
	font-family: "ZFRAMEFONT" !important;
	width: 150px;
	display: block;
	padding: 5px;
	color: #fff;
	cursor: pointer;
	transition: 0.3s;
}
.fa.fa-chevron-down.arrow{
transition: transform 100ms ease-in-out;
}

.fa.fa-chevron-down.arrow.show {
	transform: rotate(-180deg);
	transition: transform 100ms ease-in-out;
}

.navbar .user-area-content {
  display: flex;
  flex-direction: column;
  background-color: #11100f;
  color: transparent;
  padding: 0px;
  position: fixed;
  top: 61px;
  width: 163px;
  direction: rtl;
  left: 22px;
  height: 0px;
  transition: position ease 0.2s,height ease 0.2s,color ease 0.2s,padding ease 0.2s;
  border-radius: 0 0 0.5rem 0.5rem;
  box-shadow: 0 10px 15px -3px rgba(46, 41, 51, 0.08), 0 4px 6px -2px rgba(71, 63, 79, 0.16);
  visibility: hidden;
      
}
.navbar  .user-area-content.show {
  height: 107px;
  padding: 5px;
  color: #fff;
  transition: position ease 0.2s,height ease 0.2s,color ease 0.2s,padding ease 0.2s;
  visibility: visible;
}
.navbar  .user-area-content a {
	display: flex;
	flex-direction: row;
	padding: 5px;
}
.navbar .user-area-content a span.fa {
	margin-left: 5px;
}
.navbar .user-area-content a span.title {
	font-size: 10px !important;
  padding-top: 4px;
  padding-right: 4px;
}
.navbar .user-area-content a {
	display: flex;
	flex-direction: row;
	padding: 5px;
}

.jconfirm.jconfirm-rtl {
	direction: rtl;
}
.jconfirm-mcb-confirm {
	background-color: rgba(0, 0, 0, 0.3);
}
.jconfirm {
	background: rgba(0, 0, 0, 0.3);
}
.jconfirm {
	-webkit-perspective: 400px;
	perspective: 400px;
}
.jconfirm {
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	z-index: 99999999;
	font-family: inherit;
	overflow: hidden;
}
.jconfirm .jconfirm-bg {
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	-webkit-transition: opacity .4s;
	transition: opacity .4s;
}
.jconfirm .jconfirm-scrollpane {
	-webkit-perspective: 500px;
	perspective: 500px;
	-webkit-perspective-origin: center;
	perspective-origin: center;
	display: table;
	width: 100%;
	height: 100%;
}
.jconfirm .jconfirm-row {
	display: table-row;
	width: 100%;
}
.jconfirm .jconfirm-cell {
	display: table-cell;
	vertical-align: middle;
}
.jconfirm .jconfirm-holder {
	max-height: 100%;
	padding: 50px 0;
}

.justify-content-lg-center {
	-ms-flex-pack: center !important;
	justify-content: center !important;
}
.row {
	display: -ms-flexbox;
	display: flex;
	-ms-flex-wrap: wrap;
	flex-wrap: wrap;
	margin-right: -15px;
	margin-left: -15px;
}
.jconfirm .jconfirm-box-container.jconfirm-no-transition {
	-webkit-transition: none !important;
	transition: none !important;
}
.jconfirm .jconfirm-box.jconfirm-type-animated {
	-webkit-animation-duration: 2s;
	animation-duration: 2s;
	-webkit-animation-iteration-count: infinite;
	animation-iteration-count: infinite;
}
.jconfirm .jconfirm-box {
	margin-bottom: 100px !important;
}
.jconfirm-mcb-confirm .jconfirm-box {
	border-top: unset !important;
}
.jconfirm-mcb-confirm .jconfirm-box {
	border-top: unset !important;
}
.jconfirm-mcb-confirm .jconfirm-box {
	background-color: #fff !important;
	padding: 0 !important;
}
.jconfirm .jconfirm-box {
	opacity: 1;
	-webkit-transition-property: all;
	transition-property: all;
}
.jconfirm .jconfirm-box {
	background: white;
	border-radius: 4px;
	position: relative;
	outline: 0;
	padding: 15px 15px 0;
	overflow: hidden;
	margin-left: auto;
	margin-right: auto;
}
.jconfirm-box {
	width: 400px !important;
}
.jconfirm .jconfirm-box div.jconfirm-closeIcon {
	height: 20px;
	width: 20px;
	position: absolute;
	top: 10px;
	right: 10px;
	cursor: pointer;
	opacity: .6;
	text-align: center;
	font-size: 27px !important;
	line-height: 14px !important;
	display: none;
	z-index: 1;
}
.jconfirm-mcb-confirm div.jconfirm-closeIcon {
	right: unset !important;
	left: 10px !important;
	color: #fff !important;
}
.jconfirm .jconfirm-box div.jconfirm-title-c {
	display: block;
	font-size: 22px;
	line-height: 20px;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
	cursor: default;
	padding-bottom: 15px;
}
.jconfirm-mcb-confirm .jconfirm-title-c {
	background-color: #2266e3 !important;
	color: #fff !important;
	text-align: right !important;
	padding: 8px !important;
	font-size: 11pt !important;
}
.jconfirm-title-c {
	color: brown !important;
	font-weight: bold !important;
}
.jconfirm .jconfirm-box div.jconfirm-title-c .jconfirm-title {
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
	font-size: inherit;
	font-family: inherit;
	display: inline-block;
	vertical-align: middle;
}
.jconfirm .jconfirm-box div.jconfirm-content-pane.no-scroll {
	overflow-y: hidden;
}
.jconfirm .jconfirm-box div.jconfirm-content-pane {
	margin-bottom: 15px;
	height: auto;
	-webkit-transition: height .4s ease-in;
	transition: height .4s ease-in;
	display: inline-block;
	width: 100%;
	position: relative;
	overflow-x: hidden;
	overflow-y: auto;
}
.jconfirm-content-pane {
	color: #333 !important;
	font-weight: bold !important;
}
.jconfirm .jconfirm-box div.jconfirm-content-pane .jconfirm-content {
	overflow: auto;
}
.jconfirm-mcb-confirm .jconfirm-content {
	font-size: 10pt !important;
	font-weight: normal !important;
	padding: 10px !important;
	text-align: right;
}
.jconfirm-content {
	float: right;
	direction: rtl;
	font-size: 12px;
	font-family: "ZFRAMEFONT";
	text-align: right;
}
.jconfirm-mcb-confirm .jconfirm-buttons {
	text-align: right !important;
	padding: 10px !important;
}
.jconfirm-mcb-confirm .jconfirm-buttons button::before {
	font-family: "Font Awesome 5 Free" !important;
	font-style: normal !important;
	font-weight: 900 !important;
	font-size: 10pt !important;
	position: relative;
	left: 10px;
	color: #424E59;
}
.jconfirm .jconfirm-box .jconfirm-buttons button.btn-default {
	background-color: #ecf0f1;
	color: #000;
	text-shadow: none;
	-webkit-transition: background .2s;
	transition: background .2s;
}
.jconfirm-mcb-confirm .jconfirm-buttons button.btn-accept {
	background-color: #ccc !important;
}
.jconfirm .jconfirm-box .jconfirm-buttons button {
	display: inline-block;
	padding: 6px 12px;
	font-size: 14px;
	font-weight: 400;
	line-height: 1.42857143;
	text-align: center;
	white-space: nowrap;
	vertical-align: middle;
	-ms-touch-action: manipulation;
	touch-action: manipulation;
	cursor: pointer;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
	border-radius: 4px;
	min-height: 1em;
	-webkit-transition: opacity .1s ease,background-color .1s ease,color .1s ease,background .1s ease,-webkit-box-shadow .1s ease;
	/* transition: opacity .1s ease,background-color .1s ease,color .1s ease,background .1s ease,-webkit-box-shadow .1s ease; */
	/* transition: opacity .1s ease,background-color .1s ease,color .1s ease,box-shadow .1s ease,background .1s ease; */
	transition: opacity .1s ease,background-color .1s ease,color .1s ease,box-shadow .1s ease,background .1s ease,-webkit-box-shadow .1s ease;
	-webkit-tap-highlight-color: transparent;
	border: 0;
	background-image: none;
}
.jconfirm .jconfirm-box .jconfirm-buttons > button {
	margin-bottom: 4px;
	margin-left: 2px;
	margin-right: 2px;
}
.jconfirm-mcb-confirm .jconfirm-buttons button {
	padding: 10px 30px !important;
}
.jconfirm .jconfirm-box .jconfirm-buttons button.btn-default {
	background-color: #ecf0f1;
	color: #000;
	text-shadow: none;
	-webkit-transition: background .2s;
	transition: background .2s;
}
.jconfirm .jconfirm-box .jconfirm-buttons button {
	display: inline-block;
	padding: 6px 12px;
	font-size: 14px;
	font-weight: 400;
	line-height: 1.42857143;
	text-align: center;
	white-space: nowrap;
	vertical-align: middle;
	-ms-touch-action: manipulation;
	touch-action: manipulation;
	cursor: pointer;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
	border-radius: 4px;
	min-height: 1em;
	-webkit-transition: opacity .1s ease,background-color .1s ease,color .1s ease,background .1s ease,-webkit-box-shadow .1s ease;
	transition: opacity .1s ease,background-color .1s ease,color .1s ease,background .1s ease,-webkit-box-shadow .1s ease;
	transition: opacity .1s ease,background-color .1s ease,color .1s ease,box-shadow .1s ease,background .1s ease;
	transition: opacity .1s ease,background-color .1s ease,color .1s ease,box-shadow .1s ease,background .1s ease,-webkit-box-shadow .1s ease;
	-webkit-tap-highlight-color: transparent;
	border: 0;
	background-image: none;
}
.jconfirm .jconfirm-box .jconfirm-buttons > button {
	margin-bottom: 4px;
	margin-left: 2px;
	margin-right: 2px;
}
.jconfirm-mcb-confirm .jconfirm-buttons button {
	padding: 10px 30px !important;
}
.jconfirm .jconfirm-clear {
	clear: both;
}


</style>






<!--
<style>
  /* Now I have determined what the sidebar will look like for a responsive device */
.hover_collapse2 .sidebar2{
  width: 65px;  
}

.hover_collapse2 .sidebar2 ul li a .text{
    display: none;
  }

.sidebar2{
	position: fixed;
	width: 340px;
	height: 100%;
	background: #f3f2f1;
  right: 65px;
  top: 115px;
  border-left: 1px solid #bebbb8;
}

.sidebar2 ul li a{
	display: block;
	padding: 16px 25px;


}

.sidebar2 ul li a .icon{
	font-size: 18px;
    color: #4c77e4;
	vertical-align: middle;

}

.sidebar2 ul li a .text{
  vertical-align: middle;
	  margin-right: 16px;
	  color: #201f1e;
    font-family: sans-serif;
    font-size: 18px;
    justify-content: center;
    align-items: center;
}


</style>


<style>
  /* Now I have determined what the sidebar will look like for a responsive device */
.hover_collapse3 .sidebar3{
  width: 65px;  
}

.hover_collapse3 .sidebar3 ul li a .text{
    display: none;
  }

.sidebar3{
  float: left;
	position: fixed;
	left: 0;
	width: 340px;
	height: 100%;
	background: #f3f2f1;
  top: 115px;
  border-right: 1px solid #bebbb8;
}

.sidebar3 ul li a{
	display: block;
	padding: 16px 25px;


}

.sidebar3 ul li a .icon{
	font-size: 18px;
    color: #4c77e4;
	vertical-align: middle;

}

.sidebar3 ul li a .text{
  vertical-align: middle;
	  margin-right: 16px;
	  color: #201f1e;
    font-family: sans-serif;
    font-size: 18px;
    justify-content: center;
    align-items: center;
}


</style>
!-->


</head>
<body onload="loadpanelhightInStart()" onbeforeunload="unloadmainformchecking()">
<div id="isc-loading-1" class="loading1"></div>
<div id="isc-loading-2" class="loading2"></div>
<input type="hidden" id="z_f_activetabid"/>
<input type="hidden" id="z_f_activetabcloseid"/>

<% PersianCalendar sc = new PersianCalendar(); %>

<%


    if (!ApplicationInformation.DataIsLoaded) {
        ApplicationInformation.ApplicationBaseAddressOnServer = request.getServletContext().getRealPath("/");
        ApplicationInformation.readDataFromConfigFile();
    }


%>


<%
    String Direction = "ltr";
    if (zdg.zframe.configuration.ApplicationInformation.Direction == 1) {
        Direction = "rtl";
    }
%>
<form id="form1" runat="server" style="height:100%">
  <input type="hidden" id="scroll" runat="server"/>
    <input type="hidden" id="scroll" runat="server"/>

    <div id="mainexp"></div>

    <div Id="wrapper">


      <div class="navbar">
          <div class="hamburger">
              <i style="float:right;background-color: #2266e3;font-size: 28px;padding-right: 20px;padding-left: 20px;" class="fa fa-bars " id='menubar'  aria-hidden="true" onclick="HiddenDivRight('open')"></i>
          </div>
          <a style="font-family: 'Irancell-Bold';color: #f2f2f2;">
              
          <%
            out.println(ApplicationInformation.ApplicationName);
          %>
          </a>
<!--        <img src='NewWork/images/logo.png' style='float: right;  border-left: 1px solid #f2f2f2;'>-->
        <img src="Images/Control/user2.png"  alt="avatar" style='background: #ffffff4f;border-radius: 100px;margin-left: 15px;'>

                <script>
                    $(function () {
                        $('#profile').on('click', function () {
                            $('.user-area-content').toggleClass("show");
                            $('.fa-chevron-down').toggleClass("show");
                            $('.setting-area-content').removeClass("show");
                        })
                    })
                </script>
                <i class="title" id="profile" style="font-family: 'Malgun Gothic';font-style: normal;  font-size: 20px;padding: 13px 16px;border-right: 1px solid #f2f2f2;">
                    <span class="user-name">
                                 <%
                                     try {
                                         out.print(session.getAttribute("UserName").toString());
                                     } catch (Exception ex) {
                                          

                                     }
                                 %>
                            </span>
                    <span class="fa fa-chevron-down arrow" style='font-size:14px;'></span>
                </i>
                <div class="user-area-content">
                    <a>
                        <span class="fa fa-user"></span>
                        <span type="button" id="TitleBar_headerlbldayname" class="title" onclick="showcartabl();"
                              style="cursor: pointer;width:100%;text-align: right; ">
                                کارتابل
                            </span>
                        
                        <span type="button"  class="title" onclick="showcartabl();">     </span>
                        <span type="button" id="cardtablcount" class="title" onclick="showcartabl();"></span>
                    </a>
                    <a>
                        <span class="fa fa-user"></span>
                        <span type="button" id="ShowMessagebtn" class="title" onclick="ShowNotify();"
                              style="cursor: pointer;width:100%;text-align: right; ">پیام غیر فعال </span>
                    </a>
                    <a>
                        <span class="fa fa-user"></span>
                        <span type="button" id="TitleBar_headerlbldayname" class="title" onclick="LogutFromSystem();" style="cursor: pointer; width:100%;text-align: right; ">
                                خروج
                            </span>
                    </a>
                </div>
                <script>
                    $(function () {
                        $('.navbar  .fa-cog').on('click', function () {
                            $('.theme-area-content').removeClass("show");
                            $('.setting-area-content').toggleClass("show");
                            $('.user-area-content').removeClass("show");
                            $('.fa-chevron-down').removeClass("show");

                        })
                    })
                </script>
                <i class="fa fa-cog " aria-hidden="true"></i>	
                <div class="setting-area-content">

                    
                    <a>
                        <%
                            try {
                                String SessionIsAdmin = session.getAttribute("ISADMIN").toString();
                                if (SessionIsAdmin.equals("1")) {
                                    out.println("<span type=\"button\" id=\"TitleBar_headerlbldayname\" class=\"title\" onclick=\"showsetting();\" style=\"cursor: pointer;\" >");
                                    out.println("تنظیمات امنیتی");
                                    out.println("</span>");
                                }
                            } catch (Exception ex) {
                            }
                        %>
                    </a>
                    <a>
                        <span type="button" class="title" onclick="showallwindows();" style="cursor: pointer;">
                                مدیریت پنجره
                            </span>
                    </a>
                </div>
                
              
      
        <div class="expand-area">
                <script>
                    function handleFavorite(val) {
                        let tabElement = $('.tablinks');
                        if (tabElement.length > 0) {
                            const formId = tabElement.attr('id');
                            const id = formId.substr(12, formId.length);
                            const title = tabElement.val();
                            const data = {id, title};
                            if (val === true) {
                                //add to favorite list
                                McbTools.confirmDialog(
                                    {
                                        title: 'اضافه به پرکاربرد ها',
                                        message: 'آیا مایل به اضافه کردن فرم(' + title + ')  به پرکاربرد ها هستید ؟ ',
                                        acceptLabel: 'موافقم',
                                        rejectLabel: 'انصراف'

                                    }
                                ).then(accept => {
                                    console.log(id, title);
                                    const formData = {id, title};
                                    // first get sorage object
                                    const resultAddDate = McbTools.addToFavoriteForm({id, title});
                                    $('#favorite-icon-no').hide();
                                    $('#favorite-icon-yes').show();
                                }).catch(reject => {
                                    console.log("reject");
                                });

                            } else {
                                //remove from favorite list
                                McbTools.confirmDialog(
                                    {
                                        title: 'حذف از پرکاربرد ها',
                                        message: 'آیا مایل به حذف فرم(' + title + ')  از پرکاربرد ها هستید ؟ ',
                                        acceptLabel: 'بلی',
                                        rejectLabel: 'خیر'

                                    }
                                ).then(accept => {
                                    const removeResult = McbTools.removeFavoriteFormData(data);
                                    if (removeResult != null) {
                                        $('#favorite-icon-no').show();
                                        $('#favorite-icon-yes').hide();
                                    }
                                }).catch(reject => {
                                    console.log("reject");
                                });

                            }
                        } else {
                            McbTools.message('اضافه به پرکاربرد ها', 'فرمی انتخاب نشده است ', 'danger');
                        }
                    }

                    $(function () {
                        // let tabCount = 1;
                        $('.expand-area i').toggle(openFullscreen, closeFullscreen);
                        $("#TBC").on('DOMSubtreeModified', function (e) {
                            McbTools.handleStatusOfFavoriteIcon();
                            McbTools.populateFavoriteCard();
                            // console.log(tabCount ++);
                            // console.log(e.timeStamp);
                            // let enableTabCount = $("#TBC input.tablinks").length;
                            // let disableTabCount = $("#TBC input.tablinksNormal").length;
                            // console.log("disableTabCount" , disableTabCount);
                            // console.log("enableTabCount" , enableTabCount);
                            // if (enableTabCount == 0 && disableTabCount == 0) {
                            //     // console.log("is Empty Tab!!!");
                            //     //     $("#cmdtabidfrom0").removeClass().addClass('tablinks');
                            //     //     // $("#TABCC").show();
                            //     //     // McbTools.populateFavoriteCard();
                            // } else {
                            //     //
                            // }
                        });
                        $("#TBC").on('DOMNodeRemoved', function (e) {
                            console.log("DOMNodeRemoved", e);
                        });
                        $("#TBC").on('DOMNodeInserted', function (e) {
                            console.log("DOMNodeInserted", e);
                        });
                        $("#TBC").on('DOMAttrModified', function (e) {
                            console.log("DOMAttrModified", e);
                        });
                        $("#TBC").on('DOMContentLoaded', function (e) {
                            console.log("DOMContentLoaded", e);
                        });

                    });
                    var elem = document.documentElement;

                    /* View in fullscreen */
                    function openFullscreen() {
                        if (elem.requestFullscreen) {
                            elem.requestFullscreen();
                        } else if (elem.webkitRequestFullscreen) { /* Safari */
                            elem.webkitRequestFullscreen();
                        } else if (elem.msRequestFullscreen) { /* IE11 */
                            elem.msRequestFullscreen();
                        }
                    }

                    /* Close fullscreen */
                    function closeFullscreen() {
                  
                    }
                </script>
              <i class="fa fa-expand "  aria-hidden="true"></i>
            </div>
          <i class="favorite">
            <span id="favorite-icon-no" class="fa fa-bookmark" onclick="handleFavorite(true)" style="display: none;">
            </span>
            <span id="favorite-icon-yes" class="fa fa-bookmark-o" onclick="handleFavorite(false)" style="display: none;">
            </span>
          </i>

              
      </div>
      <!-- <div class="wrapper2 hover_collapse2">
        <div class="sidebar2" id="sidebar2">
          <div class="sidebar2_inner">
              <ul>
                  <li>
                      <a href="#">
                          <span class="icon"><i class="fa fa-navicon" aria-hidden="true"></i></span>
                          <span class="text"></span>
                      </a>
                  </li>
              </ul>
          </div>
        </div>
      </div>
      <div class="wrapper3 hover_collapse3">
        <div class="sidebar3" id="sidebar3">
          <div class="sidebar3_inner">
              <ul>
                  <li>
                      <a href="#">
                          <span class="icon"><i class="fa fa-navicon" aria-hidden="true"></i></span>
                          <span class="text"></span>
                      </a>
                  </li>
              </ul>
          </div>
        </div>
      </div>
      !-->
      <div class="wrapper hover_collapse hide" id="PRight">
          <div class="sidebar" id="MainDivTree" style='height: 100%;'>
              <div class="sidebar_inner divMaintree" id="SCDIV"  onscroll="javascript:document.getElementById('scroll').value = this.scrollTop">
                  <ul>
                      <li>
                      <%
                                    try {

                                        session.setAttribute("LTR", "0");
                                        TreeViewManagementPartial CTreeView = new TreeViewManagementPartial(request, response);
                                        String UserID = session.getAttribute("User_ID").toString();
                                        out.write(CTreeView.loadWorkFlowListInTreeView(Integer.valueOf(UserID), zdg.zframe.configuration.ApplicationInformation.Direction,10));
                                    } catch (Exception ex) {
                                       out.print ( "<script> GotoLogin()</script>");
                                    }
                                %>
                                                        <script>
                            $(function () {
                                manageLongText(".ButtonLable", false, 50);
                            });

                            function manageLongText(element, hasValue, length) {
                                $.each($(element), function (i, v) {
                                    if (hasValue) {
                                        if (v.value.length > length) {
                                            // $(this).addClass('tooltip');
                                            $(this).attr("title", v.value);
                                            v.target.value = v.target.value.substr(0, length - 1) + '...';
                                        }
                                    } else {
                                        if (v.innerText.length > length) {
                                            // console.log(v);
                                            // $(this).addClass('tooltip');
                                            $(this).attr("title", v.innerText);
                                            v.innerText = v.innerText.substr(0, length - 1) + '...';
                                        }
                                    }
                                });
                            }
                        </script>
                      </li>
                      
                  </ul>
              </div>
          </div>
          <script>
                            $(function () {
                                manageLongText(".ButtonLable", false, 50);
                            });

                            function manageLongText(element, hasValue, length) {
                                $.each($(element), function (i, v) {
                                    if (hasValue) {
                                        if (v.value.length > length) {
                                            // $(this).addClass('tooltip');
                                            $(this).attr("title", v.value);
                                            v.target.value = v.target.value.substr(0, length - 1) + '...';
                                        }
                                    } else {
                                        if (v.innerText.length > length) {
                                            // console.log(v);
                                            // $(this).addClass('tooltip');
                                            $(this).attr("title", v.innerText);
                                            v.innerText = v.innerText.substr(0, length - 1) + '...';
                                        }
                                    }
                                });
                            }
                        </script>
      </div>
      
      

      <div class="main" id="PLeft" style='transition: margin-right 0.2s ease 0s;'>

<style>
    
    .topmenu
    {
        top:0px;
        width: 100%;
        min-height:30px;
        background-color: #fff;  
    }
    
    </style>
    
    
         
          
                        <div id="divformviewer"
                             style=" background-color:#FFF;  width:100%; max-height: 835px;  background-repeat: no-repeat;    background-attachment: fixed; background-position: center; ">
                            <div id="Loading"   style="opacity:0.8; z-index:5000;  visibility: hidden; position: fixed;top:-10px;left: -10px;  height:110%; width:110%; background-color:#191919; background-image:url('Images/Control/loading2.gif'); background-repeat: no-repeat;    background-attachment:fixed; background-position:center; "></div>  

                           
                            
                            <!--
                                   <div class="MainView" style="width:100%;min-height:100%;float: left;  ">
                                       <iframe id="FormViewer"  class="MainView" src="UserInformation.jsp"   runat="server" style="width:100%;min-height:100%;float: left; height: -webkit-fill-available;">
                                       </iframe>
                                   </div>
                            -->

                            <div>
                                <div id="TBC" name="TBC" class="tab" style="vertical-align:top;" dir="rtl">
                                    <%--                                    <i class="fas fa-chart-pie"></i>--%>
                                    <a id="cmdtabidfrom0" class="tablinks"
                                       onclick="opentabmain( 'tabidfrom0','SelectTabVfrmDesktop','cmdtabidfrom0')"
                                    ><i class="fa fa-home" style='vertical-align: middle;height: 15px;width: 15px;text-align: center;'></i></a>
                                    <%--                                    <input id="cmdclosetabidfrom0" class="tablinksclose" title="بستن"--%>
                                    <%--                                           onclick="CloseTabinMainFormLock('cmdtabidfrom0','cmdclosetabidfrom0','tabidfrom0','0')"--%>
                                    <%--                                           alt="بستن" value="" type="button">&nbsp;--%>

                                </div>
                            </div>
                       
                            <div id="TABCC" name="TABCC" class="MainClass" style="width:100%;min-height:100%;padding:5px;padding-right: 8px;">
                                <script type="text/javascript">
                                    $(function () {
                                        McbTools.populateFavoriteCard();
                                    })
                                </script>
                                <div id="tabidfrom0" name="tabidfrom0" class="tabcontent" zfidlock="0" width="100%"
                                     style="display: block;">
                                </div>
                            </div>


                        </div>


                    </div>

          <script>
        var acc = document.getElementsByClassName("accordion");
        var i;

        for (i = 0; i < acc.length; i++) {

            acc[i].onclick = function () {

                var Panels = document.getElementsByClassName("panel");
                var c;
                for (c = 0; c < Panels.length; c++) {
                    Panels[c].style.maxHeight = null;
                    Panels[c].style.transition = 'opacity 0.10s ease';
                }

                this.classList.toggle("active");
                var panel = this.nextElementSibling;

                if (panel.style.maxHeight) {
                    panel.style.maxHeight = null;
                    panel.style.fontFamily = 'Irancell';
                }             
                else {
                    panel.style.maxHeight = "300%";
                    panel.style.fontFamily = 'Irancell';
                }
            }


        }


    </script>
      </div>
    
</form>

<script src='ZJBPMS/jquery-resizable.js'></script>

<script src="ZJBPMS/index.js"></script>

<script>
      //I have determined the constant of some class function
    var li_items = document.querySelectorAll(".sidebar2 ul li");
    var wrapper = document.querySelector(".wrapper2");
    
    //What will change if you move the mouse over the sidebar
    
    li_items.forEach((li_item)=>{
        li_item.addEventListener("click", ()=>{
          li_item.closest(".wrapper2").classList.remove("hover_collapse2");

          //I have already added style information about hover_collapse
    
        })
      //In general, hover_collapse will be applied on the sidebar.
    
    //Hover_collapse will be removed from the sidebar when the mouse is moved
    })
    
    li_items.forEach((li_item)=>{
        li_item.addEventListener("mouseleave", ()=>{
    
          //Hover Collapse will be applied again when the mouse is removed
          li_item.closest(".wrapper2").classList.add("hover_collapse2");

        })
    })
    
</script>
<script>
        //I have determined the constant of some class function
        var li_items = document.querySelectorAll(".sidebar3 ul li");
    var wrapper = document.querySelector(".wrapper3");
    
    //What will change if you move the mouse over the sidebar
    
    li_items.forEach((li_item)=>{
        li_item.addEventListener("click", ()=>{
          li_item.closest(".wrapper3").classList.remove("hover_collapse3");

          //I have already added style information about hover_collapse
    
        })
      //In general, hover_collapse will be applied on the sidebar.
    
    //Hover_collapse will be removed from the sidebar when the mouse is moved
    })
    
    li_items.forEach((li_item)=>{
        li_item.addEventListener("mouseleave", ()=>{
    
          //Hover Collapse will be applied again when the mouse is removed
          li_item.closest(".wrapper3").classList.add("hover_collapse3");

        })
    })
    
</script>
<script type="text/javascript">
  //I have determined the constant of some class function
  var subnavbtn = document.querySelectorAll(".subnav");

  //What will change if you move the mouse over the sidebar
  
  subnavbtn.forEach((subnavbtn)=>{
    subnavbtn.addEventListener("mouseenter", ()=>{
  
        document.getElementById("sidebar2").style.top = " 163px";
        document.getElementById("sidebar3").style.top = " 163px";   
        document.getElementById("main").style.marginTop  = " 60px";
        //I have already added style information about hover_collapse
  
      })
    //In general, hover_collapse will be applied on the sidebar.
  
  //Hover_collapse will be removed from the sidebar when the mouse is moved
  })
  
  subnavbtn.forEach((subnavbtn)=>{
    subnavbtn.addEventListener("mouseleave", ()=>{
  
        document.getElementById("sidebar2").style.top = " 115px";
        document.getElementById("sidebar3").style.top = " 115px";
        document.getElementById("main").style.marginTop  = " 0px";
        //Hover Collapse will be applied again when the mouse is removed
  
      })
  })
  
  </script>
<script type="text/javascript">
    //I have determined the constant of some class function
    var li_items = document.querySelectorAll(".sidebar ul li");
    var hamburger = document.querySelector(".hamburger");
    var wrapper = document.querySelector(".wrapper");
    const Panels = document.getElementsByClassName("panel");
    //What will change if you move the mouse over the sidebar
    

    
    //Now I will execute the menu button
    
    //I have instructed here that hover_collapse will be applied and removed when the menu button is clicked.
    
    //This means that the first click will be applied and the second click will be removed

    </script>
    <script>
        const element = document.getElementById("SCDIV"); 
        const nodes = element.getElementsByClassName("accordion");
      for (let i = 0; i < nodes.length; i++) {
        if( i == 0){
          const txt = element.getElementsByClassName("accordion")[i].innerHTML;
          element.getElementsByClassName("accordion")[i].innerHTML = '<div style="float:right;direction:right;"><span class="text">'+txt+' &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa fa-home" aria-hidden="true" style="font-size:18px;"></i></span><span class="icon"><i class="fa fa-home" aria-hidden="true" style="font-size:18px;"></i></span></div>';
       }
        else
        {
          const txt = element.getElementsByClassName("accordion")[i].innerHTML;
          element.getElementsByClassName("accordion")[i].innerHTML ='<div style="float:right;direction:right;"><span class="text">'+txt+' &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa fa-indent" aria-hidden="true" style="font-size:18px;"></i></span><span class="icon"><i class="fa fa-indent" aria-hidden="true" style="font-size:18px;"></i></span></div>';
        }
             
        
      } 
    </script>  
<script>
    //vertical-align: middle;
    //text-align: center;
</script>
                <script type="text/javascript">
                        var li_items = document.querySelectorAll(".sidebar ul li");      
                        li_items.forEach((li_item)=>{
                        li_item.addEventListener("click", ()=>{
                                li_item.closest(".wrapper").classList.remove("hover_collapse");
                                li_item.closest(".wrapper").classList.remove("hide");
                                li_item.closest(".wrapper").classList.add("show");
                                li_item.closest(".wrapper").classList.add("hide-icon");
                            //var navbar2 = document.getElementById('navbar2');
                            //navbar2.style.marginRight = '';
                            var navbar2 = document.getElementById('PLeft');
                            navbar2.style.marginRight = '310px';
                          //Hover Collapse will be applied again when the mouse is removed
                            document.getElementById("menubar").setAttribute( "onClick", "HiddenDivRight('close');" ) ;
                        })
                    })
                    
                   
                    
                    function HiddenDivRight(state) {
                      if (state === 'open'){
                      
                        var li_items = document.querySelectorAll(".sidebar ul li");      
                      li_items.forEach((li_item)=>{
                                  li_item.closest(".wrapper").classList.remove("hover_collapse");
                                  li_item.closest(".wrapper").classList.remove("hide");
                                  li_item.closest(".wrapper").classList.add("show");
                                  li_item.closest(".wrapper").classList.add("hide-icon");
                                  var c;
                                  for (c = 0; c < Panels.length; c++) {
                                    Panels[c].style.maxHeight = null;
                                  }
                      
                          })
                      //var navbar2 = document.getElementById('navbar2');
                      //navbar2.style.marginRight = '';
                        var navbar2 = document.getElementById('PLeft');
                        navbar2.style.marginRight = '310px';
                      document.getElementById("menubar").setAttribute( "onClick", "HiddenDivRight('close');" ) ;
                      }
                      else{
                        document.getElementById("menubar").setAttribute( "onClick", "HiddenDivRight('open');" );
                        var li_items = document.querySelectorAll(".sidebar ul li");

                      li_items.forEach((li_item)=>{
                                  li_item.closest(".wrapper").classList.add("hover_collapse");
                                  li_item.closest(".wrapper").classList.add("hide");
                                  li_item.closest(".wrapper").classList.remove("show");
                                  li_item.closest(".wrapper").classList.remove("hide-icon");
                        //var navbar2 = document.getElementById('navbar2');
                        //navbar2.style.marginRight = '';
                        var navbar2 = document.getElementById('PLeft');
                        navbar2.style.marginRight = '';
                      
                          })
                      }
                    }

                    function CBox2() {
                        var li_items = document.querySelectorAll(".sidebar ul li");
                        var NotAccess = document.getElementById('landing');
                        NotAccess.style.visibility = 'hidden';
                    }

                    function CBox2() {
                        var NotAccess = document.getElementById('landing');
                        NotAccess.style.visibility = 'hidden';
                    }

                    function PNU() {
                        var PnU = document.getElementById('landing');
                        PnU.style.visibility = 'hidden';
                        var ValR = document.getElementById('PRight');
                        ValR.style.visibility = 'visible';
                        var IfameL = document.getElementById('PLeft');
                        IfameL.style.width = '80%';

                    }

                </script>
                <script>
               // document.getElementById("New").addEventListener("click", myFunction);

                //function myFunction() {
                //  document.getElementById("demo").innerHTML = "YOU CLICKED ME!";
                //}<input id="frmInvoiceCmdNew" name="frmInvoiceCmdNew" title="New" class="ToolBoxControl"  onclick="return setnew('frmInvoiceinvoice_ID');" formnovalidate="">
                </script>

                <script>
                 $('#frmInvoiceCmdNew').click(function(){
                    //do something
                    console.log('yes')
                 return setnew('frmInvoiceinvoice_ID');
                  });
                </script>
                
                
                
<script src='ZJBPMS/jquery-resizable.js'></script>

<script src="ZJBPMS/index.js"></script>



    <script>
        var myVar = setInterval(myTimer, 100000);

        async function myTimer() {
            //var d = new Date();
            //document.getElementById("timerlabel").innerHTML = d.toLocaleTimeString();
            var xmlHttp = null;
            xmlHttp = new XMLHttpRequest();
            var urlv = baseapplicationsrc + 'notification.jsp';
            xmlHttp.open("GET", urlv, false);
            xmlHttp.send(null);
            var data = xmlHttp.responseText;
//            var s = document.getElementById("Notify").innerHTML;
//            if (s.trim() != data.trim()) {
//
//                document.getElementById("Notify").innerHTML = data;
//                //$.notify(data, "success");
//
//            }
          //  let q = await call_current_proccess_task();  
          //      document.getElementById('cardtablcount').innerHTML = q[0].CC ;
        }

    </script>
    
<script>


    __documentlocktab__ = true;


    var iframelist = [];
    var contentlist = [];

    function showallwindows() {
        var tablinks = document.getElementsByClassName("tablinksNormal");

        if (tablinks.length > 0) {
            var htcode = "<div id=\"mainexp\" ondblclick=\"closewindowsexp();\"  class=\"ShowPanel\"><table style=\"width:100%\"><tr>";

            var rowcount = 1;
            if (tablinks.length > 4) {
                rowcount = tablinks.length / 4;
            }

            for (var i = 0; i < tablinks.length; i++) {
                var nowcommand = tablinks[i];

                var cmdid = nowcommand.id;
                var ex = cmdid.substring(12);
                var ifarmeid = "FormViewercmdtabidfrom" + ex;


                htcode += "<td style=\"with:20%; height:80px;  vertical-align: baseline;\">";
                htcode += "<span class=\"Title\">";
                htcode += nowcommand.value;
                htcode += "</span><br>";
                var pagename = "vpage" + ex;
                htcode += "<div id=\"" + pagename + "\"> <img onclick=\"dowindowsShow('" + cmdid + "')\"  src=\"Images/ZFWIN.png\" > </div>";
                iframelist.push(ifarmeid);
                contentlist.push(pagename);
                htcode += "</td>";
                var q = i + 1;
                var rq = q % 4;
                if ((rowcount > 1) && (i > 2) && rq === 0) {
                    htcode += "</tr><tr>"
                }

            }

            htcode += "</tr></table></div>"
            var mainexpdiv = document.getElementById("mainexp");
            mainexpdiv.innerHTML = htcode;
        }
    }


    function dowindowsShow(commandidvalue) {
        closewindowsexp();
        var commandaction = document.getElementById(commandidvalue);
        commandaction.click();
    }

    function closewindowsexp() {
        var mainexpdiv = document.getElementById("mainexp");
        mainexpdiv.innerHTML = "";
    }

    $(function () {
        $(".LinkLabelTree").on("click", function () {
            $(this).toggleClass("selected");
        })

        $("<div class='divider div-transparent'></div>").insertAfter(".panel-right .panel table");
    })
    
         async function call_current_proccess_task()
{
	       var param = []; 
                 param.push({name:'p0', value:'0'});
 	 	 let s= await  callZf_jslib('proccess/','current_proccess_task',param,2); 
	 	 return s; 
}



  function closeMenu()
        {
            
            document.body.className  ="layout-mini layout-sticky-subnav headings-family-exo2 has-drawer-opened";
               //t.toggle();
             //var t = document.getElementsByClassName('mdk-drawer__content js-sidebar-mini');
             
        }
        
        function ACTIVEMNU()
        {
           document.body.className  ="layout-mini layout-sticky-subnav headings-family-exo2 has-drawer-opened layout-mini--open";
        }
        
</script>

        <footer>
        <div class="date-area">
            <span>امروز </span>
            <b><% out.print(sc.strWeekDay);%></b>
            <span>مورخ</span>
            <b><% out.print(PersianCalendar.getCurrentShamsidate()); %></b>
            <span>ساعت </span>
            <b>
                <%
                    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("HH:mm:ss");
                    LocalDateTime now = LocalDateTime.now();
                    String TimeV = dtf.format(now);
                    out.print(TimeV);
                %>
            </b>
        </div>

    </footer>
</body>
</html>
