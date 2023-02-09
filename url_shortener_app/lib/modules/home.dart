import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_shortener_app/Links.dart';
import 'package:url_shortener_app/shared/cubit/cubit.dart';
import 'package:url_shortener_app/shared/cubit/states.dart';

class Home extends StatelessWidget {
  Home({super.key, required this.links});

  late Links linkt;
  final List<Links> links;

  @override
  Widget build(BuildContext context) {
    var cubit = Appcubit.get(context);
    final _formkey = GlobalKey<FormState>();
    final urlTextController = TextEditingController();

    void biteLink(String url) async {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  CircularProgressIndicator.adaptive(),
                  SizedBox(
                    height: 10,
                  ),
                  Text("we're biting your link")
                ],
              ),
            ),
          );
        },
      );
      try {
        final response =
            await Dio().get('https://api.shrtco.de/v2/shorten?url=$url');
        if (response.data['ok'] = true) {
          final data = response.data;
          final bittenLink = data['result']['full_short_link'];
          final originalLink = data['result']['original_link'];
          cubit.copyToClipboard(bittenLink);

          linkt = Links(
              bittenLink: bittenLink.toString(),
              orginalLink: originalLink.toString());
          cubit.links.add(linkt);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('bitten Link copied to clipboard'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pop();
        }
      } catch (error) {
        print('error ${error}');
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Somthing went wrong please try again'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    return BlocConsumer<Appcubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = Appcubit.get(context);
        return Form(
          key: _formkey,
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Simple and fast URL shortener!',
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'ShortURL allows to reduce long links from Instagram, Facebook, YouTube, Twitter, Linked In and top sites on the Internet, just paste the long URL and click the Shorten URL button. On the next screen, copy the shortened URL and share it on websites, chat and e-mail.',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.url,
                    controller: urlTextController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the Url';
                      }
                      if (!value.startsWith('https://') &&
                          !value.startsWith('www.')) {
                        return 'Please enter a valid url.';
                      }
                      final exp = RegExp(
                          r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
                      if (!exp.hasMatch(value)) {
                        return 'Please enter a valid url.';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.link, color: Colors.black),
                      labelText: 'Enter Your URL here.',
                      labelStyle: TextStyle(
                        color: Color.fromARGB(255, 112, 112, 112),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      hintText: 'https://www.example.com',
                      hintStyle: TextStyle(
                        fontSize: 13,
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  MaterialButton(
                      color: Color.fromARGB(255, 112, 112, 112),
                      onPressed: () {
                        if (!_formkey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please Enter valid url')));
                          return;
                        }
                        biteLink(urlTextController.text);
                        print(urlTextController.text);
                      },
                      child: const Text(
                        'Shortener Url',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
