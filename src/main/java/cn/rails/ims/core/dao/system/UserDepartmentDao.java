package cn.rails.ims.core.dao.system;
import cn.rails.ims.base.IBaseDao;
import cn.rails.ims.core.entity.UserDepartment;
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
public interface UserDepartmentDao extends IBaseDao<UserDepartment>{
	/**
	 * 保存或更新
	 */
	public void saveOrUpdate(UserDepartment t);
	
	public void updateByUserId(String userId,String departmentId);
	
	public void deleteByUserId(String userId);
	//根据人员ID获取部门ID
	public UserDepartment getDepartmentIdByUserId(String userId);
}
