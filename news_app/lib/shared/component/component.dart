import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/web_view_screen.dart';

//text form field
Widget defaultTextForm({
  bool isClickable = true,
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required IconData prefix,
  void Function(String)? onSubmit,
  void Function(String)? onChange,
  void Function()? onTap,
  required String? Function(String?)? validate,
  bool isPassSec = false,
  IconData? suffix,
  VoidCallback? suffixPressed,
}) =>
    TextFormField(
      // readOnly: true,
      enabled: isClickable,
      validator: validate,
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(onPressed: suffixPressed, icon: Icon(suffix))
            : null,
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      obscureText: isPassSec,
    );

//news container
Widget buildArticleItem(article , context) => InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(article['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10,
                ),
                image: article['urlToImage'] != null
                    ? DecorationImage(
                        image: NetworkImage(
                          '${article['urlToImage']}',
                        ),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

//Line
Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
    );

//to show 10 news
Widget articleBuilder(list , {isSearch = false}) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: 10,
      ),
      fallback: (context) => isSearch ? Container() : Center(child: CircularProgressIndicator()),
    );

//Navigator
void navigateTo(context, Widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Widget,
    ));
