import 'package:app/layouts/room_page.dart';
import 'package:app/services/firestore_service.dart';
import 'package:app/widgets/drawer/drawer_widget.dart';
import 'package:flutter/material.dart';

class ListAllFingerprints extends StatefulWidget {
  ListAllFingerprints({super.key});

  @override
  State<ListAllFingerprints> createState() => _ListAllFingerprintsState();
}

class _ListAllFingerprintsState extends State<ListAllFingerprints> {
  bool isLoading = true;
  final FirestoreService _firestoreService = FirestoreService();
  List fingerprints = [];

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () async {
      var fingerprints = await _firestoreService.getAllFingerprints();
      setState(() {
        this.fingerprints = fingerprints;
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    Future.delayed(Duration.zero, () async {
      var fingerprints = await _firestoreService.getAllFingerprints();
      setState(() {
        this.fingerprints = fingerprints;
        isLoading = false;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print(fingerprints);
    if (isLoading) {
      return LockeyLayout(
          child: Container(
        //height de todo el container
        height: MediaQuery.of(context).size.height,
        child: const Center(child: CircularProgressIndicator()),
      ));
    }
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: const Text("Lockey",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontFamily: 'Playfair',
                  fontWeight: FontWeight.w500)),
        ),
        drawer: DrawerWidget(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: fingerprints.length,
            itemBuilder: (context, index) {
              final fingerprint = fingerprints[index];
              return GestureDetector(
                onTap: () {
                  // Show modal when item is tapped
                  showModal(context, fingerprint);
                },
                child: ListTile(
                  title: Text(fingerprint['name']),
                  subtitle: Text('ID Huella: ${fingerprint['id_fingerprint']}'),
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigate to add screen,
            Navigator.pushNamed(context, '/register-fingerprint');
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.black,
        ));
  }

  void showModal(BuildContext context, Map<String, dynamic> data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Editar/Eliminar'),
              Text(' ${data['name']}',
                  style: const TextStyle(
                      color: Colors.red, fontStyle: FontStyle.italic)),
            ],
          ),
          content: const Text('¿Quieres editar o eliminar este registro?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Editar'),
              onPressed: () {
                // Navigate to edit screen
                Navigator.pop(context);
                Navigator.pushNamed(context, '/edit-fingerprint',
                    arguments: data);
              },
            ),
            TextButton(
              child: const Text('Eliminar'),
              onPressed: () {
                // Delete item and dismiss modal
                Future.delayed(Duration.zero, () async {
                  await _firestoreService.deleteFingerprint(data['id_user']);
                });
                Navigator.pushReplacementNamed(context, '/list-fingerprints');
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Dismiss modal
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
              ),
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }
}
