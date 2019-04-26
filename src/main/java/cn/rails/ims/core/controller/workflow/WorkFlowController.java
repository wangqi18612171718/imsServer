package cn.rails.ims.core.controller.workflow;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.rails.ims.core.service.workflow.WorkFlowService;
import cn.rails.ims.utils.workflow.WorkFlowException;

/**
 * <p>Title      : 中国铁道科学研究院[]</p>
 * <p>Description: [部门管理]</p>
 * <p>Copyright  : Copyright (c) 2017</p>
 * <p>Company    : 铁科院电子所</p>
 * <p>Department : 信息中心</p>
 * @author       : sunyh
 * @version      : 1.0
 * @date         ：2017-02-16
 */

@Controller
@RequestMapping(value="/test", produces = "text/html;charset=UTF-8")
public class WorkFlowController {
	@Autowired
	private WorkFlowService workFlowService;
	@Autowired
	private HttpServletRequest request;
	@Autowired
	private HttpSession httpSession;
	//测试流程发起
	@RequestMapping("/testStart.do")
	@ResponseBody
	public String testStart() {
		String result="";
		try {
			result=workFlowService.StartWorkflowWithXmlData("VPSVirtualServer", "bailinyan", false, "", "");
			System.out.println(result);
		} catch (WorkFlowException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	@RequestMapping("/testSubmit.do")
	@ResponseBody
	public String testSubmit() {
		String result="";
		try {
			String workItemIds=workFlowService.getWorkItem("", "10", "1", "VPSVirtualServer", "", "");
			System.out.println(workItemIds);
		} catch (WorkFlowException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
}
