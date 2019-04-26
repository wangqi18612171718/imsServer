//package cn.rails.ims.core.dao.system.daoImpl;
//
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//import org.hibernate.Query;
//import org.hibernate.Session;
//import org.springframework.stereotype.Repository;
//
//import cn.rails.ims.base.HibernateBaseDao;
//import cn.rails.ims.core.dao.system.UserDepartmentDao;
//import cn.rails.ims.core.entity.UserDepartment;
//import cn.rails.ims.utils.page.Order;
//import cn.rails.ims.utils.page.PageTion;
//import cn.rails.ims.utils.page.Paramter;
///**
// * <p>Title      : 中国铁道科学研究院[]</p>
// * <p>Description: [人员部门管理]</p>
// * <p>Copyright  : Copyright (c) 2017</p>
// * <p>Company    : 铁科院电子所</p>
// * <p>Department : 信息中心</p>
// * @author       : sunyh
// * @version      : 1.0
// * @date         ：2017-02-16
// */
//@Repository
//public class UserDepartmentDaoImpl extends HibernateBaseDao<UserDepartment> implements UserDepartmentDao {
//	@Override
//	public Class<UserDepartment> getEntityClass() {
//		return UserDepartment.class;
//	}
//
//	@Override
//	public PageTion listByPage(int pageNo,int pageSize ,Paramter par){
//		//获取session
//		Session session = getSession();
//		//得到表名称
//		String hql ="from UserDepartment a  where 1=1 ";
//		//插入参数集合
//		Map<String,Object> map = new HashMap<String, Object>();
//		if(par!=null){
//			 map = par.getMap();
//			 //设置参数
//			 for(Map.Entry<String, Object> en:map.entrySet()){
//				 hql+=" and "+en.getKey()+"=:"+en.getKey();
//			 }
//			 //是否判断日期
//			 if(par.getBtweenAnd()!=null){
//				 hql+=par.getBtweenAnd();
//			 }
//			//and sql 语句
//			 if(par.getAndSql()!=null){
//				 hql+=par.getAndSql();
//			 }
//			 //是否排序
//			 List<Order> orders = par.getOrders();
//			 if(orders.size()>0){
//				 hql += " order by ";
//				 for(Order order :orders){
//					 if(order.getFalg()== 1){
//						 hql+=" a."+order.getClumn()+" desc,";
//					 }else{
//						 hql+=" a."+order.getClumn()+",";
//					 }
//				 }
//				 hql =  hql.substring(0, hql.lastIndexOf(","));
//				 hql+=" ,a.users.sort ";
//			 }
//
//		}
//		//创建查询
//		String count = "select count(*) "+hql;
//		hql = "select new UserDepartment (a.gid,a.departmentId,a.userId,a.users,a.department) " + hql;
//		Query query = session.createQuery(hql);
//		Query countQuery = session.createQuery(count);
//		//插叙结果
//		for(Map.Entry<String, Object> en:map.entrySet()){
//			query.setParameter(en.getKey(), en.getValue());
//			countQuery.setParameter(en.getKey(), en.getValue());
//		}
//
//		//分页
//		query.setFirstResult((pageNo-1)*pageSize).setMaxResults(pageSize);
//		//结果总数
//		long lon = 	(Long) countQuery.uniqueResult();
//		int total =(int) lon;
//		@SuppressWarnings("unchecked")
//		List<UserDepartment> list = query.list();
//		return new PageTion(pageNo, pageSize, list, total);
//	}
//
//	@Override
//	public void saveOrUpdate(UserDepartment t) {
//		super.saveOrUpdate(t);
//	}
//
//	@Override
//	public void update(UserDepartment t) {
//		getSession().update(t);
//	}
//	//更新人员部门表中数据
//	@Override
//	public void updateByUserId(String userId, String departmentId) {
//		String sql="UPDATE XT_USER_DEPARTMENT SET DEPARTMENT_ID='"+departmentId+"' where USER_ID='"+userId+"'";
//		getSession().createSQLQuery(sql).executeUpdate();
//	}
//	//删除人员部门表中的数据
//	@Override
//	public void deleteByUserId(String userId) {
//		String sql="DELETE FROM XT_USER_DEPARTMENT WHERE USER_ID='"+userId+"'";
//		getSession().createSQLQuery(sql).executeUpdate();
//	}
//	//根据人员ID获取人员部门表的数据
//	@SuppressWarnings("unchecked")
//	@Override
//	public UserDepartment getDepartmentIdByUserId(String userId) {
//		String hql = " from UserDepartment a where a.userId=?";
//		List<UserDepartment> list  = getSession().createQuery(hql).setParameter(0, userId).list();
//		UserDepartment ud = new UserDepartment();
//		if(list.size()>0){
//			ud = list.get(0);
//		}
//		return ud;
//	}
//}
