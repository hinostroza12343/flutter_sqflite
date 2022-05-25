import 'package:esekuele_repaso/db/dbglobal.dart';
import 'package:esekuele_repaso/utils/model.dart';
import 'package:esekuele_repaso/widgets/dismisItem.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? id = 0;
  TextEditingController nombController = TextEditingController();

  TextEditingController descController = TextEditingController();

  TextEditingController imgController = TextEditingController();
  List<Map<String, dynamic>> demo = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData() async {
    demo = await DBGlobal.db.getAllData();
    setState(() {});
    return demo;
  }

  addmodal(BuildContext context, bool add) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 13,
                  ),
                  TextField(
                    controller: nombController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black.withOpacity(0.1),
                      hintText: "Nombre",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  TextField(
                    controller: descController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black.withOpacity(0.1),
                      hintText: "Descripcion",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  TextField(
                    controller: imgController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black.withOpacity(0.1),
                      hintText: "Imagen",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                ],
              ),
            ),
            title: Center(
              child: Text(add ? "Agregar" : "Actualizar"),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancelar",
                  style: TextStyle(color: Colors.black.withOpacity(0.66)),
                ),
              ),
              TextButton(
                onPressed: () {
                  Model model = Model(
                      nomb: nombController.text,
                      desc: descController.text,
                      img: imgController.text);
                  if (add) {
                    DBGlobal.db.insert(model);
                  } else {
                    model.id = id;
                    DBGlobal.db.update(model);
                    getData();
                  }
                  nomb:
                  nombController.clear();
                  desc:
                  descController.clear();
                  img:
                  imgController.clear();

                  Navigator.pop(context);
                  getData();
                },
                child: const Text("Aceptar"),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addmodal(context, true);
          getData();
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Center(
          child: Text(
            'Practica',
            style: TextStyle(color: Colors.black, fontSize: 35),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                future: getData(),
                builder: (_, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<Map<String, dynamic>> aux =
                      snapshot.data as List<Map<String, dynamic>>;
                  return ListView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    primary: true,
                    itemCount: aux.length,
                    itemBuilder: (BuildContext context, int index) {
                      return DismisItem(
                        nombre: aux[index]["nomb"],
                        desc: aux[index]["desc"],
                        imagen: aux[index]["img"],
                        onDelete: () {
                          DBGlobal.db.delete(aux[index]["id"]);
                          getData();
                        },
                        onUpdate: () {
                          id = aux[index]["id"];
                          nombController.text = aux[index]["nomb"];
                          descController.text = aux[index]["desc"];
                          imgController.text = aux[index]["img"];

                          addmodal(context, false);
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
