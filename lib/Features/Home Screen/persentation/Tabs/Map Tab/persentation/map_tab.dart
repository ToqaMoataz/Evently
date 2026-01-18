import 'package:evently/Core/assets/const%20data.dart';
import 'package:evently/Features/Home%20Screen/persentation/Components/event_map_component.dart';
import 'package:evently/Features/Home%20Screen/persentation/Tabs/Map%20Tab/persentation/map_tab_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Home Tab/data/Data source/home_tab_ds.dart';
import '../../Home Tab/data/Repository IMP/home_rep_impl.dart';
import '../../Home Tab/domain/Usecase/get_events_usecase.dart';
import 'map_tab_states.dart';

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
    viewModel = MapTabViewModel(GetEventsUC(HomeRepoImp(HomeTabDSImp())));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel..getEvents(AppData.events[0]),
      child: BlocBuilder<MapTabViewModel, MapTabState>(
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: viewModel.state.currentEventPosition!,
                    zoom: 14.5,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  markers: (state.marker != null) ? {state.marker!} : {},
                  onMapCreated: (controller) => mapController = controller,
                ),
                SafeArea(
                  child: Positioned(
                    bottom: 32,
                    left: 16,
                    child: SizedBox(
                      height: 94.h,
                      child: ListView.separated(
                        itemCount: state.events.length,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder:
                            (context, index) => SizedBox(width: 10.w),
                        itemBuilder: (context, index) {
                          return EventMapCard(
                            event: state.events[index],
                            resetPosition: () {
                              viewModel.setMarker(
                                state.events[index].eventPosition,
                              );
                            },
                          );
                        },
                      ),
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
