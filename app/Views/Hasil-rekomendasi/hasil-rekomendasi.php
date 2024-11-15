<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title><?= $title ?></title>
    <meta content="" name="description">
    <meta content="" name="keywords">

    <!-- Favicons -->
    <link href="assets/img/favicon.png" rel="icon">
    <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

    <!-- Google Fonts -->
    <link href="https://fonts.gstatic.com" rel="preconnect">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

    <!-- Vendor CSS Files -->
    <link href="<?= base_url() ?>/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="<?= base_url() ?>/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="<?= base_url() ?>/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="<?= base_url() ?>/assets/vendor/quill/quill.snow.css" rel="stylesheet">
    <link href="<?= base_url() ?>/assets/vendor/quill/quill.bubble.css" rel="stylesheet">
    <link href="<?= base_url() ?>/assets/vendor/remixicon/remixicon.css" rel="stylesheet">
    <link href="<?= base_url() ?>/assets/vendor/simple-datatables/style.css" rel="stylesheet">

    <!-- Template Main CSS File -->
    <link href="<?= base_url() ?>/assets/css/style.css" rel="stylesheet">

    <style>
        .bg {
            height: 650px;
            background-image: url('../assets/img/bg.png');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }
    </style>
</head>

<body background="">
    <div class="bg">

        <div class="container">
            <div class="row mt-2 text-center">
                <?php if (session()->getFlashdata('success')): ?>
                    <div class="alert alert-success">
                        <?= session()->getFlashdata('success') ?>
                    </div>
                <?php endif; ?>

                <?php if (session()->getFlashdata('error')): ?>
                    <div class="alert alert-danger">
                        <?= session()->getFlashdata('error') ?>
                    </div>
                <?php endif; ?>

                <!-- Tampilkan pesan Data Tidak Ditemukan jika produk tidak ada -->
                <?php if (isset($dataProdukTidakDitemukan) && $dataProdukTidakDitemukan): ?>
                    <div class="alert alert-warning">
                        Data Tidak Ditemukan! Produk yang sesuai dengan kriteria Anda tidak tersedia.
                    </div>
                <?php endif; ?>

                <!-- Check if there is any alternatif data -->
                <?php if (!empty($nilaiAlternatif)) : ?>
                    <h5 class="mt-5">Perhitungan Metode SAW</h5>

                    <!-- Display flash message -->
                    <?php if (session()->getFlashdata('pesan')) : ?>
                        <script>
                            alert("<?= session()->getFlashdata('pesan'); ?>");
                        </script>
                    <?php endif; ?>

                    <!-- Rekomendasi Produk -->
                    <div class="card mt-3 shadow-sm">
                        <div class="card-header d-flex justify-content-between">
                            <h6 class="text-muted"># Rekomendasi Produk Berdasarkan Nilai Preferensi</h6>
                        </div>
                        <div class="card-body m-2">
                            <div class="table-responsive">
                                <table class="table table-striped" width="100%" cellspacing="0">
                                    <thead class="bg-primary text-white">
                                        <tr align="center">
                                            <th width="5%">No</th>
                                            <th>Nama Produk</th>
                                            <th>Harga</th>
                                            <th>Nilai Preferensi</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php
                                        $smallestDifference = PHP_INT_MAX;
                                        $productWithSmallestDifference = [
                                            'nama_produk' => '',
                                            'id_produk' => '',
                                            'harga' => ''
                                        ];
                                        $recommendedProducts = [];

                                        foreach ($nilaiAlternatif as $item) {
                                            $nama_produk = $item['nama_produk'];
                                            $id_produk = $item['id_produk'];
                                            $nilaiKriteria = $item['kriteria'];

                                            // Cari harga produk
                                            $harga_produk = null;
                                            foreach ($harga as $produk) {
                                                if ($produk['id_produk'] == $id_produk) {
                                                    $harga_produk = $produk['harga'];
                                                    break;
                                                }
                                            }

                                            // Hitung nilai preferensi
                                            $nilai_v = 0;
                                            foreach ($kriteria as $index => $key) {
                                                $nilai = array_key_exists($key['id_kriteria'], $nilaiKriteria) ? $nilaiKriteria[$key['id_kriteria']] : 0;
                                                $nilaiDiBagi = ($nilai !== 0) ? (($key['type'] == "Benefit") ? $nilai / $nilaiMax[$index] : $nilaiMin[$index] / $nilai) : 0;
                                                $nilai_v += $key['bobot'] * $nilaiDiBagi;
                                            }

                                            $difference = abs($averageNilai - $nilai_v);
                                            $recommendedProducts[$nama_produk] = [
                                                'nilaiPreferensi' => round($nilai_v, 3),
                                                'harga' => $harga_produk
                                            ];

                                            if ($difference < $smallestDifference) {
                                                $smallestDifference = $difference;
                                                $productWithSmallestDifference['nama_produk'] = $nama_produk;
                                                $productWithSmallestDifference['id_produk'] = $id_produk;
                                                $productWithSmallestDifference['harga'] = $harga_produk;
                                            }
                                        }

                                        // Urutkan produk berdasarkan nilai preferensi tertinggi
                                        uasort($recommendedProducts, function ($a, $b) {
                                            return $b['nilaiPreferensi'] <=> $a['nilaiPreferensi'];
                                        });

                                        $no = 1;
                                        foreach ($recommendedProducts as $produk => $details) : ?>
                                            <tr align="center">
                                                <td><?= $no; ?></td>
                                                <td align="left"><?= $produk; ?></td>
                                                <td><?= $details['harga']; ?></td> <!-- Menampilkan harga produk yang sesuai -->
                                                <td><?= $details['nilaiPreferensi']; ?></td>
                                            </tr>
                                            <?php $no++; ?>
                                        <?php endforeach; ?>
                                    </tbody>

                                </table>
                                <p class="text-center mt-3" style="color: #455A64;">
                                    <em>Semakin tinggi nilai preferensi, maka produk semakin direkomendasikan. Produk yang berada di peringkat 1 adalah produk terbaik.</em>
                                </p>
                                <p class="text-center mt-3" style="color: #455A64;">
                                    <em>Hasil akhir rekomendasi disesuaikan berdasarkan kriteria yang telah dimasukkan.</em>
                                </p>
                                <form action="/hasil-rekomendasi-akhir" method="post" enctype="multipart/form-data">
                                    <input type="hidden" name="nama" value="<?= $dataVisitor[0]['nama_visitor']; ?>">
                                    <input type="hidden" name="email" value="<?= $dataVisitor[0]['email']; ?>">
                                    <input type="hidden" name="id_produk" value="<?= $productWithSmallestDifference['id_produk']; ?>">

                                    <h1 class="btn text-center fs-4" style="background-color: #E3F2FD; color: #1A237E;">
                                        Rekomendasi Terbaik yang Disarankan untuk <?= $dataVisitor[0]['nama_visitor']; ?> adalah : <?= $productWithSmallestDifference['nama_produk']; ?>
                                    </h1>

                                    <!-- Button to submit the form -->
                                    <button type="submit" class="btn btn-primary mb-2">Simpan Rekomendasi</button>
                                    <a href="/" class="btn btn-danger mb-2">Kembali</a>
                                </form>
                            </div>
                        </div>
                    </div>
                <?php endif; ?>

            </div>
        </div>

    </div>

    <!-- Vendor JS Files -->
    <script src="<?= base_url() ?>/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="<?= base_url() ?>/assets/vendor/simple-datatables/simple-datatables.js"></script>
    <script src="<?= base_url() ?>/assets/js/main.js"></script>

</body>

</html>