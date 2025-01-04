











//
//
window.onerror = async function (sMessage, sUrl, sLine) {
            alert("An error occurred :" + sMessage + "\nURL : "+ sUrl + "\nLine Number: " + sLine + "\n windows location:" + window.location.href);
            await call_java_script_error (window.location.href,sUrl,sMessage,sLine);
            return true;
        }
//        
 


 async function call_java_script_error(P_url_address,P_file_name,P_error_text,P_line_number)
{
	 var param = []; 
	 	 param.push({name:'url_address', value:P_url_address});
	 	 param.push({name:'file_name', value:P_file_name});
	 	 param.push({name:'error_text', value:P_error_text});
	 	 param.push({name:'line_number', value:P_line_number});

 	 	 let s= await  callZf_jslib('sys/error/ui/','java_script_error',param,2); 
	 	 return s; 
}

        
//<editor-fold desc="@@@@ Number To Persian">
/**
 *
 * @type {string}
 */
const delimiter = ' و ';

/**
 *
 * @type {string
 */
const zero = 'صفر';

/**
 *
 * @type {string}
 */
const negative = 'منفی ';

/**
 *
 * @type {*[]}
 */
const letters = [
    ['', 'یک', 'دو', 'سه', 'چهار', 'پنج', 'شش', 'هفت', 'هشت', 'نه'],
    ['ده', 'یازده', 'دوازده', 'سیزده', 'چهارده', 'پانزده', 'شانزده', 'هفده', 'هجده', 'نوزده', 'بیست'],
    ['', '', 'بیست', 'سی', 'چهل', 'پنجاه', 'شصت', 'هفتاد', 'هشتاد', 'نود'],
    ['', 'یکصد', 'دویست', 'سیصد', 'چهارصد', 'پانصد', 'ششصد', 'هفتصد', 'هشتصد', 'نهصد'],
    ['', ' هزار', ' میلیون', ' میلیارد', ' بیلیون', ' بیلیارد', ' تریلیون', ' تریلیارد',
        ' کوآدریلیون', ' کادریلیارد', ' کوینتیلیون', ' کوانتینیارد', ' سکستیلیون', ' سکستیلیارد', ' سپتیلیون',
        ' سپتیلیارد', ' اکتیلیون', ' اکتیلیارد', ' نانیلیون', ' نانیلیارد', ' دسیلیون', ' دسیلیارد'
    ],
];

/**
 * Decimal suffixes for decimal part
 * @type {string[]}
 */
const decimalSuffixes = [
    '',
    'دهم',
    'صدم',
    'هزارم',
    'ده‌هزارم',
    'صد‌هزارم',
    'میلیونوم',
    'ده‌میلیونوم',
    'صدمیلیونوم',
    'میلیاردم',
    'ده‌میلیاردم',
    'صد‌‌میلیاردم'
];

/**
 * Clear number and split to 3 sections
 * @param {*} num
 */
const prepareNumber = (num) => {
    let Out = num;
    if (typeof Out === 'number') {
        Out = Out.toString();
    }
    const NumberLength = Out.length % 3;
    if (NumberLength === 1) {
        Out = `00${Out}`;
    } else if (NumberLength === 2) {
        Out = `0${Out}`;
    }
    // Explode to array
    return Out.replace(/\d{3}(?=\d)/g, '$&*')
        .split('*');
};

const threeNumbersToLetter = (num) => {
    // return zero
    if (parseInt(num, 0) === 0) {
        return '';
    }
    const parsedInt = parseInt(num, 0);
    if (parsedInt < 10) {
        return letters[0][parsedInt];
    }
    if (parsedInt <= 20) {
        return letters[1][parsedInt - 10];
    }
    if (parsedInt < 100) {
        const one = parsedInt % 10;
        const ten = (parsedInt - one) / 10;
        if (one > 0) {
            return letters[2][ten] + delimiter + letters[0][one];
        }
        return letters[2][ten];
    }
    const one = parsedInt % 10;
    const hundreds = (parsedInt - (parsedInt % 100)) / 100;
    const ten = (parsedInt - ((hundreds * 100) + one)) / 10;
    const out = [letters[3][hundreds]];
    const SecondPart = ((ten * 10) + one);
    if (SecondPart > 0) {
        if (SecondPart < 10) {
            out.push(letters[0][SecondPart]);
        } else if (SecondPart <= 20) {
            out.push(letters[1][SecondPart - 10]);
        } else {
            out.push(letters[2][ten]);
            if (one > 0) {
                out.push(letters[0][one]);
            }
        }
    }
    return out.join(delimiter);
};


/**
 * Convert Decimal part
 * @param decimalPart
 * @returns {string}
 * @constructor
 */
const convertDecimalPart = (decimalPart) => {
    // Clear right zero
    decimalPart = decimalPart.replace(/0*$/, "");

    if (decimalPart === '') {
        return '';
    }

    if (decimalPart.length > 11) {
        decimalPart = decimalPart.substr(0, 11);
    }
    return ' ممیز ' + Num2persian(decimalPart) + ' ' + decimalSuffixes[decimalPart.length];
};

/**
 * Main function
 * @param input
 * @returns {string}
 * @constructor
 */
const Num2persian = (input) => {
    // Clear Non digits
    input = input.toString().replace(/[^0-9.-]/g, '');
    let isNegative = false;
    const floatParse = parseFloat(input);
    // return zero if this isn't a valid number
    if (isNaN(floatParse)) {
        return zero;
    }
    // check for zero
    if (floatParse === 0) {
        return zero;
    }
    // set negative flag:true if the number is less than 0
    if (floatParse < 0) {
        isNegative = true;
        input = input.replace(/-/g, '');
    }

    // Declare Parts
    let decimalPart = '';
    let integerPart = input;
    let pointIndex = input.indexOf('.');
    // Check for float numbers form string and split Int/Dec
    if (pointIndex > -1) {
        integerPart = input.substring(0, pointIndex);
        decimalPart = input.substring(pointIndex + 1, input.length);
    }

    if (integerPart.length > 66) {
        return 'خارج از محدوده';
    }

    // Split to sections
    const slicedNumber = prepareNumber(integerPart);
    // Fetch Sections and convert
    const Output = [];
    const SplitLength = slicedNumber.length;
    for (let i = 0; i < SplitLength; i += 1) {
        const SectionTitle = letters[4][SplitLength - (i + 1)];
        const converted = threeNumbersToLetter(slicedNumber[i]);
        if (converted !== '') {
            Output.push(converted + SectionTitle);
        }
    }

    // Convert Decimal part
    if (decimalPart.length > 0) {
        decimalPart = convertDecimalPart(decimalPart);
    }

    return (isNegative ? negative : '') + Output.join(delimiter) + decimalPart;
};

String.prototype.toPersianLetter = function () {
    return Num2persian(this);
};

Number.prototype.toPersianLetter = function () {
    return Num2persian(parseFloat(this).toString());
};

//</editor-fold>


/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function generateJSON(param) {
    var jsonStr = "{";

    for (var i = 0; i < param.length; i++) {
        jsonStr += ((i < param.length - 1) ? '"' + param[i].name + '"' + ":" + '"' + param[i].value + '"' + "," : '"' + param[i].name + '"' + " : " + '"' + param[i].value + '"' + "}");
    }
    return JSON.stringify(jsonStr);
}

function getCheckListChecked(checkList1) { 
      //var checkList1 = document.getElementById('<%= cbltrucks.ClientID %>');
      var checkBoxList1 = checkList1.getElementsByTagName("input");
      var checkBoxSelectedItems1 = new Array();
      var ary="";
      var seperate = '';
      for (var i = 0; i < checkBoxList1.length; i++) { 
      	if (checkBoxList1[i].checked) { 
      		checkBoxSelectedItems1.push(checkBoxList1[i].value);
      		ary += seperate + checkBoxList1[i].value;
      		seperate = ",";
      		//alert('checked:' + checkBoxSelectedItems1.push(checkBoxList1[i].getAttribute("JSvalue")).value);
      		//alert('checked - : ' + checkBoxList1[i].value) ary += checkBoxList1[i].value+"," 
      	} 
      }
      return ary;
}

function getCheckListArray(control_id) {
    var list = [];
    var $checkboxes = $('[zid="' + control_id + '"] .CheckBoxTitle input[type="checkbox"]:checked');
    $.each($checkboxes, function (v, i) {
        list.push(i.value);
    });
    return list;
}

function getCheckIDAndStatusListArray(control_id) {
    var list = [];
    var $checkboxes = $('[zid="' + control_id + '"] .CheckBoxTitle input[type="checkbox"]');
    $.each($checkboxes, function (v, i) {
        list.push({id: i.value, checked: i.checked});
    });
    return list;
}


function selectOptionByValue(controlName, value) {
    if (!controlName || !value) {
        return;
    }

    var control = GetControlByName(controlName);
    if (control) {
        control.value = value;
    }
}


function form_Prepar(myForm_CP) {
    var ipb = IsPostBack();
    if (ipb == false) {
        //alert(10);
        Checkview(myForm_CP);
    } else {
        //alert(20);
        CheckHaveMessage(myForm_CP);
    }
}
 function getparamv(name){
   if(name=(new RegExp('[?&]'+encodeURIComponent(name)+'=([^&]*)')).exec(location.search))
      return decodeURIComponent(name[1]);
}

  function form_Prepar(myForm_CP)
    {
     var ipb = IsPostBack();
      if(ipb == false)
        {
           //alert(10);
           Checkview(myForm_CP);
        }
        else
        {
            //alert(20);
            CheckHaveMessage(myForm_CP);
        }
    }
