import 'package:flutter/material.dart';
import 'package:justcook/src/constants/customColor.dart';
import 'package:justcook/src/views/widgets/customInput.dart';
import 'package:provider/provider.dart';
import 'package:justcook/src/providers/provider.dart';

class HeaderSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<AppProvider>(context);
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: CustomInput(),
          ),
          Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: CustomColor.pinkColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            bottomLeft: Radius.circular(50))),
                    child: Icon(Icons.search, color: Colors.white),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
