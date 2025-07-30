import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:facerecognition/components/widgets/appbar.dart';
import 'package:facerecognition/utils/colors.dart';
import 'package:sizer/sizer.dart';

class AbsenView extends StatefulWidget {
  const AbsenView({super.key});

  @override
  State<AbsenView> createState() => _AbsenViewState();
}

class _AbsenViewState extends State<AbsenView> {
  late List<PlutoColumn> columns;
  late List<PlutoRow> rows;
  late PlutoGridStateManager stateManager;

  final List<Map<String, dynamic>> absenData = [
    {"nama": "Harits", "tanggal": "2025-07-01", "status": "Hadir"},
    {"nama": "Rina", "tanggal": "2025-07-01", "status": "Izin"},
    {"nama": "Budi", "tanggal": "2025-07-01", "status": "Alpha"},
    {"nama": "Ayu", "tanggal": "2025-07-01", "status": "Hadir"},
    {"nama": "Nina", "tanggal": "2025-07-01", "status": "Hadir"},
    {"nama": "Tono", "tanggal": "2025-07-01", "status": "Izin"},
    {"nama": "Rudi", "tanggal": "2025-07-01", "status": "Sakit"},
    {"nama": "Dina", "tanggal": "2025-07-01", "status": "Alpha"},
    {"nama": "Farah", "tanggal": "2025-07-01", "status": "Hadir"},
    {"nama": "Zaki", "tanggal": "2025-07-01", "status": "Hadir"},
    {"nama": "Andi", "tanggal": "2025-07-01", "status": "Sakit"},
  ];

  @override
  void initState() {
    super.initState();
    _setupTable();
  }

  void _setupTable() {
    columns = [
      PlutoColumn(
        title: 'Nama',
        field: 'nama',
        type: PlutoColumnType.text(),
        enableFilterMenuItem: true,
      ),
      PlutoColumn(
        title: 'Tanggal',
        field: 'tanggal',
        type: PlutoColumnType.text(),
        enableFilterMenuItem: true,
      ),
      PlutoColumn(
        title: 'Status',
        field: 'status',
        type: PlutoColumnType.text(),
        enableFilterMenuItem: true,
      ),
    ];

    rows = absenData.map((data) {
      return PlutoRow(
        cells: {
          'nama': PlutoCell(value: data['nama']),
          'tanggal': PlutoCell(value: data['tanggal']),
          'status': PlutoCell(value: data['status']),
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: "Absen Data"),
      backgroundColor: const Color.fromARGB(255, 233, 233, 233),
      body: Column(
        children: [
          // Header
          Container(
            height: 10.h,
            decoration: BoxDecoration(
              color: OprimaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Tabel Absen dengan PlutoGrid (scroll-only)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: PlutoGrid(
                  columns: columns,
                  rows: rows,
                  onLoaded: (PlutoGridOnLoadedEvent event) {
                    stateManager = event.stateManager;
                    stateManager.setShowColumnFilter(true);
                  },
                  configuration: PlutoGridConfiguration(
                    columnFilter: PlutoGridColumnFilterConfig(
                      filters: const [...FilterHelper.defaultFilters],
                      resolveDefaultColumnFilter: (column, resolver) {
                        return resolver<PlutoFilterTypeContains>()
                            as PlutoFilterType;
                      },
                    ),
                  ),
                  createHeader: (stateManager) {
                    return const Padding(padding: EdgeInsets.all(12.0));
                  },
                  mode: PlutoGridMode.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
