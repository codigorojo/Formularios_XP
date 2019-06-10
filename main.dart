import 'package:flutter/material.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//      title: "Formularios",
      home: PrimeraPantalla(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PrimeraPantalla extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PrimeraPantallaState();
}

class PrimeraPantallaState extends State<PrimeraPantalla> {
String usuario = "", password = "";
final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Primer Pantalla"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              TextFormField (
                decoration: InputDecoration(labelText: "Usuario"),
                validator: (value){
                  if(value.isEmpty){
                    return "El nombre de usuario no puede quedar vacío";
                  }
                },
                onSaved: (value){
                  usuario = value;
                },
              ),
              TextFormField (
                decoration: InputDecoration(labelText: "Contraseña"),
                obscureText: true,
                validator: (value){
                  if(value.isEmpty){
                    return "La contraseña no puede quedar vacía";
                  }else if(value.length < 6) {
                    return "La contraseña debe tener al menos 6 caractéres";
                  }
                },
                onSaved: (value){
                  password = value;
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: RaisedButton(
                  onPressed: (){
                  _submit(context);
                },
                  child: Text("Enviar"),
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  _submit(BuildContext context) {
    if(formKey.currentState.validate()){
      formKey.currentState.save();
      _abrirSegundaPantalla(context);
    }
  }

  _abrirSegundaPantalla(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => SegundaPantalla(usuario, password)));
  }
}



class SegundaPantalla extends StatelessWidget {
  final String usuario, password;

  SegundaPantalla(this.usuario, this.password);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Segunda Pantalla"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Usuario: $usuario",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Contraseña: $password",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            RaisedButton(
              onPressed: () => _cerrar(context),
              child: Text("Cerrar"),
            ),
          ],
        ),
      ),
    );
  }

  _cerrar(BuildContext context) {
    Navigator.pop(context);
  }
}
