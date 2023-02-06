import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/component/component.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {
        
      },
      builder: (context, state) {

        var list = NewsCubit.get(context).search;

        return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: defaultTextForm(
                controller: searchController,
                type: TextInputType.text,
                label: 'Search',
                prefix: Icons.search,
                onChange: (value) {
                  NewsCubit.get(context).getSearch(value);
                },
                validate: (value) {
                  if (value!.isEmpty) {
                    return '';
                  }
                  return null;
                },
              ),
            ),
            Expanded(child: articleBuilder(list , isSearch: true)),
          ],
        ),
      );
      },
       
    );
  }
}
