package cn.rails.ims.core.controller.system;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.rails.ims.core.entity.UserRole;
import cn.rails.ims.core.service.system.RoleService;
import cn.rails.ims.core.service.system.UserRoleService;
import cn.rails.ims.core.service.system.UserService;
import cn.rails.ims.utils.Common;
import cn.rails.ims.utils.UUIDHexGenerator;
import cn.rails.ims.utils.Constant.Message;
import cn.rails.ims.utils.Constant.StatusCode;

import com.alibaba.fastjson.JSON;
/**
 * <p>Title      : 中国铁道科学研究院[]</p>
 * <p>Description: [人员角色管理]</p>
 * <p>Copyright  : Copyright (c) 2017</p>
 * <p>Company    : 铁科院电子所</p>
 * <p>Department : 信息中心</p>
 * @author       : sunyh
 * @version      : 1.0
 * @date         ：2017-02-16
 */
@RequestMapping(value ="/userrole",produces="text/html;charset=UTF-8")
@Controller
public class UserRoleController{
	
	//绑定时间类型特殊处理
	@InitBinder
	public void initBinder(WebDataBinder binder) {
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	    dateFormat.setLenient(false);
	    binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));//true:允许输入空值，false:不能为空值
	}
	@Autowired
	private UserService userService;
	@Autowired
	private RoleService roleService;
	@Autowired 
	private UserRoleService userRoleService;
	@Autowired
	private HttpServletRequest request;
	@Autowired
	private HttpSession httpSession;
	
//	//根据人员ID获取当前人员相关角色信息
//	@RequestMapping(value = "getUserRoleByUserId.do")
//	@ResponseBody
//	public String getUserDepartmentByUserId(String userId) {
//		String json = "";
//		Map<String, Object> map = new HashMap<String, Object>();
//		List<UserRole> t = userRoleService.getUserRoleByUserId(userId);// getRoleIdByUserId(userId);
//		if (t != null) {
//			map.put("status_code", StatusCode.CORRECT.getStatusCode());
//			map.put("msg", Message.SUCCESS.getMsg());
//			map.put("projectInfo", t);
//			json = JSON.toJSONString(map);
//		} else {
//			map.put("status_code", StatusCode.ERROR.getStatusCode());
//			map.put("msg", Message.FAIL.getMsg());
//			json = JSON.toJSONString(map);
//		}
//		return json;
//	}
	
	//保存该人员的角色信息
	@RequestMapping(value = "saveUserRole")
	@ResponseBody
	public String saveUserRole() {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String userId = request.getParameter("userId");
			String roleIds = request.getParameter("roleIds");
			String[] roIds = roleIds.split(",");
			userRoleService.deleteByUserId(userId);
			for(String rId:roIds){
				UserRole uRole = new UserRole();
				uRole.setId(UUIDHexGenerator.getUUID());
				uRole.setUserId(userId);
				uRole.setRoleId(rId);
				userRoleService.save(uRole);
			}
			map = Common.getTipMsg("save", 1);
		} catch (Exception e) {
			return JSON.toJSONString(Common.getTipMsg("ex", 2));
		}
		return JSON.toJSONString(map);
	}
	/*
	 * 根据人员过滤该人员的相关角色
	 */
	@RequestMapping("/getSelectedStatus.do")
	@ResponseBody
	public String getSelectedStatus() {
		String userId=request.getParameter("userId");
		List<UserRole> urList=userRoleService.queryByCondition("userId", userId);
		
		String returnValue = "";
		for (int i = 0; i < urList.size(); i++) {
			returnValue += urList.get(i).getRoleId() + "@";
		}
		return returnValue;
	}
}
