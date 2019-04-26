package cn.rails.ims.core.controller.system;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.rails.ims.core.entity.Department;
import cn.rails.ims.core.service.system.DepartmentService;
import cn.rails.ims.core.service.system.UserDepartmentService;
import cn.rails.ims.core.service.system.UserService;
import cn.rails.ims.utils.Common;
import cn.rails.ims.utils.UUIDHexGenerator;
import cn.rails.ims.utils.Constant.Message;
import cn.rails.ims.utils.Constant.StatusCode;
import cn.rails.ims.utils.page.Order;
import cn.rails.ims.utils.page.PageTion;
import cn.rails.ims.utils.page.Paramter;

import com.alibaba.fastjson.JSON;

/**
 * 
 * @author hzx
 * @date 2017年3月20日
 * @description 部门控制层
 */
@RequestMapping(value ="/departments",produces="text/html;charset=UTF-8")
@Controller
public class DepartmentController {
	@Autowired
	private DepartmentService service;
	@Autowired
	private UserService userService;
	@Autowired
	private HttpServletRequest request;
	@Autowired
	private HttpSession httpSession;
	@Autowired
	private UserDepartmentService userDepartmentervice;

	/**
	 * 获取部门列表信息
	 * @author hzx
	 */
	@RequestMapping(value="/listByPage")
	@ResponseBody
	public String listByPage(String conditionJson) throws UnsupportedEncodingException {
		//获取分页及排序相关信息
		int page = Integer.parseInt(request.getParameter("page"));// 当前页
		int rows = Integer.parseInt(request.getParameter("rows"));// 行数
		String orderString = request.getParameter("sidx");// 排序字段
		String orderBy = request.getParameter("sord");// 行数
		Paramter par = new Paramter();
		par.setMap((Map<String, Object>) JSON.parseObject(conditionJson));
		
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
		
		String parentId=request.getParameter("pid");// 父节点
		if(parentId!=null&&!parentId.equals("null")){
			parentId= URLDecoder.decode(parentId,"UTF-8");
			par.addCondition("parentCode", parentId);
			//likeSql+=(" and pid = '"+pid+"'");
		}
		
		String name= request.getParameter("name");
		if(name!=null&&!name.equals("null")&&name!=""){
			name= URLDecoder.decode(name,"UTF-8");
			likeSql+=" and name like '%"+name+"%' ";
		}
		
		par.setAndSql(likeSql);
		
		PageTion data = service.listByPage(page, rows, par);
		Map<String, Object> map = new HashMap<String, Object>();
		
		// 设置页面展示相关信息
		map.put("total", data.getTotal());// 总页数
		map.put("rows", data.getList());// 总行数
		map.put("page", data.getPageNo());// 第几页
		map.put("rowNum", data.getPageSize());// 第几行
		map.put("records", data.getNum());//总条数
		return JSON.toJSONString(map);
	}

