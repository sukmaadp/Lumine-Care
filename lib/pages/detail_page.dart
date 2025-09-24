import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/product.dart';
import '../model/cart.dart';

class DetailPage extends StatelessWidget {
  final Product product;

  const DetailPage({super.key, required this.product});

  String getDescription() {
    switch (product.category) {
      case "Skincare":
        return "Produk perawatan kulit untuk menjaga kelembaban, kesehatan, dan keindahan kulit wajah.";
      case "Bodycare":
        return "Produk perawatan tubuh yang membuat kulit lebih sehat, lembut, dan harum sepanjang hari.";
      case "Haircare":
        return "Produk perawatan rambut untuk menjaga kesehatan, kekuatan, dan kilau rambut.";
      default:
        return "Produk kecantikan berkualitas untuk menunjang penampilan dan kesehatan.";
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Colors.purple,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () => Navigator.pushNamed(context, '/cart'),
              ),
              if (cart.items.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      cart.items.length.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),

      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF3E5F5), Color(0xFFFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon produk
            CircleAvatar(
              radius: 65,
              backgroundColor: Colors.purple.shade50,
              child: Icon(product.icon, size: 70, color: Colors.purple),
            ),
            const SizedBox(height: 20),

            // Nama produk
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // Kategori
            Chip(
              label: Text(product.category),
              backgroundColor: Colors.purple.shade100,
              labelStyle: const TextStyle(color: Colors.purple),
            ),
            const SizedBox(height: 16),

            // Harga
            Text(
              "Rp ${product.price.toStringAsFixed(0)}",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),

            // Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) =>
                    const Icon(Icons.star, color: Colors.amber, size: 22),
              ),
            ),
            const SizedBox(height: 20),

            // Divider halus
            Divider(color: Colors.grey.shade300, thickness: 1, height: 30),

            // Deskripsi
            Text(
              getDescription(),
              style: const TextStyle(fontSize: 15, color: Colors.black54),
              textAlign: TextAlign.center,
            ),

            const Spacer(),

            // Tombol Tambah ke Keranjang
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white, // ✅ biar tulisan & icon jelas
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 24,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  cart.add(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${product.name} ditambahkan ke keranjang"),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text("Tambah ke Keranjang"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
