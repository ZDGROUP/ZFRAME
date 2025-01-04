<%-- 
Document   : filter
Created on : Mar 29, 2023, 11:46:16 AM
Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"> 
<head id="Head1"> 
<title>Filter Setting</title> 
<script src="ZJBPMS/calendar.all.js" type="text/javascript"></script> 
<script src="ZJBPMS/calendar.js" type="text/javascript"></script> 
<script src="ZJBPMS/zfjquery.js" type="text/javascript"></script> 
<script src="ZJBPMS/zfjquery.ui.core.js" type="text/javascript"></script> 
<script src="ZJBPMS/jquery.ui.datepicker-cc-ar.js" type="text/javascript"></script> 
<script src="ZJBPMS/jquery.ui.datepicker-cc-fa.js" type="text/javascript"></script> 
<script src="ZJBPMS/jquery.ui.datepicker-cc.js" type="text/javascript"></script> 
<script src="ZJBPMS/jquery-confirm.min.js" type="text/javascript"></script> 
<script src="ZJBPMS/colResizable-1.6.min.js" type="text/javascript"></script> 
<script src="ZJBPMS/zbpms.js" type="text/javascript"></script> 
<script src="ZJBPMS/Application.js" type="text/javascript"></script> 
<link type="text/css" href="Style/jquery-confirm.min.css" rel="stylesheet" />
<link type="text/css" href="Style/jquery-ui-1.8.14.css" rel="stylesheet" />
<link href="Style/Main.css" rel="stylesheet" type="text/css"/> 
<script src="ZJavaScript.js?ID=15111" type="text/javascript"></script> <script type="text/javascript">
    
$(function () {
    $(".Grid").rtlColResizable();
})


</script></head> 
<body    style="background-image: url('Images/BGG12.jpg');"  onload="CheckPriceText()"  > 

<form method="post"  enctype="multipart/form-data" id="bpmform"  > 

<input type="hidden" id="___zf_uniquekey" name="___zf_uniquekey" value="af470f09-eeff-45ff-8bb1-7fd0173bdb86" > <input type="hidden" id="___pagescrolvalue" name="___pagescrolvalue"  value="null" > <input type="hidden" id="__ZFRAMEACTIVETAB" name="__ZFRAMEACTIVETAB"  zid="__ZFRAMEACTIVETAB" value="null" > <input type="hidden" id="___zframepostmethod" name="___zframepostmethod"  value="0" > 
<div  ID = "GridPanel" Name = "GridPanel" >  </div> 

