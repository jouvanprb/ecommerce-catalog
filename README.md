# Katalog Produk E-Commerce (Tugas Front-End Rakamin)

Aplikasi Vue.js yang dinamis dan responsif untuk menampilkan produk yang diambil dari [Fake Store API](https://fakestoreapi.com/). Proyek ini berfokus pada pemotongan antarmuka (UI Slicing), manajemen *state*, dan pergantian tema dinamis berdasarkan kategori produk.

## 🚀 Fitur Utama

- **Pengambilan Data Dinamis**: Mengambil data produk secara *real-time* (judul, gambar, deskripsi, harga, rating) dari Fake Store API.
- **Tema Berdasarkan Kategori**: Mengubah skema warna aplikasi secara otomatis berdasarkan kategori produk:
  -  **Men's Clothing**: Menggunakan tema biru tua modern (`#002772`) dengan latar belakang biru muda.
  -  **Women's Clothing**: Menggunakan tema magenta elegan (`#720060`) dengan latar belakang merah muda lembut.
  -  **Unavailable**: Menampilkan antarmuka bersih berwarna abu-abu untuk kategori yang tidak didukung (seperti elektronik atau perhiasan) dilengkapi tombol "Next product" yang interaktif.
- **UI yang Presisi (Pixel-Perfect)**: Kartu produk dipotong secara akurat dengan ukuran tinggi yang konsisten, desain lingkaran rating menggunakan CSS kustom, dan penanganan teks panjang (*overflow*) yang sangat rapi.
- **Arsitektur Bersih**: Seluruh CSS dikelola secara terpusat melalui *file* eksternal `main.css` sehingga komponen Vue tetap bersih dan hanya berfokus pada struktur HTML serta logika JavaScript.

## 🛠️ Teknologi yang Digunakan

- **Framework**: [Vue.js 2]
- **Styling**: Vanilla CSS (Gaya Global di `src/assets/style/main.css`)
- **Font**: [Inter](https://fonts.google.com/specimen/Inter) (Google Fonts)

## 📦 Panduan Menjalankan Proyek (Local vs Docker)

Proyek ini menyediakan dua cara untuk dijalankan: **Local Development** (untuk proses *ngoding*) dan **Docker** (untuk tahap *Production* atau rilis). Berikut adalah perbedaannya:

### 1. Local Development (Untuk Tahap Pengembangan)
Cara ini sangat cocok digunakan saat Anda sedang mengedit kode. Fitur *hot-reload* akan otomatis me-*refresh browser* setiap kali Anda menyimpan perubahan kode. Server yang digunakan adalah *development server* bawaan Node.js yang ringan namun tidak dioptimasi untuk publik.

**Cara menjalankan:**
```bash
# 1. Instal semua library yang dibutuhkan
npm install

# 2. Jalankan server pengembangan lokal
npm run serve
```
Buka `http://localhost:8080` di *browser*. 

*(Jika Anda ingin mem-build secara manual untuk melihat hasil akhir statisnya, gunakan perintah `npm run build` dan `npm run lint` untuk memperbaiki kode).*

---

### 2. Docker (Untuk Tahap Production / Rilis)
Proyek ini sudah dilengkapi dengan `Dockerfile` bersistem *multi-stage build*. Cara ini dirancang khusus untuk lingkungan **Production**. Mengapa menggunakan Docker?
- **Isolasi Lingkungan**: Aplikasi berjalan di dalam *container* yang stabil, tidak peduli sistem operasi apa pun yang menjalankan Docker.
- **Performa Maksimal**: Tahap pertama (`build-stage`) akan melakukan `npm run build` untuk menghasilkan *file statis* HTML, CSS, dan JS yang telah dikecilkan ukurannya (*minified*).
- **Web Server Asli**: Tahap kedua (`production-stage`) akan memasukkan *file statis* tersebut ke dalam **NGINX**, sebuah web server berperforma super tinggi yang jauh lebih stabil dan cepat dibanding *development server* Node.js. NGINX ini berjalan di port 80.

**Cara menjalankan:**
```bash
# 1. Build image Docker dari proyek ini (beri nama 'ecommerce-app')
docker build -t ecommerce-app .

# 2. Jalankan container di port 8080 lokal yang terhubung ke port 80 NGINX
docker run -p 8080:80 ecommerce-app
```
Buka `http://localhost:8080` di *browser*. Hasil yang Anda lihat adalah versi rilis (*production*) murni yang dilayani oleh NGINX.

## ☁️ Deployment (CI/CD)

Proyek ini telah dikonfigurasi untuk proses *deployment* otomatis ke **Firebase Hosting** menggunakan **GitHub Actions**.

### Prasyarat
1. Sebuah proyek Firebase telah dibuat di [Firebase Console](https://console.firebase.google.com/).
2. Firebase CLI telah diinstal secara global (`npm install -g firebase-tools`).
3. Inisialisasi Firebase secara lokal menggunakan perintah `firebase init hosting` (Pilih folder publik `dist`, dan atur sebagai *single-page app*).
4. Buat token CI Firebase dengan menjalankan `firebase login:ci` di terminal Anda.
5. Tambahkan token yang dihasilkan ke dalam daftar rahasia (*secrets*) repositori GitHub Anda:
   - Buka **Settings** > **Secrets and variables** > **Actions** > **New repository secret**.
   - **Name**: `FIREBASE_TOKEN`
   - **Secret**: *(Tempel token panjang Anda di sini)*

### Alur Kerja GitHub Actions (CI/CD)

**Apa itu folder `.github/workflows`?**
Folder ini adalah direktori khusus yang dibaca oleh sistem GitHub untuk menjalankan **GitHub Actions**. Di dalam folder ini, terdapat file `.yml` (seperti `deploy.yml`) yang berisi "skrip instruksi" (kapan harus berjalan, apa sistem operasinya, dan perintah apa saja yang harus dieksekusi). Saat ada kejadian (*event*) seperti kode di-*push*, GitHub akan melihat ke dalam folder ini dan menjalankan perintah secara otomatis di *server* (komputer virtual) milik GitHub.

Berikut adalah ilustrasi alur kerja dari mesin lokal hingga ke pengunjung website:

```text
┌─────────────────────────────────────────────────────────────────────────────┐
│                           DEVELOPER (ANDA)                                  │
│                                                                             │
│   ┌──────────────┐      ┌──────────────┐      ┌──────────────┐              │
│   │  Edit Kode   │ ───▶ │  git add .   │ ───▶ │ git commit   │              │
│   │  (VS Code)   │      │              │      │  -m "pesan"  │              │
│   └──────────────┘      └──────────────┘      └──────────────┘              │
│                                                                             │
│                                                      │                      │
│                                                      ▼                      │
│                                            ┌──────────────┐                 │
│                                            │ git push     │                 │
│                                            │ origin main  │                 │
│                                            └──────────────┘                 │
└─────────────────────────────────────────────────────────────────────────────┘
                                                      │
                                                      ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                           GITHUB (Repository)                               │
│                                                                             │
│   ┌──────────────────────────────────────────────────────────────────────┐  │
│   │  Branch: main                                                        │  │
│   │  ┌────────────────────────────────────────────────────────────────┐  │  │
│   │  │  Kode terbaru diterima                                         │  │  │
│   │  └────────────────────────────────────────────────────────────────┘  │  │
│   └──────────────────────────────────────────────────────────────────────┘  │
│                                                                             │
│                                                      │                      │
│                                                      ▼                      │
│   ┌──────────────────────────────────────────────────────────────────────┐  │
│   │                     GITHUB ACTIONS (CI/CD)                           │  │
│   │                                                                      │  │
│   │   ⚠️ TRIGGER: Push ke branch main                                     │  │
│   │   ⏰ OTOMATIS: Sistem membaca folder `.github/workflows/deploy.yml`   │  │
│   └──────────────────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────────────────┘
                                                      │
                                                      ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                         GITHUB ACTIONS (Proses Build)                       │
│                                                                             │
│   ┌─────────────────────────────────────────────────────────────────────┐   │
│   │                                                                     │   │
│   │   Step 1: Checkout code                                             │   │
│   │   ┌─────────────────────────────────────────────────────────────┐   │   │
│   │   │  "Mengambil kode terbaru dari repositori"                   │   │   │
│   │   └─────────────────────────────────────────────────────────────┘   │   │
│   │                              │                                      │   │
│   │                              ▼                                      │   │
│   │   Step 2: Setup Node.js                                             │   │
│   │   ┌─────────────────────────────────────────────────────────────┐   │   │
│   │   │  "Menyiapkan environment Ubuntu & Node.js versi 18"         │   │   │
│   │   └─────────────────────────────────────────────────────────────┘   │   │
│   │                              │                                      │   │
│   │                              ▼                                      │   │
│   │   Step 3: Install dependencies                                      │   │
│   │   ┌─────────────────────────────────────────────────────────────┐   │   │
│   │   │  "npm install" → Mengunduh library yang dibutuhkan          │   │   │
│   │   └─────────────────────────────────────────────────────────────┘   │   │
│   │                              │                                      │   │
│   │                              ▼                                      │   │
│   │   Step 4: Build project                                             │   │
│   │   ┌─────────────────────────────────────────────────────────────┐   │   │
│   │   │  "npm run build" → Kompilasi Vue jadi file statis (dist)    │   │   │
│   │   └─────────────────────────────────────────────────────────────┘   │   │
│   │                              │                                      │   │
│   │                              ▼                                      │   │
│   │   Step 5: Deploy to Firebase                                        │   │
│   │   ┌─────────────────────────────────────────────────────────────┐   │   │
│   │   │  Menggunakan FIREBASE_TOKEN untuk upload /dist ke Firebase  │   │   │
│   │   └─────────────────────────────────────────────────────────────┘   │   │
│   │                                                                     │   │
│   └─────────────────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────────────────┘
                                                      │
                                                      ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                           FIREBASE HOSTING                                  │
│                                                                             │
│   ┌──────────────────────────────────────────────────────────────────────┐  │
│   │                                                                      │  │
│   │   🌐 Website LIVE: https://vue-ecommerce-597a6.web.app/              │  │
│   │                                                                      │  │
│   │   ┌────────────────────────────────────────────────────────────────  │  │
│   │   │  File siap saji: index.html, css/, js/                         │ │  │
│   │   └────────────────────────────────────────────────────────────────┘ │  │
│   └──────────────────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────────────────┘
                                                      │
                                                      ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                              USER (Pengunjung)                              │
│                                                                             │
│   ┌──────────────┐      ┌──────────────┐      ┌──────────────┐              │
│   │ Buka Browser │ ───▶ │  Ketik URL   │ ───▶ │  Lihat Web   │              │
│   └──────────────┘      └──────────────┘      └──────────────┘              │
└─────────────────────────────────────────────────────────────────────────────┘
```
 proses ini menjamin integrasi berkesinambungan (CI/CD) secara *real-time*!

## 📂 Struktur Proyek

```text
src/
├── assets/
│   └── style/
│       └── main.css         # Gaya CSS terpusat secara global
├── components/
│   └── ProductDisplay.vue   # Komponen utama kartu produk & logika tampilan
├── App.vue                  # Komponen pembungkus aplikasi (Pengatur background & tema)
└── main.js                  # Titik masuk utama (Mengimpor CSS & mengeksekusi Vue)
```
