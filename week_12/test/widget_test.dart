import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:week_12/domain/entities/shipment.dart';
import 'package:week_12/domain/usecases/get_shipments.dart';
import 'package:week_12/presentation/pages/shipments_page.dart';
import 'package:week_12/presentation/bloc/shipment_bloc.dart';

/// Fake GetShipments usecase
class FakeGetShipments {
  Future<List<Shipment>> call() async {
    return [
      Shipment(
        id: "1",
        status: "In Transit",
        timeline: ["Ordered", "Shipped", "In Transit"],
      ),
    ];
  }
}

void main() {
  testWidgets('Shipments page shows list of shipments', (tester) async {
    final fakeUseCase = FakeGetShipments();

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) =>
              ShipmentBloc(fakeUseCase as GetShipments)..add(LoadShipments()),
          child: const ShipmentsPage(isOffline: false),
        ),
      ),
    );

    // allow bloc to process
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    // UI checks
    expect(find.text("Deliveries"), findsOneWidget);
    expect(find.textContaining("Shipment"), findsWidgets);
  });
}
