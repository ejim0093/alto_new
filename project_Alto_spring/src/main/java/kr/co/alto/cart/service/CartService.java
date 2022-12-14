package kr.co.alto.cart.service;

import java.util.List;
import java.util.Map;

import kr.co.alto.cart.dto.CartDTO;

public interface CartService {

	public Map listCart(String mem_id) throws Exception;
	public int addCart(Map cartMap) throws Exception;
	public int cartGoods(Map cartMap) throws Exception;
	public int editCart(Map cartMap) throws Exception;
	public int deleteCart(Map cartMap) throws Exception;
	public int quanEditCart(Map cartMap) throws Exception;
	public int deleteAll(String mem_id) throws Exception;
	
}
