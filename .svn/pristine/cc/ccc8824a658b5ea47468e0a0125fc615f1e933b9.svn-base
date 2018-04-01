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
import cn.slkj.sloa.entity.stock.Prove;
import cn.slkj.sloa.entity.stock.Prove_record;
import cn.slkj.sloa.mapper.ProveMapper;
import cn.slkj.sloa.service.ProveService;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;

@Repository
public class ProveServiceImpl implements ProveService {
	@Autowired
	private ProveMapper mapper;

	@Override
	public List<Prove> getAll(Map<String, Object> map, PageBounds pageBounds) {
		return mapper.getAll(map, pageBounds);
	}

	@Override
	public Prove queryOne(Prove prove) {
		return mapper.queryOne(prove);
	}

	@Override
	public int save(Prove prove) {
		return mapper.save(prove);
	}

	@Override
	public int edit(Prove prove) {
		return mapper.edit(prove);
	}

	@Override
	public int use(Map<String, Object> map) {
		return mapper.use(map);
	}

	@Override
	public int tovoid(Map<String, Object> map) {
		return mapper.tovoid(map);
	}

	@Override
	public int delete(String id) {
		return mapper.delete(id);
	}

	@Override
	public int billing(HashMap<String, Object> map) {
		return mapper.billing(map);
	}

	@Override
	public int fees(HashMap<String, Object> map) {
		return mapper.fees(map);
	}

	@Override
	public boolean updateImg(String imgPath, String filename, String number) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("type", imgPath);
		map.put("filename", filename);
		map.put("number", number);
		int i = mapper.updateImg(map);
		if (i > 0) {
			return true;
		}
		return false;
	}

	@Override
	public int canceled(HashMap<String, Object> map) {
		return mapper.canceled(map);
	}

	@Override
	public int revoke(HashMap<String, Object> map) {
		return mapper.revoke(map);
	}

	@Override
	public int insert_recordList(HashMap<String, Object> map) {
		return mapper.insert_recordList(map);
	}

	@Override
	public List<Prove_record> getListRecd(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return mapper.getListRecd(map);
	}
	
	
	public void exportExcel(HashMap<String, Object> map, String[] titles, ServletOutputStream outputStream) {
		List<Prove> list = mapper.getList(map);
		// 创建一个workbook 对应一个excel应用文件
		XSSFWorkbook workBook = new XSSFWorkbook();
		// 在workbook中添加一个sheet,对应Excel文件中的sheet
		XSSFSheet sheet = workBook.createSheet("证明汇总");
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
				Prove prove = list.get(j);
				// 出库状态
				cell = bodyRow.createCell(0);
				cell.setCellStyle(bodyStyle);
				int state = prove.getState();
				switch (state) {
				case 0:
					cell.setCellValue(">未出库");
					break;
				case 1:
					cell.setCellValue("已出库");
					break;
				case 2:
					cell.setCellValue("已回收");
					break;
				}
				// 使用状态
				cell = bodyRow.createCell(1);
				cell.setCellStyle(bodyStyle);
				int ustate = prove.getUstate();
				switch (ustate) {
				case 0:
					cell.setCellValue("未使用");
					break;
				case 1:
					cell.setCellValue("入网使用");
					break;
				case 3:
					cell.setCellValue("已作废");
					break;
				}
				// 领用部门
				cell = bodyRow.createCell(2);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(prove.getDepartmentName());
				// 使用类型
				cell = bodyRow.createCell(3);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(prove.getUstype());
				// 编号
				cell = bodyRow.createCell(4);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(prove.getNumber());
				// 出库日期
				cell = bodyRow.createCell(5);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(prove.getUsriqi());
				// 领用人
				cell = bodyRow.createCell(6);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(prove.getUsman());
				// 车牌号
				cell = bodyRow.createCell(7);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(prove.getCarNumber());
				// 用途
				cell = bodyRow.createCell(8);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(prove.getPurpose());
				// 开票人
				cell = bodyRow.createCell(9);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(prove.getInspector());
				// 开票时间
				cell = bodyRow.createCell(10);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(prove.getRiqi());
				// 服务期限
				cell = bodyRow.createCell(11);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(prove.getStartTime() + "至" + prove.getEndTime());
				// 金额
				cell = bodyRow.createCell(12);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(prove.getAmounts());
				// 收款状态
				cell = bodyRow.createCell(13);
				cell.setCellStyle(bodyStyle);
//				cell.setCellValue(prove.getFees());
				int fee = prove.getFees();
				switch (fee) {
				case 0:
					cell.setCellValue("待收款");
					break;
				case 1:
					cell.setCellValue("已收款");
					break;
				}
				// 收款人
				cell = bodyRow.createCell(14);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(prove.getPayee());
				// 备注
				cell = bodyRow.createCell(15);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(prove.getRemark());
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
	 * @return List<prove>对象
	 * @throws IOException
	 *             输入/输出(i/o)异常
	 */
	//public List<Prove> readXls(InputStream is) throws IOException {
	public int readXls(InputStream is) throws IOException {
		HSSFWorkbook hssfWorkbook = new HSSFWorkbook(is);
		Prove prove = null;int num=0;
		List<Prove> list = new ArrayList<Prove>();
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
				prove = new Prove();
				prove.setId(UUIDUtils.uuid());
				// 循环列Cell
				// 0使用类型1入网编号2备注
				HSSFCell ustype = hssfRow.getCell(0);
				prove.setUstype(getCellFormatValue(ustype));
				// 1证明编号
				HSSFCell number = hssfRow.getCell(1);
				if (number == null) {
					continue;
				}
				prove.setNumber(getCellFormatValue(number));
				// 2备注
				HSSFCell remark = hssfRow.getCell(2);
				
				prove.setRemark(getCellFormatValue(remark));
				// 3所属部门
				HSSFCell department = hssfRow.getCell(3);
				prove.setDepartment("5");
				
				Map<String, Object> pageMap = new HashMap<String, Object>();
				pageMap.put("number", prove.getNumber());
				pageMap.put("ustype", prove.getUstype());
				//int count=mapper.getCountByNumber(pageMap);
				//if(count<1){
				//list.add(prove);
					mapper.insertBatch(prove);
					num++;
				//}
			}
		}
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
