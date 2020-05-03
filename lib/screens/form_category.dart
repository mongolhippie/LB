import 'package:flutter/material.dart';
import 'package:littlebusiness/logic/Category.dart';
import 'package:littlebusiness/DAO.dart';
import '../elements/alerts.dart';
import '../elements/ext.dart';

class FormCategoryPage extends StatefulWidget {
  @override
  _FormCategoryPageState createState() => _FormCategoryPageState();
}

class _FormCategoryPageState extends State<FormCategoryPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sampleData.add(new RadioModel(true, 'Red', 0xffe6194B));
    sampleData.add(new RadioModel(false, 'Orange', 0xfff58231));
    sampleData.add(new RadioModel(false, 'Yellow', 0xffffe119));
    sampleData.add(new RadioModel(false, 'Green', 0xffbfef45));
    sampleData.add(new RadioModel(false, 'Blue', 0xff3595F4));
    sampleData.add(new RadioModel(false, 'Purple', 0xff9929B1));
  }

  List<RadioModel> sampleData = new List<RadioModel>();

  String _name;
  int _color = 0xffe6194B;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Category'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                    onSaved: (value) => _name = value.capitalize(),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width - 32,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: sampleData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            splashColor: Color(sampleData[index].colorCode),
                            onTap: () {
                              setState(() {
                                sampleData.forEach(
                                    (element) => element.isSelected = false);
                                sampleData[index].isSelected = true;
                                _color = sampleData[index].colorCode;
                              });
                            },
                            child: RadioColorItem(sampleData[index]),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.red)),
                  child: Text('Add New Category'),
                  color: Colors.teal,
                  textColor: Colors.white,
                  onPressed: () {
                    _formKey.currentState.save();
                    if (_formKey.currentState.validate()) {
                      if (addCategory(Category(_name, _color))) {
                        Navigator.pop(context, 1);
                      } else {
                        showOneButtonDialog(context, 'Name repeated!',
                            'There is already a Category with this name');
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
}
