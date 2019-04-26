package cn.rails.ims.core.dao.system;

import java.util.List;

import cn.rails.ims.base.IBaseDao;
import cn.rails.ims.core.entity.User;
import cn.rails.ims.utils.page.PageTion;
import cn.rails.ims.utils.page.Paramter;
/**
 * @author       : wangqi
 * @date         ：2017-03-22
 */
public interface UserDao extends IBaseDao<User>{
	public int checkLogin(String name,String pwd);
	public User queryUser(String name,String pwd);
	public void updateUser(User t) ;
	/**
	 * 保存或更新
	 */
	public void saveOrUpdate(User t);
	/**
	 * 按条件删除
	 */
	public void deleteByCondition(String key,Object value);
	
	/**
	 * 获取下拉列表
	 * @param gid
	 * @return
	 */
	public List<User> getSelectData(String key, String value);
	//根据部门ID过滤
	public List<User> listByDeptId(Paramter par);
	
	public PageTion listByPage(int pageNo, int pageSize, Paramter par);
}
