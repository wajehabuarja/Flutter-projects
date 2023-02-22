import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, shopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          // condition: ShopCubit.get(context).favoritesModel.data!.data!.isNotEmpty,
          builder: (context) => ListView.separated(
              itemBuilder: (context, index) => buildFavItem(
                  ShopCubit.get(context).favoritesModel.data!.data![index],
                  context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount:
                  ShopCubit.get(context).favoritesModel.data!.data!.length),
          fallback: (context) => Center(child: const CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildFavItem(favoritesData model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 110,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage('${model.product!.image}'),
                    width: 120,
                    height: 120,
                  ),
                  if (model.product!.discount != 0)
                    Container(
                      color: Colors.red,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 3,
                      ),
                      child: Text('DISCOUNT',
                          style: GoogleFonts.aBeeZee(
                              textStyle: const TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ))),
                    ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.product!.name ?? 'default_name',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.workSans(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          height: 1.3,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text('${model.product!.price.toString()}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.copse(
                              textStyle: const TextStyle(
                                fontSize: 12,
                                color: defaultColor,
                              ),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        if (model.product!.discount != 0)
                          Text(
                            '${model.product!.oldPrice.toString()}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.copse(
                              textStyle: const TextStyle(
                                fontSize: 10,
                                color: Colors.black,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ),
                        const Spacer(),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            print(model.id);
                            ShopCubit.get(context)
                                .changeFavorites(model.product!.id);
                          },
                          icon: Icon(
                            (ShopCubit.get(context)
                                        .favorites[model.product!.id] ??
                                    false)
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                            size: 18,
                            color: defaultColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
