package cn.slkj.sloa.service.impl;

/**
 * 派工登记 serviceImpl
 * 
 * @author xiaotianliang
 *
 */
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;

import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;

import cn.slkj.hbsl.util.ExportUtil;
import cn.slkj.sloa.entity.shfw.Dispatch;
import cn.slkj.sloa.entity.stock.Sim;
import cn.slkj.sloa.mapper.DispatchMapper;
import cn.slkj.sloa.service.DispatchService;

@Repository
public class DispatchServiceImpl implements DispatchService {
	@Autowired
	private DispatchMapper mapper;

	@Override
	public List<Dispatch> getAll(HashMap<String, Object> map,
			PageBounds pageBounds) {
		return mapper.getAll(map, pageBounds);
	}

	@Override
	public int insert(Dispatch dispatch) {
		return mapper.insert(dispatch);
	}

	@Override
	public int delete(String id) {
		return mapper.delete(id);
	}

	@Override
	public Dispatch queryOne(Map<String, Object> map) {
		return mapper.queryOne(map);
	}
	
	public void exportExcel(HashMap<String, Object> map, String[] titles, ServletOutputStream outputStream) {
		List<Dispatch> list = mapper.getAll(map,null);
		// 创建一个workbook 对应一个excel应用文件
		XSSFWorkbook workBook = new XSSFWorkbook();
		// 在workbook中添加一个sheet,对应Excel文件中的sheet
		XSSFSheet sheet = workBook.createSheet("派检单汇总");
		ExportUtil exportUtil = new ExportUtil(workBook, sheet);
		XSSFCellStyle headStyle = exportUtil.getHeadStyle();
		XSSFCellStyle bodyStyle = exportUtil.getBodyStyle();
		// 构建表头
		XSSFRow headRow = sheet.createRow(0);
		XSSFCell cell = null;
		for (int i = 0; i < titles.length; i++) {
			cell = headRow.createCell(i);
			cell.setCellStyle(headStyle);
			cell.setCellValue(titles[i]);
		}
		// 构建表体数据
		if (list != null && list.size() > 0) {
			for (int j = 0; j < list.size(); j++) {
				XSSFRow bodyRow = sheet.createRow(j + 1);
				Dispatch dispatch = list.get(j);
				// 类型
				cell = bodyRow.createCell(0);
				cell.setCellStyle(bodyStyle);
				int type = dispatch.getType();
				switch (type) {
				case 0:
					cell.setCellValue("新装");
					break;
				case 1:
					cell.setCellValue("维修");
					break;
				case 2:
					cell.setCellValue("转网");
					break;
				}

				// 维修状态
				cell = bodyRow.createCell(1);
				cell.setCellStyle(bodyStyle);
				int outcome = dispatch.getOutcome();
				switch (outcome) {
				case 0:
					cell.setCellValue("待维修");
					break;
				case 1:
					cell.setCellValue("已维修");
					break;
				}
				// 派工单号
				cell = bodyRow.createCell(2);
				cell.setCellStyle(bodyStyle);				
				cell.setCellValue(dispatch.getDispatchNum());
				// 派修员
				cell = bodyRow.createCell(3);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(dispatch.getOperator());
				// 派检时间
				cell = bodyRow.createCell(4);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(dispatch.getRepairTime());
				// 维修员
				cell = bodyRow.createCell(5);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(dispatch.getPersonnelName());
				// 维修员电话
				cell = bodyRow.createCell(6);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(dispatch.getPersonnelPhone());
				// 车牌号
				cell = bodyRow.createCell(7);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(dispatch.getCarNumber());
				// 设备ID
				cell = bodyRow.createCell(8);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(dispatch.getDeviceId());
				// 卡号
				cell = bodyRow.createCell(9);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(dispatch.getSim());
				// 业户姓名
				cell = bodyRow.createCell(10);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(dispatch.getOwner());
				// 联系电话
				cell = bodyRow.createCell(11);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(dispatch.getTelephone());
				// 原因
				cell = bodyRow.createCell(12);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(dispatch.getCauses());
				// 收费
				cell = bodyRow.createCell(13);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(dispatch.getContact());
				
			}
		}
		try {
			workBook.write(outputStream);
			outputStream.flush();
			outputStream.close();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				outputStream.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

	}

}
