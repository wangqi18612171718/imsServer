package cn.rails.ims.core.dao.system;

import java.util.List;

import cn.rails.ims.base.IBaseDao;
import cn.rails.ims.core.entity.Permission;

/**
 * @author wl
 * @date 2017年3月22日
 * @description 权限
 */
public interface PermissionDao extends IBaseDao<Permission>{
	/**
	 * 根据人员ID获取菜单列表
	 * @author sunyh
	 */
	List<Permission> getMenuListByUserId(String userId,String parentId);
}
