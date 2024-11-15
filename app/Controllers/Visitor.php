<?php

namespace App\Controllers;

use App\Models\AlternatifModel;
use App\Models\KriteriaModel;
use App\Models\SubKriteriaModel;
use App\Models\KategoriProdukModel;
use App\Models\visitorModel;
use App\Models\PenilaianVisitorModel;
use App\Models\HitungMetodeModel;
use App\Models\HasilRekomendasiModel;

class Visitor extends BaseController
{
    protected $alternatif;
    protected $kriteria;
    protected $subKriteria;
    protected $kategori;
    protected $visitor;
    protected $penilaianVisitor;
    protected $getHitung;
    protected $hasilRekomendasi;

    public function __construct()
    {

        $this->alternatif = new AlternatifModel();
        $this->kriteria = new KriteriaModel();
        $this->subKriteria = new subKriteriaModel();
        $this->kategori = new KategoriProdukModel();
        $this->visitor = new VisitorModel();
        $this->penilaianVisitor = new PenilaianVisitorModel();
        $this->getHitung = new HitungMetodeModel();
        $this->hasilRekomendasi = new HasilRekomendasiModel();
    }

    public function index()
    {
        // Dapatkan semua data kriteria
        $kriteriaList = $this->kriteria->findAll();

        // Inisialisasi array untuk menyimpan data subkriteria
        $dataKriteria = [];

        // Looping data kriteria
        foreach ($kriteriaList as $kriteria) {
            // Dapatkan data subkriteria berdasarkan ID kriteria
            $subkriteria = $this->subKriteria->where('id_kriteria', $kriteria['id_kriteria'])->findAll();

            // Tambahkan data subkriteria ke dalam array
            $dataKriteria[] = [
                'kriteria' => $kriteria,
                'subkriteria' => $subkriteria,
            ];
        }

        $data = [
            'title' => 'Form Rekomendasi',
            'dataKriteria' => $dataKriteria,
            'kategoriProduk' => $this->kategori->findAll()
        ];
        return view('/hasil-rekomendasi/index', $data);
    }


    public function addPenilaian()
    {
        // Ambil data dari form menggunakan request
        $nama = $this->request->getPost('nama');
        $email = $this->request->getPost('email');
        $kategoriProduk = $this->request->getPost('katProduk');
        $tipeKulit = $this->request->getPost('tipeKulit');
        $idKriteria = $this->request->getPost('idKriteria');
        $nilai = $this->request->getPost('nilai');

        // Buat array untuk menyimpan data ke penilaian_temp
        $dataPenilaian = [];

        // Loop data kriteria dan nilai yang didapat dari form
        for ($i = 0; $i < count($idKriteria); $i++) {
            $nilaiData = explode('|', $nilai[$i]);
            $dataPenilaian[] = [
                'kode_tipekulit' => $tipeKulit,
                'id_kategori' => $kategoriProduk,
                'id_produk' => 0, // Isi ini sesuai produk yang ingin dinilai atau 0 jika belum ada
                'id_kriteria' => $idKriteria[$i],
                'nilai' => $nilaiData[0],
                'nama' => $nama,
                'email' => $email,
            ];
        }

        // Simpan data ke tabel penilaian_temp
        $penilaianTempModel = new \App\Models\PenilaianTempModel();
        $penilaianTempModel->insertBatch($dataPenilaian);

        // Redirect atau tampilkan pesan sukses
        return redirect()->to('/')->with('success', 'Data berhasil disimpan.');
    }

    public function indexAdmin()
    {

        $data = [
            'title' => 'Data Pengunjung',
            'visitor' => $this->visitor->findAll(),
            'kategoriProduk' => $this->kategori->findAll(),
            'produk' => $this->alternatif->findAll(),
            'kriteria' => $this->kriteria->findAll(),
            'detailVisitor' => $this->visitor->getAllDataVisitor(),
            'nilaiKriteria' => $this->penilaianVisitor->findAll(),
            'subKriteria' => $this->subKriteria->findAll()
        ];
        return view('visitor/index', $data);
    }

