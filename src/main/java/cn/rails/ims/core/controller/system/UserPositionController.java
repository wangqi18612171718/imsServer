package cn.rails.ims.core.controller.system;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.rails.ims.core.entity.UserPosition;
import cn.rails.ims.core.service.system.UserPositionService;
import cn.rails.ims.utils.Common;
import cn.rails.ims.utils.UUIDHexGenerator;

import com.alibaba.fastjson.JSON;
/**
 * @author       : wangqi
 * @date         ：2017-03-24
 * @description  ：用户岗位
 */
@RequestMapping(value ="/userPosition",produces="text/html;charset=UTF-8")
@Controller
public class UserPositionController{
	
	@Autowired
	private UserPositionService userPositionService;
	@Autowired
	private HttpServletRequest request;
	@Autowired
	private HttpSession httpSession;
	
	/**
	 * 用户信息保存
	 * @param users 人员信息
	 */
	@RequestMapping("/save")
	@ResponseBody
	public String save() {
		Map<String, Object> map = new HashMap<String, Object>();
		try { 
			String userId = request.getParameter("userId");
			String positionIds = request.getParameter("positionIds");
			String[] poIds = positionIds.split(",");
			userPositionService.deleteUserPositionByUserId(userId);
			for(String positionId:poIds){
				UserPosition userPosition = new UserPosition();
				userPosition.setId(UUIDHexGenerator.getUUID());
				userPosition.setUserId(userId);
				userPosition.setPositionId(positionId);
				userPositionService.save(userPosition);
			}
			map = Common.getTipMsg("save", 1);
		} catch (Exception e) {
			return JSON.toJSONString(Common.getTipMsg("ex", 2));
		}
		return JSON.toJSONString(map);
	}
	
	/**
	 * 用户岗位信息
	 * @param userPosition 
	 */
	@RequestMapping("/delete/{id}")
	@ResponseBody
	public String deleteby(@PathVariable("id")String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		UserPosition userPosition = new UserPosition();
		try {
			userPosition.setId(id);
			//删除人员表中相关信息
			userPositionService.delete(userPosition);
			map = Common.getTipMsg("delete", 0);
		} catch (Exception e) {
			map = Common.getTipMsg("delete", 1);
		}
		return JSON.toJSONString(map);
	}
}
