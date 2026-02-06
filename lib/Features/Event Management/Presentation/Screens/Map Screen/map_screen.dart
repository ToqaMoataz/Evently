import 'package:easy_localization/easy_localization.dart';
import 'package:evently/Core/Provider/themeProvider.dart';
import 'package:evently/Core/assets/const%20data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../../Core/App Colors/main_colors.dart';
import '../../../../Authentication Screens/Presentation/Components/text_field_card.dart';
import '../../Cubit/States/event_form_states.dart';
import '../../Cubit/View Models/event_form_view_model.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  late TextEditingController _searchController;
  late EventFormViewModel viewModel;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    viewModel = context.read<EventFormViewModel>();
    if (viewModel.state.currentPosition == null) {
      viewModel.getInitialPosition();
    }
    _searchController.addListener(() {
      final text = _searchController.text.trim();
      if (text.isEmpty ||
          text == viewModel.state.selectedSearchResult?.displayName) {
        viewModel.unShowResultsCard();
        return;
      }
      viewModel.searchPlace(text);
    });
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    bool isLight = (themeProvider.themeMode == ThemeMode.light);
    return BlocBuilder<EventFormViewModel, EventFormState>(
      builder: (BuildContext context, EventFormState state) {
        return Scaffold(
          body: Stack(
            children: [
              (state.setPositionRequestState == RequestState.loading)
                  ? Center(
                    child: CircularProgressIndicator(
                      color: MainColors.getMainColor(),
                    ),
                  )
                  : GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: viewModel.state.currentPosition!,
                      zoom: 14.5,
                    ),
                    myLocationEnabled: true,
                    markers: (state.marker != null) ? {state.marker!} : {},
                    onMapCreated: (controller) => mapController = controller,
                    onTap: (latLng) {
                      viewModel.setCurrentPosition(latLng);
                    },
                  ),
              Positioned(
                top: 40,
                left: 16,
                right: 16,
                child: Column(
                  children: [
                    TextFieldCard(
                      hintText: "search_for_place_text".tr(),
                      icon: Icons.search,
                      textController: _searchController,
                      color: MainColors.getMainColor(),
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                    ),
                    SizedBox(height: 4.h,),
                    (state.showSearchResults && state.searchResults != null)
                        ? (state.searchResults!.isNotEmpty)
                            ? ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 250.h),
                      child: Material(
                        elevation: 8,
                        borderRadius: BorderRadius.circular(18.r),
                        shadowColor: Colors.black.withOpacity(0.15),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18.r),
                          ),
                          child: ListView.separated(
                            padding: EdgeInsets.zero,
                            itemCount: state.searchResults!.length,
                            separatorBuilder: (context, index) => Divider(
                              height: 1,
                              thickness: 0.8,
                              color: Colors.grey.withOpacity(0.25),
                            ),
                            itemBuilder: (context, index) {
                              final item = state.searchResults![index];
                              final placeName = item.displayName;

                              return InkWell(
                                borderRadius: BorderRadius.circular(14.r),
                                onTap: () {
                                  viewModel.selectPlace(item);
                                  _searchController.text = placeName;
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 14.w,
                                    vertical: 14.h,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        color: MainColors.getMainColor(),
                                        size: 22.sp,
                                      ),
                                      SizedBox(width: 10.w),

                                      Expanded(
                                        child: Text(
                                          placeName,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.inter(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    )
                        : SizedBox.shrink()
                        : SizedBox.shrink(),
                  ],
                ),
              ),
              (state.showSearchResults)
                  ? SizedBox.shrink()
                  : Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (state.setPositionRequestState ==
                              RequestState.success) {
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
                          "select_location_text".tr(),
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
          ),
        );
      },
    );
  }
}
