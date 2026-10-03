import 'package:flutter/material.dart';

import '../widget_basic/product_card.dart';
import 'produk_detail_page.dart';
import 'tambah_produk_page.dart';

class ProdukListPage extends StatelessWidget {
  final List<Map<String, dynamic>> produk;
  final VoidCallback onTambahKeranjang;
  final void Function(Map<String, dynamic>) onTambahProduk;
  final void Function(int) onHapusProduk;

  const ProdukListPage({
    super.key,
    required this.produk,
    required this.onTambahKeranjang,
    required this.onTambahProduk,
    required this.onHapusProduk,
  });

  void _konfirmasiHapus(BuildContext context, int index) {
    final nama = produk[index]['nama'];
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus Produk?'),
        content: Text('"$nama" akan dihapus dari daftar.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              onHapusProduk(index);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('"$nama" telah dihapus')));
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: produk.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = produk[index];
          return ProductCard(
            nama: item['nama'],
            harga: item['harga'],
            onDelete: () => _konfirmasiHapus(context, index),
            onTap: () async {
              final tambah = await Navigator.push<bool>(
                context,
                MaterialPageRoute(
                  builder: (_) => ProdukDetailPage(
                    namaProduk: item['nama'],
                    harga: item['harga'],
                  ),
                ),
              );
              if (tambah == true && context.mounted) {
                onTambahKeranjang();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${item['nama']} ditambahkan ke keranjang'),
                  ),
                );
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final hasil = await Navigator.push<Map<String, dynamic>>(
            context,
            MaterialPageRoute(builder: (_) => const TambahProdukPage()),
          );
          if (hasil != null && context.mounted) {
            onTambahProduk(hasil);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('"${hasil['nama']}" berhasil ditambahkan'),
              ),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
