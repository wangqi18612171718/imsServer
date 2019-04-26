<%@page import="cn.rails.ims.utils.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	// 获得本项目的地址(例如: http://localhost:8080/MyApp/)赋值给basePath变量    
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	// 将 "项目路径basePath" 放入pageContext中，待以后用EL表达式读出。    
	pageContext.setAttribute("basePath", basePath); 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<title><%=Constants.TITLE_STRING%></title>
	</head>
	<style>
		.input_box{
			width:680px;
			margin:0 auto;
		}
		.input_box input {
			float: left !important;
			height: 45px !important;
			width: 250px !important;
			margin-top: 30px !important;
			margin-right: 35px !important;
			background-color: transparent !important;
			background-color: 0 !important;
			border: 0 !important;
			padding-left: 50px !important;
			padding-right: 5px !important;
			font-family: "宋体" !important;
			font-size: 18px !important;
			border-radius: 8px !important;
			outline: none !important;
			box-shadow: 0 0 100px 4px #194b67 !important;
		}
		.input_box input:hover {
			box-shadow: 0 0 40px 2px #4599c8 !important;
		}
		.name {
			background-image: url(images/input_bg_name.png);
			background-size:100% 100%;
		}
		.password {
			background-image: url(images/input_bg_password.png) !important;
			background-size:100% 100% !important;
		}
		.input_box button {
			float: left;
			height: 45px;
			width: 110px;
			margin-top: 30px;
			padding: 0px;
			border: 0;
			background-color: transparent;
			background-image: url(images/button_login.png);
			background-size:100% 100%;
			border-radius: 8px;
			box-shadow: 0 0 100px 4px #194b67;
		}
		.input_box button:hover {
			box-shadow: 0 0 40px 2px #4599c8;
			cursor: pointer;
		}
		.line {
			position: absolute;
			width: 685px;
			height: 3px;
			background-image: url(images/line_bg.png);
			margin-top:120px;
		}
		.qr_box {
			width: 475px;
			height: 246px;
			position: absolute;
			left: 50%;
			top: 50%;
			margin-left: -238px;
			margin-top: 240px;
			text-align:center;
			font-family:微软雅黑;
			font-size:10px;
		}
		.qr_box h3 {
			font-family: "微软雅黑";
			font-size: 12px;
			font-weight: 100;
			text-align: center;
			color: white;
		}
		.grid .ui-jqgrid-htable th,
		.grid .ui-jqgrid-btable .jqgrow td {
			height: 3em !important;
		}
		.sidebar-shortcuts-large{
			padding-bottom:0px;
		}
		.ui-jqgrid .ui-jqgrid-labels th{
			text-align:center !important;
		}
		body{
			font-family: "Microsoft YaHei";
		}
		.input-group{
			line-height:40px;
		}
		.searchBtn{
			padding:2px 0px 7px 0px !important;
			border-color:#aaa !important;
		}
	</style>
	<meta charset="utf-8" />
	<link rel="stylesheet" href="<%=basePath%>assets/css/bootstrap.min.css" />
	<link rel="stylesheet" href="<%=basePath%>assets/css/ace.min.css" />
	<link rel="stylesheet" href="<%=basePath%>assets/css/ace-rtl.min.css" />
	<link rel="stylesheet" href="<%=basePath%>assets/css/ace-skins.min.css" />
	<script src="<%=basePath%>assets/js/jquery-2.0.3.min.js"></script>
	<script src="<%=basePath%>assets/js/ace-extra.min.js"></script>
	<script src="<%=basePath%>assets/js/bootstrap.min.js"></script>
	<script src="<%=basePath%>assets/js/typeahead-bs2.min.js"></script> 
	<script src="<%=basePath%>assets/js/jquery-ui-1.10.3.custom.min.js"></script>
	<script src="<%=basePath%>assets/js/jqGrid/jquery.jqGrid.min.js"></script>
	<script src="<%=basePath%>assets/js/jqGrid/i18n/grid.locale-cn.js"></script>
	<script src="<%=basePath%>assets/js/jquery-ui-1.10.3.full.min.js"></script>
	<script src="<%=basePath%>assets/js/ace-elements.min.js"></script>
	<script src="<%=basePath%>assets/js/ace.min.js"></script>
	<script src="<%=basePath%>assets/js/jquery.autosize.min.js"></script>
	<script src="<%=basePath%>assets/js/bootstrap-tag.min.js"></script>
	<script src="<%=basePath%>assets/js/jquery.qrcode.min.js"></script>
	<body class="login-layout" style="background:url(images/jl_background.png) no-repeat 0 center;background-size:100% 100%;">
		<div class="main-container" >
			<div class="main-content" >
				<div class="row">
					<div class="col-sm-10 col-sm-offset-1" >
						<div class="login-container" >
							<div class="space-26"></div><div class="space-4"></div>
							<div class="center">
								<h1>
									<img width="225px" src="images/white_logo.png"></img>
								</h1>
							</div>
							<div class="space-10"></div>
							<div class="center">
								<img width="685px"  src="images/jl_Title.png"></img>
							</div>
							<div class="input_box center" >
						        <input id="loginName" class="name"/>
						        <input id="loginPasswd" class="password" type="password"/>
						        <button id="login_btn"></button>
						        <div class="line center"></div>
						     </div>
						    <div class="qr_box">
						   		<h3>移动端下载</h3>
						   		<div style="width:130px;margin:0 auto">
							   		<div id="i_code" style="width:130px">
									</div>
						   		</div>
						      	<h3 style="width: 475px;position: absolute; bottom:20px;text-align:center">COPYRIGHT©2001-2017 China Academy of Railway Sciences，All Rights Reserved<br>
						      		<p>中国铁道科学研究院 版权所有</p>
						      	</h3>
						    </div>
						</div>
					</div><!-- /.col -->
				</div><!-- /.row -->
			</div>
		</div><!-- /.main-container -->
	<script type="text/javascript">
		//项目路径
    	basePath='<%=basePath%>';
		$(function(){
			//http跳转到https
// 			var oldprotocol = window.location.protocol;
// 			if(oldprotocol =='http:'){
// 				var oldUrl = window.location.href;
// 				var newUrl = oldUrl.replace("http", "https");
// 					window.location.href = 'newUrl'
// 			}
			//回车登录
			document.onkeydown = function(e){
				var ev = document.all ? window.event : e;
				if(ev.keyCode==13) {
			    	login();
			    }
			}
			$("#login_btn").click(function(){
				login();
			});
			//生成二维码
			$("#i_code").empty();
			var i_str = basePath+"appDownload/download.html";
			var url = "http://ims.rails.cn:80/appDownload/download.html";
			i_str=toUtf8(url);
			$("#i_code").qrcode({
				render: "canvas",
				width: 130,
				height:130,
				text: i_str,
				src: "images/white_logo.png"
			});
		});
		//登录方法	
		function login(){
			var loginname=$("#loginName").val();
			var password=$("#loginPasswd").val();
			if(loginname!=""&&password!=""){
				var LoginUrl=basePath+"login/login.do?loginname="+encodeURIComponent(loginname)+"&pwd="+encodeURIComponent(password);
				$.ajax({
					url: LoginUrl,
					type: "POST",
					data: "",
					success: function(result) {
					 	var rev=JSON.parse(result);
					 	if(rev.status_code=="0"){
					 		alert(rev.msg);
					 	}else{
					 		top.location.href=basePath+"index.jsp";
					 	}
					 },
					 error: function (result) { 
			        	var rev=JSON.parse(result);
			    		alert(rev.msg);
			    		window.location.reload();
					}
				});				
			}else{
				alert("请输入正确的用户名和密码！");
			}
		}
		//转UTF-8
      	function toUtf8(str) {     
		    var out, i, len, c;   
		    out = "";   
		    len = str.length;   
		    for(i = 0; i < len; i++) {   
		    	c = str.charCodeAt(i);   
		    	if ((c >= 0x0001) && (c <= 0x007F)) {   
		        	out += str.charAt(i);   
		    	} else if (c > 0x07FF) {   
		        	out += String.fromCharCode(0xE0 | ((c >> 12) & 0x0F));   
		        	out += String.fromCharCode(0x80 | ((c >>  6) & 0x3F));   
		        	out += String.fromCharCode(0x80 | ((c >>  0) & 0x3F));   
		    	} else {   
		        	out += String.fromCharCode(0xC0 | ((c >>  6) & 0x1F));   
		        	out += String.fromCharCode(0x80 | ((c >>  0) & 0x3F));   
		    	}   
		    }   
		    return out;   
		}
	</script>
	</body>
</html>
