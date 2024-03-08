

import 'package:flutter/material.dart';

class DashboardSearch extends StatelessWidget {
  DashboardSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      // padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: SizedBox(
        height: 45,
        width: double.infinity,
        child:
        Hero(
          tag: 'search',
          child: Material(
            color: Colors.transparent,
            child: TextFormField(
              readOnly: true,
              showCursor: false,
              // controller: searchCtrl.searchCtrl,
              // initialValue: searchCtrl.searchText.value,
              onTap: () {

              },
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 26,
                ),

                // helperText: "Search here now",
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: "Search here now",
                labelStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(color: Colors.transparent,width: 0)
                ),  enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide(color: Colors.transparent,width: 0)
              ),

                // isDense: true,
              ),
            ),
          ),
        )
        ,
      ),
    );
  }
}
