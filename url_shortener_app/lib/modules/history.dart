import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_shortener_app/Links.dart';
import 'package:url_shortener_app/shared/cubit/cubit.dart';
import 'package:url_shortener_app/shared/cubit/states.dart';

class History extends StatefulWidget {
  History({super.key, required this.links});

  final List<String> links;

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  void removeLink(Links link) {
    setState(() {
      Appcubit.get(context).links.remove(link);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = Appcubit.get(context);

        return ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final String bitlink = cubit.links[index].bittenLink;
            final String orglink = cubit.links[index].orginalLink;
            return InkWell(
              onLongPress: () {
                cubit.copyToClipboard(cubit.links[index].bittenLink);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('bitten Link copied to clipboard'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: ListTile(
                title: Text(bitlink),
                subtitle: Text(orglink),
                trailing: IconButton(
                    onPressed: () {
                      removeLink(cubit.links[index]);
                    },
                    icon: const Icon(
                      Ionicons.remove_circle_outline,
                      color: Colors.red,
                    )),
              ),
            );
          },
          itemCount: cubit.links.length,
          separatorBuilder: (context, index) => const Divider(
            height: 0,
          ),
        );
      },
    );
  }
}