    public function saveDataFormVisitor()
    {
        $katProduk = $this->request->getPost('katProduk');
        $tipeKulit = $this->request->getPost('tipeKulit');

        // 1. ambil data untuk keperluan menghitung matrik normalisasi
        $idVisitor = $this->visitor->getLastIDVisitor();
        // dd($idVisitor->id_visitor);
        $kriteria = $this->getHitung->getDistinctKriteria();
        $bobotKriteria = $this->kriteria->findAll();
        $dataPenilaian = $this->getHitung->getAllPenilaian($tipeKulit, $katProduk);
        $nilaiMaxMin = $this->getHitung->getNilaiMaxMin();

        $nilaiMax = [];
        foreach ($nilaiMaxMin as $nMax) {
            $nilaiMax[] = $nMax['nilaiMax'];
        }
        $nilaiMin = [];
        foreach ($nilaiMaxMin as $nMin) {
            $nilaiMin[] = $nMin['nilaiMin'];
        }

        $bobot_kriteria = [];
        foreach ($bobotKriteria as $dataBobot) {
            $bobot_kriteria[] = $dataBobot['bobot'];
        }
        // dd($bobot);

        $data = [];
        $produkMapping = [];
        $normalisasi = [];
        foreach ($dataPenilaian as $penilaian) {
            $data[$penilaian['nama_produk']][$penilaian['id_kriteria']] = $penilaian['nilai'];
            $produkMapping[$penilaian['nama_produk']] = $penilaian['id_produk'];
        }

        // 2. Melakukan perhitungan normalisasi
        foreach ($data as $nama_produk => $nilaiKriteria) {
            foreach ($kriteria as $index => $key) {
                $nilai = array_key_exists($key['id_kriteria'], $nilaiKriteria) ? $nilaiKriteria[$key['id_kriteria']] : 0;
                if ($nilai !== 0) {
                    if ($key['type'] == "Benefit") {
                        $nilaiDiBagi = $nilai / $nilaiMax[$index];
                    } else { // asumsikan tipe selain "Benefit" adalah "Cost"
                        $nilaiDiBagi = $nilaiMin[$index] / $nilai;
                    }
                } else {
                    $nilaiDiBagi = $nilai; // Jika tidak ada nilai, tetapkan 0 sebagai output
                }
                // Menyimpan hasil normalisasi
                $normalisasi[$nama_produk][$key['id_kriteria']] = round($nilaiDiBagi, 3);
                // dd($nilaiMax[$index]);
            }
        }


        // 3. menghitung nilai inputan user lalu normalisasikan
        $nilaiRange = $this->visitor->getNilaiRangePerKriteria();
        $nilaiAndId = $this->request->getPost('nilai');
        $kriteria_id = $this->request->getPost('idKriteria');
        $nama = $this->request->getPost('nama');
        $email = $this->request->getPost('email');

        // Inisialisasi array untuk menampung nilai skor dan ID subkriteria
        $nilaiInputanUser = [];
        $idSubkriteria = [];

        $totalNilaiInputUser = 0;
        foreach ($nilaiAndId as $nilai) {
            list($nilaiSkor, $idSub) = explode('|', $nilai);
            // Memasukkan nilai skor ke dalam array nilaiInputanUser
            $nilaiInputanUser[] = $nilaiSkor;
            $totalNilaiInputUser += $nilaiSkor;
            // Memasukkan ID subkriteria ke dalam array idSubkriteria
            $idSubkriteria[] = $idSub;
        }

        // var_dump($nilaiRange);
        $nilaiInputanUserNormalized = [];
        foreach ($nilaiInputanUser as $index => $nilai) {

            if (isset($kriteria_id[$index])) { // Pastikan elemen idKriteria ada
                $idKriteria = intVal($kriteria_id[$index]);
                $id = ($idKriteria - 1);
                if (isset($nilaiRange[$id])) { // Pastikan ada range untuk id ini
                    $range = $nilaiRange[$id]['dataNilai'];
                    // $nilaiInputanUserNormalized[] = $nilai / $range;
                    $nilaiInputanUserNormalized[] = $nilai / $totalNilaiInputUser;
                }
            }
        }
        // dd($nilaiInputanUserNormalized);

        // 4. hitung untuk mendapatkan skor atau nilai rekomendasi
        $skorProduk = []; // Untuk menyimpan skor akhir setiap produk

        foreach ($normalisasi as $nama_produk => $nilaiKriteria) {
            $skor = 0; // Skor awal untuk produk ini
            foreach ($nilaiKriteria as $id_kriteria => $nilaiNormalisasi) {
                // Pastikan kriteria ada dalam input pengguna dan bobot kriteria
                if (isset($nilaiInputanUserNormalized[$id_kriteria]) && isset($bobot_kriteria[$id_kriteria])) {
                    $skor += $nilaiNormalisasi * $bobot_kriteria[$id_kriteria] * $nilaiInputanUserNormalized[$id_kriteria];
                }
            }
            // Simpan skor beserta id_produk yang sesuai
            $id_produk = $produkMapping[$nama_produk] ?? null; // Gunakan null coalescing operator sebagai fallback
            if ($id_produk) {
                $skorProduk[] = [
                    'id_produk' => $id_produk,
                    'nama_produk' => $nama_produk,
                    'skor' => $skor,
                ];
            }
        }

        // $id_unik_transaksi = uniqid('id-hr-', true);
        $id = intval($idVisitor->id_visitor) + 1;
        // if ($idVisitor->id_visitor == null) {
        //     $id = 1;
        // } else {
        //     $id = intval($idVisitor->id_visitor) + 1;
        // }

        // 1. Simpan data ke tabel visitor
        $this->visitor->save([
            'nama_visitor' => $nama,
            'email' => $email,
        ]);

        // 2. Simpan data ke tabel kriteria_visitor
        foreach ($kriteria_id as $i => $value) {
            $this->penilaianVisitor->save([
                'id_visitor' => $id,
                'id_kriteria' => $value,
                'id_sub_kriteria' => $idSubkriteria[$i],
                'nilai_kriteria' => $nilaiInputanUser[$i]
            ]);
        }

        // 3. Loop untuk menyimpan data ke tabel hasil_rekomendasi
        foreach ($skorProduk as $produk) {
            $this->hasilRekomendasi->save([
                'id_visitor' => $id,
                'id_kategori_produk' => $katProduk,
                'kode_tipekulit' => $tipeKulit,
                'id_produk' => $produk['id_produk'],
                'skor_produk' => $produk['skor']
            ]);
        }


        // pesan data berhasil ditambah
        $isipesan = '<script> alert("Berikut hasil rekomendasi produk skincare anda!") </script>';
        session()->setFlashdata('pesan', $isipesan);

        return redirect()->to('/hasil-rekomendasi');
    }

