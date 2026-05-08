import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/shipment.dart';
import '../../domain/usecases/get_shipments.dart';

abstract class ShipmentEvent {}

class LoadShipments extends ShipmentEvent {}

abstract class ShipmentState {}

class ShipmentInitial extends ShipmentState {}

class ShipmentLoading extends ShipmentState {}

class ShipmentLoaded extends ShipmentState {
  final List<Shipment> shipments;

  ShipmentLoaded(this.shipments);
}

class ShipmentError extends ShipmentState {}

class ShipmentBloc extends Bloc<ShipmentEvent, ShipmentState> {
  final GetShipments getShipments;

  ShipmentBloc(this.getShipments) : super(ShipmentInitial()) {
    on<LoadShipments>((event, emit) async {
      emit(ShipmentLoading());

      try {
        final shipments = await getShipments();

        if (shipments.isEmpty) {
          emit(ShipmentError());
        } else {
          emit(ShipmentLoaded(shipments));
        }
      } catch (_) {
        emit(ShipmentError());
      }
    });
  }
}
