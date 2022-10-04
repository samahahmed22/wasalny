import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/utils/app_colors.dart';
import '../cubit/maps/maps_cubit.dart';

class SearchBar extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String imageIcon;
  final String? hint;
  final Function()? onTap;

  SearchBar(
      {required this.controller,
      required this.focusNode,
      required this.imageIcon,
      this.hint,
      this.onTap});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  void searchPlace(String placeName, BuildContext context) {
    if (placeName.length > 1) {
      final sessionToken = Uuid().v4();
      MapsCubit.get(context).getPredictions(placeName, sessionToken);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Image.asset(
          widget.imageIcon,
          height: 16,
          width: 16,
        ),
        SizedBox(
          width: 18,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.lightGrayFair,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: EdgeInsets.all(2.0),
              child: TextField(
                onTap: widget.onTap,
                controller: widget.controller,
                onChanged: (value) {
                  setState(() {});
                  searchPlace(value, context);
                },
                focusNode: widget.focusNode,
                decoration: InputDecoration(
                    suffixIcon: widget.controller.text.isEmpty
                        ? null
                        : IconButton(
                            onPressed: () {
                              widget.controller.clear();
                              setState(() {});
                            },
                            icon: Icon(Icons.clear)),
                    hintText: widget.hint,
                    fillColor: AppColors.lightGrayFair,
                    filled: true,
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding:
                        EdgeInsets.only(left: 10, top: 8, bottom: 8)),
              ),
            ),
          ),
        )
      ],
    );
  }
}
