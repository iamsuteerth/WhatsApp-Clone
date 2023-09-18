import 'package:flutter/material.dart';
import 'package:whatsapp_clone/constant_assets/colors.dart';

class WebSearchBar extends StatelessWidget {
  const WebSearchBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      width: MediaQuery.of(context).size.width * 0.25,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: dividerColor,
          ),
        ),
      ),
      child: TextField(
        decoration: InputDecoration(
          fillColor: searchBarColor,
          filled: true,
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Icon(
              Icons.search,
              size: 20,
              color: Colors.grey,
            ),
          ),
          hintStyle: const TextStyle(
            fontSize: 14,
          ),
          hintText: 'Search or start new chat',
          border: OutlineInputBorder(
            // For the circular sort of field
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          contentPadding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}
