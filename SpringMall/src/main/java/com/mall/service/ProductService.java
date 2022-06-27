package com.mall.service;

import java.util.List;

public interface ProductService {
	void insertProduct(ProductDTO dto);
	void updateProduct(ProductDTO dto);
	void deleteProduct(ProductDTO dto);
	ProductDTO getProduct(ProductDTO dto);
	List<ProductDTO> getProductList(ProductDTO dto, String mode);
}