function Checkview(myForm_CP) {
    if (getparamv('ZPPA1') == '1' || getparamv('ZPPA1') == '-1') {
        ShowPanel('FormPanel', myForm_CP);
        if (getparamv('ZPPA1') == '-1') {
            disable_all_control();
        }
    } else if (getparamv('ZPPA1') != '0') {
        var title = ' خطا ';
        var content = getparamv('ZPPA2');
        Show_Message(title, content);
        CloseFormPanel('FormPanel', myForm_CP);
    }
}

function CheckHaveMessage(frm_Panel) {

    var ZMessage = document.getElementsByClassName('ZLBLMESSAGE');
    var noc = ZMessage[ZMessage.length - 1];
    if (noc.innerHTML.length > 4) {
        var title = ' ثبت سند   ';
        var content = noc.innerHTML;
        Show_Message(title, content);
        CloseFormPanel('FormPanel', frm_Panel);
    }
}

function IsPostBack() {
    var isPostBack = document.getElementById("___zframepostmethod");
    if (isPostBack.value == 0) {
        return false;
    } else {
        return true;
    }
}


async function call_last_identity(P_table_name) {
    var param = [];
    param.push({name: 'table_name', value: P_table_name});

    let s = await callZf_jslib('system/', 'last_identity', param, 2);
    return s[0].R;
}



async function Get_Concurrency_User(Form_ID, R_ID) {
    //return true;
    var SID = await get_session_id();
    var u = await get_userid();
    var param = [];
    param.push({name: 'form_id', value: Form_ID});
    param.push({name: 'user_id', value: u});
    param.push({name: 'recordid', value: R_ID});
    param.push({name: 'sessionid', value: SID});
    let s = await callZf_jslib('system/', 'get_concurrency_user', param, 2);
    var r = s[0].UN;
    if (r == null || r == undefined || r == 'Letsgo') {
        return true;
    } else {
        //	 var ddd = Get_confirm('کنترل دسترسی همزمان ' , ' این سند هم  اکنون در اختیار کاربر ' + r + ' می باشد و تا زمان آزاد سازی این سند منتظر باشید ، آیا مایلید سند را مشاهده نمایید ');

        Show_Message('کنترل دسترسی همزمان ', ' این سند هم  اکنون در اختیار کاربر ' + r + ' می باشد و تا زمان آزاد سازی این سند منتظر بمانید ');
        return false;
    }

}

async function get_session_id() {
    try {
        var param = [];
        param.push({name: 'val1', value: 1});
        let s = await callZf_jslib('system/', 'get_session_id', param, 2);
        var t = s[0].S;
        return t;
    } catch (err) {
        return 0;
    }
}

//  let u = await get_userid();
//  var userid = u.toString();
async function get_userid() {
    try {
        var param = [];
        //param.push({name:'se_name', value:'USER_ID'});
        param.push({name: 'val1', value: 1});
        let s = await callZf_jslib('system/', 'get_session_user', param, 2);
        var t = s[0].U;
        return t;
    } catch (err) {
        return 0;
    }
}


//  let R = await get_user_is_admin();
//  var userISADMIN = R.toString();
async function get_user_is_admin() {
    try {
        var param = [];
        let s = await callZf_jslib('system/', 'get_user_isadmin', param, 1);
        var t = s[0].R;
        return t;
    } catch (err) {
        return 0;
    }
}



//  let CID = await get_owner_id();
//  var C_ID = CID.toString();
async function get_owner_id() {
    try {
        var param = [];
	let s= await  callZf_jslib('system/','get_owner_id',param,1); 
        var t =s[0].OID;
        return t;
    } catch (err) {
        return 0;
    }
}
    async  function get_branch_id()
  {
		try
		{
			var param = [];
 		   	let s= await  callZf_jslib('system/','get_branch_id',param,1);
			var t = s[0].BID;
			return t;
		}
		
		catch (err) 
		{ return 0;	}
   }
   
   function GetUrlParamter(name){ 
	 var url_string = window.location.href ; 
	 var url = new URL(url_string); 
	 var c = url.searchParams.get(name); 
	 return c; 
   }
      
function checkBoxIsChecked(control) {
    if (!control) return;
    if (control.checked) {
        return 1;
    }
    return 0;
}



 

function navigate_depended_key( formid ){
     var ctrl_Key = document.getElementById('SelectRecordID');
     var Key_ID = ctrl_Key.value;
     if (Key_ID == null || Key_ID == undefined || Key_ID == 0 || Key_ID.length  == 0 ) {
  	      Show_Message(' توجه !!!! ' , ' لطفا قبل از تکمیل سایر بخش ها، اطلاعات را ذخیره نمایید ');
	      return; }		

       ShowForm_Limited(formid , 0 , Key_ID , 0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 );
       return;
}
async function CID_Check( p1 ) {
     var ctrl_Key = document.getElementById('SelectRecordID');
     var Key_ID = ctrl_Key.value;
     var BOwner_ID = getElementByAttribute('zid' , 'BUSINESS_OWNER_ID' , null);
     var CID = await get_owner_id();
     var user_isadmin = await get_user_is_admin();

     if (user_isadmin == '1') {
       	BOwner_ID.disabled=false
       	return true;
       }

     BOwner_ID.disabled=true;
     if (Key_ID == null || Key_ID == '' || Key_ID == '0'){
         	BOwner_ID.value = CID;
        	return true;
      }    
}  

async function Company_Check( Key_ID ) {
     var BOwner_ID = getElementByAttribute('zid' , 'BUSINESS_OWNER_ID' , null);
     let CID = await get_owner_id();
     let user_isadmin = await get_user_is_admin();

     if (user_isadmin == '1') {
       	BOwner_ID.disabled=false
       	return true;
       }

     if (Key_ID == null || Key_ID == '' || Key_ID == '0'){
         	BOwner_ID.disabled=false
         	BOwner_ID.value = CID;
      }           
      BOwner_ID.disabled=true; 
}  

async function Owner_Check( Key_ID ,owner_id) {
     let OID = await get_owner_id();
     let user_isadmin = await get_user_is_admin();

     if (user_isadmin == '1') {
       	owner_id.disabled=false
       	return true;
       }

     if (Key_ID == null || Key_ID == '' || Key_ID == '0'){
         	owner_id.disabled=false
         	owner_id.value = OID;
      }           
      owner_id.disabled=true; 
}  
async function Branch_Check( Key_ID ) {
     var B_ID = getElementByAttribute('zid' , 'BRANCH_ID' , null);
     let BID = await get_branch_id();
     let user_isadmin = await get_user_is_admin();

     if (user_isadmin == '1') {
       	B_ID.disabled=false
       	return true;
       }

     if (Key_ID == null || Key_ID == '' || Key_ID == '0'){
         	B_ID.disabled=false
         	B_ID.value = BID;
      }           
      B_ID.disabled=true; 
}  

function ShowDialogFormMax(formid, title, zval1, zval2, zval3) {
    /*
        var p1 = PARTY_ID;
        var p2 = 0;
        var p3 = 0;
        ShowDialogFormMax(formid , 'اطلاعات تکمیلی' , p1 ,p2 , p3 );
     */

    var p1 = zval1;
    var p2 = zval2;
    var p3 = zval3;
    var findspace = document.getElementById("findobjectinOtherform");
    findspace.innerHTML = '';
    findspace.innerHTML += "<div id=\"findpanel\" class=\"ShowPanel\" ><div  style=\"height:100%;width:100%;\" align=\"Center\"><Table dir=\"rtl\" style=\"width:100%;\" class=\"FromCaption\" ><tr> <td align=\"right\" ><input type=\"button\" id=\"close\"   class=\"closebutton\" onclick=\"CloseFindFormAndRefresh();\"><span class=\"Title\">     انتخاب   </span><span class=\"Title\">" + title + "</span>  </td></tr></table><iframe id=\"findiframe" + formid + "\"  src=\"" + baseapplicationsrc + "FindForm.bpm?ID=" + formid + "&KeyID=0&ZPPA1=" + p1 + "&ZPPA2=" + p2 + "&ZPPA3=" + p3 + "\" style=\"width:100%; height:" + formhightinview + "%;background: #FFFFFF;\"> </iframe><Table id=\"submitformpanel\" dir=\"rtl\" style=\"width:100%;\" class=\"FindSubmit\" ><tr> <td align=\"Right\" ></td></tr></table></div></div>   ";
}
function ShowDialogFormMax2(formid, keyid, title, p1, p2, p3 , p4 , p5 , p6 , p7 , p8 , p9) {
    /*
        var p1 = PARTY_ID;
        var keyid = 1;
        var p2 = 0;
        var p3 = 0;
        ShowDialogFormMax(formid , keyid , 'اطلاعات تکمیلی' , p1 ,p2 , p3 );
     */

    var findspace = document.getElementById("findobjectinOtherform");
    findspace.innerHTML = '';
    findspace.innerHTML += "<div id=\"findpanel\" class=\"ShowPanel\" ><div  style=\"height:100%;width:100%;\" align=\"Center\"><Table dir=\"rtl\" style=\"width:100%;\" class=\"FromCaption\" ><tr> <td align=\"right\" ><input type=\"button\" id=\"close\"   class=\"closebutton\" onclick=\"CloseFindFormAndRefresh();\"><span class=\"Title\">     انتخاب   </span><span class=\"Title\">" + title + "</span>  </td></tr></table><iframe id=\"findiframe" + formid + "\"  src=\"" + baseapplicationsrc + "FindForm.bpm?ID=" + formid + "&KeyID=" + keyid + '&ZPPA1='+p1+'&ZPPA2='+p2+'&ZPPA3='+p3+'&ZPPA4='+p4+'&ZPPA5='+p5+'&ZPPA6='+p6+'&ZPPA7='+p7+'&ZPPA8='+p8+'&ZPPA9='+p9 + "\" style=\"width:100%; height:" + formhightinview + "%;background: #FFFFFF;\"> </iframe><Table id=\"submitformpanel\" dir=\"rtl\" style=\"width:100%;\" class=\"FindSubmit\" ><tr> <td align=\"Right\" ></td></tr></table></div></div>   ";
}


