import 'package:flutter/material.dart';

class DismisItem extends StatelessWidget {
  Function? onDelete;
  Function? onUpdate;
  String nombre;
  String desc;
  String imagen;

  DismisItem({
    required this.nombre,
    required this.desc,
    required this.imagen,
    this.onDelete,
    this.onUpdate,
  });
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (DismissDirection direction) {
        // DBGlobal.db.delete(demo[index]["id"]);
        // getData();
        onDelete!();
      },
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(),
      secondaryBackground: Container(
        decoration: const BoxDecoration(
          color: Colors.red,
        ),
        child: const Center(
          child: Text(
            "ELiminar",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      child: ListTile(
        leading:
            // Container(
            //   margin: const EdgeInsets.symmetric(vertical: 10),
            //   height: 50,
            //   child: Image.network(
            //    imagen
            //    ),
            // ),
            ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: FadeInImage(
            fit: BoxFit.cover,
            image: NetworkImage(imagen),
            placeholder: const AssetImage(
              "assets/images/assetsImage.jpg",
            ),
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset(
                "assets/images/assetsImage.jpg",
                height: 50,
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        title: Text(nombre),
        // demo[index]["nomb"]),
        subtitle: Text(desc),
        // demo[index]["desc"]),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                onPressed: () {
                  onDelete!();
                  // DBGlobal.db.delete(demo[index]["id"]);
                  // getData();
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.blue,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () {
                  onUpdate!();
                  // addmodal(context, false);

                  // getData();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
