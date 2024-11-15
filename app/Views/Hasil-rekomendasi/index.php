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

    <!-- =======================================================
  * Template Name: NiceAdmin
  * Updated: Jan 29 2024 with Bootstrap v5.3.2
  * Template URL: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
    <style>
        body {
            /* margin-top: -100px; */
            background-image: url('../assets/img/bgpink.jpg');
            background-size: cover;
            /* Membuat gambar menutupi seluruh area tanpa mengubah rasio aspek */
            background-position: center;
            /* Pusatkan gambar background */
            background-repeat: no-repeat;
            /* Hindari gambar berulang */
        }
    </style>
</head>

<body background="">
    <div class="container">
        <div class="row mt-2">
            <div class="col text-center">
                <h3 class="card-title fw-bold fs-3">Sistem Rekomendasi Produk Kecantikan Fifi Skin Klinik</h3>
                <p>Selamat datang di website sistem rekomendasi produk kecantikan. </p>
                    <p>Silahkan pilih kriteria sesuai dengan kebutuhan Anda ! </p>
                <!-- Tombol "Cara Penggunaan Website" -->
                    <button type="button" class="btn btn-info btn-sm mt-2" data-bs-toggle="modal" data-bs-target="#usageModal">
                        Cara Penggunaan Website
                    </button>
            </div>

                <!-- Modal Cara Penggunaan -->
                 <div class="modal fade" id="usageModal" tabindex="-1" aria-labelledby="usageModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="usageModalLabel">Cara Penggunaan Website</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Tutup"></button>
                            </div>
                            <div class="modal-body">
                                <p>Berikut adalah langkah-langkah untuk menggunakan sistem rekomendasi produk kecantikan Fifi Skin Klinik:</p>
                                <ol>
                                    <li>Isi nama dan email pada form yang tersedia.</li>
                                    <li>Pilih kategori produk sesuai kebutuhan Anda.</li>
                                    <li>Pilih tipe kulit sesuai dengan kondisi Anda.</li>
                                    <li>Isi semua kriteria yang disediakan untuk mendapatkan rekomendasi produk yang sesuai.</li>
                                    <li>Klik tombol "Submit" untuk melihat hasil rekomendasi.</li>
                                </ol>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Tutup</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row mt-3">
            <div class="col-md-6 text-center">
                <img src="assets/img/skincareroutine.png" class="border-0" style="margin-top: 100px; rotate: 15;" width="100%" alt="">
            </div>
            <div class="col-md-6">
                <div class="card shadow-lg">
                    <div class="card-body">
                        <h6 class="card-title text-center">Lengkapi form berikut untuk mendapatkan rekomendasi produk kecantikan sesuai dengan kebutuhan
                        </h6>

                        <!-- Floating Labels Form -->
                        <form id="myForm" class="row g-2" action="form-rekomendasi/add" method="post">
                            <div class="row mb-2 mx-3">
                                <label for="inputNama" class="col-sm-3 mt-2 col-form-label form-control-sm">Nama</label>
                                <div class="col-sm-9">
                                    <input type="text" name="nama" class="form-control form-control-sm mt-2" id="inputNama" placeholder="Masukan Nama">
                                </div>
                                <label for="inputEmail" class="col-sm-3 mt-2 col-form-label form-control-sm">Email</label>
                                <div class="col-sm-9">
                                    <input type="email" name="email" class="form-control form-control-sm mt-2" id="inputEmail" placeholder="Masukan Email">
                                </div>
                                <label for="inputEmail" class="col-sm-3 mt-2 col-form-label form-control-sm">Kategori
                                    Produk</label>
                                <div class="col-sm-9">
                                    <select name="katProduk" id="" class="form-control form-control-sm mt-2">
                                        <option value="" disabled selected>-- Pilih Kategori Produk --</option>
                                        <?php foreach ($kategoriProduk as $data) : ?>
                                            <option value="<?= $data['id_kategori'] ?>"><?= $data['nama_kategori_produk'] ?></option>
                                        <?php endforeach ?>
                                    </select>
                                </div>
                                <label for="inputEmail" class="col-sm-3 mt-2 col-form-label form-control-sm">Tipe
                                    Kulit</label>
                                <div class="col-sm-9">
                                    <select name="tipeKulit" id="" class="form-control form-control-sm mt-2">
                                        <option value="" disabled selected>-- Pilih Tipe Kulit --</option>
                                        <option value="a1">Semua Jenis Kulit</option>
                                        <option value="a2">Normal</option>
                                        <option value="a3">Kering</option>
                                        <option value="a4">Berminyak, Berjerawat</option>
                                        <option value="a5">Sensitif</option>
                                    </select>
                                </div>
                                <h6 class="card-title fs-6">Pilih Kriteria</h6>
                                <?php foreach ($dataKriteria as $data) : ?>
                                    <input type="hidden" name="idKriteria[]" value="<?= $data['kriteria']['id_kriteria'] ?>">
                                    <label for="inputEmail" class="col-sm-3 mt-2 col-form-label form-control-sm"><?= $data['kriteria']['kriteria'] ?></label>
                                    <div class="col-sm-9">
                                        <select name="nilai[]" id="" class="form-control form-control-sm mt-2">
                                            <option value="" disabled selected>-- Pilih <?= $data['kriteria']['kriteria'] ?> --</option>
                                            <?php foreach ($data['subkriteria'] as $dataSub) : ?>
                                                <option value="<?= $dataSub['nilai'] . '|' . $dataSub['id_sub_kriteria'] ?>"><?= $dataSub['sub_kriteria'] ?></option>
                                            <?php endforeach ?>
                                        </select>
                                    </div>
                                <?php endforeach ?>
                                <div class="col mt-4 d-flex justify-content-end">
                                    <button type="reset" class="btn btn-info btn-sm m-1"><i class="bi bi-arrow-repeat"></i> Reset</button>
                                    <button type="submit" class="btn btn-success btn-sm m-1"><i class="bi bi-arrow-up-circle"></i> Submit</button>
                                </div>
                            </div>
                        </form><!-- End floating Labels Form -->
                    </div>
                </div>
            </div>

        </div>
    </div>
    <div class="modal fade" id="resultModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Hasil Rekomendasi Produk</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    Non omnis incidunt qui sed occaecati magni asperiores est mollitia. Soluta at et reprehenderit. Placeat autem numquam et fuga numquam. Tempora in facere consequatur sit dolor ipsum. Consequatur nemo amet incidunt est facilis. Dolorem neque recusandae quo sit molestias sint dignissimos.
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Save changes</button>
                </div>
            </div>
        </div>
    </div><!-- End Vertically centered Modal-->
    </div><!-- End Vertically centered Modal-->

    <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

    <!-- Vendor JS Files -->
    <script src="<?= base_url() ?>/assets/vendor/apexcharts/apexcharts.min.js"></script>
    <script src="<?= base_url() ?>/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="<?= base_url() ?>/assets/vendor/chart.js/chart.umd.js"></script>
    <script src="<?= base_url() ?>/assets/vendor/echarts/echarts.min.js"></script>
    <script src="<?= base_url() ?>/assets/vendor/quill/quill.min.js"></script>
    <script src="<?= base_url() ?>/assets/vendor/simple-datatables/simple-datatables.js"></script>
    <script src="<?= base_url() ?>/assets/vendor/tinymce/tinymce.min.js"></script>
    <script src="<?= base_url() ?>/assets/vendor/php-email-form/validate.js"></script>
    <!-- ajax -->
    <script src="https://code.jquery.com/jquery-3.7.0.js"></script>

    <!-- Template Main JS File -->
    <script src="<?= base_url() ?>/assets/js/main.js"></script>
    <script>
        // $(document).ready(function(){
        //     $('#myForm').submit(function(e){
        //         e.preventDefault(); // Mencegah reload halaman dan pengiriman form secara tradisional
        //         // Debug data yang akan dikirim
        //         console.log($(this).serialize());
        //         $.ajax({
        //             type: "POST",
        //             url: $(this).attr('action'), // Menggunakan atribut action dari form
        //             data: $(this).serialize(), // Mengambil semua data dari form
        //             success: function(response){
        //                 // Asumsi response berisi pesan yang ingin ditampilkan
        //                 $('#modalContent').html(response);
        //                 $('#resultModal').modal('show'); // Menampilkan modal
        //             }
        //         });
        //     });
        // });
    </script>

</body>

</html>