function ShowDialogFormStandard(formid, keyid, title, p1, p2, p3 , p4 , p5 , p6 , p7 , p8 , p9) {
    /*
        var p1 = PARTY_ID;
        var keyid = 1;
        var p2 = 0;
        var p3 = 0;
        ShowDialogFormMax(formid , keyid , 'اطلاعات تکمیلی' , p1 ,p2 , p3 );
     */

    var findspace = document.getElementById("findobjectinOtherform");
    findspace.innerHTML = '';
    findspace.innerHTML += "<div id=\"findpanel\" class=\"ShowPanel\" ><div  style=\"height:100%;width:100%;\" align=\"Center\"><Table dir=\"rtl\" style=\"width:100%;\" class=\"FromCaption\" ><tr> <td align=\"right\" ><input type=\"button\" id=\"close\"   class=\"closebutton\" onclick=\"CloseFindForm();\"><span class=\"Title\">     انتخاب   </span><span class=\"Title\">" + title + "</span>  </td></tr></table><iframe id=\"findiframe" + formid + "\"  src=\"" + baseapplicationsrc + "FindForm.bpm?ID=" + formid + "&KeyID=" + keyid + '&ZPPA1='+p1+'&ZPPA2='+p2+'&ZPPA3='+p3+'&ZPPA4='+p4+'&ZPPA5='+p5+'&ZPPA6='+p6+'&ZPPA7='+p7+'&ZPPA8='+p8+'&ZPPA9='+p9 + "\" style=\"width:100%; height:" + formhightinview + "%;background: #FFFFFF;\"> </iframe><Table id=\"submitformpanel\" dir=\"rtl\" style=\"width:100%;\" class=\"FindSubmit\" ><tr> <td align=\"Right\" ></td></tr></table></div></div>   ";
}



function navigatebpmwithidshowmode(formid, recid, p1, p2, p3 , p4 , p5 , p6 , p7 , p8 , p9 ) {
    /*
          var p1 = 0;
          var p2 = 0;
          var p3 = 0;
          navigatebpmwithidshowmode(formid , PARTY_ID , p1 ,p2 , p3 , p4 , p5 , p6 , p7 , p8 , p9 );
    */

    var navigateaddress = "ZBPMS.bpm?ID=" + formid.toString() + "&KeyID=" + recid.toString() + "&ZPPA1=" + p1 + "&ZPPA2=" + p2 + "&ZPPA3=" + p3 + "&ZPPA4=" + p4 + "&ZPPA5=" + p5 + "&ZPPA6=" + p6 + "&ZPPA7=" + p7 + "&ZPPA8=" + p8 + "&ZPPA9=" + p9;
    window.location = navigateaddress;
}

function ShowForm_Limited(formid,KeyID, zpm1, zpm2, zpm3, zpm4, zpm5, zpm6, zpm7, zpm8, zpm9) {
    /*
        var p1 = PARTY_ID;
        var p2 = 0;
        var p3 = 0;
        ShowForm_Limited(formid , p1 ,p2 , p3 );
     */

    var p1 = zpm1;
    var p2 = zpm2;
    var p3 = zpm3;
    var p4 = zpm4;
    var p5 = zpm5;
    var p6 = zpm6;   
    var p7 = zpm7;
    var p8 = zpm8;
    var p9 = zpm9;
    
    var myaddress = baseapplicationsrc +'ZBPMS.bpm?ID='+formid+'&KeyID='+KeyID+'&ZPPA1='+p1+'&ZPPA2='+p2+'&ZPPA3='+p3+'&ZPPA4='+p4+'&ZPPA5='+p5+'&ZPPA6='+p6+'&ZPPA7='+p7+'&ZPPA8='+p8+'&ZPPA9='+p9+'';       
    openNewPage(myaddress);
 
}
function ShowForm_LimitedAndRefresh(formid,KeyID, zpm1, zpm2, zpm3, zpm4, zpm5, zpm6, zpm7, zpm8, zpm9) {
    /*
        var p1 = PARTY_ID;
        var p2 = 0;
        var p3 = 0;
        ShowForm_Limited(formid , p1 ,p2 , p3 );
     */

    var p1 = zpm1;
    var p2 = zpm2;
    var p3 = zpm3;
    var p4 = zpm4;
    var p5 = zpm5;
    var p6 = zpm6;   
    var p7 = zpm7;
    var p8 = zpm8;
    var p9 = zpm9;
    
    var myaddress = baseapplicationsrc +'ZBPMS.bpm?ID='+formid+'&KeyID='+KeyID+'&ZPPA1='+p1+'&ZPPA2='+p2+'&ZPPA3='+p3+'&ZPPA4='+p4+'&ZPPA5='+p5+'&ZPPA6='+p6+'&ZPPA7='+p7+'&ZPPA8='+p8+'&ZPPA9='+p9+'';       
    openNewPageAndRefresh(myaddress);
 
}


 function ShowFormModal_BackMeRefresh(formid,title, zpm1, zpm2, zpm3, zpm4, zpm5, zpm6, zpm7, zpm8, zpm9) { 
 
     /*
        var p1 = PARTY_ID;
        var p2 = 0;
        var p3 = 0;
        ShowFormModal_BackMeRefresh(formid , 'اطلاعات تکمیلی' , p1 ,p2 , p3, p4 ,p5 , p6, p7 ,p8 , p9 );
     */

    var p1 = zpm1;
    var p2 = zpm2;
    var p3 = zpm3;
    var p4 = zpm4;
    var p5 = zpm5;
    var p6 = zpm6;   
    var p7 = zpm7;
    var p8 = zpm8;
    var p9 = zpm9;
    var findspace = document.getElementById("findobjectinOtherform");
    findspace.innerHTML ='';
    findspace.innerHTML += "<div id=\"findpanel\" class=\"ShowPanel\" ><div  style=\"height:100%;width:100%;\" align=\"Center\"><Table dir=\"rtl\" style=\"width:100%;\" class=\"FromCaption\" ><tr> <td align=\"right\" ><input type=\"button\" id=\"close\"   class=\"closebutton\" onclick=\"CloseFindFormAndRefresh();\"><span class=\"Title\">     انتخاب   </span><span class=\"Title\">"+ title +"</span>  </td></tr></table><iframe id=\"findiframe" + formid + "\"  src=\"" + baseapplicationsrc + "FindForm.bpm?ID=" + formid + "&KeyID=0&ZPPA1="+p1+"&ZPPA2="+p2+"&ZPPA3="+p3+"&ZPPA4="+p4+"&ZPPA5="+p5+"&ZPPA6="+p6+"&ZPPA7="+p7+"&ZPPA8="+p8+"&ZPPA9="+p9+"\" style=\"width:100%; height:" + formhightinview + "%;background: #FFFFFF;\"> </iframe><Table id=\"submitformpanel\" dir=\"rtl\" style=\"width:100%;\" class=\"FindSubmit\" ><tr> <td align=\"Right\" ></td></tr></table></div></div>   "; 
} 

function SelectValueDeliveryForm(formid, DialogTitle, myCtrl, p1, p2, p3) {
    /*
        var p1 = PARTY_ID;
        var p2 = 0;
        var p3 = 0;
        SelectValueDeliveryForm(formid , 'اطلاعات تکمیلی' , ctrl1, p1 ,p2 , p3 );
     */
    var myCtrl_id = myCtrl.id;
    var ctrl_identity = getlookuprefrencenamefromsource(v1.id);
    FindFormLookupTableP(formid, myCtrl_id, DialogTitle, ctrl_identity, p1, p2, p3);
}

function getlookuprefrencenamefromsource(s) {
    var rt = s + "1";
    return rt;
}

