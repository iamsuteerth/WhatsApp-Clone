import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/widgets/error.dart';
import 'package:whatsapp_clone/common/widgets/loader.dart';
import 'package:whatsapp_clone/features/select_contacts/controller/select_contact_controller.dart';

final selectedGroupContact = StateProvider<List<Contact>>((ref) => []);

class SelectContactsGroup extends ConsumerStatefulWidget {
  const SelectContactsGroup({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectContactsGroupState();
}

class _SelectContactsGroupState extends ConsumerState<SelectContactsGroup> {
  List<String> selectedContactsIndex = [];

  void selectContact(Contact contact, String phoneNumber) {
    if (selectedContactsIndex.contains(phoneNumber)) {
      selectedContactsIndex.removeWhere((element) => element == phoneNumber);
      setState(() {
        ref.read(selectedGroupContact.notifier).update((state) {
          state.removeWhere((element) => element == contact);
          state = [...state];
          return state;
        });
      });
    } else {
      selectedContactsIndex.add(phoneNumber);
      setState(() {
        ref.read(selectedGroupContact.notifier).update((state) {
          state.add(contact);
          state = [...state];
          return state;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(getContactProvider).when(
          data: (contactList) => Expanded(
            child: ListView.builder(
              itemCount: contactList.length,
              itemBuilder: (context, index) {
                final contact = contactList[index];
                return InkWell(
                  onTap: () => selectContact(
                    contact,
                    contact.phones[0].number.toString(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      title: Text(
                        contact.displayName,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      leading: selectedContactsIndex
                              .contains(contact.phones[0].number)
                          ? IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.done),
                            )
                          : null,
                    ),
                  ),
                );
              },
            ),
          ),
          error: (error, stackTrace) => ErrorWidgetCustom(
            error: error.toString(),
          ),
          loading: () => const Loader(),
        );
  }
}
