import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/pages/settings_page.dart';
import 'package:flutter_application_1/pages/profile_page.dart';
import 'package:flutter_application_1/pages/cart_page.dart';
import 'package:flutter_application_1/pages/detail_page.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // ✅ Tambahkan ini untuk format rupiah
import '../model/product.dart';
import '../model/cart.dart';

/// ================= Custom Top Bar =================
class CustomTopBar extends StatelessWidget implements PreferredSizeWidget {
  final int cartCount;
  final Function(String) onSearch;
  final String email;

  const CustomTopBar({
    super.key,
    required this.cartCount,
    required this.onSearch,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double searchWidth = screenWidth * 0.35;
    if (searchWidth > 140) searchWidth = 140;

    return SafeArea(
      child: Container(
        height: preferredSize.height,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF3E5F5), Color(0xFFFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 92),
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  side: const BorderSide(color: Colors.purple),
                  foregroundColor: Colors.purple,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(Icons.menu, size: 18),
                label: const Text("Menu", style: TextStyle(fontSize: 14)),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Center(
                child: Text(
                  "Luminé Care",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: searchWidth,
                  height: 36,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.purple.shade100),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, size: 18, color: Colors.grey),
                      const SizedBox(width: 6),
                      Expanded(
                        child: TextField(
                          onChanged: onSearch,
                          decoration: const InputDecoration(
                            hintText: "Cari",
                            border: InputBorder.none,
                            isDense: true,
                          ),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.person, color: Colors.purple),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProfilePage(
                          email: email,
                          name: email.split('@')[0],
                        ),
                      ),
                    );
                  },
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.shopping_bag,
                        color: Colors.purple,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const CartPage()),
                        );
                      },
                    ),
                    if (cartCount > 0)
                      Positioned(
                        right: 6,
                        top: 6,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            cartCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

/// ================= Dashboard Page =================
class DashboardPage extends StatefulWidget {
  final String email;
  const DashboardPage({super.key, required this.email});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String searchQuery = "";
  String userName = "";
  String userEmail = "";

  // ✅ Tambahkan formatter untuk format rupiah
  final NumberFormat currencyFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('user_name') ?? widget.email.split('@')[0];
      userEmail = prefs.getString('user_email') ?? widget.email;
    });
  }

  final List<Product> products = [
    // Skincare
    SkincareProduct(
      name: "Facial Wash - Wardah",
      price: 50000,
      icon: Icons.spa,
    ),
    SkincareProduct(
      name: "Moisturizer - Scarlett",
      price: 75000,
      icon: Icons.water_drop,
    ),
    SkincareProduct(
      name: "Sunscreen - elformula",
      price: 120000,
      icon: Icons.wb_sunny,
    ),
    SkincareProduct(
      name: "Serum Vitamin C - Scarlett",
      price: 135000,
      icon: Icons.medical_services,
    ),
    SkincareProduct(
      name: "Face Toner - Garnier",
      price: 68000,
      icon: Icons.local_drink,
    ),
    SkincareProduct(
      name: "Night Cream - MS Glow",
      price: 95000,
      icon: Icons.nightlight_round,
    ),
    // Haircare
    HaircareProduct(
      name: "Shampoo - Makarizo",
      price: 60000,
      icon: Icons.shower,
    ),
    HaircareProduct(
      name: "Hair Oil - Natur",
      price: 85000,
      icon: Icons.energy_savings_leaf,
    ),
    HaircareProduct(
      name: "Hair Serum - L’Oreal",
      price: 95000,
      icon: Icons.brush,
    ),
    HaircareProduct(
      name: "Hair Mask - Tresemme",
      price: 110000,
      icon: Icons.spa_outlined,
    ),
    HaircareProduct(
      name: "Conditioner - Dove",
      price: 72000,
      icon: Icons.water,
    ),
    HaircareProduct(
      name: "Aloe Vera Gel - Nature Republic",
      price: 89000,
      icon: Icons.eco,
    ),
    // Bodycare
    BodycareProduct(
      name: "Body Lotion - Vaseline",
      price: 45000,
      icon: Icons.spa,
    ),
    BodycareProduct(
      name: "Body Scrub - Purbasari",
      price: 55000,
      icon: Icons.cleaning_services,
    ),
    BodycareProduct(
      name: "Shower Gel - Love Beauty & Planet",
      price: 65000,
      icon: Icons.bubble_chart,
    ),
    BodycareProduct(
      name: "Hand Cream - The Body Shop",
      price: 40000,
      icon: Icons.pan_tool,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);

    final filtered = products.where((p) {
      final q = searchQuery.toLowerCase();
      return p.name.toLowerCase().contains(q) ||
          p.category.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.purple),
              accountName: Text(userName),
              accountEmail: Text(userEmail),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.purple, size: 40),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        ProfilePage(name: userName, email: userEmail),
                  ),
                ).then((_) => _loadUserInfo());
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsPage()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () => Navigator.pushReplacementNamed(context, '/login'),
            ),
          ],
        ),
      ),
      appBar: CustomTopBar(
        cartCount: cart.items.length,
        email: widget.email,
        onSearch: (val) => setState(() => searchQuery = val),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: filtered.map((p) => _buildProductCard(p, cart)).toList(),
      ),
    );
  }

  Widget _buildProductCard(Product p, CartModel cart) {
    return GFCard(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: GFListTile(
        avatar: CircleAvatar(
          backgroundColor: Colors.purple.shade50,
          child: Icon(p.icon, color: Colors.purple),
        ),
        titleText: p.name,
        subTitleText: currencyFormat.format(p.price), // ✅ Format rupiah
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetailPage(product: p)),
        ),
      ),
      content: const Text(
        "Produk skincare dan perawatan terbaik untukmu.",
        style: TextStyle(fontSize: 14),
      ),
      buttonBar: GFButtonBar(
        children: [
          GFButton(
            onPressed: () {
              cart.add(p);
              GFToast.showToast(
                "${p.name} ditambahkan ke keranjang",
                context,
                toastDuration: 3,
                backgroundColor: GFColors.SUCCESS,
                textStyle: const TextStyle(color: Colors.white),
              );
            },
            text: "Tambah",
            icon: const Icon(
              Icons.add_shopping_cart,
              color: Colors.white,
              size: 18,
            ),
            color: GFColors.SUCCESS,
            size: GFSize.MEDIUM,
            shape: GFButtonShape.pills,
          ),
        ],
      ),
    );
  }
}