/*
async function call_ws(ws_url, ws_name, ws_params, detail_form_name = '') {
    let c = await callZf_jslib(ws_url, ws_name, ws_params, 2);

    var alertcode = c[0].ERROR;
    var alertdesc = c[0].ERROR_DESC;
    if (alertcode != "0") {
        let mess = await call_translate_error(alertcode, alertdesc);
        var message = mess[0].ERROR_DESC;
        var index = message.indexOf('{%O', 0);
        var param = '';
        while (index > 0) {
            param = message.substring(index + 3, message.indexOf("}", index));
            message = message.replace('{%O' + param + '}', c[0][param]);
            index = message.indexOf('{%O', index);
        }
        Show_Message('خطا', message);
    } else {
        if (detail_form_name = "") {
            Formnavigatebpm(GetUrlParameter('ID'));
        } else {
            navigatebpmwithid(GetUrlParameter('ID'), "0&ZPPA1=" + GetUrlParameter('ZPPA1') + "&ZPPA2=" + GetUrlParameter('ZPPA2') + "&ZPPA3=" + GetUrlParameter('ZPPA3'));
        }
    }
}
*/
    async function call_ws(ws_url,ws_name,ws_params,detail_form_name = '')
{
        let c = await  callZf_jslib(ws_url,ws_name,ws_params,2); 
	
        var alertcode = c[0].ERROR;
        var alertdesc = c[0].ERROR_DESC;
      //  var helpcode = c[0].HELP_ID;
        
    
	if (alertcode != "0"){
            let mess = await call_translate_error (alertcode,alertdesc);
            
            Show_Message('خطای شماره ' + alertcode ,mess[0].ERROR_DESC);
	} else {
            if (detail_form_name = ""){
               Formnavigatebpm(GetUrlParameter('ID'));
            } else {
                navigatebpmwithid(GetUrlParameter('ID') , "0&ZPPA1="+GetUrlParameter('ZPPA1')+"&ZPPA2="+GetUrlParameter('ZPPA2')+"&ZPPA3="+GetUrlParameter('ZPPA3') );
            }
	}
}

    async function call_Submit_WS(ws_url,ws_name,ws_params,detail_form_name = '',IS_Navigate)
{
        let result = await  callZf_jslib(ws_url,ws_name,ws_params,2); 
	
        var alertcode = result[0].ERROR;
        var alertdesc = result[0].ERROR_DESC;

      //  var helpcode = 0;
        
    
	if (alertcode != "0"){
            let mess = await call_translate_error (alertcode);
            
            Show_Message('خطای شماره ' + alertcode ,mess[0].ERROR_DESC);
	} else if(IS_Navigate == 1){
            if (detail_form_name = ""){
               Formnavigatebpm(GetUrlParameter('ID'));
            } else {
                navigatebpmwithid(GetUrlParameter('ID') , "0&ZPPA1="+GetUrlParameter('ZPPA1')+"&ZPPA2="+GetUrlParameter('ZPPA2')+"&ZPPA3="+GetUrlParameter('ZPPA3') );
            }
	} 
        
        return result;
}
/*
async function call_translate_error(P_input_error, P_input_error_hint) {
    var param = [];
    param.push({name: 'error', value: ""});
    param.push({name: 'error_desc', value: ""});
    param.push({name: 'input_error', value: P_input_error});
    param.push({name: 'input_error_hint', value: P_input_error_hint});

    let s = await callZf_jslib('translate_error/', 'translate_error', param, 2);
    return s;
}
*/


function checkValidation() {
    var P_message_validation = "";
    var controlList = GetRequiredControlListCaption();
    var controlList1 = GetRequiredControlListID();

    //make from normal view
        
    var form = document.getElementById('bpmform');
    for (var i = 0; i < form.elements.length; i++) {
        form.elements[i].classList.remove('InputTextRq');
    }
    GetControlByName('MESSAGE_VALIDATION').innerHTML = P_message_validation;
  	var deleteConter = 0;
    for (var i = 0; i < controlList1.length; i++) {
      if(!is_Visibil_Element(controlList1[i])){
      	controlList.splice(i-deleteConter, 1);
      	deleteConter++;
      	//delete controlList(i);
      	//controlList.remove(value);
      }
    }

    if (controlList.length > 0) {
        P_message_validation = "اقلام اجباری را وارد نمایید";

        for (var i = 0; i < controlList1.length; i++) {
            GetControlByName(controlList1[i]).classList.add('InputTextRq');
        }

        GetControlByName('MESSAGE_VALIDATION').innerHTML = '<DIV class="validation-summary" > ' + P_message_validation + '</DIV>';
        return false;
    } else {
        return true;
    }
}
function is_Visibil_Element(element_name){
	EL = getElementByAttribute('zid' , element_name , null);
	try {
		if(EL=='undefined'){return true;}
		if(EL.style.display=='undefined'){return true;}
		if(EL.readOnly != undefined){return false;}
	    if(EL.style.visibility=='hidden'){return true;}
		
	    var p1 = EL.parentElement;
	   for (let a=0 ; a < 10 ; a++ )
	    {
	    	if(p1 == undefined){return true;}
			if(p1.style.display=='none' || p1.style.visibility == "hidden"){return false;}
	    	p1 = p1.parentElement;
	    }
	 	return true; 	
	}
	catch(err) {
	return true;
	}
}


function Disable_Control(ctrl_Name, Status) {
    var ctrl_id = getElementByAttribute('zid', ctrl_Name, null);
    if (Status == true) {
        ctrl_id.disabled = true;
    } else {
        ctrl_id.disabled = false;
    }

}

function Enable_Control(ctrl_Name, Status) {
    var ctrl_id = getElementByAttribute('zid', ctrl_Name, null);
    if (Status == true) {
        ctrl_id.style.display = 'block';
    } else {
        ctrl_id.style.display = 'none';
    }
}

function defaultInput(e) {
    var specialKeys = new Array();
    specialKeys.push(126); // ~
    specialKeys.push(33); // !
    specialKeys.push(64); // @
    specialKeys.push(35); // #
    specialKeys.push(36); // $
    specialKeys.push(37); // %
    specialKeys.push(94); // ^
    specialKeys.push(38); // &
    specialKeys.push(42); // *
    specialKeys.push(40); // (
    specialKeys.push(41); // )
    specialKeys.push(123); // {
    specialKeys.push(125); // }
    specialKeys.push(91); // [
    specialKeys.push(93); // ]
    specialKeys.push(124); // |
    specialKeys.push(47); // /
    specialKeys.push(92); // \
    var keyCode = e.keyCode == 0 ? e.charCode : e.keyCode;
    console.log(keyCode, specialKeys.indexOf(keyCode));
    if ((specialKeys.indexOf(e.keyCode) != -1 && e.charCode != e.keyCode)) {
        return false;
    }
    return true;
}

function onlineValidationItem(e, type, max , maxint) {
    // type is 'persian' , 'english' , 'number' , 'floatnumber' , 'percentnumber' , 'default'
    // onkeypress ="return onlineValidationItem(event,'persian',30,0);"
    // onkeypress ="return onlineValidationItem(event,'english',30,0);"
    // onkeypress ="return onlineValidationItem(event,'number',30,0);"
    // onkeypress ="return onlineValidationItem(event,'floatnumber',30,4);"
    // onkeypress ="return onlineValidationItem(event,'percentnumber',5,2);"
    if (max) {
        document.getElementById(e.target.id).setAttribute("maxLength", max);
    }
    switch (type) {
        case 'persian': {
            if (onlyPersianInput(e))
                return true;
            return false;
        }
            ;
            break;
        case 'english': {
            if (onlyEnglishInput(e))
                return true;
            return false;
        }
            ;
            break;
        case 'number': {
            if (onlyNumberInput(e))
                return true;
            return false;
        }
            ;
            break;
        case 'floatnumber': {
            if (onlyFloatNumberInput(e, max))
                return true;
            return false;
        }
            ;
            break;
          case 'percentnumber': {
            if (onlyPercentNumberInput(e, max , maxint))
                return true;
            return false;
        }
            ;
            break;          
        case 'default': {
            if (defaultInput(e))
                return true;
            return false;
        }
            ;
            break;
    }

}

function onlyNumberInput(evt) {
    // Only ASCII charactar in that range allowed
    var ASCIICode = (evt.which) ? evt.which : evt.keyCode
    if (ASCIICode > 31 && (ASCIICode < 48 || ASCIICode > 57))
        return false;
    return true;
}

function onlyFloatNumberInput(evt, max) {
    // Only ASCII charactar in that range allowed
    var ASCIICode = (evt.which) ? evt.which : evt.keyCode

    if (ASCIICode == 46)
        if (evt.target.value.indexOf(".") == -1)
            return true;
        else
            return false;

    if (ASCIICode > 31 && (ASCIICode < 48 || ASCIICode > 57))
        return false;
    return true;
}

function onlyPersianInput(e) {
    var specialKeys = new Array();
    specialKeys.push(8); //Backspace
    specialKeys.push(9); //Tab
    specialKeys.push(46); //Delete
    specialKeys.push(36); //Home
    specialKeys.push(35); //End
    specialKeys.push(37); //Left
    specialKeys.push(39); //Right
    specialKeys.push(95); //Right
    specialKeys.push(45); //Right
    var keyCode = e.keyCode == 0 ? e.charCode : e.keyCode;
    console.log(keyCode);
    if ((keyCode == 33) || (keyCode == 64) || (keyCode == 35) || (keyCode == 36) || (keyCode == 37) || (keyCode == 94)
        || (keyCode == 38) || (keyCode == 42)
        || (keyCode >= 65 && keyCode <= 90) || (keyCode >= 97 && keyCode <= 122) || (specialKeys.indexOf(e.keyCode) != -1 && e.charCode != e.keyCode))
        return false;
    return true;
}

function onlyEnglishInput(e) {
    var specialKeys = new Array();
    specialKeys.push(8); //Backspace
    specialKeys.push(9); //Tab
    specialKeys.push(46); //Delete
    specialKeys.push(36); //Home
    specialKeys.push(35); //End
    specialKeys.push(37); //Left
    specialKeys.push(39); //Right
    var keyCode = e.keyCode == 0 ? e.charCode : e.keyCode;
    console.log(keyCode);
    if ((keyCode == 95) || (keyCode == 45) || (keyCode == 32) || (keyCode >= 48 && keyCode <= 57) || (keyCode >= 65 && keyCode <= 90) || (keyCode >= 97 && keyCode <= 122)
        || (specialKeys.indexOf(e.keyCode) != -1 && e.charCode != e.keyCode))
        return true;
    return false;
}

function checkFloatNumber(e) {
    let values = e.target.value.split(".");
    if (values.length > 1) {
        if (values[0].length == 0) {
            e.target.value = "0" + e.target.value;
        }
        if (values[1].length == 0) {
            e.target.value = e.target.value + "0";
        }
    }
}

