<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<body>
	<%@include file="../../globals.jsp" %>
	<div class="main-container" id="main-container">
		<div class="breadcrumbs" id="breadcrumbs">
			<ul class="breadcrumb" style="line-height:40px;">
				<li><i class="icon-home home-icon"></i>首页</li><li>系统管理</li><li>个人资料</li>
			</ul>
		</div>
	<div class="page-content">
		<div class="col-xs-12 input-group">
			<button class="btn btn-xs btn-primary pull-right" title='保存信息' id="saveUserinfo" ><i class='icon-save'></i>保存</button>
		</div>
		<form class="form-horizontal" role="form" id="userinfoForm">
			<div class="col-xs-12" style="line-height:28px;">
				<div class=" col-xs-10">
					<h4 class="col-xs-2">项目基本信息</h4>
				</div>
				<div class=" col-xs-12 space-4"></div>
					<input type="hidden" name="gid" id="gid"/>
                    <input type="hidden" name="createUser" id="createUser"/>
                    <input type="hidden" name="createDate" id="createDate"/>
				<div class="col-xs-12">
					<label class="col-sm-2" style="width:150px;">
						<span class="lbl pull-right"><font color="red">*</font>部门名称</span>
					</label>
					<label class="col-sm-3">
						<input type="hidden" id="departmentId" name="departmentId"/>
						<input id="departmentName" type="text" class="col-sm-12 no-padding-left" readonly="readonly"/>
					</label>
					<label class="col-sm-1">
						<span class="lbl pull-right"><font color="red">*</font>用户姓名</span>
					</label>
					<label class="col-sm-3">
						<input type="text" id="userName" name="userName" class="col-sm-12 no-padding-left" readonly="readonly"/>
					</label>
				</div>
				
				<div class="col-xs-12 space-4"></div>
				<div class="col-xs-12">
					<label class="col-sm-1" style="width:150px;">
						<span class="pull-right"><font color="red">*</font>登陆名称</span>
					</label>
					<label class="col-sm-3">
						<input type="text" id="loginName" name="loginName" class="col-sm-12 no-padding-left" readonly="readonly"/>
					</label>
					<label class="col-sm-1">
						<span class="pull-right"><font color="red">*</font>登陆密码</span>
					</label>
					<label class="col-sm-3">
						<input type="password"  name="password" id="password" class="col-sm-12 no-padding-left" />
					</label>
				</div>
				<div class=" col-xs-12 space-4"></div>
				<div class="col-xs-12">
					<label class="col-sm-1" style="width:150px;">
						<span class="lbl pull-right"><font color="red">*</font>拼音码</span>
					</label>
					<label class="col-sm-3">
						<input type="text" id="pym" name="pym" class="col-sm-12 no-padding-left" readonly="readonly"/>
					</label>
					<label class="col-sm-1">
						<span class="lbl pull-right"><font color="red">*</font>确认密码</span>
					</label>
					<label class="col-sm-3">
						<input type="password" id="checkpsw" class="col-sm-12 no-padding-left" />
					</label>
				</div>
				<div class=" col-xs-12 space-4"></div>
				<div class="col-xs-12">
					<label class="col-sm-1" style="width:150px;">
						<span class="lbl pull-right"><font color="red">*</font>序号</span>
					</label>
					<label class="col-sm-3">
						<input type="text" id="sort" name="sort" class="col-sm-12 no-padding-left" readonly="readonly"/>
					</label>
					<label class="col-sm-1">
						<span class="lbl pull-right"><font color="red">*</font>备注</span>
					</label>
					<label class="col-sm-3">
						<input type="text"  name="remark" id="remark" class="col-sm-12 no-padding-left" readonly="readonly"/>
					</label>
				</div>
			</div>	
		</form>			
	</div><!-- /.page-content -->
  </div>
	<script type="text/javascript">
	jQuery(function($) {
		//根据userID查看详情
		$.ajax({
	        type: "post",   
	        url: basePath+"/user/queryUserInfoByUserId.do",  
	        dataType:"json",
	        data:{userId:userId},
	        async:false,
	        success: function (result) {
	        	result = eval(result);
	        	if (result != null) {
	        		$("#userinfoForm input").each(function () {
	        			var thisValue=eval("result.user."+$(this).attr("name"));
	        			$(this).val(thisValue);
    	            });
	        		 $("#userinfoForm select").each(function (i) {
    	                var thisValue=eval("result.user."+$(this).attr("name"));
	        			$(this).val(thisValue);
    	            }); 
	        		$("#createDate").val(formatterdate(result.user.createDate)); 
	        		$("#departmentId").val(result.deptinfo.gid);
	        		$("#departmentName").val(result.deptinfo.name);
				}else{
		        	alert("失败");
				}
	        }
	    });
		
		$("#saveUserinfo").click(function(){
			var regex = new RegExp('(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*(){}:"<>?_]).{8,16}');
			if($('#password').val().length=="32"){
				var userdata =$('#userinfoForm').serialize();
				var userinfoUrl=basePath+"/user/save.do";
				userinfoUrl=encodeURI(encodeURI(userinfoUrl));
				execAjax("POST", userinfoUrl, userdata);
			}else{
				var passwd=$('#password').val();
				var checkpasswd=$('#checkpsw').val();
				if(passwd==checkpasswd){
					if(regex.test($('#password').val())){
						var userdata =$('#userinfoForm').serialize();
						var userinfoUrl=basePath+"/user/save.do";
						userinfoUrl=encodeURI(encodeURI(userinfoUrl));
						execAjax("POST", userinfoUrl, userdata);
					}else{
						alert("密码简单，请设置8-16位包含大、小写字母、数字、特殊符号的密码");
					}
				}else{
					alert("您输入的两次密码不一致，请确认后再进行保存");
				}
			}
		});
		
	});

	
	</script>

  	</body>
</html>