<div  ID = "FormPanel" Name = "FormPanel"onscroll = "managescrollform();"  >   <Input Type="hidden"  ID = "P_ZBPMSKEYIDFORPASSING" Name = "P_ZBPMSKEYIDFORPASSING" ZFT = "0" Value = "0" > 
<Input Type="hidden"  ID = "SelectRecordID" Name = "SelectRecordID" ZFT = "0" > 
<Input Type="hidden"  ID = "csrftoken" Name = "csrftoken" ZFT = "0" Value = "a89b4fe7e1894fa980b51a8428b0e6c2" > 
<Input Type="hidden"  ID = "csrftokencid" Name = "csrftokencid" ZFT = "0" Value = "4156f88351bc6b3cf00341e3d28316dc" > 
<Input Type="hidden"  ID = "SELECTROWID" Name = "SELECTROWID" ZFT = "0" > 
<Input Type="hidden"  ID = "SelectRecordValue" Name = "SelectRecordValue" ZFT = "0" > 
<input type="hidden" id="___formtreeviewstatus" name="___formtreeviewstatus" value=""  > 
<Input Type="hidden"  ID = "FilterP_UIFromFactoryFormRecordID" Name = "FilterP_UIFromFactoryFormRecordID" ZFT = "0" Value = "0" > 
<Input Type="hidden"  ID = "__EVENTTARGETFilter" Name = "__EVENTTARGETFilter" ZFT = "0" > 
<Input Type="hidden"  ID = "__EVENTARGUMENTFilter" Name = "__EVENTARGUMENTFilter" ZFT = "0" > 
<Input Type="hidden"  ID = "FilterP_Message" Name = "FilterP_Message" ZFT = "0" > 
<Input Type="hidden"  ID = "__INFORMATION_CON" Name = "__INFORMATION_CON" ZFT = "0" Value = "Filter" > 
<Input Type="hidden"  ID = "FilterP_EditMode" Name = "FilterP_EditMode" ZFT = "0" > 
<Input Type="hidden"  ID = "FilterP_GridSelectRecordID" Name = "FilterP_GridSelectRecordID" ZFT = "0" > 
<Input Type="hidden"  ID = "FilterP_GridSelectColumnsSort" Name = "FilterP_GridSelectColumnsSort" ZFT = "0" > 
<Input Type="hidden"  ID = "FilterP_GridSelectColumnsSortMode" Name = "FilterP_GridSelectColumnsSortMode" ZFT = "0" > 
<Input Type="hidden"  ID = "FilterP_GridSelectPageIndex" Name = "FilterP_GridSelectPageIndex" ZFT = "0" > 
<Input Type="hidden"  ID = "FilterP_GridSearchMode" Name = "FilterP_GridSearchMode" ZFT = "0" > 
	<div dir="RTL" id="formcontainer" style="margin: 3px 0 0 0;"  align="center"> 

            <div style="visibility: hidden;">
                <TABLE id="basetable">
															<TBODY>
																<TR>
																	<TD><SPAN class=Title>مقدار</SPAN><SPAN class=Title>:</SPAN>    </TD>
																	<TD > 
																		<Input Type="Text" Class ="InputText"  > 
																	</TD>
																	<TD  > 
																		<Input type="button" value="Add" ID = "cmdadd" class="cmdadd"  onclick="addtext('');"> 
																	</TD>
                                                                                                                                <TD   > 
																		<Input type="button" value="Remove" ID = "cmdadd" class="cmdremove"  onclick="removetext(this);"> 
																	</TD>
                                                                                                                                </TR>
																<TR></TR></TBODY>
                                                                                                                </TABLE>
            </div>
	
						<DIV id=maindivecontainer style="WIDTH: 90%">
							<DIV class=cctab style="WIDTH: 100%"><INPUT onclick="opencutab(this, 'TAB1')" id=CMDTAB1 class=cctablinks type=button value="فیلتر از تا"> <INPUT onclick="opencutab(this, 'TAB2')" id=CMDTAB2 class=cctablinks type=button value="فیلتر از تا در تاریخ شمسی"> <INPUT onclick="opencutab(this, 'TAB3')" id=CMDTAB3 class=cctablinks type=button value="فیلتر از تا در تاریخ میلادی"> <INPUT onclick="opencutab(this, 'TAB4')" id=CMDTAB4 class=cctablinks type=button value="فیلتر یکی از موارد "> </DIV></N>
												<DIV id=TAB1 class=cctabcontent style="FLOAT: right">
													<DIV style="WIDTH: 100%">
														<TABLE style="WIDTH: 100%">
															<TBODY>
																<TR>
																	<TD><SPAN class=Title>ازمقدار</SPAN> </TD>
																	<TD > 
																		<Input Type="Text"  ID = "FilterfromValue0" Name = "FilterfromValue0" ZFT = "0" ZID = "fromValue" ZCP = "ازمقدار" Class = "InputText" title=" "  > 
																	</TD>
																	<TD><SPAN class=Title>تا مقدار</SPAN> </TD>
																	<TD > 
																		<Input Type="Text"  ID = "Filtertovalue0" Name = "Filtertovalue0" ZFT = "0" ZID = "tovalue" ZCP = "تا مقدار" Class = "InputText" title=" "  > 
																	</TD></TR>
																<TR>
																	<TD colSpan=2 > 
                                                                                                                                            <Input type="button"  ID = "Filtercmdcommit10" Name = "Filtercmdcommit10" ZFT = "12" ZID = "cmdcommit1" ZCP = "ثبت" Value = "ثبت" Class = "CommandSetFilter" title=" " onclick="doset(1);"  > 
																	</TD></TR></TBODY></TABLE></DIV></DIV>
												<DIV id=TAB2 class=cctabcontent style="FLOAT: right">
													<DIV style="WIDTH: 100%">
														<TABLE style="WIDTH: 100%">
															<TBODY>
																<TR>
																	<TD><SPAN class=Title>از تاریخ شمسی</SPAN> </TD>
																	<TD > 
																		<Input Type="Text" Dir="rtl" placeholder="0000/00/00" data-mask="9999/99/99" data-mask-selectonfocus="true" autocomplete="off"   ID = "Filterfromdatesh0" Name = "Filterfromdatesh0" ZID="fromdatesh"  ZCP = "از تاریخ شمسی" Style = " width:150px; "  title=" "  onchange="fixvalidatezframe(this);" > <script type="text/javascript">$(function () {
																				var options = $.extend({},
																						$.datepicker.regional["fa"], {
																					dateFormat: 'yy/mm/dd',
																					showButtonPanel: true,
																				}
																				);
$('#Filterfromdatesh0').datepicker(options);
});</script>
																	</TD>
																	<TD><SPAN class=Title>تا تاریخ شمسی</SPAN> </TD>
																	<TD > 
																		<Input Type="Text" Dir="rtl" placeholder="0000/00/00" data-mask="9999/99/99" data-mask-selectonfocus="true" autocomplete="off"   ID = "Filtertodatesh0" Name = "Filtertodatesh0" ZID="todatesh"  ZCP = "تا تاریخ شمسی" Style = " width:150px; "  title=" "  onchange="fixvalidatezframe(this);" > <script type="text/javascript">$(function () {
																				var options = $.extend({},
																						$.datepicker.regional["fa"], {
																					dateFormat: 'yy/mm/dd',
																					showButtonPanel: true,
																				}
																				);
$('#Filtertodatesh0').datepicker(options);
});</script>
																	</TD></TR>
																<TR>
																	<TD colSpan=2 > 
																		<Input type="button"  ID = "Filtercmdcommit20" Name = "Filtercmdcommit20" ZFT = "12" ZID = "cmdcommit2" ZCP = "ثبت" Value = "ثبت" Class = "CommandSetFilter" title=" " onclick="doset(2);"  > 
																	</TD></TR></TBODY></TABLE></DIV></DIV>
												<DIV id=TAB3 class=cctabcontent style="FLOAT: right">
													<DIV style="WIDTH: 100%">
														<TABLE style="WIDTH: 100%">
															<TBODY>
																<TR>
																	<TD><SPAN class=Title>از تاریخ میلادی</SPAN> </TD>
																	<TD > 
																		<Input Type="Text" Dir="rtl" placeholder="0000/00/00" data-mask="9999/99/99" data-mask-selectonfocus="true" autocomplete="off"   ID = "Filterfromdatemi0" Name = "Filterfromdatemi0" ZID="fromdatemi"  ZCP = "از تاریخ میلادی" Style = " width:150px; "  title=" "  onchange="fixvalidatezframe(this);" > <script type="text/javascript">$(function () {
																				var options = $.extend({},
																						$.datepicker.regional[""], {
																					dateFormat: 'yy/mm/dd',
																					showButtonPanel: true,
																				}
																				);
$('#Filterfromdatemi0').datepicker(options);
});</script>
																	</TD>
																	<TD><SPAN class=Title>تا تاریخ میلادی</SPAN> </TD>
																	<TD > 
																		<Input Type="Text" Dir="rtl" placeholder="0000/00/00" data-mask="9999/99/99" data-mask-selectonfocus="true" autocomplete="off"   ID = "Filtertodatemi0" Name = "Filtertodatemi0" ZID="todatemi"  ZCP = "تا تاریخ میلادی" Style = " width:150px; "  title=" "  onchange="fixvalidatezframe(this);" > <script type="text/javascript">$(function () {
																				var options = $.extend({},
																						$.datepicker.regional[""], {
																					dateFormat: 'yy/mm/dd',
																					showButtonPanel: true,
																				}
																				);
$('#Filtertodatemi0').datepicker(options);
});</script>
																	</TD></TR>
																<TR>
																	<TD colSpan=2 > 
																		<Input type="button"  ID = "Filtercmdcommit30" Name = "Filtercmdcommit30" ZFT = "12" ZID = "cmdcommit3" ZCP = "ثبت" Value = "ثبت" Class = "CommandSetFilter" title=" " onclick="doset(3);"  > 
																	</TD></TR></TBODY></TABLE></DIV></DIV>
												<DIV id=TAB4 class=cctabcontent style="FLOAT: right">
													<DIV style="WIDTH: 100%" id="isoneoff">
														<TABLE >
															<TBODY>
																<TR>
																	<TD><SPAN class=Title>مقدار</SPAN><SPAN class=Title>:</SPAN>    </TD>
																	<TD > 
																		<Input Type="Text" Class ="InputText"  > 
																	</TD>
																	<TD  > 
																		<Input type="button" value="Add" ID = "cmdadd" class="cmdadd"  onclick="addtext('');"> 
																	</TD>
                                                                                                                                <TD   > 
																		
																	</TD>
                                                                                                                                </TR>
																<TR></TR></TBODY>
                                                                                                                </TABLE>
                                                                                                              
                                                                                                        </DIV>
                                                                                                  <TABLE >
															<TBODY>
																<TR>
																	<TD colSpan=2 > 
																		<Input type="button"  ID = "Filtercmdcommit40" Name = "Filtercmdcommit40" ZFT = "12" ZID = "cmdcommit4" ZCP = "ثبت" Value = "ثبت" Class = "CommandSetFilter" title=" "  onclick="doset(4);"> 
																	</TD></TR>
																<TR></TR></TBODY>
                                                                                                                </TABLE>
                                                                                                </DIV>
  	<Input type="button"  ID = "cmdcancel" Name = "cmdcancel" ZFT = "12" ZID = "cmdcancel" ZCP = "ثبت" Value = "حذف فیلتر" Class = "CommandSetFilterRemove" title=" "  onclick="doset(5);"> 
												</DIV>
												<STYLE>
													/* Style the tab */
													.cctab {
														overflow: hidden;
														border: 1px solid #ccc;
														background-color: #f1f1f1;
													}

													.lblstylemsg{
														font-size:18pt;
														font-family:BZARF;
														color:#1f9d1d;

													}

													.lblstylemsgh{
														font-size:25pt;
														font-family:BZARF;
														color:#0b34d5;

													}


													/* Style the buttons that are used to open the tab content */
													.cctab input {
														background-color: #199b64;
														float: right;
														color:#000;
														border: none;
														outline: none;
														cursor: pointer;
														padding: 14px 16px;
														transition: 0.3s;
														height:60px;
														width:200px;
                                                                                                                border: solid 1px  #ffffff;
													}

													/* Change background color of buttons on hover */
													.cctab input:hover {
														background-color: #5be357;
													}

													/* Create an active/current tablink class */
													.cctab input.active {
														background-color: #05150cd4;
													}

													/* Style the tab content */
													.cctabcontent {
														display: none;
														padding: 6px 12px;
														width: 100%;
														border: 1px solid #ccc;
														border-top: none;        
                                                                                                                background-color: #ffffff;
													}
                                                                                                        
                                                                                                        input.CommandSetFilter
                                                                                                        {
                                                                                                            width:150px;
                                                                                                            height:30px;
                                                                                                            background-color: #1A1EF7 ;
                                                                                                            color: #fff !important;
                                                                                                        }
                                                                                                        input.CommandSetFilterRemove
                                                                                                        {
                                                                                                            width:150px;
                                                                                                            height:30px;
                                                                                                            margin:  20px;
                                                                                                            background-color: #ff6666;
                                                                                                            color: #f1f1f1 !important;
                                                                                                        }
                                                                                                        
                                                                                                        input.cmdadd
                                                                                                        {
                                                                                                            width:70px;
                                                                                                            height:30px;
                                                                                                            background-color: #33cc00;
                                                                                                            color: #f1f1f1 !important;
                                                                                                        }
                                                                                                        input.cmdremove
                                                                                                        {
                                                                                                             width:70px;
                                                                                                            height:30px;
                                                                                                            background-color: #ff3333;
                                                                                                            color: #f1f1f1 !important;
                                                                                                        }

												</STYLE>

												<SCRIPT>


													jQuery(document).ready(function ($) {


														loadactivetab();


													});

													function loadactivetab() {
														var activetabcontrol = getElementByAttribute('zid', '__ZFRAMEACTIVETAB', null);
														var h = activetabcontrol.value;
														if (h == "null") {
															var defo = document.getElementById('CMDTAB1');
															opencutab(defo, 'TAB1')
														} else {
															var ac = document.getElementById(h);

															var n = h.length;
															var tabname = h.substr(h.length - 1, h.length);
															opencutab(ac, 'TAB' + tabname);


														}
													}


													function opencutab(sendero, tbname) {

														var activetabcontrol = getElementByAttribute('zid', '__ZFRAMEACTIVETAB', null);
														activetabcontrol.value = sendero.id;
														var i, tabcontent, tablinks;
														tabcontent = document.getElementsByClassName("cctabcontent");
														for (i = 0; i < tabcontent.length; i++) {
															tabcontent[i].style.display = "none";
														}

														tablinks = document.getElementsByClassName("cctablinks");
														for (i = 0; i < tablinks.length; i++) {
															tablinks[i].className = tablinks[i].className.replace(" active", "");
														}

														document.getElementById(tbname).style.display = "block";
														sendero.className += " active";
													}



												</SCRIPT>
												<Input Type="hidden"  ID = "Filterfilter_id" Name = "Filterfilter_id" ZFT = "0" ZID = "filter_id" ZCP = "filter_id" title=" "  > 
													</div> 

													</div> 
													<div id="findobjectinOtherform"> </div>
													<input type="hidden" id="zxposvalueform" name="zxposvalueform" value="" > 
														<input type="hidden" id="zyposvalueform" name="zyposvalueform" value="" > 
															<input type="hidden" id="__zfstatebag" name="__zfstatebag" value="0" > 
																</form> <script src="ZJBPMS/jquery.mask.js" type="text/javascript"></script> 
     <script>
    //Make the DIV element draggagle:
            if (document.getElementById(("moveTbl"))) {
                    dragElement(document.getElementById(("moveTbl")));
            }
            
            function dragElement(elmnt) {
                    var pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;
                    if (document.getElementById(elmnt.id + "header")) {
                            /* if present, the header is where you move the DIV from:*/
                            document.getElementById(elmnt.id + "header").onmousedown = dragMouseDown;
                    } else {
                            /* otherwise, move the DIV from anywhere inside the DIV:*/
                            elmnt.onmousedown = dragMouseDown;
                    }

                    function dragMouseDown(e) {
                            e = e || window.event;
                            // get the mouse cursor position at startup:
                            pos3 = e.clientX;
                            pos4 = e.clientY;
                            document.onmouseup = closeDragElement;
                            // call a function whenever the cursor moves:
                            document.onmousemove = elementDrag;
                    }

                    function elementDrag(e) {
                            e = e || window.event;
                            // calculate the new cursor position:
                            pos1 = pos3 - e.clientX;
                            pos2 = pos4 - e.clientY;
                            pos3 = e.clientX;
                            pos4 = e.clientY;
                            // set the element's new position:
                            elmnt.style.top = (elmnt.offsetTop - pos2) + "px";
                            elmnt.style.left = (elmnt.offsetLeft - pos1) + "px";
                            zxposvalueform.value = (elmnt.offsetTop - pos2) + "px";
                            zyposvalueform.value = (elmnt.offsetLeft - pos1) + "px";
                    }

                    function closeDragElement() {
                            /* stop moving when mouse button is released:*/
                            document.onmouseup = null;
                            document.onmousemove = null;
                    }
            }

            function doset(typec)
            {
                switch(typec)
                {
                    case 1:

                        var value="{\"type\":\"1\",\"fromvalue\":\""+FilterfromValue0.value+"\",\"tovalue\":\""+Filtertovalue0.value+"\"}";
                        var v1 = _encod64url(value);
                        SelectRecordID.value = v1 ;
                        doselectobjectforparentform(v1,'');
                        break;

                      case 2:

                        var value2="{\"type\":\"2\",\"fromvalue\":\""+Filterfromdatesh0.value+"\",\"tovalue\":\""+Filtertodatesh0.value+"\"}";
                        var v2 = _encod64url(value2);
                        SelectRecordID.value = v2 ;
                        doselectobjectforparentform(v2,'');
                        break;

                      case 3:

                        var value3="{\"type\":\"3\",\"fromvalue\":\""+Filterfromdatemi0.value+"\",\"tovalue\":\""+Filtertodatemi0.value+"\"}";
                        var v3 = _encod64url(value3);
                        SelectRecordID.value = v3 ;
                        doselectobjectforparentform(v3,'');
                        break;
                       case 4:

                        var values = ",";  
                        var allobjects = document.getElementsByClassName('InputText');
                         for (var i = 0; i < allobjects.length; i++) 
                            { 
                                if (allobjects[i].value.trim().length > 0)
                                {
                                    values += allobjects[i].value.trim()+",";
                                }
                            } 
                        var value4="{\"type\":\"4\",\"values\":\""+values+"\"}";
                        var v4="";        
                        if (values.trim().length > 2 )
                        {
                                v4=  _encod64url(value4);
                        }      
                        SelectRecordID.value = v4 ;
                        doselectobjectforparentform(v4,'');
                        break;
                        case 5:
                         doselectobjectforparentform('1','');
                        break;
                }
            }

            function doselectobjectforparentform(val,textv)
            {
                    try 
                    {
                      var idv = document.getElementById('SelectRecordID');
                      idv.value = val;
                      var a = parent.document.getElementById('closeandapplay');
                      a.click();
                    }
                    catch (e)
                    {}
            }
            
            function addtext(textvalue)
            {
                var basetable = document.getElementById('basetable');
                var notext= basetable.getElementsByClassName('InputText')[0];
                notext.value = textvalue; 
                const clone = basetable.cloneNode(true);
                var c = clone.getElementsByClassName('InputText')
                c[0].value =textvalue;
                maindiv =  document.getElementById('isoneoff');
                maindiv.appendChild(clone);
                notext.value = "";
                c[0].focus();
            }
            
         
            
            let arraycheck=[];
             $(document).on("paste", ".InputText", function(e){
                         event.preventDefault();
                   var pastedData = e.originalEvent.clipboardData.getData('text');
                   const result = pastedData.split(/\r?\n/);
                  if (result.length > 0)
                  {
                   arraycheck.push(result[0]);
                   result.forEach(processtext);
                   this.value = result[0];
                  }
                  else
                  {
                    arraycheck.push(pastedData);
                    this.value =  pastedData; 
                  }
              });
            
             $(document).on("keypress", ".InputText", function(e){
                     if(e.which == 13) {
                              addtext("");
                        }
                        else  if(e.which == 46) {
                              removetext(this);
                        }
                      
              });
            
             function removetext(obj)
            {
               var txtboxc = obj.parentElement.parentElement.getElementsByClassName('InputText')[0];
               arraycheck = arraycheck.filter(e => e !==  txtboxc.value ); 
               txtboxc.value= "";
               var relement = obj.parentElement.parentElement;
               while (relement.firstChild) {
                        relement.removeChild(relement.firstChild);
                        
                  }
                 relement.remove();
            }
            function processtext(value, index, array) {
                if (!arraycheck.includes(value))
                {
                    if (index > 0)
                    {
                            if (value.trim().length > 0)
                            {
                                addtext(value);
                                arraycheck.push(value);
                            }
                     }
                } 
            }
             
            $(document).ready(function() 
            {
                __active_enter_for_change = false;
               var  value  = GetUrlParameter('content');
               if (value.length > 1)
               {
                   var truestring =_decode64url(value) ;
                   const obj = JSON.parse(truestring);
                   if (obj.type == 1)
                   {
                       FilterfromValue0.value=obj.fromvalue;
                       Filtertovalue0.value=obj.tovalue;
                       opencutab(CMDTAB1, 'TAB1')
                   }
                   if (obj.type == 2)
                   {
                       Filterfromdatesh0.value=obj.fromvalue;
                       Filtertodatesh0.value=obj.tovalue;
                       opencutab(CMDTAB2, 'TAB2')
                   }
                   if (obj.type == 3)
                   {
                        Filterfromdatemi0.value=obj.fromvalue;
                        Filtertodatemi0.value = obj.tovalue;
                        opencutab(CMDTAB3, 'TAB3')
                   }
                   if (obj.type == 4)
                   {
                       var values = obj.values;
                       const result = values.split(/,/);
                       result.forEach(processtext);
                       opencutab(CMDTAB4, 'TAB4')
                   }
                  
               }
            });
            
            function _encod64url(value)
            {
               var v1 = encodeURI(value);
               var v2 = b64EncodeUnicode(v1);
               return v2;
            }
            
            function _decode64url(value)
            {
                var v1 = b64DecodeUnicode(value)
                var v2 = decodeURI(v1);
                return v2;
            }
            
            
            
           
    </script>
																</body> 
																</html> 