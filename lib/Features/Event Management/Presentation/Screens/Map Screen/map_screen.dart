import 'package:evently/Core/assets/const%20data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../Core/App Colors/main_colors.dart';
import '../../Cubit/States/event_form_states.dart';
import '../../Cubit/View Models/event_form_view_model.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  late EventFormViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = context.read<EventFormViewModel>();
    if(viewModel.state.currentPosition==null){
      viewModel.getInitialPosition();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<EventFormViewModel, EventFormState>(
        builder: (BuildContext context, EventFormState state) {
          if(viewModel.state.currentPosition==null){
            return Text("Something Went WRONG");
          }
          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: viewModel.state.currentPosition! ,
                  zoom: 14.5,
                ),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                markers: (state.marker != null) ? {state.marker!} : {},
                onMapCreated: (controller) => mapController = controller,
                onTap: (latLng) {
                  viewModel.setCurrentPosition(latLng);
                },
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if(state.setPositionRequestState==RequestState.success){
                        Navigator.pop(context);
                      }
                    },
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
                        color: MainColors.getLightColor(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
