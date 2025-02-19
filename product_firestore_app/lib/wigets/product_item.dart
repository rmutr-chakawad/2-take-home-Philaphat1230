import 'package:flutter/material.dart';
import 'package:product_firestore_app/models/product_model.dart';
import 'package:product_firestore_app/wigets/product_form.dart';
import 'package:product_firestore_app/wigets/product_popup.dart';

// ignore: must_be_immutable
class ProductItem extends StatelessWidget {
  final ProductModel product;

  ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 4, // เพิ่มเงาให้ Card
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // ขอบมน
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(15), // ให้ effect โค้งตามขอบ
          splashColor: Colors.redAccent.withOpacity(0.2), // Effect ตอนกด
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return ProductPopup(product: product);
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                // Icon สินค้า
                CircleAvatar(
                  backgroundColor: Colors.redAccent.shade100,
                  child: const Icon(Icons.shopping_bag, color: Colors.white),
                ),
                const SizedBox(width: 12),
                // รายละเอียดสินค้า
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.productName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${product.price.toStringAsFixed(2)} Bath',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.redAccent.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                // ปุ่ม Edit
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => ProductForm(product: product),
                    );
                  },
                  icon: const Icon(Icons.edit, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
