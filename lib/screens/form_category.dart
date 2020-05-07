import 'package:flutter/material.dart';
import 'package:littlebusiness/logic/Category.dart';
import 'package:littlebusiness/DAO.dart';
import '../elements/alerts.dart';
import '../elements/ext.dart';
import '../elements/radio_color.dart';
import '../constants.dart';

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
    checkboxes = ListColor().getColorCheckboxesList(0xffe6194B);
  }

  String _name;
  int _color = 0xffe6194B;
  List<RadioModel> checkboxes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Category',
          style: TextStyle(fontFamily: 'Comfortaa'),
        ),
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
                      labelStyle: TextStyle(fontFamily: 'Comfortaa'),
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
                        itemCount: checkboxes.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            splashColor: Color(checkboxes[index].colorCode),
                            onTap: () {
                              setState(() {
                                checkboxes.forEach(
                                    (element) => element.isSelected = false);
                                checkboxes[index].isSelected = true;
                                _color = checkboxes[index].colorCode;
                              });
                            },
                            child: RadioColorItem(checkboxes[index]),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: kBorderGreen)),
                  child: Text(
                    'Add New Category',
                    style:
                        TextStyle(fontFamily: 'Comfortaa', color: Colors.white),
                  ),
                  color: kFillGreen,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      if (addCategory(Category(_name, _color))) {
                        //       Navigator.pop(context, 1);
                        Navigator.pushReplacementNamed(context, '/categories');
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
