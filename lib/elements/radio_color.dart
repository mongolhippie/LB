import 'package:flutter/material.dart';

class RadioColorItem extends StatelessWidget {
  final RadioModel _item;

  RadioColorItem(this._item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: 35.0,
            width: 35.0,
            alignment: Alignment.center,
            child: Container(
                height: 25.0,
                width: 25.0,
                decoration: BoxDecoration(
                  color: Color(_item.colorCode),
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(15)),
                )),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                  width: 3.0,
                  color: _item.isSelected
                      ? Color(_item.colorCode)
                      : Colors.transparent),
              borderRadius: const BorderRadius.all(const Radius.circular(25)),
            ),
          ),
          Container(margin: EdgeInsets.only(left: 20.0))
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String buttonText;
  final int colorCode;
  RadioModel(this.isSelected, this.buttonText, this.colorCode);
  void changeSelect(bool s) {
    isSelected = s;
  }
}

class ListColor {
  List<RadioModel> getColorCheckboxesList(int color) {
    List<RadioModel> sampleData = new List<RadioModel>();
    sampleData.add(RadioModel(false, 'Red', 0xffe6194B));
    sampleData.add(RadioModel(false, 'Orange', 0xfff58231));
    sampleData.add(RadioModel(false, 'Yellow', 0xffffe119));
    sampleData.add(RadioModel(false, 'Green', 0xffbfef45));
    sampleData.add(RadioModel(false, 'Blue', 0xff3595F4));
    sampleData.add(RadioModel(false, 'Purple', 0xff9929B1));
    for (var i = 0; i < sampleData.length; i++) {
      if (sampleData[i].colorCode == color) {
        sampleData[i].changeSelect(true);
      }
    }
    return sampleData;
  }
}
