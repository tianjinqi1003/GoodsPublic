package goodsPublic.service;

import java.util.List;

import goodsPublic.entity.AirBottle;
import goodsPublic.entity.PreviewCRSPDF;
import goodsPublic.entity.PreviewCRSPDFSet;

public interface CreateLabelService {

	List<PreviewCRSPDF> selectPreviewCRSPDF();

	int insertPreviewCRSPDFSet(PreviewCRSPDFSet pCrsPdfSet);

	PreviewCRSPDFSet selectCRSPdfSet(Integer labelType, String accountNumber);

	int insertAirBottleRecord(AirBottle airBottle);

	int queryAirBottleForInt(String qpbh);

	List<AirBottle> queryAirBottleList(String qpbh, int page, int rows, String sort, String order);

}
