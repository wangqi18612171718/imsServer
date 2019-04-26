package cn.rails.ims.core.service.system;

import java.util.List;

import cn.rails.ims.base.IBaseService;
import cn.rails.ims.core.entity.RolePermission;
/**
 * @author wl
 * @date 2017年3月23日
 * @description 角色权限
 */
public interface RolePermissionService extends IBaseService<RolePermission>{
	public List<RolePermission> queryByCondition(String key, Object value);
	public void deleteByCondition(String key,Object value);
}
