package cn.rails.ims.core.controller.system;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.rails.ims.core.entity.Role;
import cn.rails.ims.core.service.system.RoleService;
import cn.rails.ims.utils.UUIDHexGenerator;
import cn.rails.ims.utils.Constant.Message;
import cn.rails.ims.utils.Constant.StatusCode;
import cn.rails.ims.utils.page.Order;
import cn.rails.ims.utils.page.PageTion;
import cn.rails.ims.utils.page.Paramter;

import com.alibaba.fastjson.JSON;

/**
 * <p>Title      : 中国铁道科学研究院[]</p>
 * <p>Description: [角色管理]</p>
 * <p>Copyright  : Copyright (c) 2017</p>
 * <p>Company    : 铁科院电子所</p>
 * <p>Department : 信息中心</p>
 * @author       : sunyh
 * @version      : 1.0
 * @date         ：2017-02-16
 */

@Controller
@RequestMapping(value = "/role", produces = "text/html;charset=UTF-8")
public class RoleController {
	@Autowired
	private RoleService service;
	@Autowired
	private HttpServletRequest request;
	/**
	 * 根据角色ID获取所有角色相关信息
	 * @param roleId 角色信息ID
	 */
	@RequestMapping(value = "queryRoleInfoByRoleId.do")
	@ResponseBody
	public String queryRoleInfoByRoleId(String roleId) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			Role r = service.queryById(roleId);
			if (r != null) {
				map.put("status_code", StatusCode.CORRECT.getStatusCode());
				map.put("msg", Message.SUCCESS.getMsg());
				map.put("role", r);
				json = JSON.toJSONString(map);
			} else {
				map.put("status_code", StatusCode.ERROR.getStatusCode());
				map.put("msg", Message.FAIL.getMsg());
				json = JSON.toJSONString(map);
			}
			return json;
		} catch (Exception e) {
			// TODO: handle exception
			return json;
		}
	}
	
	/**
	 * 保存角色
	 * @param Role 角色信息
	 */
	@RequestMapping("/saveOrUpdate")
	@ResponseBody
	public String saveOrUpdate(Role t) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (t.getId().isEmpty()) {
				try {
					t.setId(UUIDHexGenerator.getUUID());
					service.save(t);map.put("msg", Message.ADDSUCCESS.getMsg());
					map.put("status_code", StatusCode.CORRECT.getStatusCode());
				} catch (Exception e) {
					map.put("msg", Message.ADDFAIL.getMsg());
					map.put("status_code", StatusCode.ERROR.getStatusCode());
				}
			} else {
				try {
					service.update(t);
					map.put("msg", Message.MODIFYSUCCESS.getMsg());
					map.put("status_code", StatusCode.CORRECT.getStatusCode());
				} catch (Exception e) {
					map.put("msg", Message.MODIFYFAIL.getMsg());
					map.put("status_code", StatusCode.ERROR.getStatusCode());
				}
			}
		} catch (Exception e) {
			map.put("status_code", StatusCode.ERROR.getStatusCode());
			map.put("msg", Message.FAIL.getMsg());
			return JSON.toJSONString(map);
		}
		return JSON.toJSONString(map);
	}
	
	/**
	 * 删除角色
	 * @param role 角色信息
	 */
	@RequestMapping("/delete/{id}")
	@ResponseBody
	public String delete(@PathVariable("id") String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		Role t = new Role();
		t.setId(id);
		try {
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
	 * 角色列表
	 * @author sunyh
	 */
	@RequestMapping("/list")
	@ResponseBody
	public String list(String conditionJson) throws UnsupportedEncodingException {
		// 获取分页及排序相关信息
		int page = Integer.parseInt(request.getParameter("page"));// 当前页
		int rows = Integer.parseInt(request.getParameter("rows"));// 行数
		String orderString = request.getParameter("sidx");// 排序字段
		String orderBy = request.getParameter("sord");// 行数
		String params = request.getParameter("params");
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		Paramter param = new Paramter();
		// 设置排序
		Order order = new Order();
		order.setClumn(orderString);
		if (orderBy.equals("desc")) {
			order.setFalg(1);
		} else {
			order.setFalg(2);
		}
		param.addOrder(order);
		
		//查询条件
		String likeSql=" ";
		String name= request.getParameter("name");
		if(name!=null){
			name= URLDecoder.decode(name,"UTF-8");
			likeSql+=" and name like '%"+name+"%' ";
		}
		if(params!=null && !params.equals("()") && !params.equals("null") &&  !params.equals("")){
			likeSql+=" and id  not in  "+params;
		}
		param.setAndSql(likeSql);
		
		// 查询数据
		PageTion data = service.listByPage(page, rows, param);
		// 设置页面展示相关信息
		map.put("total", data.getTotal());// 总页数
		map.put("rows", data.getList());// 总行数
		map.put("page", data.getPageNo());// 第几页
		map.put("rowNum", data.getPageSize());// 第几页
		map.put("records", data.getNum());//总条数
		json = JSON.toJSONString(map);
		return json;
	}

	/**
	 * 获取下拉框数据
	 */
	@RequestMapping("/getSelectData.do")
	@ResponseBody
	public String getSelectData() {
		try {
			List<Role> pList = null;
			String returnValue = "<option value=''>&nbsp;</option>";
			pList = service.queryByCondition("", "");
			for (int i = 0; i < pList.size(); i++) {
				returnValue += "<option value='" + pList.get(i).getId() + "'>"
						+ pList.get(i).getName() + "</option> ";
			}
			return returnValue;
		} catch (Exception e) {
			return "<option value=''>&nbsp;</option>";
		}
	}
}
