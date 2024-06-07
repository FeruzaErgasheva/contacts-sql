import 'package:flutter/material.dart';
import 'package:lesson_52/controllers/contacts_controller.dart';
import 'package:lesson_52/providers/contacts_provider.dart';

class ConstactsScreen extends StatefulWidget {
  const ConstactsScreen({super.key});

  @override
  State<ConstactsScreen> createState() => _ConstactsScreenState();
}

class _ConstactsScreenState extends State<ConstactsScreen> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ContactsProvider.of(context),
      builder: (context, child) {
        return Builder(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                      onPressed: () {
                        ContactsProvider.of(context)
                            .addContact("Musliam", "ERgasheva", 99990);
                        setState(() {});
                      },
                      icon: const Icon(Icons.add))
                ],
                backgroundColor: Colors.amber,
                centerTitle: true,
                title: const Text("Contacts"),
              ),
              body: FutureBuilder(
                future: ContactsProvider.of(context).contacts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text("KOntaklar mavjud emas"),
                    );
                  }
                  var contacts = snapshot.data;
                  return contacts == null || contacts.isEmpty
                      ? const Center(
                          child: Text("KOntaktlar mavjud emas"),
                        )
                      : ListView.builder(
                          itemCount: contacts.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(contacts[index].name +
                                  contacts[index].surname),
                              subtitle: Text(contacts[index].phone.toString()),
                            );
                          },
                        );
                },
              ),
            );
          },
        );
      },
    );
  }
}
