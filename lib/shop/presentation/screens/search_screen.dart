import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/media_query.dart';
import 'package:shop_app_clean_architecture/core/utils/app_functions.dart';
import 'package:shop_app_clean_architecture/core/widgets/empty_widget.dart';
import 'package:shop_app_clean_architecture/core/widgets/network_error_widget.dart';
import 'package:shop_app_clean_architecture/shop/presentation/screens/product_description_screen.dart';

import '../../../core/utils/app_strings.dart';
import '../../../core/widgets/default_text_form_field.dart';
import '../cubit/search/search_cubit.dart';
import '../cubit/search/search_states.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController _searchTextEditingController =
      TextEditingController();

  SearchScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appBarSearchTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: context.height * 0.1,
              child: DefaultTextFormField(
                  textController: _searchTextEditingController,
                  textInputType: TextInputType.text,
                  prefixIcon: Icons.search,
                  label: AppStrings.searchLabel,
                  onValidateFunction: AppFunctions.validateSearch,
                  onChanged: (String? value) {
                    if (value != null) {
                      SearchCubit.get(context).searchProducts(
                        context,
                        searchValue: value,
                      );
                    }
                  }),
            ),
            BlocBuilder<SearchCubit, SearchStates>(
              builder: (context, states) {
                if (states is SearchLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (states is SearchErrorState) {
                  return NetworkErrorWidget(
                    onReloadButtonPressed: (BuildContext context) {
                      SearchCubit.get(context).searchProducts(context,
                          searchValue: _searchTextEditingController.text);
                    },
                  );
                } else if (states is SearchSuccessState &&
                    SearchCubit.get(context).searchProductResults.isEmpty) {
                  return const EmptyWidget(
                    iconData: Icons.search_off,
                    title: AppStrings.emptySearchResult,
                  );
                } else {
                  return Builder(builder: (context) {
                    return Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.all(15.0),
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(20.0),
                                      border: Border.all(
                                          color: Colors.black, width: 2)),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 30.0,
                                      backgroundImage: NetworkImage(
                                          SearchCubit.get(context)
                                              .searchProductResults[index]
                                              .image),
                                    ),
                                    title: Text(SearchCubit.get(context)
                                        .searchProductResults[index]
                                        .name,style: Theme.of(context).textTheme.bodyMedium,),
                                    subtitle: Text(SearchCubit.get(context)
                                        .searchProductResults[index]
                                        .price
                                        .toStringAsFixed(1)),
                                    onTap: () {
                                      AppFunctions.navigateTo(
                                        context: context,
                                        screen: ProductDescriptionScreen(
                                          product: SearchCubit.get(context)
                                              .searchProductResults[index],
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                              itemCount: SearchCubit.get(context)
                                  .searchProductResults
                                  .length,
                            ),
                          ),
                        ],
                      ),
                    );
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
