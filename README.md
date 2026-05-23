# Telkom Maps Firebase

Aplikasi Flutter sederhana yang mengimplementasikan Google Maps dan Firebase Realtime Database.  
Aplikasi ini menampilkan lokasi awal **Telkom University Surabaya** dan menyediakan tombol untuk berpindah lokasi ke **Jalan Tunjungan Surabaya**.

## Fitur Aplikasi

- Menampilkan Google Maps pada halaman utama.
- Lokasi awal berada di Telkom University Surabaya.
- Marker otomatis ditampilkan pada Telkom University Surabaya.
- Floating Action Button untuk berpindah ke Jalan Tunjungan Surabaya.
- Floating Action Button untuk kembali ke Telkom University Surabaya.
- Data lokasi/marker disimpan dan dibaca melalui Firebase Realtime Database.

## Teknologi yang Digunakan

- Flutter
- Dart
- Firebase Core
- Firebase Realtime Database
- Google Maps Flutter

## Struktur Project

```txt
lib/
├── main.dart
├── home_page.dart
├── map_page.dart
├── location_model.dart
├── location_service.dart
└── firebase_options.dart
```

Penjelasan singkat:

```txt
main.dart              → inisialisasi Firebase dan menjalankan aplikasi
home_page.dart         → halaman utama aplikasi
map_page.dart          → halaman Google Maps dan tombol navigasi lokasi
location_model.dart    → model data lokasi
location_service.dart  → service untuk membaca/menulis data ke Firebase Realtime Database
firebase_options.dart  → konfigurasi Firebase hasil FlutterFire CLI
```

## Tampilan dan Alur Aplikasi

Saat aplikasi dibuka:

1. Firebase diinisialisasi.
2. Google Maps ditampilkan.
3. Kamera diarahkan ke Telkom University Surabaya.
4. Marker Telkom University Surabaya ditampilkan.
5. Data marker disimpan ke Firebase Realtime Database.

Saat tombol **Ke Tunjungan** ditekan:

1. Data Jalan Tunjungan Surabaya disimpan ke Firebase.
2. Marker Jalan Tunjungan Surabaya ditampilkan.
3. Kamera Google Maps berpindah ke Jalan Tunjungan Surabaya.

Saat tombol **Ke Tel-U Surabaya** ditekan:

1. Kamera Google Maps kembali ke Telkom University Surabaya.
2. Marker Telkom University Surabaya tetap ditampilkan.

## Lokasi yang Digunakan

### Telkom University Surabaya

```txt
Latitude  : -7.3096905
Longitude : 112.7282377
```

### Jalan Tunjungan Surabaya

```txt
Latitude  : -7.27200117
Longitude : 112.74230594
```

## Persiapan Sebelum Menjalankan Project

Pastikan sudah menginstall:

- Flutter SDK
- Android Studio atau VS Code
- Android SDK
- Git
- Device Android atau emulator

Cek instalasi Flutter:

```bash
flutter doctor
```

Pastikan tidak ada error penting pada bagian Flutter, Android toolchain, dan connected device.

## Cara Menjalankan Project

Clone repository:

```bash
git clone https://github.com/username/nama-repository.git
```

Masuk ke folder project:

```bash
cd nama-repository
```

Install dependency:

```bash
flutter pub get
```

Jalankan aplikasi:

```bash
flutter run
```

## Konfigurasi Firebase

Project ini menggunakan Firebase Realtime Database.

File konfigurasi Firebase yang dibutuhkan:

```txt
lib/firebase_options.dart
android/app/google-services.json
```

Jika file tersebut sudah tersedia di repository, maka project bisa langsung dijalankan dengan:

```bash
flutter pub get
flutter run
```

Jika ingin menggunakan Firebase project sendiri, jalankan ulang konfigurasi Firebase:

```bash
flutterfire configure
```

Lalu pilih Firebase project yang ingin digunakan.

## Firebase Realtime Database

Data lokasi disimpan pada node:

