import 'package:flutter/material.dart';
import 'package:test_map/models/building.dart';
import 'package:test_map/models/class.dart';
import 'package:test_map/resources/colors.dart';
import 'package:test_map/resources/specifications.dart';

class FindClassField extends StatefulWidget {
  final void Function(ClassElement targetClass)? onFound;
  const FindClassField({super.key, required this.onFound});

  @override
  State<FindClassField> createState() => _FindClassFieldState();
}

class _FindClassFieldState extends State<FindClassField> {
  TextEditingController controller = TextEditingController();
  List<ClassElement> originalList = [];
  List<ClassElement> filteredList = [];
  bool _showSuggestions = false;

  List<ClassElement> getAllClasses() {
    return Buildings.values
        .expand((building) => building.getBuilding().floors)
        .expand((floor) => floor.classes)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    originalList = getAllClasses();
    return Column(
      children: [
        TextField(
          controller: controller,
          onChanged: (value) {
            setState(() {
              _showSuggestions = true;
            });
            _filterList(value);
          },
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            prefixIcon: const Icon(Icons.search_outlined),
            prefixIconColor: PageColors.aguWhite,
            hintText: 'Enter text...',
            fillColor: PageColors.aguColor,
            hintStyle: TextStyle(color: PageColors.aguWhite, fontWeight: FontWeight.bold),
            filled: true,
            suffixIcon: _showSuggestions
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _showSuggestions = false;
                      });
                    },
                    icon: const Center(
                      child: Icon(
                        Icons.close,
                        size: 50,
                      ),
                    ),
                  )
                : const Icon(
                    Icons.arrow_right,
                    size: 50,
                  ),
            suffixIconColor: PageColors.aguWhite,
          ),
        ),
        _showSuggestions
            ? SizedBox(
                height: filteredList.length > 4
                    ? MediaQuery.of(context).size.height * .25
                    : filteredList.length * 50,
                child: ListView.builder(
                  itemCount: filteredList.length,
                  addRepaintBoundaries: false,
                  itemBuilder: (context, index) {
                    return _searchItem(index);
                  },
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  void _filterList(String searchText) {
    setState(() {
      filteredList = originalList
          .where((item) => item.name.toLowerCase().startsWith(searchText.toLowerCase()))
          .toList();
    });
  }

  Widget _searchItem(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 70),
      child: InkWell(
        onTap: () {
          ClassElement targetClass = filteredList[index];
          widget.onFound?.call(targetClass);
          _showSuggestions = false;
        },
        child: SizedBox(
          height: 50,
          child: Card(
              shape: RoundedRectangleBorder(borderRadius: Specifications.borderRadius),
              color: PageColors.aguColor,
              child: Row(
                children: [
                  Padding(
                    padding: Specifications.padding_only_left,
                    child: Icon(Icons.home),
                  ),
                  Padding(
                    padding: Specifications.padding_only_left,
                    child: Text(filteredList[index].name),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
