﻿/**
表单验证类, 可以根据需要，参考下面的代码自行扩充
使用方法：在标签中可以添加以下属性
vtype:   输入域的类型，取值为[LetterStr, NumAndStr, NumStr, ...]， 可参考validrule
notNull/notnull: 是否为空，取值为[true, false]
vdisp:   表示提示信息
*/

var validrule               = new Object();
validrule.letterstr            = /^([a-zA-Z]+)?$/;     
validrule.numandstr            = /^([0-9a-zA-Z]+)?$/;
validrule.numstr               = /^(\d*)?$/;  
validrule.string               = /^([^'<>]+)?$/;
validrule.text 				   = /^([^'<>]+)?$/;                  
validrule.date                 = /^((([1-9]\d{3})|([1-9]\d{1}))-(0[1-9]|1[0-2])-(0[1-9]|[1-2]\d|3[0-1]))?$/;  
validrule.time                 = /^((0[1-9]|1[0-9]|2[0-4]):([0-5][0-9]):([0-5][0-9]))?$/; 
validrule.datetime             = /^((([1-9]\d{3})|([1-9]\d{1}))-(0[1-9]|1[0-2])-(0[1-9]|[1-2]\d|3[0-1]) (0[1-9]|1[0-9]|2[0-4]):([0-5][0-9]):([0-5][0-9]))?$/;   
validrule.year                 = /^(\d{4})?$/; 
validrule.month                = /^([1-9]|0[1-9]|1[0-2])?$/;
validrule.day                  = /^([1-9]|0[1-9]|1[0-9]|2[0-9]|3[0-1])?$/;
validrule.postcode             = /^(\d{6})?$/;           
validrule.email                = /^(.+\@.+\..+)?$/;   
validrule.phone                = /^(\(?0\d{2}\)?[-]?\d{8}|0\d{3}[-]?\d{7})?$/; 
validrule.mobiletel 		   = /^(1\d{10})?$/;
validrule.mobiletelorphone 	   = /^(\(?0\d{2}\)?[-]?\d{8}|0\d{3}[-]?\d{7}|(1\d{10}))?$/; 
validrule.movePhone            = /^1[0-9]{10}$/;
validrule.ip                   = /^(([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-5][0-5])\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-5][0-5])\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-5][0-5])\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-5][0-5]))?$/;  
validrule.idcard               = /^(\d{15}|\d{18}|\d{17}X|\d{17}x)?$/; 
validrule.tabledefine          = /^(([A-Za-z])([A-Za-z0-9|_]){1,18})?$/; 
validrule.chinese			   = /^[a-zA-Z\u4E00-\u9FA5]*$/;
validrule.notstring 		   = /^([^'<>\s]+)?$/;
validrule.htm 				   = /^\w+.+htm?$|\w+.+html?$/;
validrule.file 				   = /^([^'<>]+\:+)|(\\+)([^'<>]+)?$/;
validrule.datastr			   = /^[a-zA-Z]+\w*$/;
validrule.integer              = /^([1-9]\d{0,9})?$/; 
validrule.number               = /^(\d*)?$/;
validrule.percentage           = /^(([0-9](\.[0-9][0-9])?)|[0-9]|([1-9][0-9](\.[0-9][0-9]))|([1-9][0-9])?|100)$/  //匹配百分比 0 - 100
validrule.minusint             = /^(\-([1-9])(\d*))?$/;
validrule.floatnumber          = /^((\.([0-9]\d*))|(([0-9]\d*)\.\d+$)|([0-9]\d*))?$/;  
validrule.url 				   = /(^$)|(^(http:\/\/))/;
validrule.notnegativenumber    = /^\d+(\.\d+)?$/;     //匹配非负数（正数 + 0）
validrule.allnumber 		   = /^(-?\d+)(\.\d+)?$/   //匹配数字
validrule.chinesandenumandstr  = /^([\-0-9a-zA-Z\u4E00-\u9FA5]+)?$/;   //匹配数字,汉字,字符
validrule.chinesStandard  	   = /^([0-9a-zA-Z\u4E00-\u9FA5]+[-]?)?$/;   
validrule.stringNoSpecial      = /^([\u4e00-\u9fa5]+|[a-zA-Z0-9]+)$/;//特树字符
validrule.organization      = /^[a-zA-Z0-9]{8}-[a-zA-Z0-9]$/;//组织机构代码

var errorMessage = new Array();
var controlList = new Array();

//去左空格;
function ltrim(s) {
    return s.replace(/(^\s*)/g, "");
}
//去右空格;
function rtrim(s) {
    return s.replace(/(\s*$)/g, "");
}
//去左右空格;
function trim(s) {
    return rtrim(ltrim(s));
}

function validateCheckBoxOrRadio(el) {
    for (var j = 0; j < el.length; j++) {
        if (el[j].checked) {
            return true;
            break;
        }
    }
    return false;
}
//验证form中所有项
//isAll 是否一次验证所有项，默认一次验证一项
function doValidate(vform,isAll) {
errorMessage = new Array();
controlList = new Array();
var elements = vform.elements;
var frmLen = elements.length;
var thePat = "";
var strFormatInfo = "";
var checkboxName = "";
//对于每一个FROM元素
for (var i = 0; i < frmLen; i++) {
    var elem = elements[i];
    //为空检查 
    var isnull = elem.getAttribute('notnull');
    var vdisp = elem.getAttribute('vdisp');
    if ((isnull != null && isnull == "true") || (isnull != null && isnull == "true")) {
        if (elem.type == "checkbox" || elem.type == "radio") {
            var el = document.getElementsByName(elem.name);
            if (!validateCheckBoxOrRadio(el) && checkboxName != elem.name) {
          	  checkboxName = elem.name;
          	  addMessage(elem, "请选择“" + vdisp + "”！");	
                if(!isAll){
                    break;
                }
            }
        } 
        else {
            if(elem.tagName == "SELECT"){
                if (elem.selectedIndex == 0) {
                    addMessage(elem, "请选择“" + vdisp+"”！");
                    if(!isAll){
                        break;
                    }
                }
            }
            else{
                if (trim(elem.value).length == 0) {
                    addMessage(elem, "“" + vdisp + "”不能为空！");
                    if(!isAll){
                        break;
                    }
                }
            }
        }
    }

    if (elem.type == "checkbox" || elem.type == "radio") {
       /* var spanObj;
        if(elem.parentElement.parentElement.tagName == "DIV"){
            spanObj = elem.parentElement;
        }
        if(elem.parentElement.parentElement.tagName == "TD"){
            spanObj = getParentByTagName(elem,"TABLE");
        }
        if(elem.parentElement.tagName == "TD"){
            spanObj = getParentByTagName(elem,"TABLE");
        }
        if(elem.parentElement.tagName == "TH"){
            spanObj = getParentByTagName(elem,"TABLE");
        }*/
//        if((spanObj.notNull != null && spanObj.notNull == "true")|| (spanObj.notnull != null && spanObj.notnull == "true")){
//            var childNodes = spanObj.getElementsByTagName("INPUT");
//            var selectCount = 0;
//            for(var j = 0;j< childNodes.length;j++){
//                if(childNodes[j].type == "checkbox" || childNodes[j].type == "radio"){
//                    if(childNodes[j].checked){
//                        selectCount++;
//                    }
//                }
//            }
//            if(selectCount == 0){
//                addMessage(elem, "请选择“" + spanObj.vdisp + "”！");
//                if(!isAll){
//                    break;
//                }
//            }
//        }
    } 
        
    if (elem.type == "textarea" || elem.tagName=="TEXTAREA") {
    	if (trim(elem.value).length > elem.Tmaxlength) {
  			var vdisp = vdisp || "";
  			addMessage(elem, vdisp + "超过限定长度，请检查!" + vdisp + "限定长度为"+elem.Tmaxlength+" , 实际长度为" + trim(elem.value).length + ". (中文字符长度为2)");
  			elem.focus();
  			if(!isAll){
  				break;
  			}
  			return false;
        }
    }
    //类型检查          
    var vtype=elem.getAttribute('vtype');
    if (vtype == null) {
        continue;
    }
    else if (vtype == "none") {
        thePat = "";
        strFormatInfo = "";
    }
    else if (vtype == "letterstr") {
        thePat = validrule.letterstr;
        strFormatInfo = "全部为字母";
    }
    else if (vtype == "numandstr") {
        thePat = validrule.numandstr;
        strFormatInfo = "数字和字母的组合";
    }
    else if (vtype == "organization") {
        thePat = validrule.organization;
        strFormatInfo = "组织机构代码，如：00000000-0";
    }
    else if (vtype == "numstr") {
        thePat = validrule.numstr;
        strFormatInfo = "全部为数字";
    }
    else if (vtype == "string") {
        thePat = validrule.stringNoSpecial;
        strFormatInfo = "不含特殊符号，例如：@、#";
    }
    else if (vtype == "text") {
        thePat = validrule.text;
        strFormatInfo = "不含特殊符号，例如：@、#";
    }
    else if (vtype == "date") {
        thePat = validrule.date;
        strFormatInfo = "日期型，比如 2004-08-12";
    }
    else if (vtype == "time") {
        thePat = validrule.time;
        strFormatInfo = "时间型，比如08:37:29";
    }
    else if (vtype == "datetime") {
        thePat = validrule.datetime;
        strFormatInfo = "日期时间型，比如2004-08-12 08:37:29";
    }
    else if (vtype == "year") {
        thePat = validrule.year;
        strFormatInfo = "年代格式，比如 2005";
    }
    else if (vtype == "month") {
        thePat = validrule.month;
        strFormatInfo = "月份格式，比如 08";
    }
    else if (vtype == "day") {
        thePat = validrule.day;
        strFormatInfo = "日子格式，比如 14";
    }
    else if (vtype == "postcode") {
        thePat = validrule.postcode;
        strFormatInfo = "邮编，比如 100001";
    }
    else if (vtype == "email") {
        thePat = validrule.email;
        strFormatInfo = "电子邮件格式，比如 msm@hotmail.com";
    }
    else if (vtype == "phone") {
        thePat = validrule.phone;
        strFormatInfo = "电话号码格式，比如010-00000000";
    }
    else if (vtype == "mobiletel") {
        thePat = validrule.mobiletel;
        strFormatInfo = "手机号码格式，比如13800000000";
    }
    else if (vtype == "ip") {
        thePat = validrule.ip;
        strFormatInfo = "机器ip地址格式，比如 172.22.169.11";
    }
    else if (vtype == "idcard") {
        thePat = validrule.idcard;
        strFormatInfo = "身份证号码，比如15位或者18位数字";
    }
    else if (vtype == "tabledefine") {
        thePat = validrule.tabledefine;
        strFormatInfo = "不能以数字开头，如p_tablename";
    }
    else if (vtype == "chinese") {
        thePat = validrule.chinese;
        strFormatInfo = "汉字或字母";
    }
    else if (vtype == "notstring") {
        thePat = validrule.notsstring;
        strFormatInfo = "不能包含空格和特殊字符";
    }
    else if (vtype == "htm") {
        thePat = validrule.htm;
        strFormatInfo = "html格式或htm格式";
    }
    else if (vtype == "url") {
        thePat = validrule.url;
        strFormatInfo = "url地址格式，比如 http://www.baidu.cn";
    }
    else if (vtype == "file") {
        thePat = validrule.file;
        strFormatInfo = "文件格式";
    }
    else if (vtype == "datastr") {
        thePat = validrule.DataStr;
        strFormatInfo = "第一个输入必须是英文字母";
    }
    else if (vtype == "integer") {
        thePat = validrule.integer;
        strFormatInfo = "整数，比如123";
    }
    else if (vtype == "number") {
        thePat = validrule.number;
        strFormatInfo = "数字";
    }
    else if (vtype == "percentage") {
        thePat = validrule.percentage;
        strFormatInfo = "百分比0.01-100";
    }
    else if (vtype == "minusint") {
        thePat = validrule.minusint;
        strFormatInfo = "负整数，比如-123";
    }
    else if (vtype == "floatnumber") {
        thePat = validrule.floatnumber;
        strFormatInfo = "实数，比如356.32";
    }
    else if (vtype == "notnegativenumber") {
        thePat = validrule.notnegativenumber;
        strFormatInfo = "非负数，比如356.32";
    }
    else if (vtype == "allnumber") {
        thePat = validrule.allnumber;
        strFormatInfo = "数字，比如356.32";
    }
    else if(vtype == "chinesandenumandstr"){
  	  thePat = validrule.chinesandenumandstr;
        strFormatInfo = "数字,字母,汉字，比如 ‘某某某’";
    }
    else if(vtype == "mobiletelorphone"){
  	  thePat = validrule.mobiletelorphone;
        strFormatInfo = "座机号码或者手机号码，比如 010-15252525 或者 15200000000";
    }
    else if(vtype == "movePhone"){
  	  thePat = validrule.movePhone;
        strFormatInfo = "11位移动手机号码，比如  15200000000！";
    }
    var gotIt = null;
    if (thePat != "") {
        gotIt = thePat.exec(elem.value);
    }
    if (gotIt == null && elem.value != "") {
        addMessage(elem, "“" + vdisp + "”输入不合法，格式应为：" + strFormatInfo);
        if(!isAll){
            break;
        }
    }
}
return showMessages(isAll);
}

function submitForm(vform, showConfirm, isAll) {
    if (isAll == undefined) {
        isAll = false;
    }
    if (doValidate(vform,isAll)) {
        if(showConfirm != null && showConfirm != undefined && showConfirm){
            if (confirm('您确定提交吗？')) {
            	//vform.submit();
                return true;
            }
            else{
                return false;
            }
        }
        else{
            return true;
        }
        
    }
    return false;
}	

function submitFormTrue(vform){
	vform.submit();
}

/* 显示错误消息 */
function showMessages(isAll){
	if(errorMessage == null || errorMessage.length == 0) {
		return true;
	}
	var temperrorMessage = "";
	if (isAll) {
	    for (var k = 0; k < errorMessage.length; k++) {
	        temperrorMessage += ((k + 1) + "、" + errorMessage[k] + "\n");
	    }
	}
	else {
	    temperrorMessage += errorMessage[0] + "\n";
	}
	alert(temperrorMessage);    
    if(controlList.length!=0){
        try{
            //controlList[0].focus();
           // controlList[0].select();
        }
        catch(e){
            return false;
        }
    }
    return false;
}

//验证是否通过
function isValidateOK(){
	return ((errorMessage == null) || (errorMessage.length == 0));
}

//addMessage
function addMessage(obj, params){
    errorMessage.push(params);
    addToControlList(obj);
}

//把当前控件追加到控件列表
function addToControlList(obj){
    for (var i = 0; i < controlList.length; i++) {
        if (controlList[i] == obj) {
            return;
        }
    }
    controlList.push(obj);
}
function validateTextareaMaxlength(elem){
	var strLen = stringLength(elem.value);
	if(elem.maxlength != null  &&  strLen > elem.maxlength) 
	{
		var vdisp = vdisp || "";
		alert(vdisp + "超过限定长度，请检查! \r\n\r\n" + vdisp + "限定长度为" + elem.maxlength + ", 实际长度为" + strLen + ". \r\n(中文字符长度为2)");
		elem.focus();
		return false;
	}
	return true;
}

function stringLength(str){
	if(str==null) return 0;
	var n = 0;
	for(var i=0; i<str.length; i++){
		if(str.charCodeAt(i)>255)
			n = n + 2;
		else n++;
	}
	return n;
}