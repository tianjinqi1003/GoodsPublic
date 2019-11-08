package goodsPublic.service.serviceImpl;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import goodsPublic.dao.CreateLabelMapper;
import goodsPublic.entity.AirBottle;
import goodsPublic.entity.PreviewCRSPDF;
import goodsPublic.entity.PreviewCRSPDFSet;
import goodsPublic.service.CreateLabelService;

@Service
public class CreateLabelServiceImpl implements CreateLabelService {

	@Autowired
	private CreateLabelMapper createLabelDao;
	
	@Override
	public List<PreviewCRSPDF> selectPreviewCRSPDF() {
		// TODO Auto-generated method stub
		return createLabelDao.selectPreviewCRSPDF();
	}

	@Override
	public int insertPreviewCRSPDFSet(PreviewCRSPDFSet pCrsPdfSet) {
		// TODO Auto-generated method stub
		return createLabelDao.insertPreviewCRSPDFSet(pCrsPdfSet);
	}

	@Override
	public PreviewCRSPDFSet selectCRSPdfSet(Integer labelType, String accountNumber) {
		// TODO Auto-generated method stub
		return createLabelDao.selectCRSPdfSet(labelType,accountNumber);
	}

	@Override
	public int insertAirBottleRecord(AirBottle airBottle) {
		// TODO Auto-generated method stub
		return createLabelDao.insertAirBottleRecord(airBottle);
	}

	@Override
	public int queryAirBottleForInt(String qpbh) {
		// TODO Auto-generated method stub
		return createLabelDao.queryAirBottleForInt(qpbh);
	}

	@Override
	public List<AirBottle> queryAirBottleList(String qpbh, int page, int rows, String sort, String order) {
		// TODO Auto-generated method stub
		return createLabelDao.queryAirBottleList(qpbh, page, rows, sort, order);
	}

	@Override
	public int updateAirBottle(AirBottle airBottle) {
		// TODO Auto-generated method stub
		return createLabelDao.updateAirBottle(airBottle);
	}

	@Override
	public AirBottle getAirBottleById(String id) {
		// TODO Auto-generated method stub
		return createLabelDao.getAirBottleById(id);
	}

	@Override
	public int editAirBottle(AirBottle airBottle) {
		// TODO Auto-generated method stub
		return createLabelDao.editAirBottle(airBottle);
	}

	@Override
	public int deleteAirBottle(String ids) {
		// TODO Auto-generated method stub
		int count=0;
		List<String> idList = Arrays.asList(ids.split(","));
		count=createLabelDao.deleteAirBottle(idList);
		return count;
	}

}