import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/bloc/bloc_home/home_cubit.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit bloc = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return FlutterMap(
          mapController: bloc.mapController,
          options: MapOptions(
            center: const LatLng(
                51.509364, -0.128928
            ),
            zoom: 10,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            MarkerLayer(
              markers: bloc.currentLocation != null ? [
                Marker(
                  width: 40,
                  height: 40,
                  point: LatLng(bloc.currentLocation!.latitude!, bloc.currentLocation!.longitude!),
                  builder: (context) => const Icon(Icons.location_on),
                ),
              ] : [],
            )
          ],
        );
      },
    );
  }
}
