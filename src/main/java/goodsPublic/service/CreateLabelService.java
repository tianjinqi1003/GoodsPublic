package goodsPublic.service;

import java.util.List;

import goodsPublic.entity.PreviewCRSPDF;
import goodsPublic.entity.PreviewCRSPDFSet;

public interface CreateLabelService {

	List<PreviewCRSPDF> selectPreviewCRSPDF();

	int insertPreviewCRSPDFSet(PreviewCRSPDFSet pCrsPdfSet);

	PreviewCRSPDFSet selectCRSPdfSet(Integer labelType, String accountNumber);

}
