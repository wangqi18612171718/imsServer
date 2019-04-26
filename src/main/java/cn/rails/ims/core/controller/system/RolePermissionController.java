package cn.rails.ims.core.controller.system;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.rails.ims.core.entity.RolePermission;
import cn.rails.ims.core.service.system.RolePermissionService;
import cn.rails.ims.utils.UUIDHexGenerator;
import cn.rails.ims.utils.Constant.Message;
import cn.rails.ims.utils.Constant.StatusCode;

import com.alibaba.fastjson.JSON;

/**
 * @author wl
 * @date 2017年3月23日
 * @description 角色权限
 */
@Controller
@RequestMapping(value = "/rolePermission", produces = "text/html;charset=UTF-8")
public class RolePermissionController {
	@Autowired
	private RolePermissionService service;
	@Autowired
	private HttpServletRequest request;

	/**
	 * 保存角色菜单
	 * @param role 角色信息
	 */
	@RequestMapping("/saveRolePermission/{id}/{permissionId}")
	@ResponseBody
	public String saveRolePermission(@PathVariable("permissionId") String permissionId,@PathVariable("id") String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			service.deleteByCondition("roleId", id);
			for(int i=0;i<permissionId.split("@").length;i++){
				RolePermission rolePermission = new RolePermission();
				String privilegeId=permissionId.split("@")[i];
				rolePermission.setRoleId(id);
				rolePermission.setPermissionId(privilegeId);
				rolePermission.setId(UUIDHexGenerator.getUUID());
				service.save(rolePermission);
			}
			map.put("msg", Message.SUCCESS.getMsg());
			map.put("status_code", StatusCode.CORRECT.getStatusCode());
		} catch (Exception e) {
			map.put("msg", Message.FAIL.getMsg());
			map.put("status_code", StatusCode.ERROR.getStatusCode());
			return JSON.toJSONString(map);
		}
		return JSON.toJSONString(map);
	}
	/**
	 * 获取树节点信息
	 */
	@RequestMapping("/getSelectedStatus/{id}")
	@ResponseBody
	public String getSelectedStatus(@PathVariable("id") String id) {
		List<RolePermission> pList = null;
		String returnValue = "";
		pList = service.queryByCondition("roleId", id);
		for (int i = 0; i < pList.size(); i++) {
			returnValue += pList.get(i).getPermissionId() + "@";
		}
		return returnValue;
	}
}
