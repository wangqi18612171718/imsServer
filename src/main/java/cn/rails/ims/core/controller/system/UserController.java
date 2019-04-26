package cn.rails.ims.core.controller.system;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.rails.ims.core.entity.User;
import cn.rails.ims.core.entity.UserPosition;
import cn.rails.ims.core.service.system.DepartmentService;
import cn.rails.ims.core.service.system.RoleService;
import cn.rails.ims.core.service.system.UserDepartmentService;
import cn.rails.ims.core.service.system.UserPositionService;
import cn.rails.ims.core.service.system.UserRoleService;
import cn.rails.ims.core.service.system.UserService;
import cn.rails.ims.utils.Common;
import cn.rails.ims.utils.Constant.Message;
import cn.rails.ims.utils.Constant.StatusCode;
import cn.rails.ims.utils.UUIDHexGenerator;
import cn.rails.ims.utils.page.Order;
import cn.rails.ims.utils.page.PageTion;
import cn.rails.ims.utils.page.Paramter;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
/**
 * @author       : wangqi
 * @date         ：2017-03-22
 * @description  ：用户列表
 */
@RequestMapping(value ="/user",produces="text/html;charset=UTF-8")
@Controller
public class UserController{
	
	//绑定时间类型特殊处理
	@InitBinder
	public void initBinder(WebDataBinder binder) {
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	    dateFormat.setLenient(false);
	    binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));//true:允许输入空值，false:不能为空值
	}
	
	@Autowired
	private UserService service;
	@Autowired
	private UserDepartmentService userDepartmentService;
	@Autowired
	private DepartmentService departmentService;
	@Autowired
	private UserRoleService userRoleService;
	@Autowired
	private UserPositionService userPositionService;
	@Autowired
	private RoleService roleService;
	@Autowired
	private HttpServletRequest request;
	@Autowired
	private HttpSession httpSession;
	@Autowired
	private DepartmentController departmentController;
	
	/**
	 * 获取所有的人员信息（不加权限）
	 * @param 
	 * @author wangqi
	 */
	@RequestMapping(value="/listByPage")
	@ResponseBody
	public String listByPage(String conditionJson) throws UnsupportedEncodingException {
		//获取分页及排序相关信息
		int page = Integer.parseInt(request.getParameter("page"));// 当前页
		int rows = Integer.parseInt(request.getParameter("rows"));// 行数
		String orderString = request.getParameter("sidx");// 排序字段
		String orderBy = request.getParameter("sord");// 行数
		String name = request.getParameter("name");
		String code = request.getParameter("code");
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
		String likeSql = "";
		if(name!=null&&!name.equals("null")&&name!=""){
			name= URLDecoder.decode(name,"UTF-8");
			likeSql+=" and name like '%"+name+"%' ";
		}
		if(code!=null&&!code.equals("null")&&code!=""){
			code= URLDecoder.decode(code,"UTF-8");
			likeSql+=" and code like '%"+code+"%' ";
		}
		par.setAndSql(likeSql);
		par.setMap((Map<String, Object>) JSON.parseObject(conditionJson));
		PageTion data = service.listByPage(page, rows, par);				
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
	 * 根据人员ID获取所有人员相关信息（部门信息、角色信息、权限信息）
	 * @param userId 人员信息ID
	 */
	@RequestMapping("/queryUserInfoByUserId")
	@ResponseBody
	public String queryUserInfoByUserId(String userId) {
		System.out.println("---------------------------");
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			User u = service.queryById(userId);
			List<UserPosition> userPostions = userPositionService.queryByCondition("userId", u.getId());
			if(userPostions != null && userPostions.size()>0){
				u.setPositionId(userPostions.get(0).getPositionId());
				u.setPositionName("222");
			}
			if (u != null) {
				map.put("status_code", StatusCode.CORRECT.getStatusCode());
				map.put("msg", Message.SUCCESS.getMsg());
				map.put("user", u);
				json = JSON.toJSONString(map);
			} else {
				map.put("status_code", StatusCode.ERROR.getStatusCode());
				map.put("msg", Message.FAIL.getMsg());
				json = JSON.toJSONString(map);
			}
			return json;
		} catch (Exception e) {
			return json;
		}
		
	}
	
	/**
	 * 用户信息保存
	 * @param users 人员信息
	 */
	@RequestMapping("/save")
	@ResponseBody
	public String save(User user) {
		Map<String, Object> map = new HashMap<String, Object>();
		try { 
			if(user.getId().length()!=32){
				user.setId(UUIDHexGenerator.getUUID());
				service.save(user);
				map = Common.getTipMsg("add", 1);
			}else {
				System.out.println(user.getName());
				service.update(user);
				map = Common.getTipMsg("edit", 1);
			}
		} catch (Exception e) {
			return JSON.toJSONString(Common.getTipMsg("ex", 2));
		}
		return JSON.toJSONString(map);
	}
	
	/**
	 * 用户信息删除
	 * @param users 人员信息
	 */
	@RequestMapping("/delete/{id}")
	@ResponseBody
	public String deleteby(@PathVariable("id")String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		User users = new User();
		try {
			users.setId(id);
			//删除人员表中相关信息
			service.delete(users);
			map = Common.getTipMsg("delete", 0);
		} catch (Exception e) {
			map = Common.getTipMsg("delete", 1);
		}
		return JSON.toJSONString(map);
	}
	/**
	 * 获取下拉框数据
	 * @param users 人员信息
	 */
	@RequestMapping("/getSelectData.do")
	@ResponseBody
	public String getSelectData() {
		try {
			List<User> pList=null;
			String returnValue="<option value=''>&nbsp;</option>";
			Paramter par = new Paramter();
			pList = service.listByDeptId(par);
			for(int i=0;i<pList.size();i++){
				returnValue+="<option value='"+pList.get(i).getId()+"'>"+pList.get(i).getName()+"</option> ";
			}
			return returnValue;
		} catch (Exception e) {
			e.printStackTrace();
			return "<option value=''>&nbsp;</option>";
		}
	}
	
}
