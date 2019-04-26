package cn.rails.ims.core.service.system.serviceImpl;
import java.io.Serializable;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.rails.ims.core.dao.system.PositionDepartmentDao;
import cn.rails.ims.core.dao.system.UserDepartmentDao;
import cn.rails.ims.core.entity.PositionDepartment;
import cn.rails.ims.core.entity.UserDepartment;
import cn.rails.ims.core.service.system.PositionDepartmentService;
import cn.rails.ims.core.service.system.UserDepartmentService;
import cn.rails.ims.utils.page.PageTion;
import cn.rails.ims.utils.page.Paramter;

@Service
@Transactional
public class PositionDepartmentServiceImpl implements PositionDepartmentService{
	@Autowired
	private PositionDepartmentDao dao ;
	public void delete(PositionDepartment t) {
		dao.delete(t);
	}

	public PageTion listByPage(int pageNo, int pageSize, Paramter par) {
		return dao.listByPage(pageNo, pageSize, par);
	}

	public void save(PositionDepartment t) {
		dao.save(t);
	}

	public void update(PositionDepartment t) {
		dao.update(t);
	}

	@Override
	public List<PositionDepartment> list() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public PositionDepartment queryById(Serializable id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<PositionDepartment> queryByCondition(PositionDepartment t) {
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
	public PositionDepartment getDepartmentIdByUserId(String positionId) {
		// TODO Auto-generated method stub
		return dao.getDepartmentIdByUserId(positionId);
	}

}
