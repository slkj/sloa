package cn.slkj.sloa.controller.vehicle;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.slkj.hbsl.util.Const;
import cn.slkj.sloa.controller.system.base.BaseController;
import cn.slkj.sloa.entity.system.User;
import cn.slkj.sloa.entity.vehicle.Insurance;
import cn.slkj.sloa.entity.vehicle.Transfer;
import cn.slkj.sloa.service.TransferService;
import cn.slkj.sloa.util.easyuiUtil.EPager;
import cn.slkj.sloa.util.easyuiUtil.JsonResult;

import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;

/**
 * 
 * @ClassName: TransferController
 * @Description: 异动业务
 * @author wangling
 * @date 2017年5月4日下午5:16:12
 */
@Controller
@RequestMapping(value = "/transfer")
public class TransferController extends BaseController {
	@Resource
	private TransferService transferService;
	/* 跳转列表页面 */
	@RequestMapping("/transferList")
	public String toListPage() {
		return "vehicle/transfer/transferList";
	}
	/* 跳转添加页面 */
	@RequestMapping("/transferAdd")
	public String toAddPage() {
		return "vehicle/transfer/transferAdd";
	}
	
	/**
	 * 查询车辆列表，返回easyUI数据格式
	 */
	@ResponseBody
	@RequestMapping(value = "/list", method = { RequestMethod.POST })
	public EPager<Transfer> getList(HttpServletRequest request, HttpSession session, @RequestParam(required = false, defaultValue = "1") Integer page, // 第几页
			@RequestParam(required = false, defaultValue = "15") Integer rows) {
		String sortString = "riqi.desc";
		String carNumber = request.getParameter("carNumber");
		String transferType = request.getParameter("transferType");
		String endDate1 = request.getParameter("endDate1");
		String endDate2 = request.getParameter("endDate2");
		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		hashMap.put("carNumber", carNumber);
		hashMap.put("transferType", transferType);
		hashMap.put("endDate1", endDate1);
		hashMap.put("endDate2", endDate2);
		User u = (User) session.getAttribute(Const.SESSION_USER);
		String depId = u.getDepartcode();
		hashMap.put("depId", depId);
		PageBounds pageBounds = new PageBounds(page, rows, Order.formString(sortString));
		List<Transfer> list = transferService.getList(hashMap, pageBounds);
		PageList pageList = (PageList) list;
		return new EPager<Transfer>(pageList.getPaginator().getTotalCount(), list);
	}
	/**
	 * 查询单条信息
	 */
	@ResponseBody
	@RequestMapping(value = "/queryOne", method = { RequestMethod.POST })
	public Transfer queryOne(String id) {
		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		hashMap.put("id", id);
		Transfer transfer = transferService.queryOne(hashMap);
		return transfer;
	}
	
	/**
	 * 保存车辆信息
	 * @param vehicle
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public JsonResult save(Transfer transfer) {
		try {
			int i = -1;
			
				transfer.setId(this.get32UUID());
				i = transferService.save(transfer);
			
			if (i != -1) {
				return new JsonResult(true, "添加成功。");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new JsonResult(false, "系统异常，添加失败！");
		}
		return new JsonResult(false, "添加失败！");
	}

	/**
	 * 编辑车辆信息
	 * @param vehicle
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public JsonResult editInsurance(Transfer transfer) {
		try {
			int i = -1;
			i = transferService.edit(transfer);
			if (i != -1) {
				
				return new JsonResult(true, "操作成功。");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new JsonResult(false, "操作异常！");
		}
		return new JsonResult(false, "操作失败！");
	}

	/**
	 * 删除车辆信息
	 * 
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/delete")
	public JsonResult deletes(String id) {
		int i = transferService.delete(id);
		try {
			if (i > 0) {
				return new JsonResult(true, "删除成功。");
			} else {
				return new JsonResult(false, "删除失败。");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new JsonResult(false, "操作异常。");
		}
	}
}
