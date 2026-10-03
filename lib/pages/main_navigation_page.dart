import 'package:flutter/material.dart';

import 'produk_list_page.dart';
import 'profil_page.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _tabTerpilih = 0;
  int _jumlahKeranjang = 0;

  final List<Map<String, dynamic>> _produk = [
    {'nama': 'Kursi Minimalis', 'harga': 350000},
    {'nama': 'Meja Kerja Kayu', 'harga': 750000},
    {'nama': 'Lampu Meja LED', 'harga': 120000},
    {'nama': 'Rak Buku', 'harga': 480000},
    {'nama': 'Sofa Kecil', 'harga': 1250000},
  ];

  void _tambahKeranjang() {
    setState(() => _jumlahKeranjang++);
  }

  void _tambahProduk(Map<String, dynamic> produk) {
    setState(() => _produk.add(produk));
  }

  void _hapusProduk(int index) {
    setState(() => _produk.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    final halaman = [
      ProdukListPage(
        produk: _produk,
        onTambahKeranjang: _tambahKeranjang,
        onTambahProduk: _tambahProduk,
        onHapusProduk: _hapusProduk,
      ),
      const ProfilPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_tabTerpilih == 0 ? 'Katalog Produk' : 'Profil'),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.shopping_cart),
              ),
              if (_jumlahKeranjang > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$_jumlahKeranjang',
                      style: const TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: halaman[_tabTerpilih],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabTerpilih,
        onTap: (index) => setState(() => _tabTerpilih = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Produk'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
