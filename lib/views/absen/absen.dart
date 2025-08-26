import 'package:facerecognition/controllers/absence_controller.dart';
import 'package:facerecognition/controllers/global_controller.dart';
import 'package:facerecognition/views/pdf/pdf.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllAttendanceView extends StatelessWidget {
  AllAttendanceView({Key? key}) : super(key: key);

  final GetAttendancesController controller = Get.put(
    GetAttendancesController(),
  );

  @override
  Widget build(BuildContext context) {
    controller.fetchAllAttendances();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Semua Data Absensi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            tooltip: 'Generate PDF',
            onPressed: () async {
              final pdf = await controller.createAttendancePdf();
              final pdfUrl = pdf?.path.replaceAll(
                'localhost:3000',
                mainbaseFile,
              );
              if (pdfUrl != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PdfPreviewPage(pdfUrl: pdfUrl),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        if (controller.attendances.isEmpty) {
          return const Center(child: Text('Belum ada data absensi.'));
        }

        return ListView.builder(
          itemCount: controller.attendances.length,
          itemBuilder: (context, index) {
            final absen = controller.attendances[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                title: Text('Tanggal: ${absen.date}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Check In: ${absen.checkIn ?? "-"}'),
                    Text('Check Out: ${absen.checkOut ?? "-"}'),
                    Text('Tipe: ${absen.type}'),
                    Text('Nama: ${absen.user?.profile?.fullname ?? "-"}'),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