function onlyPercentNumberInput(evt, max , maxint) {
    // Only ASCII charactar in that range allowed
    var maxdecimal = max - maxint - 1;
    var evtlen = evt.target.value.length;
    var ASCIICode = (evt.which) ? evt.which : evt.keyCode
    if (ASCIICode == 46){
        if (evt.target.value.indexOf(".") == -1){
            return true;
        }else{ return false; }
        
    }else if (ASCIICode > 31 && (ASCIICode < 48 || ASCIICode > 57)){
    	return false;
    }else{
         if (evt.target.value.indexOf(".") == -1){
             if(evtlen < maxint ){
                 return true;
             }else{ return false;}
         }else{
            if ((evtlen - evt.target.value.indexOf(".") - 1) < maxdecimal ){
             return true;
            }else{return false;}
         }
	}
   
    return true;
 }

function FormatCurrency(ctrl, showCharacter, format) {
    //Check if arrow keys are pressed - we want to allow navigation around textbox using arrow keys
    if (event.keyCode == 37 || event.keyCode == 38 || event.keyCode == 39 || event.keyCode == 40) {
        return;
    }

    let val = ctrl.value;

    val = val.replace(/,/g, "")
    ctrl.value = "";
    val += '';
    let x = val.split('.');
    let x1 = x[0];
    let x2 = x.length > 1 ? '.' + x[1] : '';

    let rgx = /(\d+)(\d{3})/;

    while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + ',' + '$2');
    }

    ctrl.value = x1 + x2;

    if (!format) {
        format = 'ریال'
    }
    if (showCharacter && format) {
        const space = " ";
        let id = ctrl.getAttribute('zid') + 'currencyTitle';
        console.log(id);

        let char = Num2persian(ctrl.value) + space + format;
        if (!$("#" + id).length) {
            let element = '<span style="font-size: 8pt; color:#1F951D" id="' + id + '"></span>';
            $("input[zid=" + ctrl.getAttribute('zid') + "]").parent().append(element);
        }
        $("#" + id).html(char);


    }
}

function customValidation(e, type, max) {
    // type is 'persian' , 'english' , 'number' , 'floatnumber' , 'percentnumber' , 'default'
    if (max) {
        document.getElementById(e.target.id).setAttribute("maxLength", max);
    }
    switch (type) {
        case 'persian': {
            if (onlyPersianInput(e))
                return true;
            return false;
        }
            ;
            break;
        case 'english': {
            if (onlyEnglishInput(e))
                return true;
            return false;
        }
            ;
            break;
        case 'number': {
            if (onlyNumberInput(e))
                return true;
            return false;
        }
            ;
            break;
        case 'floatnumber': {
            if (onlyFloatNumberInput(e, max))
                return true;
            return false;
         }
            ;
            break;
        case 'default': {
            if (defaultInput(e))
                return true;
            return false;
        }
            ;
            break;
    }

}

function validatedate(inputText,msg,minDate,maxDate)
{
	//validatedate(Text1,'تاریخ موثر')
	// format dd/mm/yyyy or in any order of (dd or mm or yyyy) you can write dd or mm or yyyy in first or second or third position ... or can be slash"/" or dot"." or dash"-" in the dates formats
	var DateFormat = "yyyy/mm/dd";
	var invalid = "";
	var dt = "";
	var mn = "";
	var yr = "";
	var k;
        //-------------------------------
	var delm = DateFormat.includes("/") ? "/" : ( DateFormat.includes("-") ? "-" : ( DateFormat.includes(".") ? "." : "" ) ) ;
	var f1 = inputText.value.split(delm);
	var f2 = DateFormat.split(delm);
	for(k=0;k<=2;k++)
	{ 
	 dt = dt + (f2[parseInt(k)]=="dd" ? f1[parseInt(k)] : "");
	 mn = mn + (f2[parseInt(k)]=="mm" ? f1[parseInt(k)] : "");
	 yr = yr + (f2[parseInt(k)]=="yyyy" ? f1[parseInt(k)] : "");
	}
        //-----------------------------------
        var dt_min = "";
	var mn_min = "";
	var yr_min = "";
        var limitmin = 0;
        var limit_min = "";
        if (minDate == null || minDate == undefined || minDate == 0 || minDate.length  == 0 ) {
             limitmin = 13000101;
             limit_min = "1300/01/01";
        }else{
            var f1_min = minDate.split(delm);
            var f2_min = DateFormat.split(delm);
            for(k=0;k<=2;k++)
            { 
             dt_min = dt_min + (f2_min[parseInt(k)]=="dd" ? f1_min[parseInt(k)] : "");
             mn_min = mn_min + (f2_min[parseInt(k)]=="mm" ? f1_min[parseInt(k)] : "");
             yr_min = yr_min + (f2_min[parseInt(k)]=="yyyy" ? f1_min[parseInt(k)] : "");
            }
            limitmin = parseInt(yr_min+mn_min+dt_min);
            limit_min = yr_min+'/'+mn_min+'/'+dt_min;
        }
        //-----------------------------------
        var dt_max = "";
	var mn_max = "";
	var yr_max = "";
        var limitmax = 0;
        var limit_max = "";
        if (maxDate == null || maxDate == undefined || maxDate == 0 || maxDate.length  == 0 ) {
             limitmax = 14991230;
             limit_max = '1499/12/30';
        }else{
            var f1_max = maxDate.split(delm);
            var f2_max = DateFormat.split(delm);
            for(k=0;k<=2;k++)
            { 
             dt_max = dt_max + (f2_max[parseInt(k)]=="dd" ? f1_max[parseInt(k)] : "");
             mn_max = mn_max + (f2_max[parseInt(k)]=="mm" ? f1_max[parseInt(k)] : "");
             yr_max = yr_max + (f2_max[parseInt(k)]=="yyyy" ? f1_max[parseInt(k)] : "");
            }
            limitmax = parseInt(yr_max+mn_max+dt_max);
            limit_max = yr_max+'/'+mn_max+'/'+dt_max;
        }
        //-----------------------------------
	//var mn_days = "0-31-" + (yr % 4 == 0 ? 29 : 28) + "-31-30-31-30-31-31-30-31-30-31";
	var mn_days = "0-31-31-31-31-31-31-30-30-30-30-30-" + ((parseInt(yr)+1) % 4 == 0 ? 30 : 29);
	var days = mn_days.split("-");
	var inputdate = parseInt(yr+mn+dt);
     if( f1.length!=3 || mn.length>2 || dt.length>2 || yr.length!=4 || !(parseInt(mn)>=1 && parseInt(mn)<=12) || !(parseInt(yr)>=parseInt(1200) && parseInt(yr)<=parseInt(1500)) || !(parseInt(dt)>=1 && parseInt(dt)<=parseInt(days[parseInt(mn)])) )
    {
	Show_Message('خطای نقص اطلاعات ','لطفا ' + msg + ' را با الگوی صحیح درج نمایید');
	inputText.focus();
	return false;
    }   
    

    
    if( !(inputdate >= limitmin && inputdate <= limitmax))
    {
	Show_Message('خطای نقص اطلاعات ','لطفا ' + msg + ' را در محدوده ' + limit_min + ' تا ' + limit_max + ' درج نمایید ');
	inputText.focus();
	return false;
    }    
    return true
}