	/**
	 * 保存部门信息
	 * @param t
	 * @return
	 * @throws ParseException
	 */
	@RequestMapping("/save")
	@ResponseBody
	public String save(Department t) throws ParseException {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String token=request.getHeader("token");
			if(t.getId().length()!=32){
				t.setId(UUIDHexGenerator.getUUID());
				service.save(t);
				map = Common.getTipMsg("add", 1);
			}else {
				System.out.println(t.getName());
				service.update(t);
				map = Common.getTipMsg("edit", 1);
			}
		} catch (Exception e) {
			return JSON.toJSONString(Common.getTipMsg("ex", 2));
		}
		return JSON.toJSONString(map);
	}

	/**
	 * 删除部门信息
	 * @author hzx
	 */
	@RequestMapping("/delete/{id}")
	@ResponseBody
	public String delete(@PathVariable("id") String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		Department t = new Department();
		try {
			t.setId(id);
			service.delete(t);
			map.put("msg", Message.DELETESUCCESS.getMsg());
			map.put("status_code", StatusCode.CORRECT.getStatusCode());
		} catch (Exception e) {
			map.put("msg", Message.DELETEFAIL.getMsg());
			map.put("status_code", StatusCode.ERROR.getStatusCode());
		}
		return JSON.toJSONString(map);
	}
	
	/**
	 * 获取部门树节点信息
	 * @author hzx
	 */
	@RequestMapping("/getTreeData")
	@ResponseBody
	public String getTreeData(String tableName, String tiaojian) {
		List<Department> pList = null;
		Paramter par = new Paramter();
		Order order = new Order();
		order.setClumn("parentCode");
		par.addOrder(order);
		
		
		String returnValue = " var zNodes =[";
		pList = service.queryByCondition(par);
		for (int i = 0; i < pList.size(); i++) {
			returnValue += "{ id:'"+pList.get(i).getCode()+"', pId:'"+pList.get(i).getParentCode()+
				"', name:'"+pList.get(i).getName()+"', deptId:'"+pList.get(i).getId()+"'},";
		}
		returnValue = returnValue.substring(0, returnValue.length() - 1);
		returnValue += "]; ";
		return returnValue;
	}
	
	/**
	 *获取下拉框数据
	 * @author hzx
	 */
	@RequestMapping(value="/getSelectData.do")
	@ResponseBody
	public String getSelectData() {
		try {
			List<Department> pList=null;
			String returnValue="<option value=''>&nbsp;</option>";
			pList=service.queryByCondition("","");
			for(int i=0;i<pList.size();i++){
				returnValue+="<option value='"+pList.get(i).getCode()+"'>"+pList.get(i).getName()+"</option> ";
			}
			return returnValue;
		} catch (Exception e) {
			return "<option value=''>&nbsp;</option>";
		}
	}
	
	/**
	 *根据部门ID获取部门信息
	 * @author hzx
	 */
	@RequestMapping("/{deptId}/edit")
	@ResponseBody
	public String queryById(@PathVariable("deptId")String deptId) {
		Map<String, Object> map = new HashMap<String, Object>();
		try{
			Department department=service.queryById(deptId);
			map = Common.getTipMsg("edit", 1);
			map.put("department", department);
		}catch (Exception e) {
			map = Common.getTipMsg("edit", 0);
			return JSON.toJSONString(map);
		}
		return JSON.toJSONString(map);
	}
	
	/*
	 * 部门及以下部门或者部门及以上
	 * */
	public List<Object> getdeptIds(String departmentId,String orders) {
		try {
			List<Object> deptIdString=service.mysqlgetdeptIds(departmentId,orders);
			return deptIdString;
		} catch (Exception e) {
			return null;
		}
		
	}
	/*
	 * 部门及以下部门
	 * */
	public String getLowDeptIds(String departmentId,String orders) {
		try {
			String minDepartmentIds="(";
			List<Object> minDepartmentId=getdeptIds(departmentId, "low");
			String deptidsString = (String) minDepartmentId.get(0);
			String[] arraydeptStrings=deptidsString.split(",");
			for(int d=1;d<arraydeptStrings.length;d++){
				minDepartmentIds+="'"+arraydeptStrings[d]+"',";
			}
			minDepartmentIds =  minDepartmentIds.substring(0, minDepartmentIds.lastIndexOf(","));
			minDepartmentIds+=")";
			return minDepartmentIds;
		} catch (Exception e) {
			return null;
		}
		
	}
	
	
	//根据当前登录人的部门，去过滤本所的所有部门
	public String getOwnDeptIds(String departmentId){
		List<Object> maxDepartmentId=getdeptIds(departmentId, "up");
		String maxDepartmentIds=(String) (maxDepartmentId.get(maxDepartmentId.size()-1));
		List<Object> minDepartmentId=getdeptIds(maxDepartmentIds, "low");
		String minDepartmentIds="(";
		for(int i=0;i<minDepartmentId.size();i++){
			minDepartmentIds+="'"+minDepartmentId.get(i)+"',";
		}
		minDepartmentIds =  minDepartmentIds.substring(0, minDepartmentIds.lastIndexOf(","));
		minDepartmentIds+=")";
		return minDepartmentIds;
	}
	
}
