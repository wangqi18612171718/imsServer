package cn.rails.ims.core.controller.system;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
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

import cn.rails.ims.core.entity.UserDepartment;
import cn.rails.ims.core.service.system.UserDepartmentService;
import cn.rails.ims.core.service.system.UserService;
import cn.rails.ims.utils.Constant;
import cn.rails.ims.utils.Constant.Message;
import cn.rails.ims.utils.Constant.StatusCode;
import cn.rails.ims.utils.page.Order;
import cn.rails.ims.utils.page.PageTion;
import cn.rails.ims.utils.page.Paramter;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
/**
 * <p>Title      : 中国铁道科学研究院[]</p>
 * <p>Description: [人员部门管理]</p>
 * <p>Copyright  : Copyright (c) 2017</p>
 * <p>Company    : 铁科院电子所</p>
 * <p>Department : 信息中心</p>
 * @author       : sunyh
 * @version      : 1.0
 * @date         ：2017-02-16
 */
@RequestMapping(value ="/userdepartment",produces="text/html;charset=UTF-8")
@Controller
public class UserDepartmentController{
	
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
	private UserDepartmentService userDepartmentService;
	@Autowired
	private DepartmentController departmentController;
	@Autowired
	private HttpServletRequest request;
	@Autowired
	private HttpSession httpSession;
	/**
	 * 获取所有的人员部门信息（不加权限）
	 * @param departmentId 部门ID
	 * @author sunyh
	 */
	@RequestMapping(value="/listByPage.do")
	@ResponseBody
	public String listByPage(String conditionJson) throws UnsupportedEncodingException {
		//获取分页及排序相关信息
		int page = Integer.parseInt(request.getParameter("page"));// 当前页
		int rows = Integer.parseInt(request.getParameter("rows"));// 行数
		String orderString = request.getParameter("sidx");// 排序字段
		String orderBy = request.getParameter("sord");// 行数
		String departmentId = request.getParameter("departmentId");//部门Id
		Paramter par = new Paramter();
		// 设置排序
		Order order = new Order();
		order.setClumn(orderString);
		if (orderBy.equals("desc")) {
			order.setFalg(1);
		} else {
			order.setFalg(2);
		}
		par.addOrder(order);
		//查询条件
		String likeSql=" ";
		//本部门及以下所有部门ID
		String departmentIds=departmentController.getLowDeptIds(departmentId, "low");
		if(departmentId!=null && departmentId!="" && !departmentId.equals("null")){
			likeSql+=" and a.departmentId  in "+departmentIds+" ";
		}else{
			likeSql+=" and a.departmentId  !='"+Constant.rootDepart+"' ";
		}
		par.setAndSql(likeSql);
		par.setMap((Map<String, Object>) JSON.parseObject(conditionJson));
		PageTion data = userDepartmentService.listByPage(page, rows, par);				
		Map<String, Object> map = new HashMap<String, Object>();
		// 设置页面展示相关信息
		map.put("total", data.getTotal());// 总页数
		map.put("rows", data.getList());// 总行数
		map.put("page", data.getPageNo());// 第几页
		map.put("rowNum", data.getPageSize());// 第几行
		map.put("records", data.getNum());//总条数
		return JSON.toJSONString(map,SerializerFeature.DisableCircularReferenceDetect);
	}
	
	/**
	 * 根据人员ID获取人员部门信息
	 * @param departmentId 部门ID
	 * @author sunyh
	 */
	@RequestMapping(value = "getUserDepartmentByUserId.do")
	@ResponseBody
	public String getUserDepartmentByUserId(String gid) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		UserDepartment t = userDepartmentService.getDepartmentIdByUserId(gid);
		if (t != null) {
			map.put("status_code", StatusCode.CORRECT.getStatusCode());
			map.put("msg", Message.SUCCESS.getMsg());
			map.put("projectInfo", t);
			json = JSON.toJSONString(map);
		} else {
			map.put("status_code", StatusCode.ERROR.getStatusCode());
			map.put("msg", Message.FAIL.getMsg());
			json = JSON.toJSONString(map);
		}
		return json;
	}
}
