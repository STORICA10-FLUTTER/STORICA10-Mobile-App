<h1>README.md</h1>

1. **Nama-nama anggota kelompok**

   - Edward Salim - 2206024890
   - Rakha Davin Bani Alamsyah - 2206082650
   - Jason Kent Winata - 2206081313
   - Nazkya Raahiil Ramandha - 2206030893
   - Zaidan Naufal Ilmi - 2206081761
     <br><br>

2. **Cerita aplikasi yang diajukan serta manfaatnya**

   Dalam rangka memperingati Bulan Bahasa dan Sastra yang diselenggarakan setiap bulan Oktober di Indonesia, yang menghormati kelahiran bahasa Indonesia, kami dengan bangga memperkenalkan aplikasi Storica. Storica dirancang dengan tujuan mulia: meningkatkan tingkat literasi di kalangan masyarakat Indonesia, sambil merayakan kekuatan kata-kata.

   Storica adalah wadah kreatif yang memungkinkan pengguna untuk mengekspresikan diri mereka melalui cerita-cerita yang mereka ciptakan, yang dapat diakses dan dinikmati oleh orang lain. Aplikasi ini sangat relevan mengingat tantangan literasi yang masih dihadapi oleh sebagian warga Indonesia.

   Dalam semangat Bulan Bahasa dan Sastra, Storica memberikan kesempatan kepada pengguna untuk memulai perjalanan literasi mereka dan mungkin merintis karir sebagai penulis yang berbakat. Semoga aplikasi ini tidak hanya menjadi perayaan bahasa Indonesia, tetapi juga membawa perubahan positif dalam literasi dan kepenulisan di Indonesia. Mari bersama-sama merayakan kekayaan bahasa dan sastra kita melalui Storica.<br><br>

3. **Daftar modul yang akan diimplementasikan**

   - **Modul Auth / Landing Page (1, Kelompok):**

     Ini akan memberikan akses awal ke aplikasi, dan pengguna akan melihat data buku dari API. Kami juga akan menyertakan opsi filter untuk seleksi modul berikutnya.

   - **Modul Home Page (2, Zaidan):**

     Di sini, pengguna akan dapat melihat semua buku yang tersedia. Kami akan mencakup fitur untuk melacak capaian buku, dengan kemajuan yang ditandai setelah pengguna memilih tombol "Baca".

   - **Modul Saved Library (3, Nazkya):**

     Pengguna akan memiliki koleksi buku favorit mereka. Ini akan memungkinkan pengguna untuk menambahkan buku ke koleksi ini dengan mengidentifikasi buku berdasarkan ID, dan model pengguna akan diperbarui sesuai.

   - **Modul Buat Cerita Baru (4, Davin):**

     Di sini, pengguna dapat membuat cerita baru dan mengedit cerita yang ada. Kami akan menyertakan tombol untuk kembali ke halaman utama setelah menyelesaikan pembacaan.

   - **Modul Baca (5, Edward):**

     Dalam modul ini, pengguna akan dapat menikmati membaca cerita yang ada. Setelah membaca, pengguna akan memiliki opsi untuk memberikan penilaian dan menyampaikan komentar terkait cerita tersebut, yang dapat dilihat oleh semua pengguna aplikasi.

   - **Modul Preview Buku (6, Jason):**

     Dalam modul ini, pengguna akan memiliki kesempatan untuk melihat preview dan detail suatu buku. Mereka akan diberikan opsi untuk memilih antara tombol "Baca" atau "Favorit".<br><br>

4. **Role atau peran pengguna beserta deskripsinya**

   - **Pengguna Guest:**
     - Pengguna tamu hanya dapat mengakses halaman beranda dan melihat pratinjau buku.
     - Untuk menggunakan fitur-fitur lainnya, pengguna diharuskan untuk melakukan login, karena akses ke fitur tersebut memerlukan otentikasi.
   - **Pengguna Storica (Non-Guest):**
     - Pengguna Storica yang sudah masuk ke akun mereka dapat mengakses semua fitur pada modul yang tersedia.

5. **Alur Integrasi Web Service untuk Aplikasi STORICA**

    1. **Penentuan Kebutuhan Esensial**
    * Di tahap awal, tim kami fokus untuk mengidentifikasi kebutuhan krusial dari web service untuk aplikasi STORICA. Kebutuhan ini meliputi proses inti seperti login dan logout pengguna, registrasi akun baru, serta pengambilan data buku, termasuk daftar buku favorit dan katalog buku secara keseluruhan. Kami memilih Django sebagai kerangka kerja web service kami karena keandalan dan fleksibilitasnya.
    2. **Arsitektur Integrasi yang Direncanakan dengan Matang**
    * Selanjutnya, kami merancang arsitektur integrasi yang sinergis antara aplikasi Flutter kami dan web service Django. Pendekatan ini memperhatikan berbagai aspek penting seperti manajemen sesi pengguna dan strategi penyimpanan data yang efektif, memastikan bahwa integrasi berlangsung lancar dan aman.
    3. **Pengembangan Terpadu**
    * Dengan lingkungan pengembangan yang sudah disiapkan, lengkap dengan semua dependensi yang diperlukan, tim kami memulai proses pembuatan kode. Kami berfokus pada pembuatan permintaan HTTP yang mencakup operasi CRUD, pengiriman header yang diperlukan (termasuk API key), serta pengiriman dan penerimaan data dalam format JSON yang efisien.
    4. **Pengujian Komprehensif**
    * Tahap pengujian dilakukan dengan ketelitian tinggi untuk memastikan bahwa setiap aspek integrasi beroperasi sesuai harapan. Kami memberikan perhatian khusus pada pengujian performa, terutama mengingat frekuensi tinggi pemanggilan web service dan potensi beban data yang besar, untuk memastikan stabilitas dan kecepatan respons yang optimal.
    5. **Peluncuran dan Implementasi**
    * Setelah serangkaian pengujian yang menyeluruh, kami siap meluncurkan integrasi ini ke dalam lingkungan produksi. Tahap ini merupakan puncak dari proses integrasi yang telah kami kerjakan, membawa aplikasi STORICA ke tingkat fungsionalitas dan efisiensi yang baru.

6. **Berita acara kelompok** 
    https://docs.google.com/spreadsheets/d/1XuODbe-lljNz-xdFanQyudAxOpNnPBLw/edit?usp=sharing&ouid=105789646608386182412&rtpof=true&sd=true

