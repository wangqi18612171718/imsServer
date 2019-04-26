package cn.rails.ims.core.service.system.serviceImpl;
import java.io.Serializable;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.rails.ims.core.dao.system.UserRoleDao;
import cn.rails.ims.core.entity.UserRole;
import cn.rails.ims.core.service.system.UserRoleService;
import cn.rails.ims.utils.page.PageTion;
import cn.rails.ims.utils.page.Paramter;

/**
 * <p>Title      : 中国铁道科学研究院[]</p>
 * <p>Description: [人员角色管理]</p>
 * <p>Copyright  : Copyright (c) 2017</p>
 * <p>Company    : 铁科院电子所</p>
 * <p>Department : 信息中心</p>
 * @author       : sunyh
 * @version      : 1.0
 * @date         ：2017-02-16
 */

@Service
@Transactional
public class UserRoleServiceImpl implements UserRoleService{
	@Autowired
	private UserRoleDao dao ;
	public void delete(UserRole t) {
		dao.delete(t);
	}

	public PageTion listByPage(int pageNo, int pageSize, Paramter par) {
		return dao.listByPage(pageNo, pageSize, par);
	}

	public void save(UserRole t) {
		dao.save(t);
	}

	public void update(UserRole t) {
		dao.update(t);
	}
	@Override
	public void updateByUserId(String userId, String roleId) {
		dao.updateByUserId(userId,roleId);
	}

	@Override
	public void deleteByUserId(String userId) {
		dao.deleteByUserId(userId);
	}

	@Override
	public List<UserRole> getUserRoleByUserId(String userId) {
		// TODO Auto-generated method stub
		return dao.getUserRoleByUserId(userId);// getDepartmentIdByUserId(userId);
	}

	@Override
	public List<UserRole> list() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public UserRole queryById(Serializable id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<UserRole> queryByCondition(UserRole t) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public List<UserRole> queryByCondition(String key, Object value) {
		return dao.queryByCondition(key, value);
	}

}
