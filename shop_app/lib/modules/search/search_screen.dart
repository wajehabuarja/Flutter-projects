import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/search/cubit/search_cubit.dart';
import 'package:shop_app/modules/search/cubit/search_states.dart';
import 'package:shop_app/shared/component/component.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();

    var searchController = TextEditingController();

    return BlocProvider(
      create: (context) => ShopSearchCubit(),
      child: BlocConsumer<ShopSearchCubit, ShopSearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) return 'Enter text to search';

                        return null;
                      },
                      label: 'Search',
                      prefix: Icons.search,
                      onSubmit: (String text) {
                        ShopSearchCubit.get(context).Search(text);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (state is ShopSearchLoadingStates)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 10,
                    ),
                    if (state is ShopSearchSuccessStates)
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) => buildListProduct(
                              ShopSearchCubit.get(context)
                                  .searchModel
                                  .data!
                                  .data![index],
                              context,
                              isOldPrice: false),
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount: ShopSearchCubit.get(context)
                              .searchModel
                              .data!
                              .data!
                              .length),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
