import 'package:easy_localization/easy_localization.dart';
import 'package:evently/Features/Authentication%20Screens/Presentation/Components/text_field_card.dart';
import 'package:evently/Features/Home%20Screen/domain/Usecase/update_fave.dart';
import 'package:evently/Features/Home%20Screen/persentation/Tabs/Fav%20Tab/data/Data%20source/fave_ds.dart';
import 'package:evently/Features/Home%20Screen/persentation/Tabs/Fav%20Tab/data/Repository%20IMP/fav_repo_imp.dart';
import 'package:evently/Features/Home%20Screen/persentation/Tabs/Fav%20Tab/domain/Usecase/get_fav_events_usecase.dart';
import 'package:evently/Features/Home%20Screen/persentation/Tabs/Fav%20Tab/domain/Usecase/search_usecase.dart';
import 'package:evently/Features/Home%20Screen/persentation/Tabs/Fav%20Tab/persentation/fav_tab_states.dart';
import 'package:evently/Features/Home%20Screen/persentation/Tabs/Fav%20Tab/persentation/fav_tab_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:evently/Core/Color/main_colors.dart';
import '../../../../data/Repository Implementation/repo_impl.dart';
import '../../../../data/datasource/home_screen_ds.dart';
import '../../../Components/event_card.dart';

class FavTab extends StatefulWidget {
  const FavTab({super.key});

  @override
  State<FavTab> createState() => _FavTabState();
}

class _FavTabState extends State<FavTab> {
  late TextEditingController _searchController;

  late FavViewModel viewModel;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    viewModel = FavViewModel(
      searchUseCase: SearchUC(FavRepoImp(FaveTabDSImp())),
      favEventsUseCase: GetFavEventsUC(FavRepoImp(FaveTabDSImp())),
      updateUseCase: UpdateFavUC(HomeScreenRepoImp(HomeScreenDSImp())),
    );

    _searchController.addListener(() {
      final text = _searchController.text.trim();
      if (text.isEmpty) {
        viewModel.getFavEvents();
        return;
      }
      viewModel.searchEvents(text);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: BlocProvider(
            create: (context) => viewModel,
            child: BlocBuilder<FavViewModel, FavTabState>(
              builder: (context, state) {
                return Column(
                  spacing: 16.h,
                  children: [
                    TextFieldCard(
                      hintText: "search_for_event_text".tr(),
                      icon: Icons.search,
                      textController: _searchController,
                      color: MainColors.getMainColor(),
                    ),
                    (state.events.isEmpty)
                        ? Align(alignment:Alignment.center,child: Text("No events"))
                        : Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 16.h);
                            },
                            itemCount: (_searchController.text=="") ?state.events.length : viewModel.state.searchResults.length,
                            itemBuilder: (context, index) {
                              if (_searchController.text==""){
                                return EventCard(
                                  event: state.events[index],
                                  updateFav: () {
                                    viewModel.updateFave(
                                      viewModel.state.events[index].id,
                                      viewModel.state.events[index].isFav,
                                    );
                                  },
                                );
                              }
                              return EventCard(
                                event: state.searchResults[index],
                                updateFav: () {
                                  viewModel.updateFave(
                                    state.searchResults[index].id,
                                    state.searchResults[index].isFav
                                  );
                                },
                              );
                            },
                          ),
                        ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
