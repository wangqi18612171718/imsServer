package cn.rails.ims.core.dao.system.daoImpl;

import org.springframework.stereotype.Repository;

import cn.rails.ims.base.HibernateBaseDao;
import cn.rails.ims.core.dao.system.RoleDao;
import cn.rails.ims.core.entity.Role;

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

@Repository
public class RoleDaoImpl extends HibernateBaseDao<Role> implements RoleDao {

	@Override
	public Class<Role> getEntityClass() {
		return Role.class;
	}
}
