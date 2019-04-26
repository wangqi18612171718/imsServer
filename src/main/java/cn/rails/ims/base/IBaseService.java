package cn.rails.ims.base;

import java.io.Serializable;
import java.util.List;

import cn.rails.ims.utils.page.PageTion;
import cn.rails.ims.utils.page.Paramter;

public interface IBaseService<T> {
		/**
		 * 分页查询
		 * @param pageNo
		 * @param pageSize
		 * @param par
		 */
		PageTion listByPage(int pageNo,int pageSize ,Paramter par);
		
		/**
		 * 模糊分页查询
		 * @param pageNo
		 * @param pageSize
		 * @param par
		 *//*
		PageTion listByPageByLike(int pageNo,int pageSize ,Paramter par);*/
		/**
		 * 查询所有
		 */
		List<T> list();
		/**
		 * 保存
		 * @param t
		 */
		void save(T t);
		/**
		 * 更新
		 * @param t
		 */
		void update(T t);
		/**
		 * 删除
		 * @param t
		 */
		void delete(T t);
		/**
		 * 根据id进行查询
		 * @param id
		 */
		T queryById(Serializable id);
		/**
		 * 按条件查询，如果条件不为null，那么就根据条件查询，但是不包括id字段
		 * @param t
		 */
		List<T> queryByCondition(T t);

}
