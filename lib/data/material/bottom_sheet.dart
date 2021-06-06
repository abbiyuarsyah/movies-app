import 'package:flutter/material.dart';

class BottomSheetMaterial {
  Widget bottomSheetDialog(
      String description, BuildContext context, VoidCallback onTap) {
    return Container(
      height: 140,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin:
                    EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                child: Text(
                  "Information",
                  maxLines: 3,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 16, top: 16, bottom: 16),
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: onTap,
                  child: Icon(
                    Icons.close,
                    color: Color(0XFF77869E),
                  ),
                ),
              ),
            ],
          ),
          Divider(
            height: 6,
            color: Color(0XFFE5E5EA),
          ),
          Container(
            margin: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
            alignment: Alignment.centerLeft,
            child: Text(
              description,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          )
        ],
      ),
    );
  }
}
