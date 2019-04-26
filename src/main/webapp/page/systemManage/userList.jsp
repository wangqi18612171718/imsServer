<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<body>
	<%@include file="../../globals.jsp" %>
		<div class="main-container" id="main-container">
			<div class="main-container-inner">
				<div class="breadcrumbs" id="breadcrumbs">
					<ul class="breadcrumb" style="line-height:40px;">
						<li><i class="icon-home home-icon"></i>首页</li><li>系统管理</li><li>用户信息</li>
					</ul>
				</div>
				<div class="page-content">
					<div class="pull-left input-group" style="width:100%">
						<label class="inline">
							<span class="pull-left">用户名称</span>
						</label>
						<input type="text" class=""searchBtn" id="userName" style="width:18% !important" />
						<label class="inline">
							<span class="pull-left">用户编码</span>
						</label>
						<input type="text" class="searchBtn" id="userCode" style="width:18% !important"/>
						<button type="button" class="btn btn-info" id="userSearch" style="line-height:20px">
						<i class="icon-search bigger-110"></i>搜索
					</button>
						<button class='btn btn-info pull-right ismanager' style='margin-top:7px;'data-toggle='modal' id="delUser" onclick="delectUserList()">
							<i class='icon-trash'></i>删除</button>
						<button class='btn btn-info pull-right ismanager' style='margin-top:7px;'data-toggle='modal' id="addUser">
							<i class='icon-plus'></i>添加</button>
					</div>
					<!-- 列表 -->
					<div class="row">
						<div class="col-xs-12">
							<div class="col-xs-12">
								<table id="userTable"></table>
								<div id="userPager"></div>
							</div>
						</div>
					</div>
					
				    <!-- 添加人员 -->
					<div class="modal fade" id="userModal" tabindex="-1" role="dialog" aria-labelledby="eidtModalLabel" aria-hidden="true">
				        <div class="modal-dialog">
				            <div class="modal-content">
				                <div class="modal-header">
				                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				                    <h4 class="modal-title" id="modal-title">添加人员</h4>
				                </div>
				                <div class="modal-body">
				                    <div class="row">
				                        <div class="col-xs-12">
				                            <!-- PAGE CONTENT BEGINS -->
				                            <form class="form-horizontal" role="form" id="userForm">
				                            	<div class="form-group">
													<input type="hidden" id="id" name="id" names="user.id"/><!-- 人员信息主键 -->
													<input type="hidden" id="createUserId" name="createUserId" names="user.createUserId"/><!-- 创建人 -->
													<input type="hidden" id="availableDate" name="availableDate" names="user.availableDate"/><!-- 创建时间 -->									
												</div>
												<div class="form-group">
													<label class="col-sm-3 control-label no-padding-right" for="code">用户编码 </label>
													<div class="col-sm-9">
														<input type="text" id="code" name="code" notnull="true" vdisp="用户编码" names="user.code"
															class="col-xs-10 input-large" />
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-3 control-label no-padding-right" for="pwd">密码 </label>
													<div class="col-sm-9">
														<input type="password" id="pwd" name="pwd" notnull="true" vdisp="密码" names="user.pwd"
															class="col-xs-10 input-large"/>
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-3 control-label no-padding-right" for="name">用户姓名 </label>
													<div class="col-sm-9">
														<input type="text" id="name" name="name" notnull="true" vdisp="用户姓名" names="user.name"
															class="col-xs-10 input-large" />
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-3 control-label no-padding-right" for="sortNumber">序号 </label>
													<div class="col-sm-9">
														<input type="text" id="sortNumber" name="sortNumber" notnull="true" vdisp="序号" names="user.sortNumber"
															vtype="integer" class="col-xs-10 input-large" value="1"/>
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-3 control-label no-padding-right" for="memo">备注 </label>
													<div class="col-sm-9">
														<input type="text" id="memo" name="memo" class="col-xs-10 input-large" names="user.memo" />
													</div>
												</div>
				                            </form>
				                        </div><!-- /.col -->
				                    </div>
				                </div>
				                <div class="modal-footer">
				                    <button type="button" class="btn btn-primary" id="saveOrUpdateBtn">保存</button>
				                    <button type="button" class="btn btn-default" id="userClose" data-dismiss="modal">关闭</button>
				                </div>
				            </div><!-- /.modal-content -->
				        </div><!-- /.modal-dialog -->
				    </div><!-- /.modal --> 
				    <!-- 添加角色 -->
					<div class="modal fade" id="roleListModal" tabindex="-1" role="dialog" aria-labelledby="eidtModalLabel" aria-hidden="true" style="z-index:1060 !important">
						<div class="modal-dialog" style="width:780px;">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
									<h4 class="modal-title" id="role_modal-title">选择角色</h4>
									<input id= "userRoleId" hidden = "true"/>
								</div>
					 			<div class="modal-body" >
										<div style="width:44%;float:left;border:1px solid #ccc;">
											<table id="roleList-table"></table>
											<div id="role-pager"></div>
										</div>
										<div style="text-align:center; float:left;padding-top:150px">
											<div style= "padding-top:10px">
												<button class="btn btn-info" onclick="addRole()">>></button>
											</div>
											<br>
											<div style= "padding-top:10px">
												<button class="btn btn-info" onclick="deletRole()"><<</button>
											</div>
										</div>
									
										<div style=" width:48%;float:left;border:1px solid #ccc;">
											<table id="role-checked-table"></table>
											<div id="role-checked-pager"></div>
										</div>
					 			</div>
						 	 	<div class="modal-footer" style="padding-top:450px;text-align:center; width:100%;" >
				                    <button class="btn btn-info" onclick="saveRole()">确定</button>
									<button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
				          		</div>
						 	</div>
						</div>
					</div>	
					<!-- 选择岗位模态框 -->
					<div class="modal fade" id="positionListModal" tabindex="-1" role="dialog" aria-labelledby="eidtModalLabel" aria-hidden="true" style="z-index:1060 !important">
						<div class="modal-dialog" style="width:780px;">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
									<h4 class="modal-title" id="sel_modal-title">选择岗位</h4>
									<input id= "userId" hidden = "true"/>
								</div>
					 			<div class="modal-body" >
										<div style="width:44%;float:left;border:1px solid #ccc;">
											<table id="positionList-table"></table>
											<div id="position-pager"></div>
										</div>
										<div style="text-align:center; float:left;padding-top:150px">
											<div style= "padding-top:10px">
												<button class="btn btn-info" onclick="add()">>></button>
											</div>
											<br>
											<div style= "padding-top:10px">
												<button class="btn btn-info" onclick="delet()"><<</button>
											</div>
										</div>
									
										<div style=" width:48%;float:left;border:1px solid #ccc;">
											<table id="checked-table"></table>
											<div id="checked-pager"></div>
										</div>
					 			</div>
						 	 	<div class="modal-footer" style="padding-top:450px;text-align:center; width:100%;" >
				                    <button class="btn btn-info" onclick="saveValue()">确定</button>
									<button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
				          		</div>
						 	</div>
						</div>
					</div>
				
				</div><!-- /.page-content -->
			</div><!-- /.main-content -->
  		</div>
	<script type="text/javascript">
	var userId="";
	jQuery(function($) {
		$("#positionGid_chosen").css('width','200px');
		//首次加载用户列表,在userdepartment表中获取人员和部门信息
		var grid_selector = "#userTable";
		var pager_selector = "#userPager";
		var url = basePath+ "/user/listByPage";
		$(grid_selector).jqGrid({
			url : url,
			datatype: "json",
			height: listHeight,
			colNames:['gid','岗位id','角色id','序号','用户姓名', '用户编码','角色','岗位','备注', '操作'],
			colModel:[
			    {name:'id',index:'id',hidden:true},
			    {name:'positionId',index:'positionId',hidden:true},
			    {name:'roleId',index:'roleId',hidden:true},
			    {name:'sortNumber',index:'sortNumber', width:45,align:"center"},
				{name:'name',index:'name', width:70,align:"center"},
				{name:'code',index:'code', width:70,align:"center"},
				{name:'roleName',index:'roleName', width:70,align:"center"},
				{name:'positionName',index:'positionName', width:70,align:"center"},
				{name:'memo',index:'memo', width:70},
				{name:'oper',index:'query', width:140,  formatter: function (value, rowIndex,rowData ) {
					var strHtml = "";
               		var id = rowData.id;
               		var positionId = rowData.positionId;
               		var positionName = rowData.positionName;
               		var roleId = rowData.roleId;
               		var roleName = rowData.roleName;
               		if(isManager=="false"){
               			strHtml += "<div class='sidebar-shortcuts-large' style='text-align:center'>";
                        strHtml += "<button class='btn btn-info' data-toggle='modal' title='查看' userId='"+id+"' onclick='clickUser(this,\"view\")'><i class='icon-zoom-in'></i></button>&nbsp;";
                        strHtml += "<button class='btn' disabled='disabled' title='编辑'><i class='icon-pencil'></i></button>&nbsp;";
                        strHtml += "<button class='btn' disabled='disabled' title='岗位'><i class='icon-position'></i></button>&nbsp;";
                        strHtml += "<button class='btn' disabled='disabled' title='角色'><i class='icon-cogs'></i></button>&nbsp;";
                        strHtml += "<button class='btn' disabled='disabled' title='删除'><i class='icon-trash'></i></button>";
                        strHtml += "</div>";
               		}else{
               			strHtml += "<div class='sidebar-shortcuts-large' style='text-align:center'>";
                        strHtml += "<button class='btn btn-info' data-toggle='modal' title='查看' userId='"+id+"' onclick='clickUser(this,\"view\")'><i class='icon-zoom-in'></i></button>&nbsp;";
                        strHtml += "<button class='btn btn-success' data-toggle='modal' title='编辑' userId='"+id+"' onclick='clickUser(this,\"edit\")'><i class='icon-pencil'></i></button>&nbsp;";
                        strHtml += "<button class='btn btn-warning' data-toggle='modal' title='设置岗位' positionId='"+positionId+"' positionName='"+positionName+"' userId='"+id+"' onclick='modifyPosition(this,\"modify\")'><i class='icon-plus'></i></button>&nbsp;";
                        strHtml += "<button class='btn btn-warning' data-toggle='modal' title='设置角色' roleId='"+roleId+"' roleName='"+roleName+"' userId='"+id+"' onclick='modifyRole(this,\"modify\")'><i class='icon-cogs'></i></button>&nbsp;";
                        strHtml += "<button class='btn btn-danger' data-toggle='modal' title='删除' userId='"+id+"' onclick='deleteUsers(\""+rowData.id+"\")' ><i class='icon-trash'></i></button>";
                        strHtml += "</div>";
               		}
                    return strHtml;
				}},
			], 
			viewrecords : true,
			rowNum:10,
			rowList:[10,20,30],
			pager : pager_selector,
			altRows: true,
			multiselect: true,
	        multiboxonly: true,
	        sortable:true,
	        sortorder:"asc",
	        sortname:"name",
	        loadComplete : function(data) {
				setTimeout(function(){
					updatePagerIcons(this);
					enableTooltips(this);
				}, 0);
			},
			autowidth: true
		});
		
		//搜索
		$("#userSearch").click(function(){
			var name=$("#userName").val();
			var pym=$("#userCode").val();
			var url=encodeURI(encodeURI(basePath+"/user/listByPage.do?name="+name+"&code="+pym));
			$(grid_selector).jqGrid('setGridParam',{page:1,url:url}).trigger("reloadGrid"); 
		});
		//新增人员按钮,把人员信息和部门信息带入到人员部门表
		$("#addUser").click(function(){
			$("#userForm input").removeAttr("disabled","true");
			$("#userForm select").removeAttr("disabled","true");
			$("#userForm textarea").removeAttr("disabled","true"); 
			$("#userForm")[0].reset();
			$("#modal-title").html('添加用户');
   			$("#saveOrUpdateBtn").show();
   			$("#userModal").modal('show');	
		});
		//保存人员信息
		$("#saveOrUpdateBtn").click(function(){
			if(doValidate(userForm)){
				$("#userModal").modal('hide');
				var positionId = $("#positionGid").val();
				stepAjax("POST", basePath+"/user/save?positionId="+positionId, $('#userForm').serialize());
			}
		});
		//人员角色保存
		$("#saveUserRole").click(function(){
			//角色ID
			var roleId="";
			var roleIds = $("#role-table").jqGrid('getGridParam','selarrrow');
			for(var i=0;i<roleIds.length;i++){
				roleId+=$("#role-table").jqGrid("getRowData",roleIds[i]).id+"@";
			}
 			var url=basePath+"/userrole/saveUserRole.do?userId="+userId+"&roleId="+roleId;
 			stepAjax("POST", url, "");
		});
	});
	//根据ID获取人员信息
	function clickUser(user,style) {
		if(style=="edit"){
			$("#modal-title").html('修改用户');
			$("#saveOrUpdateBtn").show();
			$("#userModal").modal('show');
			$("#positionName").removeAttr("disabled","true");
			$("#userForm select").removeAttr("disabled","true");
			$("#userForm textarea").removeAttr("disabled","true");
		}else{
			$("#modal-title").html("查看用户");
			$("#saveOrUpdateBtn").hide();
			$("#userClose").hide();
			$("#userModal").modal('show');
			$("#userForm input").attr("disabled","true");
			$("#userForm select").attr("disabled","true");
			$("#userForm textarea").attr("disabled","true");
		}
		var userId = user.getAttribute("userId");
		getUserInfoByUserId(userId);
	}
	//根据人员ID获取人员部门信息、部门信息、角色信息、人员信息
	function getUserInfoByUserId(userId){
		if(userId!=null){
			//根据ID查看详情
			$.ajax({
		        type: "post",   
		        url: basePath+"/user/queryUserInfoByUserId",  
		        dataType:"json",
		        data:{userId:userId},
		        async:false,
		        success: function (result) {
		        	result = eval(result);
		        	if (result != null) {
		        		$("#userForm input").each(function () {
		        			var thisValue=eval("result."+$(this).attr("names"));
		        			$(this).val(thisValue);
	    	            });
		        		 $("#userForm select").each(function (i) {
	    	                var thisValue=eval("result."+$(this).attr("names"));
		        			$(this).val(thisValue);
	    	            }); 
// 		        		$("#userForm textarea").each(function (i) {
// 		    	    		var thisValue=eval("result."+$(this).attr("names"));
// 			        		$(this).val(thisValue);
// 		    	        });
		        		$("#availableDate").val(formatterdate(result.user.availableDate));
		        		$("#positionGid").val(result.user.positionId);
					}else{
			        	alert("获取人员信息失败");
					}
		        }
		    });
		}else{
			alert("获取人员信息失败！");
		}
	}
	//删除单个用户
	function deleteUsers(userId) {
		var r=confirm("你确认删除?");
		if (r==true){
			$.ajax({
				url:basePath+"/user/delete/"+userId,
				type: "delete",
	    		error: function(result) {
			 		alert("发送请求失败！");
			 	},
	        	success: function (result) { 
	        		alert("操作成功");
	    		window.location.reload();
				}
			});
		}
	}
	//删除多个用户
	function delectUserList(){
	    var ids=$("#userTable").jqGrid('getGridParam','selarrrow');
	    if(ids.length<1){
	        alert("请选择要删除的项!");
	        return false;
	    }
	    if(confirm("你确认删除?")){
	        var deleteStatus="删除成功";
	        for(var i=0;i<ids.length;i++){
					var id = $("#userTable").jqGrid('getRowData',ids[i]).id;
					$.ajax({
	    				url: basePath+"/user/delete/"+id,
	    				type: "post",
	    				data: "null",
	    		        success: function (result) { 
	    		        	var rev=JSON.parse(result);
	    		        	if(rev.status_code=="0"){
	    		        		deleteStatus="删除失败";
	    		        	}
	    				}
	    			});
				}
				alert(deleteStatus);
				window.location.reload();
			}
	    }
	function stepAjax(type, url,data) {
	    $.ajax({
	        type: type,   
	        url: url,  
	        data: data,
	    	error: function(result) {
			 	alert("发送请求失败！");
			 	},
	        success: function (result) { 
	        	alert("操作成功");
	    		window.location.reload();
				}
			});
		}
	//根据ID获取人员信息
	function modifyRole(role,style) {
		var userId = role.getAttribute("userId");
		var roleId = role.getAttribute("roleId");
		var roleName = role.getAttribute("roleName");
		var roleIds = roleId.split(",");
		var roleNames = roleName.split(",");
		$("#userRoleId").val(userId);
		var json = "[";
		//过滤条件
		var params ="(";
		if(roleId.indexOf(",")>0){
			for(var i=0;i<roleIds.length-1;i++){
				params += "'"+roleIds[i]+"',";
				json += "{'roleId':'"+roleIds[i]+"','roleName':'"+roleNames[i]+"'},";
			}
		}
		json+="]";
		var dataJson = eval("("+json+")");
		//已经存在的	
		dataJson = eval("("+json+")");
		var num = params.indexOf(",");
		if(num>0){
			params = params.substring(0, params.length-1);
		}
		params+=")";
		listHeight="331";
		//用户列表
		var grid_selector = "#roleList-table";
		var pager_selector = "#role-pager";
		var url = "${pageContext.request.contextPath}"+ "/role/list?params="+params;
		$(grid_selector).jqGrid('GridUnload');//重新加载
		$(grid_selector).jqGrid({
			url : url,
			datatype: "json",
			height: listHeight,
			colNames:['id','角色名称','排序','备注'],
			colModel:[
			    {name:'id',index:'id',hidden:true},
				{name:'name',index:'name', width:150},
				{name:'sortNumber',index:'sortNumber',hidden:true},
				{name:'memo',index:'memo', width:150},
			], 
			viewrecords : false,
			rowNum:10,
			rowList:[10,20,30],
			pager : pager_selector,
			altRows: true,
			multiselect: true,
	        multiboxonly: true,
	        sortable:true,
	        sortorder:"asc",
	        sortname:"sortNumber",
	        loadComplete : function(data) {
	        	tableData=data;
				var table = this;
				setTimeout(function(){
					updatePagerIcons(table);
					enableTooltips(table);
				}, 0);
			},
			caption:"岗位列表",
			autowidth: true
		});
		$("#role-checked-table").jqGrid('GridUnload');//重新加载
		$("#role-checked-table").jqGrid({
			datatype: "local",
			data:dataJson,
			height: listHeight,
			colNames:['roleId','角色名称'],
			colModel:[
			    {name:'roleId',index:'roleId',key: true,hidden:true},
				{name:'roleName',index:'roleName', width:290}
			], 
			viewrecords : false,
			rowNum:10,
			rowList:[10,20,30],
			pager : "#role-checked-pager",
			altRows: true,
			multiselect: true,
	        multiboxonly: true,
	        sortable:true,
	        sortorder:"asc",
	        sortname:"sortNumber",
	        rownumbers:true,//添加左侧行号
	        autowidth:true,
	        loadComplete : function(data) {
	        	tableData=data;
				var table = this;
				setTimeout(function(){
					updatePagerIcons(table);
					enableTooltips(table);
				}, 0);
			},
			caption: "已选择角色",
			autowidth: true
		});
		
		$("#roleListModal").modal('show');
	}
	
	//增加
	function addRole(){
		var ids=$("#roleList-table").jqGrid('getGridParam','selarrrow');
		if(ids.length>0){
		//获得新添加行的行号（数据编号）  
			for(var i=0;i<ids.length;i++){
				var data =	$("#roleList-table").jqGrid('getRowData',ids[i]);
				var roleId = data.id;
				var roleName = data.name;
				var jsonData ={roleId:roleId,roleName:roleName};
				$("#role-checked-table").addRowData(roleId,jsonData, "first");
			}
			var gids = "(";
			var allData=$("#role-checked-table").jqGrid('getRowData');
			
		 	jQuery(allData).each(function(){
        		gids += "'"+this.roleId+"',";
    		});
			var num = gids.indexOf(",");
			if(num>0){
				gids = gids.substring(0,gids.length-1);
			}
			gids+=")";
			var params = gids;
			var url=encodeURI(encodeURI("${pageContext.request.contextPath}"+"/role/list?params="+params));
			$("#roleList-table").jqGrid('setGridParam',{page:1,url:url}).trigger("reloadGrid"); 
		}
	}
	//删除
	function deletRole(){
		var ids=$("#role-checked-table").jqGrid('getGridParam','selarrrow');
		if(ids.length>0){
		var len = ids.length;
			for(var i=0;i<len;i++){
				$("#role-checked-table").jqGrid("delRowData", ids[0]);
			}
			var gids = "(";
			var allData=$("#role-checked-table").jqGrid('getRowData');
			
		 	jQuery(allData).each(function(){
        		gids += "'"+this.roleId+"',";
    		});
			var num = gids.indexOf(",");
			if(num>0){
				gids = gids.substring(0,gids.length-1);
			}
			gids+=")";
			params = gids;
			$("#roleList-table").jqGrid('setGridParam',{url:"${pageContext.request.contextPath}"+ "/role/list?params="+params}).trigger("reloadGrid");
		}
	}
	//保存
	function saveRole(){
		var gids = "";
		var names ="";
		var allData=$("#role-checked-table").jqGrid('getRowData');
		var userId = $("#userRoleId").val();
	 	jQuery(allData).each(function(){
       		gids += this.roleId+",";
       		names += this.roleName+",";
   		});
		var num = gids.indexOf(",");
		if(num>0){
			gids = gids.substring(0,gids.length-1);
			names =names.substring(0,names.length-1);
		}
		$("#roleListModal").modal('hide');
		stepAjax("POST", basePath+"/userrole/saveUserRole?userId="+userId+"&roleIds="+gids);
	}
	
	function modifyPosition(position,type){
		var userId = position.getAttribute("userId");
		var positionId = position.getAttribute("positionId");
		var positionName = position.getAttribute("positionName");
		var positionIds = positionId.split(",");
		var positionNames = positionName.split(",");
		$("#userId").val(userId);
		var json = "[";
		//过滤条件
		var params ="(";
		if(positionId.indexOf(",")>0){
			for(var i=0;i<positionIds.length-1;i++){
				params += "'"+positionIds[i]+"',";
				json += "{'positionId':'"+positionIds[i]+"','positionName':'"+positionNames[i]+"'},";
			}
		}
		json+="]";
		var dataJson = eval("("+json+")");
		//已经存在的	
		dataJson = eval("("+json+")");
		var num = params.indexOf(",");
		if(num>0){
			params = params.substring(0, params.length-1);
		}
		params+=")";
		listHeight="331";
		//用户列表
		var grid_selector = "#positionList-table";
		var pager_selector = "#position-pager";
		var url = "${pageContext.request.contextPath}"+ "/position/listByPage?params="+params;
		$(grid_selector).jqGrid('GridUnload');//重新加载
		$(grid_selector).jqGrid({
			url : url,
			datatype: "json",
			height: listHeight,
			colNames:['id','岗位名称','排序','备注'],
			colModel:[
			    {name:'id',index:'id',hidden:true},
				{name:'name',index:'name', width:150},
				{name:'sortNumber',index:'sortNumber',hidden:true},
				{name:'memo',index:'memo', width:150},
			], 
			viewrecords : false,
			rowNum:10,
			rowList:[10,20,30],
			pager : pager_selector,
			altRows: true,
			multiselect: true,
	        multiboxonly: true,
	        sortable:true,
	        sortorder:"asc",
	        sortname:"sortNumber",
	        loadComplete : function(data) {
	        	tableData=data;
				var table = this;
				setTimeout(function(){
					updatePagerIcons(table);
					enableTooltips(table);
				}, 0);
			},
			caption:"岗位列表",
			autowidth: true
		});
		$("#checked-table").jqGrid('GridUnload');//重新加载
		$("#checked-table").jqGrid({
			datatype: "local",
			data:dataJson,
			height: listHeight,
			colNames:['positionId','岗位名称'],
			colModel:[
			    {name:'positionId',index:'positionId',key: true,hidden:true},
				{name:'positionName',index:'positionName', width:290}
			], 
			viewrecords : false,
			rowNum:10,
			rowList:[10,20,30],
			pager : "#checked-pager",
			altRows: true,
			multiselect: true,
	        multiboxonly: true,
	        sortable:true,
	        sortorder:"asc",
	        sortname:"sortNumber",
	        rownumbers:true,//添加左侧行号
	        autowidth:true,
	        loadComplete : function(data) {
	        	tableData=data;
				var table = this;
				setTimeout(function(){
					updatePagerIcons(table);
					enableTooltips(table);
				}, 0);
			},
			caption: "已选择岗位",
			autowidth: true
		});
		
		$("#positionListModal").modal('show');
 	}
 	//增加
	function add(){
		var ids=$("#positionList-table").jqGrid('getGridParam','selarrrow');
		if(ids.length>0){
		//获得新添加行的行号（数据编号）  
			for(var i=0;i<ids.length;i++){
				var data =	$("#positionList-table").jqGrid('getRowData',ids[i]);
				var positionId = data.id;
				var positionName = data.name;
				var jsonData ={positionId:positionId,positionName:positionName};
				$("#checked-table").addRowData(positionId,jsonData, "first");
			}
			var gids = "(";
			var allData=$("#checked-table").jqGrid('getRowData');
			
		 	jQuery(allData).each(function(){
        		gids += "'"+this.positionId+"',";
    		});
			var num = gids.indexOf(",");
			if(num>0){
				gids = gids.substring(0,gids.length-1);
			}
			gids+=")";
			var params = gids;
			var url=encodeURI(encodeURI("${pageContext.request.contextPath}"+"/position/listByPage?params="+params));
			$("#positionList-table").jqGrid('setGridParam',{page:1,url:url}).trigger("reloadGrid"); 
		}
	}
	//删除
	function delet(){
		var ids=$("#checked-table").jqGrid('getGridParam','selarrrow');
		if(ids.length>0){
		var len = ids.length;
			for(var i=0;i<len;i++){
				$("#checked-table").jqGrid("delRowData", ids[0]);
			}
			var gids = "(";
			var allData=$("#checked-table").jqGrid('getRowData');
			
		 	jQuery(allData).each(function(){
        		gids += "'"+this.positionId+"',";
    		});
    		
			var num = gids.indexOf(",");
			
			if(num>0){
				gids = gids.substring(0,gids.length-1);
			}
			gids+=")";
			params = gids;
			$("#positionList-table").jqGrid('setGridParam',{url:"${pageContext.request.contextPath}"+ "/position/listByPage?params="+params}).trigger("reloadGrid");
		}
	}
	//保存
	function saveValue(){
		var gids = "";
		var names ="";
		var allData=$("#checked-table").jqGrid('getRowData');
		var userId = $("#userId").val();
	 	jQuery(allData).each(function(){
       		gids += this.positionId+",";
       		names += this.positionName+",";
   		});
		var num = gids.indexOf(",");
		if(num>0){
			gids = gids.substring(0,gids.length-1);
			names =names.substring(0,names.length-1);
		}
		$("#positionListModal").modal('hide');
		stepAjax("POST", basePath+"/userPosition/save?userId="+userId+"&positionIds="+gids);
	}
	</script>
</body>
</html>
