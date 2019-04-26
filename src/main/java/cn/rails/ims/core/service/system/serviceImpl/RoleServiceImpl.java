package cn.rails.ims.core.service.system.serviceImpl;

import java.io.Serializable;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.rails.ims.core.dao.system.RoleDao;
import cn.rails.ims.core.entity.Role;
import cn.rails.ims.core.service.system.RoleService;
import cn.rails.ims.utils.page.PageTion;
import cn.rails.ims.utils.page.Paramter;

/**
 * <p>Title      : 中国铁道科学研究院[]</p>
 * <p>Description: [菜单管理]</p>
 * <p>Copyright  : Copyright (c) 2017</p>
 * <p>Company    : 铁科院电子所</p>
 * <p>Department : 信息中心</p>
 * @author       : sunyh
 * @version      : 1.0
 * @date         ：2017-02-16
 */
@Service
@Transactional
public class RoleServiceImpl implements RoleService {
	@Autowired
	private RoleDao dao;

	public PageTion listByPage(int pageNo, int pageSize, Paramter par) {
		return dao.listByPage(pageNo, pageSize, par);
	}

	public List<Role> list() {
		return dao.list();
	}

	public void save(Role t) {
		dao.save(t);
	}

	public void update(Role t) {
		dao.update(t);
	}

	public void delete(Role t) {
		dao.delete(t);
	}

	public Role queryById(Serializable id) {
		return dao.queryById(id);
	}

	public List<Role> queryByCondition(Role t) {
		return dao.queryByCondition(t);
	}

	public void saveOrUpdate(Role t) {
		// TODO Auto-generated method stub

	}

	@Override
	public List<Role> queryByCondition(String key, Object value) {
		return dao.queryByCondition(key, value);
	}

}
