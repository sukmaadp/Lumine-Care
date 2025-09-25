import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/cart.dart';
import '../model/product.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Keranjang"),
        backgroundColor: Colors.purple,
      ),
      body: cart.items.isEmpty
          ? const Center(child: Text("Keranjang masih kosong"))
          : ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                Product product = cart.items[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: Icon(product.icon, color: Colors.purple),
                    title: Text(product.name),
                    subtitle: Text("Rp ${product.price.toStringAsFixed(0)}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        cart.remove(product);
                      },
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total: Rp ${cart.totalPrice.toStringAsFixed(0)}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Checkout berhasil!")),
                );
                cart.clear();
              },
              child: const Text("Checkout"),
            ),
          ],
        ),
      ),
    );
  }
}
