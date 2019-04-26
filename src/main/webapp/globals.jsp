﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
		<!-- basic styles -->
		<link rel="stylesheet" href="<%=basePath%>assets/css/bootstrap.min.css" />
		<link rel="stylesheet" href="<%=basePath%>assets/css/font-awesome.min.css" />
		<link rel="stylesheet" href="<%=basePath%>assets/css/jquery-ui-1.10.3.custom.min.css" />
		<link rel="stylesheet" href="<%=basePath%>assets/css/chosen.css" />
		<link rel="stylesheet" href="<%=basePath%>assets/css/colorpicker.css" />
		<link rel="stylesheet" href="<%=basePath%>assets/css/ui.jqgrid.css" />
		<link rel="stylesheet" href="<%=basePath%>assets/css/ace.min.css" />
		<link rel="stylesheet" href="<%=basePath%>assets/css/ace-rtl.min.css" />
		<link rel="stylesheet" href="<%=basePath%>assets/css/ace-skins.min.css" />
		<link rel="stylesheet" href="<%=basePath%>assets/css/jquery-ui-1.10.3.full.min.css" />
		<link rel="stylesheet" href="<%=basePath%>assets/css/zTreeStyle/zTreeStyle.css" />
		<link rel="stylesheet" href="<%=basePath%>css/public/globals.css" />
		<link rel="stylesheet" href="<%=basePath%>css/public/fileinput.css" />
		<style>
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
			.isShow{
				display:none
			}
			.isHide{
				display:block
			}
		</style>
	</head>
	<body>
		<script type="text/javascript" src="https://api.map.baidu.com/api?v=2.0&ak=QWntoaxcGm9RzCKrOuOjCN5P&s=1"></script>
		<script src="<%=basePath%>assets/js/jquery-2.0.3.min.js"></script>
		<script src="<%=basePath%>assets/js/ace-extra.min.js"></script>
		<script src="<%=basePath%>assets/js/bootstrap.min.js"></script>
		<script src="<%=basePath%>assets/js/typeahead-bs2.min.js"></script> 
        <script src="<%=basePath%>js/customer/validateform.js"></script>
		<script src="<%=basePath%>assets/js/jquery-ui-1.10.3.custom.min.js"></script>
		<script src="<%=basePath%>assets/js/jquery.slimscroll.min.js"></script>
		<script src="<%=basePath%>assets/js/jquery.sparkline.min.js"></script>
		<script src="<%=basePath%>assets/js/jqGrid/jquery.jqGrid.min.js"></script>
		<script src="<%=basePath%>assets/js/jqGrid/i18n/grid.locale-cn.js"></script>
		<script src="<%=basePath%>assets/js/ajaxfileupload.js"></script>
		<script src="<%=basePath%>assets/js/jquery-ui-1.10.3.full.min.js"></script>
		<script src="<%=basePath%>assets/js/ace-elements.min.js"></script>
		<script src="<%=basePath%>assets/js/ace.min.js"></script>
		<script src="<%=basePath%>assets/js/chosen.jquery.min.js"></script>
		<script src="<%=basePath%>assets/js/jquery.autosize.min.js"></script>
		<script src="<%=basePath%>assets/js/bootstrap-tag.min.js"></script>
		<script src="<%=basePath%>assets/js/jquery.qrcode.min.js"></script>
		<script src="<%=basePath%>assets/js/menus.js"></script>
        <script src="<%=basePath%>assets/js/menu.js"></script>
        <script src="<%=basePath%>assets/js/ztree/jquery.ztree.all.min.js"></script>
        <script src="<%=basePath%>assets/js/ztree/jquery.ztree.core.min.js"></script>
        <script src="<%=basePath%>assets/js/ztree/jquery.ztree.excheck.min.js"></script>
        <script src="<%=basePath%>assets/js/ztree/jquery.ztree.exedit.min.js"></script>
        <script src="<%=basePath%>assets/js/ztree/jquery.ztree.exhide.min.js"></script>
        <script src="<%=basePath%>js/customer/common.js"></script>
        <script src="<%=basePath%>/js/customer/fileinput.js"></script>
        <script src="<%=basePath%>/js/customer/zh.js"></script>
        <script src="<%=basePath%>/js/My97DatePicker/WdatePicker.js"></script>
       <script type="text/javascript">
        	//列表高度全局变量
        	listHeight="346";
        	//listHeight="98%";
        	autoHeight="100%";
        	//文件上传大小限制
        	maxFileSize="51200";
        	//项目路径
        	basePath='<%=basePath%>';
        	//用户名称
        	userName="<%=session.getAttribute("USERNAME")%>";
        	//用户ID
        	userId="<%=session.getAttribute("USERID")%>";
        	//角色String
        	roleString="<%=session.getAttribute("ROLESTRING")%>";
        	//部门ID
        	deptId = "<%=session.getAttribute("DEPTID")%>";
        	//部门名称
        	deptName="<%=session.getAttribute("DEPTNAME")%>";
        	//是否是管理员
        	isAdmin="<%=session.getAttribute("ISADMIN")%>";
        	//是否是人员信息管理者
        	isManager = "<%=session.getAttribute("ISMANAGER")%>";
    		$(function(){
    			//页面加载时，判断session是否超期
    			if(userName==""||userName=="null"){
   					alert("您已超时登录，请重新登录！")
   					top.location.href="<%=basePath%>";
    			}
    			
    			if(isManager=="true"){
    				$('.ismanager').show();
    			}else{
    				$('.ismanager').hide();
    			}
    			
    			
    			
    			
    			
    			
    			
    			
    			
    			/*
    			以下代码未整理
    			
    			*/
    			
    			
	        	
	        	 //全局下拉框
	        	$('.globalSels').each(function(){
 	        		var StableName=$(this).attr('StableName');//表名
 	        		var StableClo =$(this).attr('StableClo');//字段名
 	        		var filter=$(this).attr('filter');//过滤条件
 	        		var that=this;
 	        		var selectUrl="<%=basePath%>/blog/globalSel.do?StableName="+StableName+
 	        				"&StableClo="+StableClo+"&filter="+filter;
 	    			$.ajax({
	    				url: selectUrl,
	    				type: "POST",
	    				data: "",
	    				async:false,
    					success: function(resObj) {
    						that.innerHTML=resObj;
    					}
	    			});
	        	}); 
	        	
	        	//下拉树相关
	        	$(".MySelecttree").addClass("treehidden");
	        	$('.MySelecttreeinput').click(function(){
					$('#'+this.id+'Tree').removeClass("treehidden");
				});
	        	$(".MySelecttree").click(function(e){
					e.stopPropagation();
					$(this).removeClass("treehidden");
				});
				$(document).dblclick(function(){
					if($(".MySelecttreeinput").is(":focus")){
						
					}else{
						if(!$(".MySelecttree").hasClass("treehidden")){
							$(".MySelecttree").addClass("treehidden");
						}
					}
				});
				
				//下拉框加载
	        	$('select').each(function(){
	        		var mapName=$(this).attr('mapName');
	        		var type=$(this).attr('type');
	        		var that=this;
	        		var selectUrl=basePath+mapName+"/getSelectData.do";
	        		if(type!=""&&type!=undefined&&type!=null){
	        			selectUrl=basePath+mapName+"/dateForSelect.do?type="+type;
	        		}
	        		if (mapName) {
		    			$.ajax({
		    				url: selectUrl,
		    				type: "POST",
		    				data: "",
		    				async:false,
		    				success: function(resObj) {
		    					that.innerHTML=resObj;
		    				}
		    			});
	        		}
	        	});
				//下拉框补全
				$.widget( "custom.catcomplete", $.ui.autocomplete, {
					_renderMenu: function( ul, items ) {
						var that = this,
						currentCategory = "";
						$.each( items, function( index, item ) {
							if ( item.category != currentCategory ) {
								ul.append( "<li class='ui-autocomplete-category'>" + item.category + "</li>" );
								currentCategory = item.category;
							}
							that._renderItemData( ul, item );
						});
					}
				});
				//必选的下拉框
				$(".chosen-select").chosen();
				//
				var Uov=getUrlParam("Uov");
		        if(Uov=="view"){
		        	$('input').attr("disabled",true);
		        	$('.save_btn').hide(); 
		        	$('.save_btn').attr("disabled",true);
		        	$("select").attr("disabled", "disabled");
		        	//$("button").attr("disabled",true);
		        }
		      //窗口自适应
				$(window).resize(function(){   
			  		$('.autowith').setGridWidth($('.page-content').width-5);
				});
    		});
    		
    	

    		//分页图标
    		function updatePagerIcons(table) {
    			var replacement = 
    			{
    				'ui-icon-seek-first' : 'icon-double-angle-left bigger-140',
    				'ui-icon-seek-prev' : 'icon-angle-left bigger-140',
    				'ui-icon-seek-next' : 'icon-angle-right bigger-140',
    				'ui-icon-seek-end' : 'icon-double-angle-right bigger-140'
    			};
    			$('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon').each(function(){
    				var icon = $(this);
    				var $class = $.trim(icon.attr('class').replace('ui-icon', ''));
    				
    				if($class in replacement) icon.attr('class', 'ui-icon '+replacement[$class]);
    			});
    		}
    		function enableTooltips(table) {
    			$('.navtable .ui-pg-button').tooltip({container:'body'});
    			$(table).find('.ui-pg-div').tooltip({container:'body'});
    		}
    		
    		
    		function headCenter(table){
    			$(table).closest("div.ui-jqgrid-view")
    				.children("div.ui-jqgrid-titlebar")
    				.css("text-align","center")
    				.children("span.ui-jqgrid-title")
    				.css("float","none");
    		}
    		//执行ajax
    		function execAjax(type, url, data) {
    			$.ajax({
    				url: url,
    				type: type,
    				data: data,
    				error: function(result) {
    				 	var rev=JSON.parse(result);
    		    		alert(rev.msg);
    		    		window.location.reload();
    				 	},
    		        success: function (result) { 
    		        	var rev=JSON.parse(result);
    		    		alert(rev.msg);
    		    		window.location.reload();
    					}
    			});
    		}
    		//获取列表数据
    		function getRowData(gid){
    			var rowData=null;
    			$.each(dgData.rows, function(i,row){      
    				if(row.gid==gid){
    					rowData=row;
    			 		return false;
    				}
    		  	});  
    			return rowData;
    		}
    		//获取url中的参数
            function getUrlParam(name) {
                var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
                var r = window.location.search.substr(1).match(reg);  //匹配目标参数
                if (r != null) return unescape(r[2]); return null; //返回参数值
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
			//获取后台路径的方法
			function getBackPath(){
			var path="";
					$.ajax({
    				url: "<%=basePath%>"+"/blog/getBackPath.do?",
    				type: "get",
    				data: "",
    				async:false,
    				error: function(result) {
    					alert("获取失败！");
   				 	},
    		        success: function (result) {
    		         	path=result;
   					}
    			});
    			return path;
			}  
        </script>
</body>
</html>

