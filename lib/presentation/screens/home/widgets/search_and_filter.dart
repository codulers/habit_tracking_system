import 'package:flutter/material.dart';

class SearchAndFilter extends StatelessWidget {
  final TextEditingController searchController;
  final String selectedFilter;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String?> onFilterChanged;

  const SearchAndFilter({
    required this.searchController,
    required this.selectedFilter,
    required this.onSearchChanged,
    required this.onFilterChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Field & Filter Dropdown
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search Habits...',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.search),
                  ),
                  onChanged: onSearchChanged,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade300, blurRadius: 4, spreadRadius: 2)
                  ],
                ),
                child: DropdownButton<String>(
                  value: selectedFilter,
                  onChanged: onFilterChanged,
                  underline: const SizedBox(),
                  items: const [
                    DropdownMenuItem(value: 'Name', child: Text('Habit Name')),
                    DropdownMenuItem(value: 'Start Date', child: Text('Start Date')),
                    //DropdownMenuItem(value: 'Duration', child: Text('Duration')),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
