package co.micol.notice.product.serviceImpl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import co.micol.notice.common.DataSource;
import co.micol.notice.product.service.ProductMapper;
import co.micol.notice.product.service.ProductService;
import co.micol.notice.product.service.ProductVO;

public class ProductServiceImpl implements ProductService {
	SqlSession sqlSession = DataSource.getInstance().openSession(true); //DAO선언
	ProductMapper map = sqlSession.getMapper(ProductMapper.class);	//매핑
	
	@Override
	public List<ProductVO> productSelectList() {
		// TODO Auto-generated method stub
		return map.productSelectList();
	}

	@Override
	public ProductVO productSelect(ProductVO vo) {
		// TODO Auto-generated method stub
		return map.productSelect(vo);
	}

	@Override
	public int productInsert(ProductVO vo) {
		// TODO Auto-generated method stub
		return map.productInsert(vo);
	}

	@Override
	public int productUpdate(ProductVO vo) {
		// TODO Auto-generated method stub
		return map.productUpdate(vo);
	}

	@Override
	public int productDelete(ProductVO vo) {
		// TODO Auto-generated method stub
		return map.productDelete(vo);
	}

}
