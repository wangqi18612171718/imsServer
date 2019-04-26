package cn.rails.ims.core.service.system;

import java.util.List;

import cn.rails.ims.base.IBaseService;
import cn.rails.ims.core.entity.Permission;

/**
 * @author wangqi
 * @date 2017年3月22日
 * @description 权限
 */
public interface PermissionService extends IBaseService<Permission>{

	/**
	 * 根据人员ID获取菜单列表
	 * @author sunyh
	 */
	List<Permission> getMenuListByUserId(String userId,String parentId);
	void saveOrUpdate(Permission t);
	List<Permission> queryByCondition(String key,Object value);
}
