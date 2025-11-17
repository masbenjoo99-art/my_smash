import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter/foundation.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('recycle_app.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
      sqfliteFfiInit();
      final dbPath = await databaseFactoryFfi.getDatabasesPath();
      final path = join(dbPath, filePath);
      return await databaseFactoryFfi.openDatabase(path,
          options: OpenDatabaseOptions(version: 1, onCreate: _createDB));
    }

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE banksampah (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT NOT NULL,
        alamat TEXT NOT NULL,
        city TEXT NOT NULL,
        latitude REAL,
        longitude REAL,
        penanggung_jawab TEXT,
        kontak TEXT,
        email TEXT,
        jumlah_nasabah INTEGER DEFAULT 0,
        jumlah_kategori INTEGER DEFAULT 0
      )
    ''');

    // Tabel kategori sampah
    await db.execute('''
      CREATE TABLE kategori_sampah (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        bank_sampah_id INTEGER,
        nama_kategori TEXT NOT NULL,
        harga_per_kg INTEGER NOT NULL,
        satuan TEXT DEFAULT 'KG',
        last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (bank_sampah_id) REFERENCES banksampah (id) ON DELETE CASCADE
      )
    ''');

    // ✅ TABEL BARU: Smart Drop Box
    await db.execute('''
      CREATE TABLE smart_drop_box (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT NOT NULL,
        lokasi TEXT NOT NULL,
        city TEXT NOT NULL,
        latitude REAL,
        longitude REAL,
        status TEXT DEFAULT 'aktif',
        jenis_sampah TEXT DEFAULT 'botol plastik, kaleng, cup plastik',
        reward_per_item INTEGER DEFAULT 50,
        qr_code TEXT,
        jam_operasional TEXT DEFAULT '24 Jam'
      )
    ''');
  }

  /// ✅ Ambil semua bank sampah
  Future<List<Map<String, dynamic>>> getAllBankSampah() async {
    final db = await database;
    return await db.query('banksampah', orderBy: 'nama ASC');
  }

  /// ✅ Ambil daftar kota unik KHUSUS BANK SAMPAH - TAMBAHAN BARU
  Future<List<String>> getBankSampahCities() async {
    final db = await database;
    final result = await db.rawQuery("SELECT DISTINCT city FROM banksampah ORDER BY city");
    return result.map((row) => row['city'] as String).toList();
  }

  /// ✅ Ambil daftar kota unik KHUSUS SMART DROP BOX - TAMBAHAN BARU
  Future<List<String>> getSmartDropBoxCities() async {
    final db = await database;
    final result = await db.rawQuery("SELECT DISTINCT city FROM smart_drop_box ORDER BY city");
    return result.map((row) => row['city'] as String).toList();
  }

  /// ✅ Ambil daftar kota unik (backward compatibility - return Bank Sampah cities)
  Future<List<String>> getAllCities() async {
    return getBankSampahCities();
  }

  /// ✅ Ambil semua bank sampah berdasarkan kota
  Future<List<Map<String, dynamic>>> getBanksByCity(String city) async {
    final db = await database;
    return await db.query(
      'banksampah',
      where: 'LOWER(city) = ?',
      whereArgs: [city.toLowerCase()],
      orderBy: 'nama ASC',
    );
  }

  /// ✅ Search bank sampah berdasarkan multiple field - TAMBAHAN BARU
  Future<List<Map<String, dynamic>>> searchBankSampah(String query) async {
    final db = await database;
    if (query.isEmpty) return getAllBankSampah();
    
    final lowerQuery = query.toLowerCase();
    return await db.rawQuery('''
      SELECT * FROM banksampah 
      WHERE LOWER(nama) LIKE ? 
         OR LOWER(alamat) LIKE ? 
         OR LOWER(city) LIKE ? 
         OR LOWER(penanggung_jawab) LIKE ?
         OR LOWER(kontak) LIKE ?
         OR LOWER(email) LIKE ?
      ORDER BY 
        CASE 
          WHEN LOWER(nama) LIKE ? THEN 1
          WHEN LOWER(city) LIKE ? THEN 2
          WHEN LOWER(alamat) LIKE ? THEN 3
          ELSE 4
        END,
        nama ASC
    ''', [
      '%$lowerQuery%', '%$lowerQuery%', '%$lowerQuery%', '%$lowerQuery%',
      '%$lowerQuery%', '%$lowerQuery%',
      '%$lowerQuery%', '%$lowerQuery%', '%$lowerQuery%'
    ]);
  }

  /// ✅ Search kota BANK SAMPAH berdasarkan nama - TAMBAHAN BARU
  Future<List<String>> searchBankSampahCities(String query) async {
    final db = await database;
    if (query.isEmpty) return getBankSampahCities();
    
    final result = await db.rawQuery('''
      SELECT DISTINCT city FROM banksampah 
      WHERE LOWER(city) LIKE ? 
      ORDER BY city
    ''', ['%${query.toLowerCase()}%']);
    
    return result.map((row) => row['city'] as String).toList();
  }

  /// ✅ Search kota SMART DROP BOX berdasarkan nama - TAMBAHAN BARU
  Future<List<String>> searchSmartDropBoxCities(String query) async {
    final db = await database;
    if (query.isEmpty) return getSmartDropBoxCities();
    
    final result = await db.rawQuery('''
      SELECT DISTINCT city FROM smart_drop_box 
      WHERE LOWER(city) LIKE ? 
      ORDER BY city
    ''', ['%${query.toLowerCase()}%']);
    
    return result.map((row) => row['city'] as String).toList();
  }

  /// ✅ Search kota berdasarkan nama (backward compatibility - return Bank Sampah cities)
  Future<List<String>> searchCities(String query) async {
    return searchBankSampahCities(query);
  }

  /// ✅ Ambil kategori sampah berdasarkan bank sampah ID - TAMBAHAN BARU
  Future<List<Map<String, dynamic>>> getKategoriSampahByBankId(int bankId) async {
    final db = await database;
    return await db.query(
      'kategori_sampah',
      where: 'bank_sampah_id = ?',
      whereArgs: [bankId],
      orderBy: 'nama_kategori ASC',
    );
  }

  /// ✅ Insert kategori sampah - TAMBAHAN BARU
  Future<int> insertKategoriSampah(Map<String, dynamic> kategori) async {
    final db = await database;
    return await db.insert('kategori_sampah', kategori);
  }

  /// ✅ Seed data kategori sampah untuk bank tertentu - TAMBAHAN BARU
  Future<void> seedKategoriSampah(int bankSampahId) async {
    final db = await database;
    
    // Cek apakah sudah ada data kategori untuk bank ini
    final existing = await db.query(
      'kategori_sampah',
      where: 'bank_sampah_id = ?',
      whereArgs: [bankSampahId],
      limit: 1,
    );
    
    if (existing.isNotEmpty) {
      debugPrint("🔹 Kategori sampah untuk bank ID $bankSampahId sudah ada");
      return;
    }

    var batch = db.batch();

    // Data kategori sesuai gambar
    final kategoriData = [
      {'nama_kategori': 'Duplex', 'harga_per_kg': 500},
      {'nama_kategori': 'Koran', 'harga_per_kg': 2800},
      {'nama_kategori': 'Kardus', 'harga_per_kg': 1200},
      {'nama_kategori': 'Arsip', 'harga_per_kg': 2000},
      {'nama_kategori': 'Buram', 'harga_per_kg': 1100},
      {'nama_kategori': 'Kerasan', 'harga_per_kg': 900},
      {'nama_kategori': 'Putihan', 'harga_per_kg': 3500},
      {'nama_kategori': 'Bodong', 'harga_per_kg': 2700},
      {'nama_kategori': 'Kabel', 'harga_per_kg': 1400},
      {'nama_kategori': 'Plastik', 'harga_per_kg': 1100},
      {'nama_kategori': 'PE', 'harga_per_kg': 1600},
      {'nama_kategori': 'HD', 'harga_per_kg': 1100},
      {'nama_kategori': 'Kabin', 'harga_per_kg': 1400},
    ];

    for (var kategori in kategoriData) {
      batch.insert('kategori_sampah', {
        'bank_sampah_id': bankSampahId,
        'nama_kategori': kategori['nama_kategori'],
        'harga_per_kg': kategori['harga_per_kg'],
        'satuan': 'KG',
      });
    }

    await batch.commit(noResult: true);
    debugPrint("🔹 Seeding ${kategoriData.length} kategori sampah untuk bank ID $bankSampahId selesai");
  }

  /// ✅ Seed kategori untuk Bank Sampah Akar Rumput Janti berdasarkan NAMA, bukan ID - TAMBAHAN BARU
  Future<void> seedKategoriSampahByName() async {
    final db = await database;
    
    // Cari ID bank berdasarkan nama
    final result = await db.query(
      'banksampah',
      columns: ['id'],
      where: 'nama = ?',
      whereArgs: ['Bank Sampah Akar Rumput Janti'],
      limit: 1,
    );
    
    if (result.isEmpty) {
      debugPrint("🔹 Bank Sampah Akar Rumput Janti tidak ditemukan");
      return;
    }
    
    final bankId = result.first['id'] as int;
    debugPrint("🔹 Bank Sampah Akar Rumput Janti ditemukan dengan ID: $bankId");
    
    await seedKategoriSampah(bankId);
  }

  /// ✅ SMART DROP BOX METHODS - TAMBAHAN BARU

  /// Ambil semua smart drop box
  Future<List<Map<String, dynamic>>> getAllSmartDropBox() async {
    final db = await database;
    return await db.query('smart_drop_box', orderBy: 'nama ASC');
  }

  /// Ambil smart drop box berdasarkan kota
  Future<List<Map<String, dynamic>>> getSmartDropBoxByCity(String city) async {
    final db = await database;
    return await db.query(
      'smart_drop_box',
      where: 'LOWER(city) = ?',
      whereArgs: [city.toLowerCase()],
      orderBy: 'nama ASC',
    );
  }

  /// Search smart drop box berdasarkan multiple field
  Future<List<Map<String, dynamic>>> searchSmartDropBox(String query) async {
    final db = await database;
    if (query.isEmpty) return getAllSmartDropBox();
    
    final lowerQuery = query.toLowerCase();
    return await db.rawQuery('''
      SELECT * FROM smart_drop_box 
      WHERE LOWER(nama) LIKE ? 
         OR LOWER(lokasi) LIKE ? 
         OR LOWER(city) LIKE ? 
      ORDER BY 
        CASE 
          WHEN LOWER(nama) LIKE ? THEN 1
          WHEN LOWER(city) LIKE ? THEN 2
          ELSE 3
        END,
        nama ASC
    ''', [
      '%$lowerQuery%', '%$lowerQuery%', '%$lowerQuery%',
      '%$lowerQuery%', '%$lowerQuery%'
    ]);
  }

  /// ✅ UPDATE: Seed data REAL smart drop box Bandung
  Future<void> seedSmartDropBoxIfEmpty() async {
    final db = await database;
    final count = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM smart_drop_box'),
    );
    
    if (count == 0) {
      var batch = db.batch();

      // ✅ DATA REAL Smart Drop Box Bandung - Program Desa Digital Sadar Sampah
      batch.insert('smart_drop_box', {
        'nama': 'Smart Drop Box Desa Cipagalo',
        'lokasi': 'Desa Cipagalo, Kab. Bandung',
        'city': 'Bandung',
        'latitude': -6.9775,
        'longitude': 107.6539,
        'status': 'aktif',
        'jenis_sampah': 'Botol plastik, Cup plastik, Kaleng',
        'reward_per_item': 100,
        'qr_code': 'SDB_Cipagalo',
        'jam_operasional': '24 Jam',
      });

      batch.insert('smart_drop_box', {
        'nama': 'Smart Drop Box Desa Dayeuhkolot',
        'lokasi': 'Desa Dayeuhkolot, Kab. Bandung',
        'city': 'Bandung',
        'latitude': -6.9771,
        'longitude': 107.6139,
        'status': 'aktif',
        'jenis_sampah': 'Botol plastik, Botol kaca, Kaleng',
        'reward_per_item': 75,
        'qr_code': 'SDB_Dayeuhkolot',
        'jam_operasional': '06:00 - 22:00',
      });

      batch.insert('smart_drop_box', {
        'nama': 'Smart Drop Box Desa Bojongsoang',
        'lokasi': 'Desa Bojongsoang, Kab. Bandung',
        'city': 'Bandung',
        'latitude': -6.9697,
        'longitude': 107.5999,
        'status': 'aktif',
        'jenis_sampah': 'Botol plastik, Cup plastik',
        'reward_per_item': 50,
        'qr_code': 'SDB_Bojongsoang',
        'jam_operasional': '07:00 - 19:00',
      });

      batch.insert('smart_drop_box', {
        'nama': 'Smart Drop Box Desa Wangisagara',
        'lokasi': 'Desa Wangisagara, Kab. Bandung',
        'city': 'Bandung',
        'latitude': -6.9994,
        'longitude': 107.6688,
        'status': 'aktif',
        'jenis_sampah': 'Botol plastik, Kaleng, Cup plastik, Kardus kecil',
        'reward_per_item': 80,
        'qr_code': 'SDB_Wangisagara',
        'jam_operasional': '10:00 - 22:00',
      });

      batch.insert('smart_drop_box', {
        'nama': 'Smart Drop Box Kel. Wargamekar',
        'lokasi': 'Kelurahan Wargamekar, Kab. Bandung',
        'city': 'Bandung',
        'latitude': -6.9733,
        'longitude': 107.6312,
        'status': 'aktif',
        'jenis_sampah': 'Semua jenis sampah plastik',
        'reward_per_item': 120,
        'qr_code': 'SDB_Wargamekar',
        'jam_operasional': '24 Jam',
      });

      batch.insert('smart_drop_box', {
        'nama': 'Smart Drop Box Kel. Baleendah',
        'lokasi': 'Kelurahan Baleendah, Kab. Bandung',
        'city': 'Bandung',
        'latitude': -7.0246,
        'longitude': 107.6358,
        'status': 'aktif',
        'jenis_sampah': 'Botol plastik, Botol kaca, Kaleng',
        'reward_per_item': 90,
        'qr_code': 'SDB_Baleendah',
        'jam_operasional': '24 Jam',
      });

      await batch.commit(noResult: true);
      debugPrint("🔹 Seeding 6 Smart Drop Box Bandung (Data Real) selesai");
    } else {
      debugPrint("🔹 Smart Drop Box data sudah ada, jumlah: $count");
    }
  }

  /// ✅ Method untuk reset database BENAR-BENAR BERSIH - TAMBAHAN BARU
  Future<void> resetDatabaseCompletely() async {
    try {
      if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
        final dbPath = await databaseFactoryFfi.getDatabasesPath();
        final path = join(dbPath, 'recycle_app.db');
        // Hapus file database
        final file = File(path);
        if (await file.exists()) {
          await file.delete();
          debugPrint("🔹 Database file desktop berhasil dihapus");
        }
      } else {
        final dbPath = await getDatabasesPath();
        final path = join(dbPath, 'recycle_app.db');
        final file = File(path);
        if (await file.exists()) {
          await file.delete();
          debugPrint("🔹 Database file mobile berhasil dihapus");
        }
      }
      _database = null;
    } catch (e) {
      debugPrint("⚠️ Error reset database: $e");
    }
  }

  /// ✅ Method untuk menghapus database (untuk reset) - FIXED
  Future<void> deleteDatabase() async {
    try {
      if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
        final dbPath = await databaseFactoryFfi.getDatabasesPath();
        final path = join(dbPath, 'recycle_app.db');
        await databaseFactoryFfi.deleteDatabase(path);
        debugPrint("🔹 Database desktop berhasil dihapus");
      } else {
        final dbPath = await getDatabasesPath();
        final path = join(dbPath, 'recycle_app.db');
        await databaseFactory.deleteDatabase(path); // ✅ FIX: hapus recursive call
        debugPrint("🔹 Database mobile berhasil dihapus");
      }
      _database = null;
    } catch (e) {
      debugPrint("⚠️ Error menghapus database: $e");
    }
  }

  Future<void> seedBankSampahIfEmpty() async {
    final db = await database;
    final count = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM banksampah'),
    );
    if (count == 0) {
      var batch = db.batch();

      // Data sesuai dengan gambar yang user kirimkan
      batch.insert('banksampah', {
        'nama': 'Bank Sampah Akar Rumput Janti',
        'alamat': 'Janti Gg Kruwing 3 no 9, RT 10/Rw 05 Catrurtunggal',
        'city': 'Yogyakarta',
        'latitude': -7.7591,
        'longitude': 110.3875,
        'penanggung_jawab': 'Rustian Taruna',
        'kontak': '081328769991',
        'email': 'rustianf63@gmail.com',
        'jumlah_nasabah': 0,
        'jumlah_kategori': 13,
      });

      batch.insert('banksampah', {
        'nama': 'Bank Sampah Sorasem 39',
        'alamat': 'Komp. Museum Karate Kraton Yogyakarta, Jln. Rotowijayan No2, RT 039/RW 011 Kel Kadipaten Kec Kraton Yogyakarta 55132',
        'city': 'Yogyakarta',
        'latitude': -7.8056,
        'longitude': 110.3647,
        'penanggung_jawab': 'Siti Rahayu',
        'kontak': '081234567890',
        'email': 'sorasem39@gmail.com',
        'jumlah_nasabah': 45,
        'jumlah_kategori': 8,
      });

      batch.insert('banksampah', {
        'nama': 'Bank Sampah Akprind Yogyakarta',
        'alamat': 'IST AKPRIND Jl. Bimasakti No. 3 Pengok, Gondokusuman, Kota Yogyakarta',
        'city': 'Yogyakarta',
        'latitude': -7.7827,
        'longitude': 110.3783,
        'penanggung_jawab': 'Dr. Ahmad Wijaya',
        'kontak': '081345678901',
        'email': 'banksampah@akprind.ac.id',
        'jumlah_nasabah': 120,
        'jumlah_kategori': 12,
      });

      batch.insert('banksampah', {
        'nama': 'Bank Sampah Melati Husada',
        'alamat': 'RS Dr Sardjito, Jalan Kesehatan No. 1 Yogyakarta',
        'city': 'Yogyakarta',
        'latitude': -7.7686,
        'longitude': 110.3721,
        'penanggung_jawab': 'dr. Maria Sari',
        'kontak': '081456789012',
        'email': 'melati.husada@sardjito.co.id',
        'jumlah_nasabah': 89,
        'jumlah_kategori': 10,
      });

      batch.insert('banksampah', {
        'nama': 'Bank Sampah Berkah',
        'alamat': 'Gulon RT. 02 Srirandono Pundong Bantul Yogyakarta',
        'city': 'Yogyakarta',
        'latitude': -7.9502,
        'longitude': 110.3390,
        'penanggung_jawab': 'Budi Santoso',
        'kontak': '081567890123',
        'email': 'berkah.pundong@gmail.com',
        'jumlah_nasabah': 33,
        'jumlah_kategori': 7,
      });

      batch.insert('banksampah', {
        'nama': 'Bank Sampah Bendowo Makmur',
        'alamat': 'Pasar Kepuh, Bendowo, Pampang, Paliyan, Gunungkidul',
        'city': 'Yogyakarta',
        'latitude': -8.0215,
        'longitude': 110.5712,
        'penanggung_jawab': 'Tri Wulandari',
        'kontak': '081678901234',
        'email': 'bendowo.makmur@gmail.com',
        'jumlah_nasabah': 67,
        'jumlah_kategori': 9,
      });

      batch.insert('banksampah', {
        'nama': 'Bank Sampah Anugerah 07',
        'alamat': 'Iromejan GK III/616 RT 30 RW 07 Yogyakarta 55223',
        'city': 'Yogyakarta',
        'latitude': -7.7812,
        'longitude': 110.3679,
        'penanggung_jawab': 'Dwi Lestari',
        'kontak': '081890123456',
        'email': 'anugerah07@gmail.com',
        'jumlah_nasabah': 28,
        'jumlah_kategori': 6,
      });

      batch.insert('banksampah', {
        'nama': 'Bank Sampah Balak',
        'alamat': 'Balak, Pendoworejo, Girimulyo, Kulon Progo',
        'city': 'Yogyakarta',
        'latitude': -7.7652,
        'longitude': 110.1843,
        'penanggung_jawab': 'Joko Susilo',
        'kontak': '081901234567',
        'email': 'balak.girimulyo@gmail.com',
        'jumlah_nasabah': 41,
        'jumlah_kategori': 8,
      });

      batch.insert('banksampah', {
        'nama': 'Bank Sampah Lintas Winongo',
        'alamat': 'RW 11 Badran Bumijo, Jetis Yogyakarta',
        'city': 'Yogyakarta',
        'latitude': -7.7873,
        'longitude': 110.3608,
        'penanggung_jawab': 'Sri Mulyani',
        'kontak': '082012345678',
        'email': 'lintas.winongo@gmail.com',
        'jumlah_nasabah': 72,
        'jumlah_kategori': 10,
      });

      batch.insert('banksampah', {
        'nama': 'Bank Sampah Kapareksi Nawa',
        'alamat': 'Jl. Masjid No. 16 Rt. 36 Rw.09 Gunungketur Pakualaman',
        'city': 'Yogyakarta',
        'latitude': -7.7993,
        'longitude': 110.3737,
        'penanggung_jawab': 'Rini Astuti',
        'kontak': '082123456789',
        'email': 'kapareksi.nawa@gmail.com',
        'jumlah_nasabah': 36,
        'jumlah_kategori': 9,
      });

      batch.insert('banksampah', {
        'nama': 'Bank Sampah Berseri 35',
        'alamat': 'Bumijo Kulon 1 j1/1077 H Rt 35/08 Yogyakarta',
        'city': 'Yogyakarta',
        'latitude': -7.7911,
        'longitude': 110.3635,
        'penanggung_jawab': 'Agus Priyanto',
        'kontak': '082234567890',
        'email': 'berseri35@gmail.com',
        'jumlah_nasabah': 58,
        'jumlah_kategori': 7,
      });

      batch.insert('banksampah', {
        'nama': 'Bank Sampah Pa-Q-One',
        'alamat': 'Gedongkiwo MJ I031 Yogyakarta RT 55 RW 11 Kel Gedongkiwo Kemantren Mantrijeron',
        'city': 'Yogyakarta',
        'latitude': -7.8164,
        'longitude': 110.3577,
        'penanggung_jawab': 'Eka Sari',
        'kontak': '082345678901',
        'email': 'paqone.gedongkiwo@gmail.com',
        'jumlah_nasabah': 47,
        'jumlah_kategori': 8,
      });

      batch.insert('banksampah', {
        'nama': 'Bank Sampah Srikandi Mandiri',
        'alamat': 'Tawarsari rt06 rw18 Wonosari Kab. Gunungkidul',
        'city': 'Yogyakarta',
        'latitude': -7.9664,
        'longitude': 110.6020,
        'penanggung_jawab': 'Indah Permata',
        'kontak': '082456789012',
        'email': 'srikandi.mandiri@gmail.com',
        'jumlah_nasabah': 63,
        'jumlah_kategori': 11,
      });

      batch.insert('banksampah', {
        'nama': 'Timdis ID',
        'alamat': 'Jl. Kesehatan No.1, Sendowo, Sinduadi, Mlati, Sleman',
        'city': 'Yogyakarta',
        'latitude': -7.7625,
        'longitude': 110.3699,
        'penanggung_jawab': 'Hendra Wijaya',
        'kontak': '082567890123',
        'email': 'timdis@gmail.com',
        'jumlah_nasabah': 95,
        'jumlah_kategori': 15,
      });

      batch.insert('banksampah', {
        'nama': 'Bank Sampah Taman Resik Lestari Tamantirto',
        'alamat': 'Tamantirto, Kasihan, Bantul',
        'city': 'Yogyakarta',
        'latitude': -7.8274,
        'longitude': 110.3302,
        'penanggung_jawab': 'Yoga Pratama',
        'kontak': '082678901234',
        'email': 'tamanresik.tamantirto@gmail.com',
        'jumlah_nasabah': 84,
        'jumlah_kategori': 12,
      });

      batch.insert('banksampah', {
        'nama': 'Bank Sampah Barokah MJ',
        'alamat': 'Jl. Mangkuyudan 55, Kel Mantrijeron, Yogyakarta',
        'city': 'Yogyakarta',
        'latitude': -7.8152,
        'longitude': 110.3573,
        'penanggung_jawab': 'Fatimah Zahra',
        'kontak': '082789012345',
        'email': 'barokah.mantrijeron@gmail.com',
        'jumlah_nasabah': 52,
        'jumlah_kategori': 9,
      });

      batch.insert('banksampah', {
        'nama': 'Bank Sampah Muda Raharja',
        'alamat': 'Benyo Sendangsari Pajangan Bantul',
        'city': 'Yogyakarta',
        'latitude': -7.8641,
        'longitude': 110.2985,
        'penanggung_jawab': 'Rahmat Hidayat',
        'kontak': '082890123456',
        'email': 'mudaraharja.pajangan@gmail.com',
        'jumlah_nasabah': 39,
        'jumlah_kategori': 8,
      });

      batch.insert('banksampah', {
        'nama': 'Bank Sampah KTMB',
        'alamat': 'Ngosari 1, Wukirsari, Imogiri, Bantul',
        'city': 'Yogyakarta',
        'latitude': -7.9167,
        'longitude': 110.3949,
        'penanggung_jawab': 'Lilis Suryani',
        'kontak': '082901234567',
        'email': 'ktmb.imogiri@gmail.com',
        'jumlah_nasabah': 76,
        'jumlah_kategori': 10,
      });

      batch.insert('banksampah', {
        'nama': 'Bank Sampah Pesona 05',
        'alamat': 'Manggung RT 05, Wukirsari, Imogiri, Bantul',
        'city': 'Yogyakarta',
        'latitude': -7.9128,
        'longitude': 110.3925,
        'penanggung_jawab': 'Dewi Anggraini',
        'kontak': '083012345678',
        'email': 'pesona05.imogiri@gmail.com',
        'jumlah_nasabah': 61,
        'jumlah_kategori': 9,
      });

      batch.insert('banksampah', {
        'nama': 'Bank Sampah RS Bethesda',
        'alamat': 'Jl. Jend. Sudirman No.70, Kotabaru, Yogyakarta',
        'city': 'Yogyakarta',
        'latitude': -7.7824,
        'longitude': 110.3729,
        'penanggung_jawab': 'dr. David Simanullang',
        'kontak': '083123456789',
        'email': 'banksampah@bethesda.or.id',
        'jumlah_nasabah': 103,
        'jumlah_kategori': 14,
      });

      batch.insert('banksampah', {
        'nama': 'Bank Sampah Pintar',
        'alamat': 'Mojohuro, Imogiri - Siluk, Sriharjo, Bantul',
        'city': 'Yogyakarta',
        'latitude': -7.9007,
        'longitude': 110.3622,
        'penanggung_jawab': 'Novi Ratnasari',
        'kontak': '083234567890',
        'email': 'banksampah.pintar@gmail.com',
        'jumlah_nasabah': 48,
        'jumlah_kategori': 11,
      });

      batch.insert('banksampah', {
        'nama': 'Bank Sampah Singo Ras 03',
        'alamat': 'Omah Mbah Singosaren RT 03 Wukirsari, Imogiri, Bantul',
        'city': 'Yogyakarta',
        'latitude': -7.9135,
        'longitude': 110.3912,
        'penanggung_jawab': 'Sugeng Riyanto',
        'kontak': '083345678901',
        'email': 'singoras03@gmail.com',
        'jumlah_nasabah': 34,
        'jumlah_kategori': 7,
      });

      await batch.commit(noResult: true);
      print("🔹 Seeding 22 data Bank Sampah Yogyakarta dengan data lengkap selesai");
      
      // ✅ UPDATE: Gunakan nama, bukan asumsi ID=1 (lebih robust)
      await Future.delayed(Duration(milliseconds: 100));
      await seedKategoriSampahByName(); // Lebih safe daripada seedKategoriSampah(1)
      
      // ✅ TAMBAHAN: Seed Smart Drop Box
      await seedSmartDropBoxIfEmpty();
      
    } else {
      print("🔹 Data sudah ada, jumlah: $count");
      
      // ✅ TAMBAHAN: Cek dan seed Smart Drop Box jika belum ada
      await seedSmartDropBoxIfEmpty();
    }
  }
}
