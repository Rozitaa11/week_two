import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'core/network/network_info.dart';
import 'data/datasources/shipment_local_datasource.dart';
import 'data/datasources/shipment_remote_datasource.dart';
import 'data/repositories/shipment_repository_impl.dart';
import 'domain/usecases/get_shipments.dart';
import 'presentation/bloc/shipment_bloc.dart';
import 'presentation/pages/shipments_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  final networkInfo = NetworkInfo(Connectivity());

  final repository = ShipmentRepositoryImpl(
    remote: ShipmentRemoteDataSource(),
    local: ShipmentLocalDataSource(),
    networkInfo: networkInfo,
  );

  final isOffline = !(await networkInfo.isConnected);

  runApp(MyApp(
    repository: repository,
    isOffline: isOffline,
  ));
}

class MyApp extends StatelessWidget {
  final ShipmentRepositoryImpl repository;
  final bool isOffline;

  const MyApp({
    super.key,
    required this.repository,
    required this.isOffline,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) =>
            ShipmentBloc(GetShipments(repository))..add(LoadShipments()),
        child: ShipmentsPage(isOffline: isOffline),
      ),
    );
  }
}
