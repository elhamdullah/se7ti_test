import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety_123/core/utils/colors.dart';
import 'package:se7ety_123/core/utils/text_style.dart';
import 'package:se7ety_123/feature/patient/search/widgets/search_list.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.color1,
        foregroundColor: AppColors.white,
        title: const Text(
          'ابحث عن دكتور',
        ),
        centerTitle: true,
      ),

      ////////
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              height: 55,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.3),
                    blurRadius: 15,
                    offset: const Offset(5, 5),
                  )
                ],
              ),
              child: TextField(
                onChanged: (searchKey) {
                  setState(
                    () {
                      search = searchKey;
                    },
                  );
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.accentColor,
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      borderSide: BorderSide.none),
                  hintText: "البحث",
                  hintStyle: getBodyStyle(),
                  suffixIcon: const SizedBox(
                      width: 50,
                      child: Icon(Icons.search, color: AppColors.color1)),
                ),
              ),
            ),
            const Gap(15),
            Expanded(
              child: SearchList(
                searchKey: search,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
