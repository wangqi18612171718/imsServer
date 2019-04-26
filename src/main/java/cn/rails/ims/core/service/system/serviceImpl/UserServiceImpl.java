package cn.rails.ims.core.service.system.serviceImpl;

import java.io.Serializable;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.rails.ims.core.dao.system.PositionDao;
import cn.rails.ims.core.dao.system.UserDao;
import cn.rails.ims.core.dao.system.UserPositionDao;
import cn.rails.ims.core.entity.Position;
import cn.rails.ims.core.entity.Role;
import cn.rails.ims.core.entity.User;
import cn.rails.ims.core.entity.UserPosition;
import cn.rails.ims.core.entity.UserRole;
import cn.rails.ims.core.service.system.RoleService;
import cn.rails.ims.core.service.system.UserRoleService;
import cn.rails.ims.core.service.system.UserService;
import cn.rails.ims.utils.page.PageTion;
import cn.rails.ims.utils.page.Paramter;

/**
 * @author       : wangqi
 * @date         ：2017-03-22
 */
@Service
@Transactional
public class UserServiceImpl implements UserService{
	@Autowired
	private UserDao dao ;
	@Autowired
	private UserPositionDao userPositionDao ;
	@Autowired
	private PositionDao positionDao ;
	@Autowired
	private RoleService roleService;
	@Autowired 
	private UserRoleService userRoleService;
	public void delete(User t) {
		dao.delete(t);
	}

	public List<User> list() {
		return null;
	}

	public PageTion listByPage(int pageNo, int pageSize, Paramter par) {
		PageTion pageTion = dao.listByPage(pageNo, pageSize, par);
		for(User user:(List<User>)pageTion.getList()){
			List<UserPosition> userPositions = userPositionDao.queryByCondition("userId", user.getId());
			if(userPositions != null && userPositions.size()>0){
				String positionIds = "";
				String positionNames = "";
				for(UserPosition userPosition:userPositions){
					String positionId = userPosition.getPositionId();
					List<Position> positions = positionDao.queryByCondition("id", positionId);
					if(positions != null && positions.size()>0){
						positionIds += positionId +",";
						positionNames += positions.get(0).getName() + ",";
					}
				}
				if(!positionNames.equals("")){
					positionNames = positionNames.substring(0,positionNames.length()-1);
					user.setPositionId(positionIds);
					user.setPositionName(positionNames);
				}
			}
			List<UserRole> userRoles = userRoleService.queryByCondition("userId", user.getId());
			if(userRoles != null && userRoles.size()>0){
				String roleIds = "";
				String roleNames = "";
				for(UserRole userRole:userRoles){
					String roleId = userRole.getRoleId();
					List<Role> roles = roleService.queryByCondition("id", roleId);
					if(roles != null & roles.size()>0){
						roleIds += roleId +",";
						roleNames += roles.get(0).getName()+",";
					}
				}
				if(!roleNames.equals("")){
					roleNames = roleNames.substring(0, roleNames.length()-1);
					user.setRoleId(roleIds);
					user.setRoleName(roleNames);
				}
			}
		}
		return pageTion;
	}

	public User queryById(Serializable id) {
		return dao.queryById(id);
	}

	public void save(User t) {
		dao.save(t);
	}

	public void deleteByCondition(String key, Object value) {
		dao.deleteByCondition(key, value);
	}

	public void update(User t) {
		dao.update(t);
	}

	public void updateUser(User t) {
		dao.updateUser(t);
	}

	
	public User queryUser(String name,String pwd){
		return dao.queryUser(name, pwd);
	}
	
	//获取下拉数据
	public List<User> getSelectData(String key, String value){
		return dao.getSelectData(key, value);
	}

	@Override
	public List<User> listByDeptId(Paramter par) {
		// TODO Auto-generated method stub
		return dao.listByDeptId(par);
	}

	@Override
	public List<User> queryByCondition(User t) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<User> queryByCondition(String key, String value) {
		// TODO Auto-generated method stub
		return null;
	}

}
