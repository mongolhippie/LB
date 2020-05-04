import 'package:flutter/material.dart';
import 'package:littlebusiness/logic/Category.dart';
import 'package:littlebusiness/DAO.dart';
import '../elements/alerts.dart';
import '../elements/ext.dart';
import '../elements/radio_color.dart';

class FormEditCategoryPage extends StatefulWidget {
  FormEditCategoryPage({Key key, this.id}) : super(key: key);
  final String id;

  @override
  _FormEditCategoryPageState createState() => _FormEditCategoryPageState();
}

class _FormEditCategoryPageState extends State<FormEditCategoryPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    category = getCategoryByID(widget.id);
    _name = category.getName();
    _color = category.getColor();
    checkboxes = ListColor().getColorCheckboxesList(_color);
  }

  String _name;
  int _color;
  Category category;
  List<RadioModel> checkboxes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Category ${category.getName()}'),
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
                    initialValue: _name,
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
                      side: BorderSide(color: Colors.red)),
                  child: Text('Edit Category'),
                  color: Colors.teal,
                  textColor: Colors.white,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      category.changeName(_name);
                      category.changeColor(_color);
                      editCategory(category);
                      Navigator.pushReplacementNamed(context, '/categories');
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
