package goodsPublic.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import goodsPublic.dao.CreateLabelMapper;
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

}