import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class Registration extends StatefulWidget {
  @override
  _RegistrationPageState createState() => new _RegistrationPageState();
}

class _RegistrationPageState extends State<Registration> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  String _email;
  String _name;
  String _mobileNo;

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();

      // Email & password matched our validation rules
      // and are saved to _email and _password fields.
      _performLogin();
    }
  }

  void _performLogin() {
    // This is just a demo, so no actual login here.
    final snackbar = new SnackBar(
      content: new Text('Email: $_email, password: $_name'),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
        title: new Text('Registration forms'),
      ),
      body: new Padding(
          padding: const EdgeInsets.all(16.0),
          child: new ListView(children: [
            new Form(
              key: formKey,
              child: new Column(
                children: [
                  new ListTile(
                      title: new Container(
                        child: new TextFormField(
                          decoration: new InputDecoration(
                              labelText: "Name",
                              hintText: "Enter your Name",
                              border: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0)))),
                          key: new Key('name'),
                          validator: (val) =>
                          val.isEmpty ? 'Enter your Name' : null,
                          onSaved: (val) => _name = val,
                          // onFieldSubmitted:
                          //   (String value) {
                          // FocusScope.of(context)
                          //   .requestFocus(textfocus)
                          //},
                          keyboardType: TextInputType.text,
                        ),
                        margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                      )),
                  new ListTile(
                    title: new Container(
                      margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                      child: new TextFormField(
                        decoration: new InputDecoration(
                            labelText: "Phone",
                            hintText: "Enter Contact.No.",
                            border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0)))),
                        key: new Key('phone'),
                        validator: (val) =>
                        val.length != 10 ? 'Enter Contact.No.' : null,
                        onSaved: (val) => _mobileNo = val,
                        // onFieldSubmitted:
                        //   (String value) {
                        // FocusScope.of(context)
                        //   .requestFocus(textfocus)
                        //},
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ),
                  new ListTile(
                      title: new Container(
                        margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                        child: new TextFormField(
                          decoration: new InputDecoration(
                              labelText: "Email",
                              hintText: "Enter your Email.",
                              border: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0)))),
                          key: new Key('email'),
                          validator: (val) =>
                          !val.contains('@') ? 'Not a valid email.' : null,
                          onSaved: (val) => _email = val,
                          // onFieldSubmitted:
                          //   (String value) {
                          // FocusScope.of(context)
                          //   .requestFocus(textfocus)
                          //},
                          keyboardType: TextInputType.emailAddress,
                        ),
                      )),
                  new Container(
                    child: new RaisedButton(
                      onPressed: _submit,
                      child: new Text('Register',
                        style: new TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15.0,
                          fontFamily: 'Roboto-medium',
                        ),),
                      color: Theme.of(context).accentColor,
                      elevation: 4.0,
                      splashColor: Colors.blueGrey,
                      textColor: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ])),
    );
  }
}