    public function simpanRekomendasi()
    {
        // Retrieve form inputs
        $nama = $this->request->getVar('nama');
        $email = $this->request->getVar('email');
        $tipeKulit = $this->request->getVar('tipeKulit');
        $katProduk = $this->request->getVar('katProduk');
        $idKriteria = $this->request->getVar('idKriteria[]');
        $nilai = $this->request->getVar('nilai[]');

        // Initialize a variable to calculate the sum of 'nilai'
        $totalNilai = 0;

        // Perform validation for each element in the arrays
        foreach ($idKriteria as $index => $value) {
            if (!$this->validate([
                'nama' => 'required',
                'email' => 'required|valid_email',
                'idKriteria' => 'required',
                'nilai' => 'required'
            ])) {
                $validation = \Config\Services::validation();
                return redirect()->back()->withInput()->with('validation', $validation);
            }

            list($nilaiUtama, $nilaiTambahan) = explode('|', $nilai[$index]);

            $nilaiUtama = (float) $nilaiUtama;
            $nilaiTambahan = (float) $nilaiTambahan;

            $totalNilai += $nilaiUtama;

            // Load the database connection
            $db = \Config\Database::connect();

            // Prepare raw SQL query for visitor
            $queryAddVisitor = "INSERT INTO visitor (nama_visitor, email) VALUES (?, ?)";

            // Insert visitor data and get inserted ID
            $db->query($queryAddVisitor, [$nama, $email]);
            $visitorId = $db->insertID();

            // Prepare raw SQL query for penilaian
            $query = "INSERT INTO penilaian_temp (kode_tipekulit, id_kategori, id_kriteria, nilai, nama, email)
                  VALUES (?, ?, ?, ?, ?, ?)";

            // Save each entry
            $db->query($query, [
                $tipeKulit,       // kode_tipekulit
                $katProduk,       // id_kategori
                $value,           // id_kriteria
                $nilaiUtama,      // nilai
                $nama,            // nama
                $email            // email
            ]);
        }

        // Calculate the average of 'nilai'
        $averageNilai = $totalNilai / count($nilai);

        // Success message
        $isipesan = '<script> alert("Berhasil ditambahkan! Rata-rata nilai: ' . $averageNilai . '") </script>';
        session()->setFlashdata('pesan', $isipesan);

        // Redirect to hasil-rekomendasi with tipeKulit, katProduk, averageNilai, and visitorId
        return redirect()->to('/hasil-rekomendasi/' . $tipeKulit . '/' . $katProduk . '/' . $averageNilai . '/' . $visitorId);
    }

   
    public function hasilRekomendasi($tipe_kulit, $id_kategori, $averageNilai, $idVisitor)
    {
        // Ambil kriteria, penilaian, nilai max/min, dan data visitor
        $kriteria = $this->getHitung->getDistinctKriteria();
        $dataPenilaian = $this->getHitung->getAllPenilaian($tipe_kulit, $id_kategori);
        $nilaiMaxMin = $this->getHitung->getNilaiMaxMin();
        $dataVisitor = $this->visitor->getAllDataVisitorById($idVisitor);
    
        // Ambil data harga produk berdasarkan tipe kulit dan kategori
        $produk = $this->alternatif->getProduk($tipe_kulit, $id_kategori); // Menyesuaikan dengan tipe kulit dan kategori
    
        // Cek jika tidak ada produk ditemukan
        if (empty($produk)) {
            $dataProdukTidakDitemukan = true; // Variabel untuk menandakan tidak ada produk ditemukan
        } else {
            $dataProdukTidakDitemukan = false;
        }
    
        // Prepare max dan min values
        $nilaiMax = [];
        foreach ($nilaiMaxMin as $nMax) {
            $nilaiMax[] = $nMax['nilaiMax'];
        }
        $nilaiMin = [];
        foreach ($nilaiMaxMin as $nMin) {
            $nilaiMin[] = $nMin['nilaiMin'];
        }
    
        // Organisasi data produk berdasarkan id_produk
        $data = [];
        foreach ($dataPenilaian as $penilaian) {
            $id_produk = $penilaian['id_produk'];
            $data[$id_produk]['id_produk'] = $penilaian['id_produk'];
            $data[$id_produk]['nama_produk'] = $penilaian['nama_produk']; // Simpan nama produk
            $data[$id_produk]['kriteria'][$penilaian['id_kriteria']] = $penilaian['nilai']; // Simpan nilai kriteria
        }
    
        // Kirim data ke view
        return view('/hasil-rekomendasi/hasil-rekomendasi', [
            'title' => 'Perhitungan',
            'kriteria' => $kriteria,
            'nilaiAlternatif' => $data,
            'harga' => $produk, // Menyertakan data harga produk
            'kategoriProduk' => $this->kategori->findAll(),
            'nilaiMax' => $nilaiMax,
            'nilaiMin' => $nilaiMin,
            'id_kategori' => $id_kategori,
            'tipe_kulit' => $tipe_kulit,
            'averageNilai' => $averageNilai,
            'dataVisitor' => $dataVisitor,
            'dataProdukTidakDitemukan' => $dataProdukTidakDitemukan // Menambahkan variabel untuk menunjukkan tidak ada produk
        ]);
    }
    

