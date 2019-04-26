package cn.rails.ims.core.service.system;

import java.util.List;

import cn.rails.ims.base.IBaseService;
import cn.rails.ims.core.entity.Role;

/**
 * 
 * @author hzx
 * @date 2017年3月23日
 * @description 角色业务层
 */
public interface RoleService extends IBaseService<Role> {
	public List<Role> queryByCondition(String key, Object value);
}
