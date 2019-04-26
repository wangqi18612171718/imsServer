<%@page import="cn.rails.ims.utils.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<title><%=Constants.TITLE_STRING%></title>
	</head>
<%@include file="globals.jsp" %>
	<body style="overflow:hidden">
		<!-- head -->
		<div class="navbar navbar-default" id="navbar" style="background:url(images/headBg.png) no-repeat 0 center;background-size:100% 100%;">
			<div class="navbar-container" id="navbar-container">
				<div class="navbar-header pull-left">
					<a href="#" class="navbar-brand">
						<small>
							<img width="353px" height="42px" src="images/logo.png"></img>
						</small>
					</a><!-- /.brand -->
				</div><!-- /.navbar-header -->
				<!-- 个人信息 -->
				<div class="navbar-header pull-right" role="navigation">
					<ul class="nav ace-nav">
						<li style="margin-top:10px">
							<a data-toggle="dropdown" href="#" class="dropdown-toggle" style="background-color:transparent;">
								<img class="nav-user-photo" src="assets/avatars/user.png" alt="Photo" />
								<span class="user-info">
									<small>欢迎光临,</small>
									<p id="username"></p>
								</span>
								<i class="icon-caret-down"></i>
							</a>
							<ul class="user-menu pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
								<li>
									<a href="#" id="personSet">
										<i class="icon-user"></i>
										个人资料
									</a>
								</li>
								<li class="divider"></li>
								<li>
									<a href="<%=request.getContextPath()%>/login.jsp">
										<i class="icon-off"></i>
										退出
									</a>
								</li>
							</ul>
						</li>
					</ul><!-- /.ace-nav -->
				</div><!-- /.navbar-header -->
			</div><!-- /.container -->
		</div>
	<!-- mainBody -->		
		<div class="main-container" id="main-container">
            <div class="main-container-inner">
                <a class="menu-toggler" id="menu-toggler" href="#">
                    <span class="menu-text"></span>
                </a>
                <div class="sidebar" id="sidebar">
                    <!-- #sidebar-shortcuts -->
                    <ul id="menu"></ul>
                    <div class="sidebar-collapse" id="sidebar-collapse">
                        <i class="icon-double-angle-left" data-icon1="icon-double-angle-left" data-icon2="icon-double-angle-right"></i>
                    </div>
                </div>
                <div class="main-content">
                    <div class="breadcrumbs" id="breadcrumbs" style="background-color: white; border: none; padding-right: 2px;">
                        <div class="row" style="margin: 0px;">
                            <!-- 适应各种屏幕大小的12 -->
                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin: 0px 0px 0px 1px; padding: 0px;">
                                <!-- 主要内容区域 -->
                                <div id="main-tab">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
		<script type="text/javascript">
		$(function () {
			//右上角登录名称
			$('#username').text(userName);
			//根据当前登录人获取相关角色对应的菜单
			var menusDataurl=basePath+"/permission/queryMenu.do";
			$.ajax({
				url: menusDataurl,
				type: "POST",
				data: "",
				success: function(resObj) {
					if(resObj){
						debugger;
						$('#menu').acemenu({
			                menuTabID: "main-tab",
			                data:eval(resObj) 
						 });
					}else{
						alert("加载失败");
					}	
				}
			});
			//打开个人设置页面
			$('#personSet').click(function(){
				$("#main-tab").aceaddtab({ title: "个人资料", url: basePath+"/page/systemManage/userInfo.jsp" });
			});
        });
		</script>
	</body>
</html>