const McbTools = (function () {
        const ajaxDefault = {
            type: "post",
            dataType: 'json'
        }

        const _ajax = function (options, doneCallBack, failCallBack, alwaysCallBack) {
            const settings = $.extend({}, ajaxDefault, options || {});

            $.ajax(settings)
                .done(function (res) {
                    if (doneCallBack) {
                        if ({}.toString.call(doneCallBack) === '[object Function]') {
                            doneCallBack(res);
                        } else {
                            console.warn('doneCallBack param is not function!');
                        }
                    }
                })
                .fail(function (jqXHR, textStatus) {
                    if (window.top.McbServices) {
                        if (jqXHR.responseText) {
                            const responseText = JSON.parse(jqXHR.responseText);
                            if (responseText) {
                                let message = `${responseText.status} - ${responseText.error} - ${responseText.message}`;
                                window.top.McbServices.messageService.push(message, 'error');
                            } else {
                                window.top.McbServices.messageService.push(jqXHR.responseText, 'error');
                            }
                        } else {
                            window.top.McbServices.messageService.push(jqXHR, 'error');
                        }
                    }
                    console.error("textStatus: " + textStatus);
                    console.error(jqXHR);
                    if (failCallBack) {
                        if ({}.toString.call(failCallBack) === '[object Function]') {
                            failCallBack(jqXHR);
                        } else {
                            console.warn('failCallBack param is not function!');
                        }
                    }
                })
                .always(function () {
                    if (alwaysCallBack) {
                        if ({}.toString.call(alwaysCallBack) === '[object Function]') {
                            alwaysCallBack();
                        } else {
                            console.warn('alwaysCallBack param is not function!');
                        }
                    }
                });
        }

        const _getElementByZName = function (name) {
            let $item = $('[zid=' + name + ']');
            if ($item.length > 0) {
                return $item;
            }
            return null;
        }

        const _getElementValue = function (element) {
            if (!element) {
                return null;
            }

            if (element.type === 'checkbox') {
                return element.checked;
            }
            return element.value;
        }

        const _getValueByZName = function (name) {
            let element = $('[zid=' + name + ']');
            if (element && element.length > 0) {
                let first = element.get(0);
                if (first.type) {
                    return _getElementValue(first);
                }
            }
            return null;
        }

        const _closeFindFormAndRefreshParent = function () {
            let panel = document.getElementById("findpanel");
            if (!panel) {
                panel = window.parent.document.getElementById("findpanel");
            }
            panel.className = "hiddenPanel";
            try {
                ShowNowSelected();
            } catch (ex) {
                console.error(ex);
            }

            let objectForm = window.parent.document.getElementById('bpmform');
            if (objectForm) {
                objectForm.submit();
            } else {
                console.warn("can't submit parent form!");
            }
        }

        const _closeCurrentTab = function () {
            let tabs = window.parent.document.getElementsByClassName("tablinks");
            let currentTab = tabs[0];
            if (currentTab != undefined) {
                let id = currentTab.id.substr(12, currentTab.id.length - 1);
                console.log(id);

                // get current elements
                let buttonMain = "cmdtabidfrom" + id;
                let closeButtonMain = "cmdclosetabidfrom" + id;
                let tabMain = "tabidfrom" + id;


                // close and remove elements
                RemoveConcurrencyForm(id);
                var element1 = window.parent.document.getElementById(buttonMain);
                element1.parentNode.removeChild(element1);
                var element2 = window.parent.document.getElementById(closeButtonMain);
                element2.parentNode.removeChild(element2);
                var element3 = window.parent.document.getElementById(tabMain);
                element3.parentNode.removeChild(element3);
            }

        }

        const _submitForm = function (element) {
            let loading = window.parent.document.getElementById("isc-loading-1");
            if (loading) {
                loading.style.display = "block";
            }
            if (element) {
                let formSessionKey = $("input[zid$='txtFormSession']").val();
                let elementName = element.getAttribute("zid");
                if (!elementName) {
                    elementName = element.id;
                }
                let scrollPosition = window.scrollY;
                localStorage.setItem("form-focus-element-name", formSessionKey + "@" + elementName + "@" + scrollPosition);
            }
            window.setTimeout(function () {
                loading = window.parent.document.getElementById("isc-loading-2");
                if (loading) {
                    loading.style.display = "block";
                }
            }, 3000);
        }

        const confirmData = {
            title: "تایید عملیات",
            message: " آیا اطمینان دارید ؟ ",
            acceptLabel: "بلی",
            rejectLabel: "خیر",
        }
        const _confirmDialog = (obj) => {
            // const data = (obj == undefined || obj == null) ? confirmData : obj;
            let data = {};
            if (obj) {
                data.title = obj.title ? obj.title : confirmData.title;
                data.message = obj.message ? obj.message : confirmData.message;
                data.acceptLabel = obj.acceptLabel ? obj.acceptLabel : confirmData.acceptLabel;
                data.rejectLabel = obj.rejectLabel ? obj.rejectLabel : confirmData.rejectLabel;
            } else {
                data = confirmData;
            }
            return new Promise(function (resolve, reject) {
                $.confirm({
                    rtl: true,
                    title: data.title,
                    content: data.message,
                    theme: 'Z-confirm',
                    buttons: {
                        confirm: {
                            text: data.acceptLabel,
                            btnClass: 'btn-default btn-accept',
                            keys: ['enter'],
                            action: function () {
                                resolve("Accepted");
                            }
                        },
                        cancel: {
                            text: data.rejectLabel,
                            btnClass: 'btn-default btn-reject',
                            action: function () {
                                reject("Rejected");
                            }
                        }
                    }
                });
            })
        }



        function addToFavoriteForm(data) {
            let items = getFavoriteFormData() != null ? getFavoriteFormData() : [];
            if (items.length > 0) {
                const filteredData = items.filter(f => f.id == data.id);
                if (filteredData.length > 0) {
                    showMessage('اضافه به پرکاربرد ها', 'این فرم قبلا در پرکاربرد ها ثبت شده است ', 'danger');
                } else {
                    items.push(data);
                    localStorage.setItem(McbConstant.FAVORITE_DATA_NAME, JSON.stringify(items));
                }
            } else {
                items.push(data);
                localStorage.setItem(McbConstant.FAVORITE_DATA_NAME, JSON.stringify(items));
            }
        }

        function getFavoriteFormData() {
            const data = JSON.parse(localStorage.getItem(McbConstant.FAVORITE_DATA_NAME));
            if (data != null && data != undefined) {
                if (data.length > 0) {
                    return data;
                }
            }
            return null;
        }

        function removeFavoriteFormData(data) {
            if (data != null && data != undefined) {
                const favData = getFavoriteFormData();
                console.log(data);
                console.log(favData)
                if (favData != null) {
                    let result = $.grep(favData, function (e) {
                        return e.id != data.id;
                    });
                    localStorage.setItem(McbConstant.FAVORITE_DATA_NAME, JSON.stringify(result));
                    return result;
                }
            }
            return null;
        }

        function handleStatusOfFavoriteIcon() {
            let tabElement = document.getElementsByClassName('tablinks');
            if (tabElement != null && tabElement != undefined && tabElement.length > 0) {
                const currentElement = tabElement[0];
                if (currentElement != null && currentElement != undefined) {
                    const formId = currentElement.getAttribute('id');
                    const id = formId.substr(12, formId.length);
                    if (id > 0) {
                        const title = currentElement.value;
                        const data = {id, title};
                        //favorite-icon-no ,yes
                        //get data and check storage
                        const favData = McbTools.getFavoriteFormData();
                        if (favData != null) {
                            const filteredData = favData.filter(f => f.id == data.id);
                            if (filteredData.length > 0) {
                                document.getElementById('favorite-icon-no').style.display = 'none';
                                document.getElementById('favorite-icon-yes').style.display = 'block';
                            } else {
                                document.getElementById('favorite-icon-no').style.display = 'block';
                                document.getElementById('favorite-icon-yes').style.display = 'none';
                            }
                        } else {
                            document.getElementById('favorite-icon-no').style.display = 'block';
                            document.getElementById('favorite-icon-yes').style.display = 'none';
                        }
                    } else {
                        document.getElementById('favorite-icon-no').style.display = 'none';
                        document.getElementById('favorite-icon-yes').style.display = 'none';
                    }
                }
            } else {
                document.getElementById('favorite-icon-no').style.display = 'none';
                document.getElementById('favorite-icon-yes').style.display = 'none';
            }
        }

       function populateFavoriteCard() {
            const colors = [{id: 1, color: '#'}]
            const favData = McbTools.getFavoriteFormData();
            let $dashboard = $('<div class="dashboard-container" "></div>');
            let $favArea = $('<a class="fav-area"></a>');
            let $favAreaHeader = $('<div class="header"></div>');
            let $favAreaTitle = $('<div class="title">فرم های پرکاربرد</div>');
            let $favAreaContent = $('<div class="row content"></div>');
            $favAreaHeader.html($favAreaTitle);

            $favArea.append($favAreaHeader).append($favAreaContent);
            $dashboard.html($favArea);

            $("#tabidfrom0").html($dashboard);

            if (favData != null && favData.length > 0) {
                $.each(favData, function (i, v) {
                    const tabId = 'tabidfrom' + v.id;
                    let $bootstrapCard = $('<div class="col-2"></div>');
                    let $card = $('<a data-form-id="' + tabId + '" data-title="' + v.title + '" data-id="' + v.id + '" class="card"></a>');
                    let $cardHeader = $('<div class="card-header"></div>');
                    let $cardHeaderAction = $('<a class="card-header-action" data-id="' + v.id + '"><i class="fas fa-times"></i></a>');
                    $cardHeader.html($cardHeaderAction);
                    let $cardTitle = $('<span class="title">' + v.title + '</span>');
                    $bootstrapCard.html($card);
                    $card.append($cardHeader);
                    $card.append($cardTitle);
                    $favAreaContent.append($bootstrapCard);
                });
            } else {
                $favAreaContent.append('<div class="empty-fav-message" style="background-color: #FFF;text-align:right"><img src="Images/ERP.jpg"></div>');
            }

            $('.fav-area .card .title').on('click', function () {
                let element = $(this).parent('.card');
                let formId = element.attr("data-form-id");
                let id = element.attr("data-id");
                let title = element.attr("data-title");
                openWindowsInNewTabNavigation(id, formId, title, this);
            });
            $(".card-header-action").on('click', function () {
                let element = $(this);
                let id = element.attr("data-id");
                const favData = McbTools.getFavoriteFormData();
                if (favData != null && favData.length > 0) {
                    const currentData = favData.find(f => f.id == id);
                    if (currentData != undefined && currentData != null) {
                        console.log(currentData);
                        McbTools.removeFavoriteFormData(currentData);
                        McbTools.populateFavoriteCard();
                    }

                }
            })

        }

        // public methods
        return {
            rest: _ajax,
            getElementValue: _getElementValue,
            getElementByZName: _getElementByZName,
            getValueByZName: _getValueByZName,
            closeFindFormAndRefreshParent: _closeFindFormAndRefreshParent,
            closeCurrentTab: _closeCurrentTab,
            submitForm: _submitForm,
            confirmDialog: _confirmDialog,
            message: showMessage,
            addToFavoriteForm,
            getFavoriteFormData,
            removeFavoriteFormData,
            handleStatusOfFavoriteIcon,
            populateFavoriteCard
        }
    }

)();

const McbConstant = {
    FAVORITE_DATA_NAME: 'favoriteForms'
}

