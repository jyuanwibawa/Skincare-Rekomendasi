<head>
    <!-- Include Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.0.2/css/bootstrap.min.css" rel="stylesheet">
</head>

<?= $this->extend('layout/template') ?>

<?= $this->section('content') ?>

<!-- Check if there is any visitor data -->
<?php if (!empty($visitor)) : ?>
    <div class="card mt-4 shadow-sm w-100">
        <div class="card-body p-4">
            <div class="table-responsive w-100">
                <table id="myTable" class="table table-striped datatable w-100">
                    <thead>
                        <tr>
                            <th style="width: 10%;">No</th>
                            <th style="width: 30%;">Nama</th>
                            <th style="width: 30%;">Email</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php $no = 1; ?>
                        <?php foreach ($visitor as $row) : ?>
                            <tr>
                                <td><?= $no++ ?></td>
                                <td><?= $row['nama_visitor'] ?></td>
                                <td><?= $row['email'] ?></td>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
<?php else : ?>
    <div class="alert alert-info mt-5" role="alert">
        Data tidak ada, silahkan input data terlebih dahulu untuk menampilkan data!
    </div>
<?php endif; ?>

<!-- Modal Structure -->
<?php foreach ($visitor as $row) : ?>
    <div class="modal fade" id="detailModal<?= $row['id_visitor'] ?>" tabindex="-1" aria-labelledby="detailModalLabel<?= $row['id_visitor'] ?>" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-body p-4">
                    <table class="table table-bordered">
                        <tbody>
                            <tr>
                                <th>Nama</th>
                                <td><?= $row['nama_visitor'] ?></td>
                            </tr>
                            <tr>
                                <th>Email</th>
                                <td><?= $row['email'] ?></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <a href="/admin/visitor" class="btn btn-secondary">Close</a>
                </div>
            </div>
        </div>
    </div>
<?php endforeach; ?>

<?= $this->endSection('content') ?>
