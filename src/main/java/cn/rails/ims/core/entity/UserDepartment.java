package cn.rails.ims.core.entity;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity; 
import javax.persistence.Id; 
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;
/**
 * <p>Title      : 中国铁道科学研究院[]</p>
 * <p>Description: [人员部门]</p>
 * <p>Copyright  : Copyright (c) 2017</p>
 * <p>Company    : 铁科院电子所</p>
 * <p>Department : 信息中心</p>
 * @author       : sunyh
 * @version      : 1.0
 * @date         ：2017-02-16
 */
@Entity
@Table(name = "XT_user_department")
public class UserDepartment implements java.io.Serializable {
 
	private static final long serialVersionUID = 1L;
	/**
	 * Id
	 */
	private String gid;
	/**
	 * 人员ID
	 */
	private String userId; 
	/**
	 * 部门Id
	 */
	private String departmentId; 
	/**
	 * 人员
	 */
	private User users;
	/**
	 * 部门
	 */
	private Department department;
 
	public UserDepartment() {
		super();
	}
	
	public UserDepartment(String gid,String departmentId,String userId,User users,Department department) {
		this.gid = gid;
		this.departmentId = departmentId;
		this.userId=userId;
		this.users = users;
		this.department = department;
	}
	
	
	
	@Id
	@Column(name = "gid")
	public String getGid() {
		return this.gid;
	} 
	public void setGid(String gid) {
		this.gid = gid;
	}

	@Column(name="USER_ID")
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}

	@Column(name="DEPARTMENT_ID")
	public String getDepartmentId() {
		return departmentId;
	}
	public void setDepartmentId(String departmentId) {
		this.departmentId = departmentId;
	}
	
	@OneToOne(cascade=CascadeType.ALL)
	@JoinColumn(name="USER_ID",insertable=false,updatable=false)
	@NotFound(action=NotFoundAction.IGNORE)
	public User getUsers() {
		return users;
	}
	public void setUsers(User users) {
		this.users = users;
	}
	
	@OneToOne(cascade=CascadeType.ALL)
	@JoinColumn(name="DEPARTMENT_ID",insertable=false,updatable=false)
	@NotFound(action=NotFoundAction.IGNORE)
	public Department getDepartment() {
		return department;
	}
	public void setDepartment(Department department) {
		this.department = department;
	}
	
}