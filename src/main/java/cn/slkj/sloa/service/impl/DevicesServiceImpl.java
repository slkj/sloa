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
import cn.slkj.sloa.entity.stock.Devices;
import cn.slkj.sloa.entity.stock.Devices_record;
import cn.slkj.sloa.mapper.DevicesMapper;
import cn.slkj.sloa.service.DevicesService;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;

@Repository
public class DevicesServiceImpl implements DevicesService {
	@Autowired
	private DevicesMapper mapper;

	@Override
	public List<Devices> getAll(Map<String, Object> map, PageBounds pageBounds) {
		return mapper.getAll(map, pageBounds);
	}

	 
	@Override
	public int insert(Devices devices) {
		return mapper.insert(devices);
	}

	@Override
	public int outRepertory(Devices devices) {
		return mapper.outRepertory(devices);
	}

	@Override
	public int outRepertory(HashMap<String, Object> map) {
		return mapper.ckData(map);
	}

	@Override
	public int testing(Map<String, Object> map) {
		return mapper.testing(map);
	}

	@Override
	public List<Devices> getList(Map<String, Object> map) {
		return mapper.getList(map);
	}

	@Override
	public int insert_record(Devices devices) {
		return mapper.insert_record(devices);
	}


	@Override
	public List<Devices_record> getAllRecord(Map<String, Object> pageMap, PageBounds pageBounds) {
		return mapper.getAllRecord(pageMap, pageBounds);
	}

	@Override
	public Devices queryOne(Map<String, Object> map) {
		return mapper.queryOne(map);
	}

	@Override
	public int deletes(String[] ids) {
		return mapper.deletes(ids);
	}

	@Override
	public int edit(Devices devices) {
		return mapper.edit(devices);
	}

	@Override
	public int pack(Map<String, Object> map) {
		return mapper.pack(map);
	}

	@Override
	public List<Devices_record> getListRecd(Map<String, Object> map) {
		return mapper.getListRecd(map);
	}

	@Override
	public int packList(Map<String, Object> map) {
		return mapper.packList(map);
	}

	@Override
	public int revoke(HashMap<String, Object> map) {
		return mapper.revoke(map);
	}

	@Override
	public int editbyNum(Devices devices) {
		return mapper.editbyNum(devices);
	}

	@Override
	public int insert_recordList(HashMap<String, Object> map) {
		return mapper.insert_recordList(map);
	}

	@Override
	public int isReceive(HashMap<String, Object> map) {
		return mapper.isReceive(map);
	}
	
	/**
	 * 导出Excel
	 */
	public void exportExcel(HashMap<String, Object> map, String[] titles, ServletOutputStream outputStream) {
		List<Devices> list = mapper.getList(map);
		// 创建一个workbook 对应一个excel应用文件
		XSSFWorkbook workBook = new XSSFWorkbook();
		// 在workbook中添加一个sheet,对应Excel文件中的sheet
		XSSFSheet sheet = workBook.createSheet("设备汇总");
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
				Devices devices = list.get(j);
				// 出库状态
				cell = bodyRow.createCell(0);
				cell.setCellStyle(bodyStyle);
				int state = devices.getState();
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
				int ustate = devices.getUstate();
				switch (ustate) {
				case 0:
					cell.setCellValue("未使用");
					break;
				case 1:
					cell.setCellValue("入网使用");
					break;
				}
				// 厂牌型号
				cell = bodyRow.createCell(2);
				cell.setCellStyle(bodyStyle);
				String firm = devices.getFirm() == null ? "" : devices.getFirm();
				String model = devices.getModel() == null ? "" : devices.getModel();
				cell.setCellValue(firm + model);
				// 设备编号
				cell = bodyRow.createCell(3);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(devices.getListnum());
				// 入库时间
				cell = bodyRow.createCell(4);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(devices.getRktime());
				// 用途
				cell = bodyRow.createCell(5);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(devices.getUstype());
				// 领用人
				cell = bodyRow.createCell(6);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(devices.getLyr());
				// 领用部门
				cell = bodyRow.createCell(7);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(devices.getDepartmentName());
				// 领用时间
				cell = bodyRow.createCell(8);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(devices.getLytime());
				// 车牌号
				cell = bodyRow.createCell(9);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(devices.getCarNumber());
				// 安装人
				cell = bodyRow.createCell(10);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(devices.getInstallers());
				// 安装时间
				cell = bodyRow.createCell(11);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(devices.getInstalltime());
				// 使用公司
				cell = bodyRow.createCell(12);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(devices.getCompanyName());
				// 返还时间
				cell = bodyRow.createCell(13);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(devices.getFhtime());
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
//	public List<Devices> readXls(InputStream is) throws IOException {
	public int readXls(InputStream is) throws IOException {
		HSSFWorkbook hssfWorkbook = new HSSFWorkbook(is);
		Devices devices = null;int num=0;
		List<Devices> list = new ArrayList<Devices>();
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
				devices = new Devices();
				devices.setId(UUIDUtils.uuid());
				// 循环列Cell
				// 0设备号
				HSSFCell listnum = hssfRow.getCell(0);
				if (listnum == null) {
					continue;
				}
				devices.setListnum(getCellFormatValue(listnum));
				// 1设备包装
				HSSFCell pack = hssfRow.getCell(1);				
//				devices.setPack(Integer.valueOf(getCellFormatValue(pack)));
				devices.setPack(getCellFormatValue(pack));
				// 2入库时间
				HSSFCell rktime = hssfRow.getCell(2);				
				devices.setRktime(getCellFormatValue(rktime));
				// 3设备厂商
				HSSFCell firm = hssfRow.getCell(3);				
				devices.setFirm(getCellFormatValue(firm));
				// 4 厂牌型号
				HSSFCell model = hssfRow.getCell(4);				
				devices.setModel(getCellFormatValue(model));
				// 5所属部门
				HSSFCell department = hssfRow.getCell(5);
				devices.setDepartment("5");
				
				//int count=mapper.getCountByListnum(devices.getListnum());
				//if(count<1){
				//list.add(devices);
					mapper.insertBatch(devices);
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
