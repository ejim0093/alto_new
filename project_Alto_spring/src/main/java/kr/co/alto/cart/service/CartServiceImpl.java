package kr.co.alto.cart.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.co.alto.cart.dao.CartDAO;
import kr.co.alto.cart.dto.CartDTO;
import kr.co.alto.cla.dao.ClassDAO;
import kr.co.alto.item.dao.ItemDAO;

@Service("cartService")
@Transactional(propagation = Propagation.REQUIRED)
public class CartServiceImpl implements CartService {

	@Autowired
	private CartDAO cartDAO;
	
	@Autowired
	private ClassDAO classDAO;
	
	@Autowired
	private ItemDAO itemDAO;
	
	
	@Override
	public Map listCart(String mem_id) throws Exception {
		
		Map<String, Object> cartMainMap = new HashMap<>();
		
		List cartClassList = cartDAO.selectClassCart(mem_id);
		cartMainMap.put("cartClassList", cartClassList);
		
		List cartItemList = cartDAO.selectItemCart(mem_id);
		cartMainMap.put("cartItemList", cartItemList);
		
		return cartMainMap;
	}

	@Override
	public int addCart(Map cartMap) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

}
