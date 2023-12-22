import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test_map/data/location_data.dart';
import 'package:test_map/models/location.dart';
import 'package:test_map/pages/map_view.dart';
import 'package:test_map/resources/colors.dart';
import 'package:test_map/services/LocationProvider.dart';

class MapTab extends StatefulWidget {
  const MapTab({super.key});

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> with RouteAware {
  LocationProvider? locationProvider;

  @override
  Widget build(BuildContext context) {
    locationProvider = Provider.of<LocationProvider>(context);
    return Stack(
      children: [
        const MapView(),
        FindClassField(
          onFound: (location) {
            locationProvider?.setNewTarget(location);
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class FindClassField extends StatefulWidget {
  final void Function(LatLng location)? onFound;
  const FindClassField({super.key, required this.onFound});

  @override
  State<FindClassField> createState() => _FindClassFieldState();
}

class _FindClassFieldState extends State<FindClassField> {
  TextEditingController controller = TextEditingController();
  List<LocationModel> originalList = DummyData.locations;
  List<LocationModel> filteredList = [];
  bool _showSuggestions = false;

  @override
  Widget build(BuildContext context) {
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
          .where(
              (item) => item.roomName.toLowerCase().startsWith(searchText.toLowerCase()))
          .toList();
    });
  }

  Widget _searchItem(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 70),
      child: InkWell(
        onTap: () {
          LatLng latLng = filteredList[index].building.getLocation();
          widget.onFound?.call(latLng);
          _showSuggestions = false;
        },
        child: SizedBox(
          height: 50,
          child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              color: PageColors.aguColor,
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Icon(Icons.home),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(filteredList[index].roomName),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

class AutocompleteBasicExample extends StatelessWidget {
  const AutocompleteBasicExample({super.key});

  static const List<String> _kOptions = <String>[
    'aardvark',
    'bobcat',
    'chameleon',
  ];

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsViewBuilder: (context, onSelected, options) {
        return ListView.builder(
          itemCount: options.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.white, border: Border.all(color: Colors.black)),
              child: Text(
                options.toList()[index],
                style: const TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    decoration: TextDecoration.none),
              ),
            );
          },
        );
      },
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return _kOptions.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        debugPrint('You just selected $selection');
      },
    );
  }
}
