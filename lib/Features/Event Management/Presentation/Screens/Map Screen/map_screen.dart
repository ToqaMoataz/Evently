import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../Core/Color/main_colors.dart';
import '../../Cubit/States/event_creation_states.dart';
import '../../Cubit/View Models/event_creation_view_model.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<EventCreationViewModel, EventCreationState>(
        builder: (context, state) {
          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(30.0277, 31.2115),
                  zoom: 14.5,
                ),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                markers: {},
                onMapCreated: (controller) => mapController = controller,
                onTap: (latLng) {

                  // setState(() {
                  //   currentPosition = latLng;
                  //   mapController?.animateCamera(
                  //     CameraUpdate.newLatLng(latLng),
                  //   );
                  //   markers.add(
                  //     Marker(
                  //       markerId: MarkerId('event'),
                  //       position: currentPosition!,
                  //     ),
                  //   );
                  // });
                },
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MainColors.getMainColor(),
                      padding: EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: Text(
                      "Tap on Location To Select",
                      style: GoogleFonts.inter(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: MainColors.getTextPrimaryColor(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        listener: (context, state) {

        },

      ),
    );
  }
}
