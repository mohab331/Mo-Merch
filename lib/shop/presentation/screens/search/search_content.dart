import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class SearchContent extends StatefulWidget {
  const SearchContent({Key? key}) : super(key: key);

  @override
  State<SearchContent> createState() => _SearchContentState();
}

class _SearchContentState extends State<SearchContent> {
  late TextEditingController searchTextEditingController;
  Timer? _debounce;
  String? previousValue = '';

  @override
  void initState() {
    searchTextEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchTextEditingController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = context.watch<SearchCubit>().state;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          DefaultTextFormField(
            textController: searchTextEditingController,
            textInputType: TextInputType.text,
            prefixIcon: Icons.search,
            label: R.strings.searchLabel,
            onValidateFunction: (value) => value.validateIsEmpty(),
            onChanged: (value) {
              if(previousValue?.toLowerCase() != value?.toLowerCase()) {
                previousValue = value;
                _search(
                  context,
                  word: value,
                );
              }
            },
          ),
          SizedBox(
            height: 8.h,
          ),
          if (searchState is SearchLoadingState)
            const LinearProgressIndicator(),
          Expanded(
            child: StateHandlingWidget(
              isLoading: false,
              hasError: searchState is SearchErrorState,
              onRetryButtonPressed: () => _search(
                context,
                word: searchTextEditingController.text,
              ),
              successWidget: searchState is SearchSuccessState
                  ? (searchState.products.isNotEmpty)
                      ? ListView.separated(
                physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) =>
                              BlocProvider<FavoriteCubit>(
                            create: (context) =>
                                diInstance.get<FavoriteCubit>(),
                            child: SearchItem(
                              product: searchState.products[index],
                            ),
                          ),
                          separatorBuilder: (context, index) => Divider(
                            height: 10.h,
                          ),
                          itemCount: searchState.products.length,
                        )
                      : EmptyListWidget(
                isLoading: searchState is SearchLoadingState,
                          emptyString: R.strings.emptySearchResult,
                          emptyWidget: const Icon(
                            Icons.search_off_outlined,
                          ),
                          onReloadButtonPressed: () => _search(
                            context,
                            word: searchTextEditingController.text,
                          ),
                        )
                  : Container(),
            ),
          ),
        ],
      ),
    );
  }

  bool _validateWord(String? searchWord) {
    return (searchWord != null && searchWord.isNotEmpty && searchWord != ' ');
  }

  void _search(
    BuildContext context, {
    required String? word,
  }) async {
    if (_validateWord(word)) {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 700), () async {
        context.read<SearchCubit>().searchProducts(
              searchString: word ?? '',
            );
      });
    }
  }
}
