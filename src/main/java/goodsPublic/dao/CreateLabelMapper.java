package goodsPublic.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import goodsPublic.entity.PreviewCRSPDF;
import goodsPublic.entity.PreviewCRSPDFSet;

public interface CreateLabelMapper {

	List<PreviewCRSPDF> selectPreviewCRSPDF();

	int insertPreviewCRSPDFSet(PreviewCRSPDFSet pCrsPdfSet);

	PreviewCRSPDFSet selectCRSPdfSet(@Param("labelType")Integer labelType, @Param("accountNumber")String accountNumber);

}
