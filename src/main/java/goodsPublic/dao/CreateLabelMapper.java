package goodsPublic.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import goodsPublic.entity.AirBottle;
import goodsPublic.entity.PreviewCRSPDF;
import goodsPublic.entity.PreviewCRSPDFSet;

public interface CreateLabelMapper {

	List<PreviewCRSPDF> selectPreviewCRSPDF();

	int insertPreviewCRSPDFSet(PreviewCRSPDFSet pCrsPdfSet);

	PreviewCRSPDFSet selectCRSPdfSet(@Param("labelType")Integer labelType, @Param("accountNumber")String accountNumber);

	int insertAirBottleRecord(AirBottle airBottle);

	int queryAirBottleForInt(@Param("qpbh")String qpbh);

	List<AirBottle> queryAirBottleList(@Param("qpbh")String qpbh, int page, int rows, String sort, String order);

	int updateAirBottle(AirBottle airBottle);

	AirBottle getAirBottleById(@Param("id")String id);

}
