package cn.slkj.sloa.service.impl;

import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import cn.slkj.hbsl.util.ExportUtil;
import cn.slkj.hbsl.util.javaUtil.UUIDUtils;
import cn.slkj.sloa.entity.stock.Sim;
import cn.slkj.sloa.mapper.SimMapper;
import cn.slkj.sloa.service.SimService;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
@Repository
public class SimServiceImpl implements SimService {
	@Autowired
	private SimMapper mapper;

	@Override
	public List<Sim> getAll(Map<String, Object> map, PageBounds pageBounds) {
		return mapper.getAll(map, pageBounds);
	}

	@Override
	public List<Sim> getList(Map<String, Object> map) {
		return mapper.getList(map);
	}

	@Override
	public int insert(Sim sim) {
		return mapper.insert(sim);
	}

	@Override
	public int edit(Sim sim) {
		return mapper.edit(sim);
	}

	@Override
	public int editPay(Sim sim) {
		return mapper.editPay(sim);
	}

	@Override
	public int simPay(Sim sim) {
		return mapper.simPay(sim);
	}

	@Override
	public int deletes(String[] ids) {
		return mapper.deletes(ids);
	}

	@Override
	public List<Sim> simPaylist(Map<String, Object> pageMap, PageBounds pageBounds) {
		return mapper.simPaylist(pageMap, pageBounds);
	}

	@Override
	public int use(HashMap<String, Object> map) {
		return mapper.use(map);
	}

	@Override
	public int useByDevices(HashMap<String, Object> map) {
		return mapper.use(map);
	}

	@Override
	public int editByNum(Sim sim) {
		return mapper.editByNum(sim);
	}

	@Override
	public int revoke(HashMap<String, Object> map) {
		return mapper.revoke(map);
	}
	
	
	public void exportExcel(HashMap<String, Object> map, String[] titles, ServletOutputStream outputStream) {
		List<Sim> list = mapper.getList(map);
		// 创建一个workbook 对应一个excel应用文件
		XSSFWorkbook workBook = new XSSFWorkbook();
		// 在workbook中添加一个sheet,对应Excel文件中的sheet
		XSSFSheet sheet = workBook.createSheet("SIM卡汇总");
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
				Sim sim = list.get(j);
				// 出库状态
				cell = bodyRow.createCell(0);
				cell.setCellStyle(bodyStyle);
				int state = sim.getState();
				switch (state) {
				case 1:
					cell.setCellValue("已出库");
					break;
				case 2:
					cell.setCellValue("未出库");
					break;
				case 3:
					cell.setCellValue("退回");
					break;
				}

				// 使用状态
				cell = bodyRow.createCell(1);
				cell.setCellStyle(bodyStyle);
				int ustate = sim.getUstate();
				switch (ustate) {
				case 0:
					cell.setCellValue("未使用");
					break;
				case 1:
					cell.setCellValue("入网使用");
					break;
				}
				// 领用部门
				cell = bodyRow.createCell(2);
				cell.setCellStyle(bodyStyle);				
				cell.setCellValue(sim.getDepartmentName());
				// 运营商
				cell = bodyRow.createCell(3);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(sim.getCardType());
				// 卡号
				cell = bodyRow.createCell(4);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(sim.getTelnum());
				// 出库日期
				cell = bodyRow.createCell(5);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(sim.getOuttime());
				// 领用人
				cell = bodyRow.createCell(6);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(sim.getLyr());
				
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

	/**
	 * 读取xls文件内容
	 * 
	 * @return List<Devices>对象
	 * @throws IOException
	 *             输入/输出(i/o)异常
	 */
	public int readXls(InputStream is) throws IOException {
		HSSFWorkbook hssfWorkbook = new HSSFWorkbook(is);
		Sim sim = null;int num=0;
		List<Sim> list = new ArrayList<Sim>();
		// 循环工作表Sheet
		for (int numSheet = 0; numSheet < hssfWorkbook.getNumberOfSheets(); numSheet++) {
			HSSFSheet hssfSheet = hssfWorkbook.getSheetAt(numSheet);
			if (hssfSheet == null) {
				continue;
			}
			// 循环行Row
			for (int rowNum = 1; rowNum <= hssfSheet.getLastRowNum(); rowNum++) {
				HSSFRow hssfRow = hssfSheet.getRow(rowNum);
				if (hssfRow == null) {
					continue;
				}
				sim = new Sim();
				sim.setId(UUIDUtils.uuid());
				// 循环列Cell
				// 0卡号
				HSSFCell telnum = hssfRow.getCell(0);
				if (telnum == null) {
					continue;
				}
				sim.setTelnum(getCellFormatValue(telnum));
				// 1类型
				HSSFCell cardType = hssfRow.getCell(1);
				sim.setCardType(getCellFormatValue(cardType));
				// 2所属部门
				HSSFCell department = hssfRow.getCell(2);
				sim.setDepartment("5");
				//int count=mapper.getCountByTelnum(sim.getTelnum());
				//if(count<1){
				//list.add(sim);
					mapper.insertBatch(sim);
					num++;
				//}
			}
		}
		//return list;
		return num;
	}

	/**
	 * 根据HSSFCell类型设置数据
	 * 
	 * @param cell
	 * @return
	 */
	private String getCellFormatValue(HSSFCell cell) {
		String cellvalue = "";
		if (cell != null) {
			// 判断当前Cell的Type
			switch (cell.getCellType()) {
			// 如果当前Cell的Type为NUMERIC
			case HSSFCell.CELL_TYPE_NUMERIC:
			case HSSFCell.CELL_TYPE_FORMULA: {
				// 判断当前的cell是否为Date
				if (HSSFDateUtil.isCellDateFormatted(cell)) {
					// 如果是Date类型则，转化为Data格式
					// 方法1：这样子的data格式是带时分秒的：2011-10-12 0:00:00
					// cellvalue = cell.getDateCellValue().toLocaleString();
					// 方法2：这样子的data格式是不带带时分秒的：2011-10-12
					Date date = cell.getDateCellValue();
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					cellvalue = sdf.format(date);

				}
				// 如果是纯数字
				else {
					// 取得当前Cell的数值
					DecimalFormat df = new DecimalFormat("0");
					String whatYourWant = df.format(cell.getNumericCellValue());
					cellvalue = String.valueOf(whatYourWant);
				}
				break;
			}
			// 如果当前Cell的Type为STRIN
			case HSSFCell.CELL_TYPE_STRING:
				// 取得当前的Cell字符串
				cellvalue = cell.getRichStringCellValue().getString();
				break;
			// 默认的Cell值
			default:
				cellvalue = " ";
			}
		} else {
			cellvalue = "";
		}
		return cellvalue;

	}

	public int importBrandPeriodSort(InputStream in) throws IOException {
		int count = readXls(in);
		return count;
	}

}
