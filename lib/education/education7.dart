import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart';

class Education7 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(     
      ),
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Text(
              'Daur Ulang Limbah Kain',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF216BC2),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage('assets/images/fabric.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: const Text(
                '1. Pengertian Daur Ulang Limbah Kain\n'
                'Daur ulang limbah kain adalah proses mengolah kembali sisa kain atau pakaian bekas agar dapat digunakan kembali dalam bentuk produk baru atau bahan baku industri. Limbah kain yang tidak dikelola dengan baik dapat mencemari lingkungan karena membutuhkan waktu lama untuk terurai, terutama yang berbahan sintetis seperti poliester.\n'
                'Daur ulang kain bertujuan untuk mengurangi limbah tekstil, menghemat sumber daya alam, serta mendukung konsep ekonomi sirkular dengan memanfaatkan kain bekas menjadi barang yang bernilai lebih tinggi.\n\n'
                '2. Jenis-Jenis Limbah Kain\n'
                'Limbah kain dapat dikategorikan berdasarkan asal dan jenis materialnya.\n'
                'A. Berdasarkan Asalnya\n'
                'Limbah Kain dari Industri Tekstil\n'
                'Berasal dari pabrik pakaian, konveksi, dan garmen.\n'
                'Contoh: sisa potongan kain dari produksi pakaian atau produk tekstil lainnya.\n\n'
                'Limbah Kain dari Konsumen\n'
                'Berasal dari pakaian atau produk tekstil yang sudah tidak digunakan oleh individu atau rumah tangga.\n'
                'Contoh: pakaian bekas, seprai, dan tirai lama.\n\n'
                'Limbah Kain dari Industri Mode (Fashion Waste)\n'
                'Berasal dari produksi dan pergantian tren mode yang cepat.\n'
                'Contoh: pakaian yang tidak terjual atau koleksi lama dari merek fashion.\n\n'
                'B. Berdasarkan Materialnya\n'
                'Kain Alami\n'
                'Terbuat dari serat alami yang dapat terurai lebih cepat.\n'
                'Contoh: katun, wol, linen, dan sutra.\n\n'
                'Kain Sintetis\n'
                'Terbuat dari bahan kimia yang membutuhkan waktu lebih lama untuk terurai.\n'
                'Contoh: poliester, nilon, spandeks, dan rayon.\n\n'
                'Kain Campuran\n'
                'Kombinasi antara serat alami dan sintetis.\n'
                'Contoh: kain katun-poliester, yang sering digunakan dalam produksi pakaian.\n\n'
                '3. Proses Daur Ulang Limbah Kain\n'
                'Limbah kain dapat didaur ulang melalui beberapa metode yang disesuaikan dengan kondisi bahan dan tujuan penggunaannya.\n'
                'A. Proses Daur Ulang Secara Manual (Upcycling)\n'
                'Mengubah kain bekas menjadi produk baru dengan sedikit atau tanpa pengolahan kimia.\n'
                'Contoh:\n'
                'Pakaian bekas → dijahit ulang menjadi tas, sarung bantal, atau dekorasi rumah.\n'
                'Kain perca → dibuat menjadi patchwork, selimut, atau boneka.\n\n'
                'B. Proses Daur Ulang Secara Industri\n'
                'Pengumpulan dan Pemilahan\n'
                'Kain dikumpulkan dari rumah tangga, pabrik, atau pusat daur ulang.\n'
                'Dipisahkan berdasarkan jenis bahan dan kualitasnya.\n\n'
                'Pembersihan dan Sterilisasi\n'
                'Kain dicuci untuk menghilangkan kotoran, pewarna, atau zat kimia yang menempel.\n\n'
                'Pemotongan dan Penggilingan\n'
                'Kain yang sudah tidak bisa digunakan kembali akan dihancurkan menjadi serat kain baru.\n'
                'Serat ini kemudian digunakan untuk membuat benang baru atau bahan pengisi (seperti untuk jok mobil dan matras).\n\n'
                'Pengolahan Kimiawi (Fiber Regeneration)\n'
                'Kain sintetis seperti poliester dilelehkan untuk dibuat menjadi serat kain baru.\n'
                'Proses ini membutuhkan teknologi khusus agar limbah kain bisa diolah menjadi bahan berkualitas tinggi.\n\n'
                'Produksi Produk Baru\n'
                'Serat kain yang dihasilkan dipintal menjadi benang untuk membuat pakaian atau produk tekstil baru.\n\n'
                '4. Produk Hasil Daur Ulang Limbah Kain\n'
                'Berbagai produk dapat dihasilkan dari limbah kain yang didaur ulang, antara lain:\n'
                'Pakaian dan Aksesori\n'
                'Jaket, kaos, tas, dan sepatu dari kain daur ulang.\n'
                'Patchwork fashion (pakaian dari kain perca yang dijahit ulang).\n\n'
                'Produk Rumah Tangga\n'
                'Keset, sarung bantal, taplak meja, dan selimut.\n\n'
                'Bahan Baku Industri\n'
                'Serat kain bekas digunakan sebagai bahan pengisi jok mobil, matras, dan kursi.\n\n'
                'Produk Kreatif dan Kerajinan\n'
                'Boneka, hiasan dinding, dan barang dekorasi dari kain bekas.\n\n'
                '5. Manfaat Daur Ulang Limbah Kain\n'
                'A. Manfaat Lingkungan\n'
                'Mengurangi Sampah Tekstil\n'
                'Mengurangi limbah tekstil yang berakhir di tempat pembuangan akhir (TPA).\n\n'
                'Mengurangi Konsumsi Air dan Energi\n'
                'Produksi tekstil baru membutuhkan banyak air dan energi, sehingga daur ulang membantu menghemat sumber daya alam.\n\n'
                'Mengurangi Polusi dan Emisi Karbon\n'
                'Limbah kain sintetis dapat melepaskan mikroplastik ke lingkungan jika tidak dikelola dengan baik.\n'
                'Dengan mendaur ulang, emisi karbon dari produksi tekstil baru bisa ditekan.\n\n'
                'B. Manfaat Ekonomi\n'
                'Menciptakan Lapangan Kerja\n'
                'Industri daur ulang kain membuka peluang kerja di bidang produksi, desain, dan distribusi produk berbahan kain bekas.\n\n'
                'Meningkatkan Nilai Ekonomis Barang Bekas\n'
                'Kain bekas yang diolah kembali bisa dijual sebagai produk baru dengan harga lebih tinggi.\n\n'
                'Menghemat Biaya Produksi\n'
                'Pabrik yang menggunakan serat daur ulang dapat mengurangi biaya bahan baku.\n\n'
                'C. Manfaat Sosial\n'
                'Mendorong Gaya Hidup Berkelanjutan\n'
                'Mengurangi konsumsi pakaian baru dan mendukung konsep slow fashion.\n\n'
                'Memberikan Peluang Usaha\n'
                'Banyak UMKM dan industri kreatif yang berkembang dari pemanfaatan limbah kain, seperti pembuatan tas dan produk fashion berbasis upcycling.\n\n'
                '6. Dampak Limbah Kain Jika Tidak Didaur Ulang\n'
                'Jika limbah kain tidak dikelola dengan baik, dapat menimbulkan berbagai dampak negatif:\n'
                'Peningkatan Volume Sampah\n'
                'Limbah tekstil menyumbang bagian besar dari sampah global, terutama akibat fast fashion.\n\n'
                'Pencemaran Lingkungan\n'
                'Kain sintetis seperti poliester dapat melepaskan mikroplastik ke lingkungan, yang berbahaya bagi ekosistem laut.\n\n'
                'Pemborosan Sumber Daya\n'
                'Produksi pakaian baru membutuhkan banyak air, energi, dan bahan kimia, sehingga membuang pakaian secara sembarangan berarti menyia-nyiakan sumber daya ini.\n\n'
                'Emisi Gas Rumah Kaca\n'
                'Pakaian yang dibuang ke TPA akan membusuk dan menghasilkan metana, gas yang lebih berbahaya daripada karbon dioksida bagi pemanasan global.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 3),
    );
  }

}