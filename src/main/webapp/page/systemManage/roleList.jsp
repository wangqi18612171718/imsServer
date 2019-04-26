<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<body>
	<%@include file="../../globals.jsp" %>
	<!-- 主体 -->
	<div class="main-container" id="main-container">
		<div class="main-container-inner">
			<div class="breadcrumbs" id="breadcrumbs">
				<ul class="breadcrumb" style="line-height:40px;">
					<li><i class="icon-home home-icon"></i>首页</li><li>系统管理</li><li>角色信息</li>
				</ul><!-- .breadcrumb -->
			</div>
				
			<div class="page-content">
				<div class="pull-left input-group" style="width:100%">
				<!-- 查询条件 -->
					<label class="inline"> 
						<span class="pull-left">角色名称</span>
					</label>
					<input type="text" class="searchBtn" id="rolename" style="width:18% !important"/>
					<!-- <label class="inline"> 
						<span class="pull-left">拼音码</span>
					</label>
					<input type="text" class="searchBtn" id="rolepym" style="width:18% !important"/> -->
					<button type="button" class="btn btn-info" id="roleSearch" style="line-height:20px">
						<i class="icon-search bigger-110"></i>搜索
					</button>
					<button class='btn btn-info pull-right ismanager' style='margin-top:7px;'data-toggle='modal'  onclick="delectRoleList()" >
						<i class='icon-trash'></i>删除</button>
					<button class='btn btn-info pull-right ismanager' style='margin-top:7px;'data-toggle='modal'  onclick="setForm('','add')">
						<i class='icon-plus'></i>添加</button>
				</div>
				<!-- 列表 -->
				<div class="row">
					<div class="col-xs-12">
						<table id="role-table" class="autowith"></table>
						<div id="role-pager"></div>
					</div>
				</div>
				
				<!-- 角色新增模态框 -->
				<div class="modal" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			        <div class="modal-dialog">
			            <div class="modal-content">
			                <div class="modal-header">
			                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			                    <h4 class="modal-title" id="modal-title">添加角色</h4>
			                </div>
			                <div class="modal-body">
			                    <div class="row">
			                        <div class="col-xs-12">
			                            <!-- PAGE CONTENT BEGINS -->
			                            <form id="roleForm" class="form-horizontal" role="form">
			                                <div class="form-group">
			                                    <label class="col-sm-3 control-label no-padding-right" for="name"> 角色名称 </label>
			                                    <div class="col-sm-9">
			                                    	<input type="hidden" id="id" name="id" />
			                                    	<input type="hidden" id="isDelete" name="isDelete" value='0' />
			                                        <input type="text" id="name" name="name" placeholder="输入角色名称" class="col-xs-10" />
			                                    </div>
			                                </div>
			                               <!--  <div class="space-4"></div>
			                                <div class="form-group">
			                                    <label class="col-sm-3 control-label no-padding-right" for="pym"> 拼音码 </label>
			                                    <div class="col-sm-9">
			                                        <input type="text" id="pym" name="pym" placeholder="拼音码" class="col-xs-10" />
			                                    </div>
			                                </div> -->
			
			                                <div class="space-4"></div>
			                                <div class="form-group">
			                                    <label class="col-sm-3 control-label no-padding-right" for="sort"> 序号 </label>
			                                    <div class="col-sm-9">
			                                        <input type="text" id="sort" name="sortNumber" class="col-xs-10" />
			                                    </div>
			                                </div>
			
			                                <div class="space-4"></div>
			                                <div class="form-group">
			                                    <label class="col-sm-3 control-label no-padding-right" for="remark"> 备注 </label>
			                                    <div class="col-sm-9">
			                                        <input type="text" id="remark" name="memo" class="col-xs-10" />
			                                    </div>
			                                </div>
			                            </form>
			                        </div><!-- /.col -->
			                    </div>
			                </div>
			                <div class="modal-footer">
			                    <button type="button" class="btn btn-primary ismanager" id="roleSave">保存</button>
		                    	<button type="button" class="btn btn-default ismanager" data-dismiss="modal">关闭</button>
			                </div>
			            </div><!-- /.modal-content -->
			        </div><!-- /.modal-dialog -->
			    </div><!-- /.modal --> 
				<!-- 设置权限 模态框-->
				<div class="modal" id="privModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			        <div class="modal-dialog">
			            <div class="modal-content">
			                <div class="modal-header">
			                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			                    <h4 class="modal-title" id="modal-title">设置权限</h4>
			                </div>
			                <div class="modal-body">
			                    <div class="row">
									<div class="col-xs-12">
										<div id="PrivilegeTree" class="ztree" style='display:block;z-index:100'></div>
									</div>
								</div>
			                </div>
			                <div class="modal-footer">
			                    <button type="button" class="btn btn-primary ismanager" id="btnSavePrimary">保存</button>
		                    	<button type="button" class="btn btn-default ismanager" data-dismiss="modal">关闭</button>
			                </div>
			            </div><!-- /.modal-content -->
			        </div><!-- /.modal-dialog -->
			    </div><!-- /.modal --> 
			</div><!-- /.page-content -->
		</div><!-- /.main-content-inner -->
	</div><!-- /.main-container -->
	
	<script type="text/javascript">
		jQuery(function($) {
			var grid_selector = "#role-table";
			var pager_selector = "#role-pager";
			//角色列表
			var url = basePath+"/role/list.do";
			$(grid_selector).jqGrid({
				url : url,
				datatype: "json",
				height: listHeight,
				colNames:['ID','序号','角色名称','备注', '操作'],
				colModel:[
					{name:'id',index:'id', width:60, sorttype:"int",hidden : true},
					{name:'sortNumber',index:'sortNumber', width:35,align:"center"},
					{name:'name',index:'name', width:100},
					{name:'memo',index:'memo', width:250, sortable:false},
					{name:'oper',index:'oper', width:140,  formatter: function (value, rowIndex, rowData) {
	                    var strHtml = "";
	                    var id = rowData.id;
	                    if(isManager=="true"){
	                    	strHtml += "<div class='sidebar-shortcuts-large' style='text-align:center'>";
	                    	strHtml += "<button class='btn btn-info' title='查看' data-toggle='modal' onclick='setForm(\"" + id + "\",\"view\");'><i class='icon-zoom-in'></i></button>&nbsp;";
		                    strHtml += "<button class='btn btn-warning' title='设置菜单' data-toggle='modal' onclick='setPriv(\"" + id + "\");'><i class='icon-cog'></i></button>&nbsp;";
		                    strHtml += "<button class='btn btn-success'title = '修改' data-toggle='modal' onclick='setForm(\"" + id + "\",\"update\");'><i class='icon-pencil'></i></button>&nbsp;";
		                    strHtml += "<button class='btn btn-danger'title = '删除' data-toggle='modal' onclick='deleteRole(\"" + id + "\");'><i class='icon-trash'></i></button>";
		                    strHtml += "</div>";
	                    }else{
	                    	strHtml += "<div class='sidebar-shortcuts-large' style='text-align:center'>";
	                    	strHtml += "<button class='btn btn-info' title='查看' data-toggle='modal' onclick='setForm(\"" + id + "\",\"view\");'><i class='icon-zoom-in'></i></button>&nbsp;";
	                    	strHtml += "<button class='btn' title = '设置权限' disabled='disabled'><i class='icon-cog'></i></button>&nbsp;";
		                    strHtml += "<button class='btn' title = '修改' disabled='disabled'><i class='icon-pencil'></i></button>&nbsp;";
		                    strHtml += "<button class='btn' title = '删除' disabled='disabled'><i class='icon-trash'></i></button>";
		                    strHtml += "</div>";
	                    }
	                    return strHtml;
					}},
				], 
				rowNum:10,//显示几行
				rowList:[5,10,15],
				pager : pager_selector,
				altRows: true,
				multiselect: true,
		        multiboxonly: true,
		        sortable:true,
		        sortorder:"desc",
		        sortname:"sortNumber",
		        viewrecords : true,
		        loadComplete : function(data) {
					var table = this;
					setTimeout(function(){
						updatePagerIcons(table);
						enableTooltips(table);
					}, 0);
				},
				autowidth: true
			});
			
			//搜索
			$("#roleSearch").click(function(){
				var name=$("#rolename").val();
				var url=encodeURI(encodeURI(basePath+"/role/list.do?name="+name));
				$(grid_selector).jqGrid('setGridParam',{page:1,url:url}).trigger("reloadGrid"); 
			});
			
			//保存角色信息
			$("#roleSave").click(function(){
				execAjax("POST", basePath+"/role/saveOrUpdate", $('#roleForm').serialize());
			});
			
			//保存角色权限btnSavePrimary
			$("#btnSavePrimary").click(function(){
				//角色ID
				var id=$("#id").val();
				//权限ID
				var permissionId="";
				var treeObj = $.fn.zTree.getZTreeObj("PrivilegeTree");
				var nodes = treeObj.getCheckedNodes(true);
				for(var i=0;i<nodes.length;i++){
					permissionId+=nodes[i].id+"@";
				}
 				var url=basePath+"/rolePermission/saveRolePermission/"+id+"/"+permissionId;
 				execAjax("POST", url, "");
			});
			
			//权限树加载
			loadPrivilege();
			
			$("#privModal").on('hidden.bs.modal', function () {
				var treeObj = $.fn.zTree.getZTreeObj("PrivilegeTree");
				treeObj.refresh();
				loadPrivilege();
			});
    		
		});
		//权限树加载
		function loadPrivilege(){
			var treeDataurl=basePath+"/permission/getTreeData";
			$.ajax({
				url: treeDataurl,
				type: "POST",
				data: "",
				success: function(resObj) {
					eval(resObj);
					var PrivilegeTreesetting={
						check: {  
			                enable: true,  
			                nocheckInherit: false,  
			                chkboxType: { "Y": "p", "N": "p" }
				        }, 
						data: {
							simpleData: {
								enable: true
							}
						}
					}
					$.fn.zTree.init($("#PrivilegeTree"), PrivilegeTreesetting, zNodes);
				}
			});
		}
		
		
		
		function setForm(gid,flag){
			if(flag=="add"){//新增角色
				$("#modal-title").html('添加角色');
				$("#roleForm")[0].reset();
				$("#roleSave").show();
			}else {//修改角色
				getRoleInfoById(gid);
				if(flag=="update"){
					$("#modal-title").html('修改角色');
					$("#roleSave").show();
				}else{
					$("#modal-title").html('查看角色');
					$("#roleSave").hide();
				}
			}
			$("#addModal").modal('show');
		}
		
		//根据人员ID获取人员部门信息、部门信息、角色信息、人员信息
		function getRoleInfoById(roleId){
			if(roleId!=null){
				//根据ID查看详情
				$.ajax({
			        type: "post",   
			        url: basePath+"/role/queryRoleInfoByRoleId.do",  
			        dataType:"json",
			        data:{roleId:roleId},
			        async:false,
			        success: function (result) {
			        	result = eval(result);
			        	if (result != null) {
			        		$("#roleForm input").each(function () {
			        			var thisValue=eval("result.role."+$(this).attr("name"));
			        			$(this).val(thisValue);
		    	            });
			        		 $("#roleForm select").each(function (i) {
		    	                var thisValue=eval("result.role."+$(this).attr("name"));
			        			$(this).val(thisValue);
		    	            }); 
			        		$("#roleForm textarea").each(function (i) {
			    	    		var thisValue=eval("result.role."+$(this).attr("name"));
				        		$(this).val(thisValue);
			    	        });
						}else{
				        	alert("获取角色信息失败");
						}
			        }
			    });
			}else{
				alert("获取角色信息失败！");
			}
		}
		
		//删除角色
		function deleteRole(id) {
			var r=confirm("你确认删除?");
			if (r==true)
			{
				execAjax("POST", basePath+"/role/delete/"+id, "null");
			}
		}
		//批量删除
		function delectRoleList(){
		    var ids=$("#role-table").jqGrid('getGridParam','selarrrow');
		    if(ids.length<1){
		        alert("请选择要删除的项!");
		        return false;
		    }
		    if(confirm("你确认删除?")){
		        var deleteStatus="删除成功";
	     		for(var i=0;i<ids.length;i++){
					var gid = $("#role-table").jqGrid('getRowData',ids[i]).id;
					$.ajax({
	    				url: basePath+"/role/delete/"+gid,
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
		
		//权限列表树
		function setPriv(id){
			$("#privilege-table").trigger("reloadGrid");
			$("#id").val(id);
			$("#privModal").modal('show');
			setSelected(id);
		}
		//权限设置选中状态
		function setSelected(id){
			
			var SetSelUrl=basePath+"/rolePermission/getSelectedStatus/"+id;
			$.ajax({
				url: SetSelUrl,
				type: "POST",
				data: "",
				success: function(resObj) {
					var treeObj = $.fn.zTree.getZTreeObj("PrivilegeTree");
					var ids="";
					for(var i=0;i<resObj.split('@').length-1;i++){
						var node = treeObj.getNodeByParam("id",resObj.split('@')[i],null);
						treeObj.checkNode(node,true,true); 
					}
				}
			});
		}
	</script>
  </body>
</html>
