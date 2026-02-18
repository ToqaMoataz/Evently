import 'package:evently/Core/App%20Colors/main_colors.dart';
import 'package:evently/Core/Dependency%20Injection/di.dart';
import 'package:evently/Core/assets/const%20data.dart';
import 'package:evently/Features/Home%20Screen/persentation/Components/event_map_component.dart';
import 'package:evently/Features/Home%20Screen/persentation/Tabs/Map%20Tab/persentation/Cubit/map_tab_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../../../../Core/Provider/network_info_provider.dart';
import '../Cubit/map_tab_states.dart';

class MapTab extends StatefulWidget {
  const MapTab({super.key});

  @override
  State<MapTab> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapTab> {
  GoogleMapController? mapController;
  late MapTabViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt<MapTabViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    var networkProvider = Provider.of<NetworkProvider>(context);
    return BlocProvider(
      create: (context) => viewModel..getEvents()..getInitialPosition(),
      child: BlocBuilder<MapTabViewModel, MapTabState>(
        builder: (context, state) {
          return Scaffold(
            body:
                (state.currentEventPosition == null || state.setPositionRequestState == RequestState.loading)
                    ? Center(
                      child: CircularProgressIndicator(
                        color: MainColors.getMainColor(),
                      ),
                    )
                    : Stack(
                      children: [
                        GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: viewModel.state.currentEventPosition!,
                            zoom: 14.5,
                          ),
                          myLocationEnabled: true,
                          myLocationButtonEnabled: true,
                          markers: (state.marker != null) ? {state.marker!} : {},
                          onMapCreated:(controller) => mapController = controller,
                        ),
                        Positioned(
                          bottom: 32,
                          left: 16,
                          right: 16,
                          child: SizedBox(
                            height: 97.h,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.events.length,
                              separatorBuilder: (_, __) => SizedBox(width: 10.w),
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  child: EventMapCard(
                                    event: state.events[index],
                                    resetPosition: () {
                                      final position = state.events[index].eventPosition;
                                      viewModel.setMarker(position);
                                      mapController?.animateCamera(
                                        CameraUpdate.newCameraPosition(
                                          CameraPosition(
                                            target: position,
                                            zoom: 14.5,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                      ],
                    ),
          );
        },
      ),
    );
  }
}
