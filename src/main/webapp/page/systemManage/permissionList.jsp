<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<body>
	<%@include file="../../globals.jsp" %>
	<!-- 主体 -->
	<div class="main-container" id="main-container">
		<!-- 导航栏 -->
		<div class="breadcrumbs" id="breadcrumbs">
			<ul class="breadcrumb middle" style="line-height:40px">
				<li><i class="icon-home home-icon"></i>首页</li><li>系统管理</li><li>菜单管理</li>
			</ul><!-- 导航栏结束  -->
		</div>
		<!-- 页面内容 -->
		<div class="page-content">
			<form class="form-inline">
				<div class=" input-group pull-right">
					<button class='btn btn-info ismanager'  data-toggle='modal' onclick="openDialog('','add')"><i class='icon-plus'></i>添加</button>
					<button class='btn btn-info ismanager'  data-toggle='modal' onclick="delectPrivilegeList()"  data-target='#deleteModal'><i class='icon-trash'></i>删除</button>
				</div>
				<!-- 数据列表 -->
				<div class="row col-xs-12" style="margin-left:6px;">
					<label class="col-xs-2" style="height:448px;border: 1px solid #e5e5e5;overflow:auto">
						<div id="PrivilegeTree" class="ztree" style='display:block;z-index:100'></div>
					</label>
					<div class="col-xs-10">
						<table id="privilege-table"></table>
						<div id="privilege-pager"></div>
					</div>
				</div>
			</form>
			<!-- 权限详细信息模态框 -->
			<div class="modal fade" id="addModal"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		        <div class="modal-dialog">
		            <div class="modal-content">
		                <div class="modal-header">
		                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		                    <h4 class="modal-title" id="modal-title">添加权限</h4>
		                </div>
		                <div class="modal-body">
		                    <div class="row">
		                        <div class="col-xs-12">
		                            <!-- 详细信息Form -->
		                            <form id="privilegeForm" class="form-horizontal" role="form" name="privilegeForm">
		                                <div class="form-group">
		                                    <label class="col-sm-3 control-label no-padding-right" for="parentGid_sel"> 上级权限 </label>
		                                    <div class="col-sm-9">
		                                        <input type="hidden" id="id" name="id" />
		                                        <input type="hidden" id="parentId" name="parentId" />
		                                        <div id="permissionNameTree" class="ztree MySelecttree input-large"></div>
												<input id="permissionName" type="text" class="input-large MySelecttreeinput " readonly="readonly"/>
		                                        <!-- <select class="form-control input-large" id="parentId" name="parentId" mapName='permission' notnull="true" vdisp="上级权限" ></select> -->
		                                    </div>
		                                </div>
		                                <div class="form-group">
		                                    <label class="col-sm-3 control-label no-padding-right" for="name"> 权限名称 </label>
		                                    <div class="col-sm-9">
		                                        <input type="text" id="name" name="name" class="col-xs-10" notnull="true" vdisp="权限名称" vtype="chinese"/>
		                                    </div>
		                                </div>
		                                <div class="form-group">
		                                    <label class="col-sm-3 control-label no-padding-right" for="pageUrl"> 页面名称 </label>
		                                    <div class="col-sm-9">
		                                        <input type="text" id="pageUrl" name="pageUrl" class="col-xs-10" />
		                                    </div>
		                                </div>
		                                <div class="form-group">
		                                    <label class="col-sm-3 control-label no-padding-right" for="sortNumber"> 序号 </label>
		                                    <div class="col-sm-9">
		                                        <input type="text" id="sortNumber" name="sortNumber" value="0" class="col-xs-10" notnull="true" vdisp="序号" vtype="number"/>
		                                    </div>
		                                </div>
		                                <div class="form-group">
		                                    <label class="col-sm-3 control-label no-padding-right" for="menuIcon"> 图标 </label>
		                                    <div class="col-sm-9">
		                                    	<select id="menuIcon" name="menuIcon" class="col-xs-10">
		                                    		<option></option>
		                                    		<option value="icon-leaf">叶子</option>
		                                    		<option value="icon-bar-chart">报表</option>
		                                    		<option value="icon-barcode">二维码</option>
		                                    		<option value="icon-bell">闹钟</option>
		                                    		<option value="icon-bookmark">书签</option>
		                                    		<option value="icon-calendar">日历</option>
		                                    		<option value="icon-camera">相机</option>
		                                    		<option value="icon-check">已选</option>
		                                    		<option value="icon-check-empty">未选</option>
		                                    		<option value="icon-circle">实心圆</option>
		                                    		<option value="icon-circle-blank">空心圆</option>
		                                    		<option value="icon-cloud-download">云下载</option>
		                                    		<option value="icon-cloud-upload">云上传</option>
		                                    		<option value="icon-cog">齿轮</option>
		                                    		<option value="icon-cogs">多个齿轮</option>
		                                    		<option value="icon-comments-alt">对话</option>
		                                    		<option value="icon-dashboard">仪表</option>
		                                    		<option value="icon-desktop">桌面</option>
		                                    		<option value="icon-edit">编辑</option>
		                                    		<option value="icon-home">首页</option>
		                                    	</select>
		                                    </div>
		                                </div>
		                                <div class="form-group">
		                                    <label class="col-sm-3 control-label no-padding-right" for="memo"> 备注 </label>
		                                    <div class="col-sm-9">
		                                        <input type="text" id="memo" name="memo" class="col-xs-10" />
		                                    </div>
		                                </div>
		                            </form>
		                        </div><!-- /.col -->
		                    </div>
		                </div>
		                <div class="modal-footer">
		                    <button type="button" class="btn btn-primary" id="btnSave">保存</button>
		                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		                </div>
		            </div><!-- /.modal-content -->
		        </div><!-- /.modal-dialog -->
		    </div><!-- /.modal --> 
		</div><!-- /.page-content -->
	</div><!-- /.main-content-inner -->
	<script type="text/javascript">
	jQuery(function($) {
		//加载菜单列表数据
		var grid_selector = "#privilege-table";
		var pager_selector = "#privilege-pager";
		var url = basePath+"/permission/list.do";
		$(grid_selector).jqGrid({
			url : url,
			datatype: "json",
			height: listHeight,
			colNames:['ID','权限名称', '页面名称', '图标','序号','备注', '操作'],
			colModel:[
				{name:'id',index:'id',hidden : true},
				{name:'name',index:'name', width:80,align:'center'},
				{name:'pageUrl',index:'pageUrl', width:280},
				{name:'menuIcon',index:'menuIcon', width:80,align:'center'},
				{name:'sortNumber',index:'sortNumber', width:80,align:'center'},
				{name:'memo',index:'memo', width:80, sortable:false},
				{name:'oper',index:'oper', width:130,formatter: function (value, rowIndex, rowData) {
                    var strHtml = "";
                    if(isManager=="true"){
                    	strHtml += "<div class='sidebar-shortcuts-large' style='text-align:center'>";
                        strHtml += "<button class='btn btn-info' title='查看' data-toggle='modal' "+
                        	"onclick='openDialog(\"" + rowData.id + "\",\"view\");'><i class='icon-zoom-in'></i></button>&nbsp;";
                        strHtml += "<button class='btn btn-success'  title = '修改' "+
                        	" data-toggle='modal' onclick='openDialog(\"" + rowData.id + "\",\"update\");'><i class='icon-pencil'></i></button>&nbsp;";
                        strHtml += "<button class='btn btn-danger ismanager' title= '删除' "
                        	+"data-toggle='modal' onclick='deletePriv(\"" + rowData.id + "\");'><i class='icon-trash'></i></button>";
                        strHtml += "</div>";
                    }else{
                    	strHtml += "<div class='sidebar-shortcuts-large' style='text-align:center'>";
                        strHtml += "<button class='btn btn-info' title='查看' data-toggle='modal' "+
                        	"onclick='openDialog(\"" + rowData.id + "\",\"view\");'><i class='icon-zoom-in'></i></button>&nbsp;";
                        strHtml += "<button class='btn' disabled='disabled' title = '修改' "+
                        	" data-toggle='modal' onclick='openDialog(\"" + rowData.id + "\",\"update\");'><i class='icon-pencil'></i></button>&nbsp;";
                        strHtml += "<button class='btn' disabled='disabled' title= '删除' "
                        	+"data-toggle='modal' onclick='deletePriv(\"" + rowData.id + "\");'><i class='icon-trash'></i></button>";
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
					updatePagerIcons(table);//分页图片相关
					enableTooltips(table);
				}, 0);
			},
			autowidth: true
		});
		
		//左侧菜单加载
		debugger;
   		var treeDataurl=basePath+"/permission/getTreeData.do";
		$.ajax({
			url: treeDataurl,
			type: "POST",
			data: "",
			success: function(resObj) {
				eval(resObj);
				var PrivilegeTreesetting={
					data: {
						simpleData: {
							enable: true
						}
					},
					callback: {
						onClick:function(event, treeId, treeNode){
							var treeNodeId=treeNode.id;
							var url=encodeURI(encodeURI(basePath+"/permission/list.do?pid="+treeNodeId));
							$(grid_selector).jqGrid('setGridParam',{page:1,url:url}).trigger("reloadGrid"); 
						}
					}
				}
				$.fn.zTree.init($("#PrivilegeTree"), PrivilegeTreesetting, zNodes);
			}
		});
		
		//新增页面中的下拉树
		$.ajax({
			url: treeDataurl,
			type: "POST",
			data: "",
			success: function(resObj) {
				eval(resObj);
				var MyTreesetting = {
					data: {
						simpleData: {
							enable: true
						}
					},
					callback: {
						onDblClick:function(event, treeId, treeNode){
							$("#permissionName").val(treeNode.name);
							$("#id").val(treeNode.id);
							$(".MySelecttree").addClass("treehidden");
						}
					}
				};
				$.fn.zTree.init($("#permissionNameTree"), MyTreesetting, zNodes);
			}
		}); 
		
		//保存按钮
		$("#btnSave").click(function(){
			if(doValidate(privilegeForm)){
				execAjax("POST", basePath+"/permission/saveOrUpdate.do", $('#privilegeForm').serialize());
			}
		});		
		
		
	});
		
		
	
	//增改查菜单数据
	function openDialog(gid,flag){
		if(flag=="add"){
			var zTree = $.fn.zTree.getZTreeObj("PrivilegeTree");
			if(zTree.getSelectedNodes().length>0){
				$("#modal-title").html('添加权限');
				$("#privilegeForm")[0].reset();
				$("#parentId").val(zTree.getSelectedNodes()[0].id);
                $("#permissionName").val(zTree.getSelectedNodes()[0].name);//新增显示上级名称
				$("#btnSave").show();
			}else{
				alert("请选择一个节点");
				return;
			}
		}else {
			getPrivilegeInfoById(gid);
			if(flag=="update"){
				$("#modal-title").html('修改权限');
				$("#btnSave").show();
			}else{
				$("#modal-title").html('查看权限');
				$("#btnSave").hide();
			}
		}
		$("#addModal").modal('show');
	}
	//根据人员ID获取人员部门信息、部门信息、角色信息、人员信息
	function getPrivilegeInfoById(privilegeId){
		if(privilegeId!=null){
			//根据ID查看详情
			$.ajax({
		        type: "post",   
		        url: basePath+"/permission/queryPrivilegeInfoById.do",  
		        dataType:"json",
		        data:{privilegeId:privilegeId},
		        async:false,
		        success: function (result) {
		        	result = eval(result);
		        	if (result != null) {
		        		$("#privilegeForm input").each(function () {
		        			var thisValue=eval("result.privilege."+$(this).attr("name"));
		        			$(this).val(thisValue);
	    	            });
		        		 $("#privilegeForm select").each(function (i) {
	    	                var thisValue=eval("result.privilege."+$(this).attr("name"));
		        			$(this).val(thisValue);
	    	            }); 
		        		$("#privilegeForm textarea").each(function (i) {
		    	    		var thisValue=eval("result.privilege."+$(this).attr("name"));
			        		$(this).val(thisValue);
		    	        });
		        		//编辑回显上级名称
		    			var zTree = $.fn.zTree.getZTreeObj("permissionNameTree");
		    			var node = zTree.getNodeByParam("id",result.privilege.parentId);
		    			$("#permissionName").val(node.name);
					}else{
			        	alert("获取权限信息失败");
					}
		        }
		    });
		}else{
			alert("获取权限信息失败！");
		}
	}
	//删除菜单及相关数据
	function deletePriv(gid) {
		var r=confirm("你确认删除?");
		if (r==true)
		{
			execAjax("POST", basePath+"/permission/delete.do?id="+gid, "null");
		}
	}
	//批量删除菜单及相关数据
	function delectPrivilegeList(){
	    var ids=$("#privilege-table").jqGrid('getGridParam','selarrrow');
	    if(ids.length<1){
	        alert("请选择要删除的项!");
	        return false;
	    }
	    if(confirm("你确认删除?")){
	        var deleteStatus="删除成功";
	        for(var i=0;i<ids.length;i++){
					var gid = $("#privilege-table").jqGrid('getRowData',ids[i]).id;
					$.ajax({
	    				url: basePath+"/permission/delete.do?gid="+id,
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
	</script>
  </body>
</html>