package goodsPublic.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.goodsPublic.util.JsonUtil;
import com.goodsPublic.util.PlanResult;

import goodsPublic.entity.ModuleSPZS;
import jxl.Sheet;
import jxl.Workbook;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/merchant/excel")
public class ExcelController {

	@RequestMapping(value="/downloadExcelModule")
	public void downloadExcelModule(HttpServletRequest request, HttpServletResponse response) {
		try {
			String trade = request.getParameter("trade");
			String moduleType = request.getParameter("moduleType");
			String jsonStr = request.getParameter("jsonStr");
			JSONArray ja = JSONArray.fromObject(jsonStr);
			String fileName = null;
			
			HSSFWorkbook wb=new HSSFWorkbook();
			HSSFSheet sheet = wb.createSheet("excel模板生成码");
			HSSFCellStyle style = wb.createCellStyle();
			for (int i = 0; i < ja.size(); i++) {
				JSONObject jo = ja.getJSONObject(i);
				HSSFRow row = sheet.createRow(i);
				Iterator<String> it = jo.keys();
				int colIndex=0;
				while (it.hasNext()) {
					String key = it.next().toString();
					String value = jo.getString(key);
					HSSFCell cell = row.createCell(colIndex);
					cell.setCellValue(value);
					cell.setCellStyle(style);
					colIndex++;
				}
			}
		
			switch (trade) {
			case "spzs":
				if(ModuleSPZS.RED_WINE.equals(moduleType)) {
					fileName="红酒_excel模板";
				}
				else if(ModuleSPZS.WHITE_WINE.equals(moduleType)) {
					fileName="白酒_excel模板";
				}
				else if(ModuleSPZS.HOME_TEXTILES.equals(moduleType)) {
					fileName="家纺_excel模板";
				}
				else if(ModuleSPZS.ARTWORK.equals(moduleType)) {
					fileName="艺术品_excel模板";
				}
				break;
			}
			download(fileName, wb, response);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@RequestMapping(value="/loadExcelData",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String loadExcelData(@RequestParam(value="excel_file",required=false) MultipartFile excel_file) {
		PlanResult plan=new PlanResult();
		String json=null;
		try {
			System.out.println(excel_file.getSize());
			// 创建输入流，读取Excel  
			InputStream is = excel_file.getInputStream();  
			// jxl提供的Workbook类  
			Workbook wb = Workbook.getWorkbook(is);  
			// Excel的页签数量  
			int sheet_size = wb.getNumberOfSheets();  
			
			JSONArray ja = new JSONArray();
			JSONObject jo = null;
			for (int index = 0; index < sheet_size; index++) {  
			    // 每个页签创建一个Sheet对象  
			    Sheet sheet = wb.getSheet(index);  
			    // sheet.getRows()返回该页的总行数  
			    for (int i = 0; i < sheet.getRows(); i++) {  
			        // sheet.getColumns()返回该页的总列数  
			    	jo = new JSONObject();
			        for (int j = 0; j < sheet.getColumns(); j++) {  
			            String value = sheet.getCell(j, i).getContents();  
			            jo.put("value"+j, value);
			            System.out.print(value+"   ");
			        }
			        ja.add(jo);
			        System.out.println("  ");
			    	/*
			    	String cpxh_qc = sheet.getCell(0, i).getContents();
			    	String qpbh = sheet.getCell(1, i).getContents();
		        	String zl = sheet.getCell(2, i).getContents().replaceAll("\"", "");
		        	String scrj = sheet.getCell(3, i).getContents().replaceAll("\"", "");
		        	String qpzjxh = sheet.getCell(4, i).getContents();
		        	String qpzzdw = sheet.getCell(5, i).getContents();
			        System.out.println("zl==="+zl);
			        System.out.println("scrj==="+scrj);
			        System.out.println("qpzjxh==="+qpzjxh);
			        System.out.println("qpzzdw==="+qpzzdw);
			        */
			        
			    }  
			}
			plan.setStatus(1);
			plan.setData(ja);
			json=JsonUtil.getJsonFromObject(plan);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			plan.setStatus(0);
			plan.setMsg("查询失败！");
		}
		return json;
	}

	private void download(String fileName, HSSFWorkbook wb, HttpServletResponse response) throws IOException {  
	      ByteArrayOutputStream os = new ByteArrayOutputStream();
	      wb.write(os);
	      byte[] content = os.toByteArray();
	      InputStream is = new ByteArrayInputStream(content);
	      // 设置response参数，可以打开下载页面
	      response.reset();
	      response.setContentType("application/vnd.ms-excel;charset=utf-8");
	      response.setHeader("Content-Disposition", "attachment;filename="
	          + new String((fileName + ".xls").getBytes(), "iso-8859-1"));
	      ServletOutputStream out = response.getOutputStream();
	      BufferedInputStream bis = null;
	      BufferedOutputStream bos = null;
	 
	      try {
	        bis = new BufferedInputStream(is);
	        bos = new BufferedOutputStream(out);
	        byte[] buff = new byte[2048];
	        int bytesRead;
	        // Simple read/write loop.
	        while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
	          bos.write(buff, 0, bytesRead);
	        }
	      } catch (Exception e) {
	        // TODO: handle exception
	        e.printStackTrace();
	      } finally {
	        if (bis != null)
	          bis.close();
	        if (bos != null)
	          bos.close();
	      }
	}
}
