package cn.rails.ims.core.service.system.serviceImpl;
import java.io.Serializable;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.rails.ims.core.dao.system.UserDepartmentDao;
import cn.rails.ims.core.entity.UserDepartment;
import cn.rails.ims.core.service.system.UserDepartmentService;
import cn.rails.ims.utils.page.PageTion;
import cn.rails.ims.utils.page.Paramter;
/**
 * <p>Title      : 中国铁道科学研究院[]</p>
 * <p>Description: [人员部门管理]</p>
 * <p>Copyright  : Copyright (c) 2017</p>
 * <p>Company    : 铁科院电子所</p>
 * <p>Department : 信息中心</p>
 * @author       : sunyh
 * @version      : 1.0
 * @date         ：2017-02-16
 */
@Service
@Transactional
public class UserDepartmentServiceImpl implements UserDepartmentService{
	@Autowired
	private UserDepartmentDao dao ;
	public void delete(UserDepartment t) {
		dao.delete(t);
	}

	public PageTion listByPage(int pageNo, int pageSize, Paramter par) {
		return dao.listByPage(pageNo, pageSize, par);
	}

	public void save(UserDepartment t) {
		dao.save(t);
	}

	public void update(UserDepartment t) {
		dao.update(t);
	}

	@Override
	public List<UserDepartment> list() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public UserDepartment queryById(Serializable id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<UserDepartment> queryByCondition(UserDepartment t) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateByUserId(String userId, String departmentId) {
		dao.updateByUserId(userId,departmentId);
	}

	@Override
	public void deleteByUserId(String userId) {
		dao.deleteByUserId(userId);
	}

	@Override
	public UserDepartment getDepartmentIdByUserId(String userId) {
		// TODO Auto-generated method stub
		return dao.getDepartmentIdByUserId(userId);
	}

}
