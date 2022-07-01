package com.kiku.springmall.service;

import java.util.List;

public interface ProductService {
	void insertProduct(ProductDTO dto);
	void updateProduct(ProductDTO dto);
	void deleteProduct(ProductDTO dto);
	int getProductCount(ProductDTO dto);
	ProductDTO getProduct(ProductDTO dto);
	List<ProductDTO> getProductList(ProductDTO dto, BlockDTO block);
}