    public function hasilAkhirRekomendasi()
    {
        $nama = $this->request->getPost('nama');
        $email = $this->request->getPost('email');
        $id_produk = $this->request->getPost('id_produk');
        $date = date('Y-m-d H:i:s');

        $db = \Config\Database::connect();

        $query = "INSERT INTO hasil_rekomendasi_akhir (nama, email, id_produk, created_date) VALUES (?, ?, ?, ?)";

        if ($db->query($query, [
            $nama,
            $email,
            $id_produk,
            $date
        ])) {
            return redirect()->to(previous_url())->with('success', 'Rekomendasi berhasil disimpan!');
        } else {
            return redirect()->to(previous_url())->with('error', 'Gagal menyimpan data: ' . $db->error());
        }
    }

    // Fungsi untuk menghitung nilai preferensi
    private function hitungNilaiPreferensi($data, $nilaiMax, $nilaiMin)
    {
        $total = 0;
        $kriteriaCount = count($data);

        foreach ($data as $id_kriteria => $nilai) {
            // Misalkan kita melakukan normalisasi
            $normalized = ($nilai - $nilaiMin[$id_kriteria]) / ($nilaiMax[$id_kriteria] - $nilaiMin[$id_kriteria]);
            $total += $normalized; // Tambahkan hasil normalisasi
        }

        return $total / $kriteriaCount; // Mengembalikan rata-rata nilai preferensi
    }
}
