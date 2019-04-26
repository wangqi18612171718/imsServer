<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<body>
	<%@include file="../../globals.jsp" %>
	<div class="main-container" id="main-container">
		<div class="main-container-inner">
			<div class="breadcrumbs" id="breadcrumbs">
				<ul class="breadcrumb" style="line-height:40px;">
					<li><i class="icon-home home-icon"></i>首页</li><li>系统管理</li><li>部门信息</li>
				</ul>
			</div>
			<div class="page-content">
				<!-- 查询条件 -->
				<div class="pull-left input-group" style="width:100%">
					<label class="inline"> 
						<span class="pull-left">部门名称</span>
					</label>
					<input type="text" class="searchBtn" id="departmentName" style="width:18% !important"/>
					<!-- <label class="inline"> 
						<span class="pull-left">拼音码</span>
					</label>
					<input type="text" class="searchBtn" id="departmentPym" style="width:18% !important"/> -->
					<button type="button" class="btn btn-info" id="departmentSearch" style="line-height:20px">
						<i class="icon-search bigger-110"></i>搜索
					</button>
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
			                    <h4 class="modal-title" id="modal-title">添加部门</h4>
			                </div>
			                <div class="modal-body">
			                    <div class="row">
			                        <div class="col-xs-12">
			                            <!-- PAGE CONTENT BEGINS -->
			                            <form class="form-horizontal" role="form" id="departmentForm" >
			                            	<input type="hidden" name="id" id="id" />
			                                <input type="hidden" name="parentCode" id="parentCode"/>
			                        		<div class="form-group">
			                                    <label class="col-sm-3 control-label no-padding-right" for="parentDepartment">上级部门 </label>
			                                    <div class="col-sm-9">
			                                       <select class="form-control input-large" disabled="disabled" id="parentDepartment" mapName='departments'></select>
			                                    </div>
			                                </div>
			                                
			                            	<div class="space-4"></div>
			                                <div class="form-group">
			                                    <label class="col-sm-3 control-label no-padding-right" for="name"> 部门名称 </label>
			                                    <div class="col-sm-9">
			                                        <input type="text" name="name" id="name" class="col-xs-10 input-large" />
			                                    </div>
			                                </div>
			
			                                <div class="space-4"></div>
			                                <div class="form-group">
			                                    <label class="col-sm-3 control-label no-padding-right" for="pym"> 编码</label>
			                                    <div class="col-sm-9">
			                                        <input type="text" name="code" id="code" class="col-xs-10 input-large" />
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
			                                    <label class="col-sm-3 control-label no-padding-right" for="departCode"> 部门编码 </label>
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
		//部门列表
		var url = basePath+ "/departments/listByPage";
		$(grid_selector).jqGrid({
			url : url,
			datatype: "json",
			height: listHeight,
			colNames:['id','编码','名称', '备注', '操作'],
			colModel:[
			    {name:'id',index:'id',hidden:true},
				{name:'code',index:'code', width:100},
				{name:'name',index:'name', width:100},
				{name:'memo',index:'memo', width:90},
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
                       strHtml += "<button class='btn btn-info' title='查看' data-toggle='modal'  deptId='"+id+"' onclick='viewDept(this)'><i class='icon-zoom-in'></i></button>&nbsp;";
                       strHtml += "<button class='btn btn-success' title = '修改' data-toggle='modal' deptId='"+id+"' onclick='updateDept(this)'><i class='icon-pencil'></i></button>&nbsp;";
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
		    sortname:"code",
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
	
		//部门搜索按钮
		$("#departmentSearch").click(function(){
			var departmentName=$("#departmentName").val();
			var departmentPym=$("#departmentPym").val();
			var url=encodeURI(encodeURI(basePath+"/departments/listByPage?name="+departmentName+"&pym="+departmentPym));
			$(grid_selector).jqGrid('setGridParam',{page:1,url:url}).trigger("reloadGrid"); 
		});
		
		//保存按钮
		$("#departemntSave").click(function(){
			if(doValidate(departmentForm)){
				$("#saveOrUpdateModal").modal('hide');
				$("#parentId").val(getParentId());
				execAjax("POST", basePath+"/departments/save", $('#departmentForm').serialize());
			}
		});
		
		//新增按钮
		$("#addDept").click(function(){
			$("#modal-title").html('添加部门');
			$("#departmentForm")[0].reset();
			var treeObj=$.fn.zTree.getZTreeObj("deptTree");
            var treeNodeId=treeObj.getSelectedNodes(true);
            if(treeNodeId.length==0){
            	alert("请选择一个部门");
            }else{
            	//alert(treeNodeId[0].id);
            	$("#parentDepartment").val(treeNodeId[0].id);
            	$("#parentCode").val(treeNodeId[0].id);
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
							var url=encodeURI(encodeURI(basePath+"/departments/listByPage?pid="+treeNodeId));
							$(grid_selector).jqGrid('setGridParam',{page:1,url:url}).trigger("reloadGrid"); 
						}
					}
				}
				$.fn.zTree.init($("#deptTree"), deptTreesetting, zNodes);
			}
		});
		
	});

	//更新按钮
	function updateDept(dept) {
		getDeptInfoById(dept.getAttribute("deptId"))
		$("#modal-title").html('修改部门');
		$("#departemntSave").show();
		$("#saveOrUpdateModal").modal('show');
	}
	//查看部门信息
	function viewDept(dept) {
		getDeptInfoById(dept.getAttribute("deptId"))
		$("#modal-title").html('查看部门');
		$("#departemntSave").hide();
		$("#saveOrUpdateModal").modal('show');
	}
	
	//根据人员ID获取人员部门信息、部门信息、角色信息、人员信息
	function getDeptInfoById(deptId){
		if(deptId!=null){
			//根据ID查看详情
			$.ajax({
		        type: "post",   
		        url: basePath+"/departments/"+deptId+"/edit",
		        dataType:"json",
		        async:false,
		        success: function (result) {
		        	result = eval(result);
		        	if (result != null) {
		        		$("#departmentForm input").each(function () {
		        			var thisValue=eval("result.department."+$(this).attr("name"));
		        			$(this).val(thisValue);
	    	            });
		        		 $("#departmentForm select").each(function (i) {
	    	                var thisValue=eval("result.department."+$(this).attr("name"));
		        			$(this).val(thisValue);
	    	            }); 
		        		$("#departmentForm textarea").each(function (i) {
		    	    		var thisValue=eval("result.department."+$(this).attr("name"));
			        		$(this).val(thisValue);
		    	        });
		        		$("#parentDepartment").val(result.department.parentCode);
					}else{
			        	alert("获取部门信息失败");
					}
		        }
		    });
		}else{
			alert("获取部门信息失败！");
		}
	}
	
	//删除按钮
	function deleteDept(gid) {
		if (confirm("你确认删除?")){
			execAjax("post", basePath+"/departments/delete/"+gid, "null");
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
	//获取上级部门下拉框中的ID
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