```txt
locations
```

Contoh struktur data:

```json
{
  "locations": {
    "telkom_university_surabaya": {
      "label": "Telkom University Surabaya",
      "lat": -7.3096905,
      "lng": 112.7282377
    },
    "jalan_tunjungan_surabaya": {
      "label": "Jalan Tunjungan Surabaya",
      "lat": -7.27200117,
      "lng": 112.74230594
    }
  }
}
```

## Rules Firebase Realtime Database

Untuk kebutuhan praktikum, rules dapat dibuat terbuka seperti berikut:

```json
{
  "rules": {
    ".read": true,
    ".write": true
  }
}
```

Catatan: rules di atas hanya disarankan untuk praktikum atau pengujian.  
Untuk aplikasi production, rules harus dibatasi menggunakan Firebase Authentication.

## Konfigurasi Google Maps

Project ini menggunakan package:

```yaml
google_maps_flutter
```

API Key Google Maps diletakkan di file:

```txt
android/app/src/main/AndroidManifest.xml
```

Pada bagian:

```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_GOOGLE_MAPS_API_KEY" />
```

Pastikan API berikut sudah aktif di Google Cloud Console:

```txt
Maps SDK for Android
```

Jika map tidak muncul, cek beberapa hal berikut:

```txt
1. API key Google Maps sudah benar.
2. Maps SDK for Android sudah aktif.
3. Package name aplikasi sesuai dengan konfigurasi API key.
4. Jika API key dibatasi SHA-1, pastikan SHA-1 debug device sudah ditambahkan.
5. Koneksi internet device aktif.
```

## Cara Cek SHA-1 Debug

Jika Google Maps API key dibatasi menggunakan SHA-1, setiap anggota kelompok perlu menambahkan SHA-1 debug masing-masing.

Jalankan:

```bash
cd android
gradlew signingReport
```

Untuk PowerShell:

```powershell
cd android
.\gradlew signingReport
```

Cari bagian:

```txt
Variant: debug
SHA1: xx:xx:xx:xx:...
```

Tambahkan SHA-1 tersebut ke konfigurasi API key di Google Cloud Console.

## Dependency Utama

Dependency utama dapat dilihat di file `pubspec.yaml`.

Contoh dependency yang digunakan:

```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: any
  firebase_database: any
  google_maps_flutter: any
```

## File dan Folder yang Tidak Perlu Diupload ke GitHub

Folder hasil build tidak perlu diupload:

```txt
build/
.dart_tool/
android/.gradle/
```

File lokal berikut juga sebaiknya tidak diupload:

```txt
android/local.properties
```

Karena file tersebut berisi path Android SDK dan Flutter SDK di komputer masing-masing.

## Contoh `.gitignore`

Pastikan `.gitignore` memuat item berikut:

```gitignore
build/
.dart_tool/
android/.gradle/
android/local.properties
.idea/
.vscode/
*.iml
```

## Troubleshooting

### 1. Firebase tidak menampilkan data

Cek rules Realtime Database:

```json
{
  "rules": {
    ".read": true,
    ".write": true
  }
}
```

Pastikan juga URL database di `location_service.dart` sesuai dengan URL Realtime Database Firebase.

### 2. Map tidak muncul

Cek:

```txt
- API key Google Maps
- Maps SDK for Android
- AndroidManifest.xml
- koneksi internet
- package name dan SHA-1 jika API key dibatasi
```

### 3. Error Gradle memory atau Kotlin daemon

Coba jalankan:

```bash
flutter clean
flutter pub get
flutter run
```

Jika masih error, ubah file:

```txt
android/gradle.properties
```

Tambahkan atau sesuaikan:

```properties
org.gradle.jvmargs=-Xmx1536m -XX:MaxMetaspaceSize=512m -XX:+HeapDumpOnOutOfMemoryError -Dfile.encoding=UTF-8
org.gradle.workers.max=1
kotlin.incremental=false
kotlin.compiler.execution.strategy=in-process
```