$(document).ready(async function() {
    
    
    
    
     var MID = document.getElementById('ZF_OUT_MESSAGE_ID');
     var RCID = document.getElementById('ZF_OUT_REC_ID');
     var M_TXT = document.getElementById('ZF_OUT_TXT');
     var c = document.getElementsByClassName("ZLBLMESSAGE");
     var error = document.getElementsByClassName("ErrorLable");
     if (MID != null )
     {
         if (MID.value.trim().length > 0)
         {
             if (MID.value == "0")
             {
                 // sucess
                
                if (M_TXT.value.trim().length > 0)
                {
                     Show_Message("پیام سیستم ", M_TXT.value,'info');
                }
                else
                {
                     Show_Message("پیام سیستم ", c[0].innerText,'info');
                }
                 
             }
             else
             {
                  // error 
                   let q = await get_message (MID.value);
                  
                   Show_Message("پیام سیستم ", q  + ' '  + error[0].innerText ,'danger');
             }
             
             return ;
         }
     }
    
    
    
     
     
     if (error != null && error != undefined)
     {
         if (error.length > 0)
         {
          
              showMessage("پیام سیستم ",error[0].innerText , 'danger');
              error[0].style.visibility = "hidden";
           return ;
         }
     }
     
     if (c == null || c == undefined){ return ;} 
     
     if (c.length > 0 )
     {
         if (c[0].innerText.length > 0 )
         {
             showMessage("پیام سیستم ",c[0].innerText, 'info');
         }
         
     }
    
});


async function get_message(Code)
{
     var message = localStorage.getItem(code);
     if (message != null && message.trim().length > 0)
     {
         return message;
     }
     else
     {
         let q = await call_get_message_data(code);
         if (!LA_IS_NULL(q))
         {
             var mid = q[0].CODE ;
             var text = q[0].TXT;
             localStorage.setItem(mid,text);
             return text;
         }
     }
     
    // return "برای این رخداد پیامی از سمت سرور یافت نشد";
    return "";
}


 async function call_get_message_data(P_code)
{
	 var param = []; 
	 	 param.push({name:'code', value:P_code});

 	 	 let s= await  callZf_jslib('sys/','get_message_data',param,2); 
	 	 return s; 
}


function Show_Message(Title,message)
    {
          let currentType = "info";
            $.notify.defaults({ globalPosition: 'top left'});
            $.notify(
                message,
                currentType
            );
        
        //alert(message);
        
//            if (message.trim().length > 4)
//            {
//                var c = $.dialog({
//                                title: Title,
//				content: message,
//				type: 'blue',
//				typeAnimated: true,
//				columnClass: 'small',
//                                 draggable: true,
//				rtl: true,
//				alignMiddle: true,
//				    buttons: {
//				   
//				       NO : {
//				             btnClass: 'btnNO',
//				             text: 'بستن',
//				             keys: ['N'],
//				             action: function () {}
//				        }
//            
//                    }
//                });
//            }
            
                 }
 /*   
function Show_Message(Title, message) {
    if (message.trim().length > 4) {
        var c = $.dialog({
            title: Title,
            content: message,
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

function Show_Message(Title, message) {
    if (message.trim().length > 4) {
        var c = $.dialog({
            title: Title,
            content: message,
            boxWidth: '500px',
            useBootstrap: false,
            draggable: true,
            theme: 'dark',
            theme: 'dark',

            rtl: true,
            backgroundDismiss: true,
            onDestroy: function () {
                b = 1;
            }
        });
    }
}

*/
//==============================================================================
    async function call_ws_c (ws_url,ws_name,ws_params,detail_form_name = '')
{
         let c = await callZf_jslib(ws_url, ws_name, ws_params, 2);

        var alertcode = c[0].ERROR;
        var alertdesc = c[0].ERROR_DESC;
        //  var helpcode = c[0].HELP_ID;

        if (alertcode != "0") {
            let mess = await call_translate_error(alertcode, alertdesc);
            var message =  mess[0].ERROR_DESC;
            var index = message.indexOf('{%O',0);
            var param = '';
            while ( index > 0){
                param = message.substring(index + 3 , message.indexOf("}",index));
                message = message.replace('{%O' + param + '}', c[0][param]);
                index = message.indexOf('{%O',index);
        }
            Show_Message('خطا',message);
        } else {
            if (detail_form_name = "") {
                Formnavigatebpm(GetUrlParameter('ID'));
            } 
            else 
            {
               // navigatebpmwithid(GetUrlParameter('ID'), "0&ZPPA1=" + GetUrlParameter('ZPPA1') + "&ZPPA2=" + GetUrlParameter('ZPPA2') + "&ZPPA3=" + GetUrlParameter('ZPPA3'));
                do_customize_job();
            }
        }

}

//=======================================================

function clear_all_controls()
{
    window.location.href=window.location.href;  
}

function GetAllRequiredControls(){ 
  var arr = []; 
  var form = document.getElementById('bpmform');   
  var c =  0 ; 
   
  if ( form != undefined )
  {
    for(var i=0; i < form.elements.length; i++) 
    { 
      if(form.elements[i].hasAttribute('required')) 
      {  
        arr[c] = form.elements[i].getAttribute('zid'); 
        c++; 
      }         
    } 
  }  
    return arr;     
     
 } 
 
function show_requrired_controls()
{
   
    var controlList = GetAllRequiredControls();
    var form = document.getElementById('bpmform');
    
    if ( form != undefined )
  {
    for (var i = 0; i < form.elements.length; i++) {
        form.elements[i].classList.remove('InputTextRq');
    }
    if (controlList.length > 0) {
        for (var i = 0; i < controlList.length; i++) {
            if (controlList[i] != null)
            {
            GetControlByName(controlList[i]).classList.add('InputTextRq');
             }
        }
    }
  }
}

$(document).ready(function() {
    
	show_requrired_controls();
        
        var Panel = document.getElementById('GridPanel');
        var len = $("table[class='Grid'] > tbody > tr").length;
        if (len == 0)
        {
            if (Panel != null && Panel != undefined)
            {
                    Panel.remove();
            }
        }
         


 });
// 
 function FindObject_Disable(ctrl01 , ctrl_disable ) {
// ctrl_disable = 0   
// ctrl_disable = 1  control is active
// ctrl_disable = -1  control is not active


         var b = parseInt(ctrl_disable);
 	 var ctrl_p = ctrl01.parentElement.parentElement.parentElement.parentElement;
 	    var childNodes = ctrl_p.getElementsByTagName('*');
 	    if (b >= 1 ){
				for (var node of childNodes) {
	    			node.disabled = false;
				}
		 } 
		 else if ( b  == -1 ) {
				for (var node of childNodes) {
	    			node.disabled = true;
				}
		 }    
	return true;
}

 function checkbox_Disable(ctrl01 , ctrl_disable ) {
// ctrl_disable = 0   
// ctrl_disable = 1  control is active
// ctrl_disable = -1  control is not active


         var b = parseInt(ctrl_disable);
 	 var ctrl_p = ctrl01.parentElement.parentElement;
 	    var childNodes = ctrl_p.getElementsByTagName('*');
 	    if (b >= 1 ){
				for (var node of childNodes) {
	    			node.disabled = false;
				}
		 } 
		 else if ( b  == -1 ) {
				for (var node of childNodes) {
	    			node.disabled = true;
				}
		 }    
	return true;
}

 function FindObject_Set(ctrl01 , ctrl_disable , ctrl_id , ctrl_text) {
// ctrl_disable = 0   
// ctrl_disable = 1  control is active
// ctrl_disable = -1  control is not active

  	 var ctrlname = ctrl01.name;
	 var ctrl02 = document.getElementById(ctrlname + 'txt');
          ctrl01.value = ctrl_id;
          if (ctrl02 != null)
          {
                ctrl02.value = ctrl_text;
          }
 	 
 	 var ctrl_p = ctrl01.parentElement.parentElement;
 	    var childNodes = ctrl_p.getElementsByTagName('*');
 	    if (ctrl_disable > '1' ){
				for (var node of childNodes) {
	    			node.disabled = false;
				}
		 } 
		 else if ( ctrl_disable == '-1' ) {
				for (var node of childNodes) {
	    			node.disabled = true;
				}
		 }    
		 
	return true;
}

 function LookupTableBox_Set(ElementName , Element_value_id ,Element_value_Code, Element_value_text, Element_disable) {
// Element_disable = 0   
// Element_disable = 1  control is active
// Element_disable = -1  control is not active
        var Element = getElementByAttribute('zid' , ElementName , null);

	 
     var Element_Code = document.getElementById(Element.name + '1');
     var Element_Text = document.getElementById(Element.name + '2');
     
         Element.value = Element_value_id;
	 Element_Code.value = Element_value_Code;
         Element_Text.value = Element_value_text;

 	 
 	 var Element_p = Element.parentElement;
 	    var childNodes = Element_p.getElementsByTagName('*');
 	    if (Element_disable > '1' ){
		for (var node of childNodes) {
                    node.disabled = false;
		}
	   }else if ( Element_disable === '-1' ) {
		for (var node of childNodes) {
	    	  node.disabled = true;
		}
	   }    
		 
	return true;
}

function closePanelForChild()
{
    var closeBtn =  window.parent.document.getElementById("close"); 
         closeBtn.click();

               var closeBtn =  window.parent.document.getElementsByClassName("ToolBoxControl");
           closeBtn.addEventListener("click", (event) => {
               alert('eeeee');
         		//closePanelForChild();
           });	
}

