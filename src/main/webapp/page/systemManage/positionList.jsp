<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<body>
	<%@include file="../../globals.jsp" %>
	<div class="main-container" id="main-container">
		<div class="main-container-inner">
			<div class="breadcrumbs" id="breadcrumbs">
				<ul class="breadcrumb" style="line-height:40px;">
					<li><i class="icon-home home-icon"></i>首页</li><li>系统管理</li><li>岗位管理</li>
				</ul>
			</div>
			<div class="page-content">
				<!-- 查询条件 -->
				<div class="pull-left input-group" style="width:100%">
					<!-- <label class="inline"> 
						<span class="pull-left">岗位名称</span>
					</label>
					<input type="text" class="searchBtn" id="positionName" style="width:18% !important"/>
					
					<button type="button" class="btn btn-info" id="departmentSearch" style="line-height:20px">
						<i class="icon-search bigger-110"></i>搜索
					</button> -->
					<button class='btn btn-info pull-right ismanager' style='margin-top:7px;'data-toggle='modal' id="delDept" onclick="delectDepList()">
						<i class='icon-trash'></i>删除</button>
					<button class='btn btn-info pull-right ismanager' style='margin-top:7px;'data-toggle='modal' id="addDept">
						<i class='icon-plus'></i>添加</button>
				</div>
				<!-- 列表 -->
				<div class="row">
					<div class="col-xs-12">
						<label class="col-xs-3" style="height:450px;border: 1px solid #e5e5e5;overflow:auto">
							<div id="deptTree" class="ztree" style='display:block;z-index:100'></div>
							<input type="hidden" id="pid" value=""/>
						</label>
						<div class="col-xs-9">
							<table id="dept_table"></table>
							<div id="dept_pager"></div>
						</div>
					</div>
				</div>
			    <!-- 添加编辑模态框 -->
				<div class="modal fade" id="saveOrUpdateModal" tabindex="-1" role="dialog" aria-labelledby="eidtModalLabel" aria-hidden="true">
			        <div class="modal-dialog">
			            <div class="modal-content">
			                <div class="modal-header">
			                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			                    <h4 class="modal-title" id="modal-title">添加岗位</h4>
			                </div>
			                <div class="modal-body">
			                    <div class="row">
			                        <div class="col-xs-12">
			                            <!-- PAGE CONTENT BEGINS -->
			                            <form class="form-horizontal" role="form" id="departmentForm" >
			                            	<input type="hidden" name="id" id="id" />
			                                <input type="hidden" name="parentId" id="parentId"/>
			                        		<div class="form-group">
			                                    <label class="col-sm-3 control-label no-padding-right" for="parentDepartment">部门 </label>
			                                    <div class="col-sm-9">
			                                       <select class="form-control input-large" disabled="disabled" id="parentDepartment" mapName='departments'></select>
			                                    </div>
			                                </div>
			                                
			                            	<div class="space-4"></div>
			                                <div class="form-group">
			                                    <label class="col-sm-3 control-label no-padding-right" for="name"> 岗位名称 </label>
			                                    <div class="col-sm-9">
			                                        <input type="text" name="name" id="name" class="col-xs-10 input-large" />
			                                    </div>
			                                </div>
			
			
			                                <div class="space-4"></div>
			                                <div class="form-group">
			                                    <label class="col-sm-3 control-label no-padding-right" for="sortNumber"> 序号 </label>
			                                    <div class="col-sm-9">
			                                        <input type="text" name="sortNumber" id="sort" value="1" notnull="true" vdisp="序号"
														 class="col-xs-10 input-large" />
			                                    </div>
			                                </div>
			                                
			                                <div class="space-4"></div> 
			                                <div class="form-group">
			                                    <label class="col-sm-3 control-label no-padding-right" for="memo"> 备注 </label>
			                                    <div class="col-sm-9">
			                                        <input type="text" name="memo" id="memo" class="col-xs-10 input-large" />
			                                    </div>
			                                </div>
			                                
			                                <!-- <div class="form-group">
			                                    <label class="col-sm-3 control-label no-padding-right" for="departCode"> 岗位编码 </label>
			                                    <div class="col-sm-9">
			                                        <input type="text" name=departCode id="departCode" class="col-xs-10 input-large" />
			                                    </div>
			                                </div> -->
			                            </form>
			                        </div><!-- /.col -->
			                    </div>
			                </div>
			                <div class="modal-footer">
			                    <button type="button" class="btn btn-primary" id="departemntSave">保存</button>
			                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			                </div>
			            </div><!-- /.modal-content -->
			        </div><!-- /.modal-dialog -->
			    </div><!-- /.modal --> 
			</div><!-- /.page-content -->
		</div>
	</div>
	<script type="text/javascript">
	jQuery(function($) {
		var grid_selector = "#dept_table";
		var pager_selector = "#dept_pager";
		//岗位列表
		var url = basePath+ "/positiondepartment/listByPage";
		$(grid_selector).jqGrid({
			url : url,
			datatype: "json",
			height: listHeight,
			colNames:['id','编码','名称', '备注', '操作'],
			colModel:[
			    {name:'positions.id',index:'id',hidden:true},
				{name:'positions.sortNumber',index:'sortNumber', width:100},
				{name:'positions.name',index:'name', width:100},
				{name:'positions.memo',index:'memo', width:90},
				{name:'oper',index:'query', width:130,  formatter: function (value, rowIndex, rowData) {
                   var strHtml = "";
                   var id = rowData.id;
                   if(isManager!="true"){
                	   strHtml += "<div class='sidebar-shortcuts-large' style='text-align:center'>";
                       strHtml += "<button class='btn btn-info' title='查看' data-toggle='modal'  deptId='"+id+"' onclick='viewDept(this)'><i class='icon-zoom-in'></i></button>&nbsp;";
                       strHtml += "<button class='btn' disabled='disabled' title='修改'><i class='icon-pencil'></i></button>&nbsp;";
                       strHtml += "<button class='btn' disabled='disabled' title='删除'><i class='icon-trash'></i></button>";
                       strHtml += "</div>";
                   }else{
                	   strHtml += "<div class='sidebar-shortcuts-large' style='text-align:center'>";
                       strHtml += "<button class='btn btn-info' title='查看' data-toggle='modal'  deptId='"+id+"' onclick='viewDept(\"" + rowData.positionId + "\")'><i class='icon-zoom-in'></i></button>&nbsp;";
                       strHtml += "<button class='btn btn-success' title = '修改' data-toggle='modal' deptId='"+id+"' onclick='updateDept(\"" + rowData.positionId + "\")'><i class='icon-pencil'></i></button>&nbsp;";
                       strHtml += "<button class='btn btn-danger' title='删除' data-toggle='modal' deptId='"+id+"' onclick='deleteDept(\"" + rowData.id + "\");' ><i class='icon-trash'></i></button>";
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
			sortorder:"desc",
		    sortname:"sortNumber",
			multiselect: true,
	        multiboxonly: true,
			loadComplete : function(data) {
				var table = this;
				setTimeout(function(){
					updatePagerIcons(table);
					enableTooltips(table);
				}, 0);
			},
			autowidth: true
		});
	
		//岗位搜索按钮
		$("#departmentSearch").click(function(){
			var positionName=$("#positionName").val();
			var url=encodeURI(encodeURI(basePath+"/position/listByPage?name="+positionName));
			$(grid_selector).jqGrid('setGridParam',{page:1,url:url}).trigger("reloadGrid"); 
		});
		
		//保存按钮
		$("#departemntSave").click(function(){
			if(doValidate(departmentForm)){
				$("#saveOrUpdateModal").modal('hide');
				var departmentId = $("#parentId").val();
				if(departmentId==null||departmentId==""){
					execAjax("POST", basePath+"/position/update", $('#departmentForm').serialize());
					return;
				}
				execAjax("POST", basePath+"/position/save/"+departmentId, $('#departmentForm').serialize());
			}
		});
		
		//新增按钮
		$("#addDept").click(function(){
			$("#modal-title").html('添加岗位');
			$("#departmentForm")[0].reset();
			var treeObj=$.fn.zTree.getZTreeObj("deptTree");
            var treeNodeId=treeObj.getSelectedNodes(true);
            if(treeNodeId.length==0){
            	alert("请选择一个部门");
            }else{
            	//alert(treeNodeId[0].id);
            	$("#parentDepartment").val(treeNodeId[0].id);
            	$("#parentId").val(treeNodeId[0].deptId);
				$("#departemntSave").show();
				$("#saveOrUpdateModal").modal('show');
            }
		});
		
		//部门树加载
		var treeDataurl=basePath+"/departments/getTreeData";
		$.ajax({
			url: treeDataurl,
			type: "POST",
			data: "",
			success: function(resObj) {
				eval(resObj);
				var deptTreesetting={
					data: {
						simpleData: {
							enable: true
						}
					},
					callback: {
						onClick:function(event, treeId, treeNode){
							var treeNodeId=treeNode.id;
							var deptId = treeNode.deptId;
							var url=encodeURI(encodeURI(basePath+"/positiondepartment/listByPage?pid="+treeNodeId+"&deptId="+deptId));
							$(grid_selector).jqGrid('setGridParam',{page:1,url:url}).trigger("reloadGrid"); 
						}
					}
				}
				$.fn.zTree.init($("#deptTree"), deptTreesetting, zNodes);
			}
		});
		
	});

	//更新按钮
	function updateDept(positionId) {
		getDeptInfoById(positionId);
		$("#modal-title").html('修改岗位');
		$("#departemntSave").show();
		$("#saveOrUpdateModal").modal('show');
	}
	//查看岗位信息
	function viewDept(deptId) {
		getDeptInfoById(deptId);
		$("#modal-title").html('查看岗位');
		$("#departemntSave").hide();
		$("#saveOrUpdateModal").modal('show');
	}
	
	//根据人员ID获取人员岗位信息、岗位信息、角色信息、人员信息
	function getDeptInfoById(positionId){
		//var treeObj=$.fn.zTree.getZTreeObj("deptTree");
		if(deptId!=null){
			//根据ID查看详情
			$.ajax({
		        type: "post",   
		        url: basePath+"/positiondepartment/"+positionId+"/getPositionDepartmentById",
		        dataType:"json",
		        async:false,
		        success: function (result) {
		        	result = eval(result);
		        	debugger;
		        	if (result != null) {
		    	        $("#id").val(result.projectInfo.positions.id);
		    	        $("#name").val(result.projectInfo.positions.name);
		    	        $("#sort").val(result.projectInfo.positions.sortNumber);
		    	        $("#memo").val(result.projectInfo.positions.memo);
		        		$("#parentDepartment").val(result.projectInfo.departments.code);
					}else{
			        	alert("获取岗位信息失败");
					}
		        }
		    });
		}else{
			alert("获取岗位信息失败！");
		}
	}
	
	//删除按钮
	function deleteDept(id) {
		if (confirm("你确认删除?")){
			execAjax("post", basePath+"/positiondepartment/delete/"+id, "null");
		}
	}
	
	//批量删除
	function delectDepList(){
	    var ids=$("#dept_table").jqGrid('getGridParam','selarrrow');
	    if(ids.length<1){
	        alert("请选择要删除的项!");
	        return false;
	    }
	    if(confirm("你确认删除?")){
	        var deleteStatus="删除成功";
	        for(var i=0;i<ids.length;i++){
					var gid = $("#dept_table").jqGrid('getRowData',ids[i]).id;
					$.ajax({
	    				url: basePath+"/department/delete/"+gid,
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
	//获取上级岗位下拉框中的ID
	function getParentId(){
		var op = $("#parentDepartment")[0];
		var i = op.selectedIndex;
		if(i>0){
			return op.options[i].value;
		}else{
			return 0;
		}
	}
	</script>
	</body>
</html>