//==============================================================================
var formControlList = [];
function getElementsParameter(DC,key)
{
    formControlList = [];
    laodControlList(formControlList,DC);
  var param = [];
    param.push({name:key.getAttribute('zid').toLowerCase(), value:key.value});
    
    for (var c=0 ; c <formControlList.length ; c++){                
            var valueforsave= formControlList[c].value;                                
            if ( formControlList[c].tagName.toLowerCase() === 'input' && formControlList[c].getAttribute('type') === 'checkbox'){
                   if (formControlList[c].checked) 
                   {
                       valueforsave="1";
                   }
                   else
                   {
                       valueforsave="0";
                   }
               }else if ( formControlList[c].tagName.toLowerCase() === 'textareac' && formControlList[c].getAttribute('type') === 'texteditor'){
                    valueforsave = tinyMCE.get(ccid).getContent();
                }            
  		       if (valueforsave == undefined){valueforsave = ' ';}
    		   param.push({name:formControlList[c].getAttribute('zid').toLowerCase(), value:valueforsave.trim()});
        }
        var queryString = getQueryString();
        param.concat(queryString); 
        return param;
}


function  laodControlList(CL,DC)
{
    var q =   document.querySelectorAll("[zid]");
    
    for (let a=0 ; a < q.length ; a++ )
    {
            if(IS_Element_Parent(q[a],DC)){
                CL.push(q[a]);
            } 
     }
}
function IS_Element_Parent(EL,DC){
    var p1 = EL.parentElement;
   for (let a=0 ; a < 10 ; a++ )
    {
    if(p1 != null && p1 != undefined){
        if(p1.getAttribute('DataClass')== DC){
            if (EL.id.includes(EL.getAttribute('zid'))){
                return true;
            }
        }else{
            p1 = p1.parentElement;
        }
    }else{return false;}
    }
    
 return false;   
}
//==============================================================================
function removeInlineEvent(el)
{		
		var listOfEvents=[];  
		var attributes = [].slice.call(el.attributes);  
		
		for (i = 0; i < attributes.length; i++){
		    var att= attributes[i].name; 
		
		   if(att.indexOf("on")===0){
		
		     var eventHandlers={};
		     eventHandlers.attribute=attributes[i].name;
		     eventHandlers.value=attributes[i].value;
		     listOfEvents.push(eventHandlers);
		     el.attributes.removeNamedItem(att);             
		   }     
		} 
}
//==============================================================================
function get_checkbox_value(element){
	if(element.checked){
		return '1';
	}
	return '0';
}
    async function Make_Process(P_business_owner_id,P_branch_id,P_organization_id,P_process_id,P_source_type,P_source_id,P_source_rec_id,P_service_parameters)
{
        var ws_url = 'create_current_processes';
        var ws_name ='processes/';
    	var ws_params = []; 
	 	 ws_params.push({name:'business_owner_id', value:P_business_owner_id});
	 	 ws_params.push({name:'branch_id', value:P_branch_id});
	 	 ws_params.push({name:'organization_id', value:P_organization_id});
	 	 ws_params.push({name:'process_id', value:P_process_id});
	 	 ws_params.push({name:'source_type', value:P_source_type});
	 	 ws_params.push({name:'source_id', value:P_source_id});
	 	 ws_params.push({name:'source_rec_id', value:P_source_rec_id});
	 	 ws_params.push({name:'service_parameters', value:P_service_parameters});    
        let result = await  callZf_jslib(ws_url,ws_name,ws_params,2); 
	
        var alertcode = result[0].ERROR;
        var alertdesc = result[0].ERROR_DESC;

      //  var helpcode = 0;
        
    
	if (alertcode != "0"){
            let mess = await call_translate_error (alertcode,alertdesc);
            Show_Message('خطای شماره ' + alertcode ,mess[0].ERROR_DESC);
            return;
	}
        
        return result;
}


function get_form_id(){
    var c = document.getElementsByClassName("ZLBLMESSAGE");
     if (c == null || c == undefined){ return ;} 
        
     if (c.length > 0 )
     {
         var f_id = c[0].getAttribute('id');
         var myForm_CP = f_id.substr(0, f_id.length-10) + 'P_EditMode';
         return myForm_CP;
     }
}

function CheckShowMode() {
    var myForm_CP = get_form_id();
    //var myForm_CP = 'frmPRICE_PROPOSALP_EditMode'
    var showmode = getparamv('ZPPA9');
    if ( showmode == '1' || showmode == '-1') {
        ShowPanel('FormPanel', myForm_CP);
        document.getElementById( 'GridPanel' ).style.visibility = "hidden";
        getElementByAttribute('alt' , 'بستن' , null).style.visibility = "hidden";
      
	   if (showmode == '-1') {
	       disable_all_control();
	   }
	}
}

function removeItems(select)
{
		var length = select.options.length;
		for (i = length-1; i >= 0; i--) {
		  select.options[i] = null;
		}
}
function IsNull(P1){
	if (P1 == null || P1 == '' || P1 == '0' || P1 == undefined ){
		return true;
	}else{return false;}	
}
function znumber(P1){
   
     try 
      {
          var a = parseInt(P1);
          if (Math.abs(a)*2 > -1)
          {
              return true ;
          }
      }catch(e)
      {
          return false;
      }
   
   return false;
}

     function showMessage(title, message, type) {
            let currentType = "info";
            if (type !== null && type !== undefined) {
                switch (type) {
                    case 'info' :
                        currentType = "info";
                        break;
                    case 'danger':
                        currentType = "error";
                        break;
                    case 'warning':
                        currentType = "warn";
                        break;
                    case 'success':
                        currentType = "success";
                        break;
                }
            }
            $.notify.defaults({ globalPosition: 'top left'});
            $.notify(
                message,
                currentType
            );
        }
//        function showMessage(title, message, type) {
//            let currentType = "blue";
//            if (type != null && type != undefined) {
//                switch (type) {
//                    case 'info' :
//                        currentType = "blue";
//                        break;
//                    case 'danger':
//                        currentType = "red";
//                        break;
//                    case 'warning':
//                        currentType = "yellow";
//                        break;
//                    case 'success':
//                        currentType = "green";
//                        break;
//                }
//            }
//            $.dialog({
//                title: title,
//                content: message,
//                type: currentType,
//                theme: 'Z-confirm',
//                typeAnimated: true,
//            });
//        }
        
function get_confirm(intitle , incontent , btn_confirm_atribute,btn_cancel_atribute ,confirm_text,cancel_text, fn_ok , fn_cancel ){
 set_jconfirm_defaults();
 $.alert({
        title: intitle,
        content:incontent,
        rtl: true,
        closeIcon: true,
        buttons: {
            main_confirm: {
                text: confirm_text,
                btnClass: btn_confirm_atribute,
                action: function () {
                    if ( fn_ok != undefined ){fn_ok();}else{return;}
                }
            },
            main_cancel: {
                text: cancel_text,
                btnClass: btn_cancel_atribute,
                action: function () {
                 	if (fn_cancel != undefined){fn_cancel();}else{return;}
                }
            }
        }
    });
}


function resolve(){
	alert('yes');
}

function reject(){
	alert('No');
}


function set_jconfirm_defaults(){
     jconfirm.defaults = {
        title: 'Hello',
        titleClass: '',
        type: 'default',
        typeAnimated: true,
        draggable: true,
        dragWindowGap: 15,
        dragWindowBorder: true,
        animateFromElement: true,
        smoothContent: true,
        content: 'Are you sure to continue?',
        buttons: {},
        defaultButtons: {
            ok: {
                action: function () {
                }
            },
            close: {
                action: function () {
                }
            },
        },
        contentLoaded: function(data, status, xhr){
        },
        icon: '',
        lazyOpen: false,
        bgOpacity: null,
        theme: 'light',
        animation: 'scale',
        closeAnimation: 'scale',
        animationSpeed: 800,
        animationBounce: 1,
        rtl: true,
        container: 'body',
        containerFluid: false,
        backgroundDismiss: false,
        backgroundDismissAnimation: 'shake',
        autoClose: false,
        closeIcon: null,
        closeIconClass: false,
        watchInterval: 100,
        columnClass: 'col-md-4 col-md-offset-4 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1',
        boxWidth: '200%',
        scrollToPreviousElement: true,
        scrollToPreviousElementAnimate: true,
        useBootstrap: true,
        offsetTop: 40,
        offsetBottom: 40,
        bootstrapClasses: {
            container: 'container',
            containerFluid: 'container-fluid',
            row: 'row',
        },
        onContentReady: function () {},
        onOpenBefore: function () {},
        onOpen: function () {},
        onClose: function () {},
        onDestroy: function () {},
        onAction: function () {}
    };
}        
 
 
 async function process_start(P_process_id,P_source_id,P_source_rec_id,P_organization_id){
     		 var P_business_owner_id = 1;
		 var P_branch_id = 1;
		 //var P_organization_id = getElementByAttribute('zid' , 'VENDOR_ID' , null).value;
		 //var P_process_id = 3;
		 var P_source_type = 1;
		 //var P_source_id = 44;
		 //var P_source_rec_id = price_proposal_id.value;
		 var P_service_parameters = '';
        await call_create_current_processes(P_business_owner_id,P_branch_id,P_organization_id,P_process_id,P_source_type,P_source_id,P_source_rec_id,P_service_parameters)

 }
 
  async function get_rec_user_info(P_create_user_id,P_update_user_id)
{
	 var param = []; 
	 	 param.push({name:'create_user_id', value:P_create_user_id});
	 	 param.push({name:'update_user_id', value:P_update_user_id});

 	 	 let s= await  callZf_jslib('system/','get_rec_user_info',param,1); 
	 	 return s; 
}


function closealltabinfrom()
{
//    var tabllist =   document.getElementsByClassName('mcp_panel');
//    if (tabllist != null && tabllist!= undefined)
//    {
//        for (var a=0 ; a < tabllist.length ; a++)
//        {
//            tabllist[a].style.display = "none";
//        }
//    }
}




//-------------------------------------------------------

