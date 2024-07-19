import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../data/store/brandnew.dart';
import '../../../main/home/viewmodel/brandnew_page_viewmodel.dart';

class BrandNewPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMonth = ref.watch(selectedMonthProvider);
    final asyncBrandNewData = ref.watch(brandNewDataProvider);
    final groupedBooks = ref.watch(groupedBooksProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Brandnew'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_left),
                  onPressed: () {
                    ref.read(selectedMonthProvider.notifier).state =
                        DateTime(selectedMonth.year, selectedMonth.month - 1);
                  },
                ),
                Text(
                  DateFormat('yyyy년 MM월').format(selectedMonth),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_right),
                  onPressed: () {
                    ref.read(selectedMonthProvider.notifier).state =
                        DateTime(selectedMonth.year, selectedMonth.month + 1);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: asyncBrandNewData.when(
              data: (data) {
                if (groupedBooks.isEmpty) {
                  return Center(child: Text('No books found for the selected month.'));
                }

                return ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: groupedBooks.entries.map((entry) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.key,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: 250,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: entry.value.length,
                            itemBuilder: (context, index) {
                              final book = entry.value[index];
                              return Container(
                                width: 150,
                                margin: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Image.asset(
                                        book.path,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      book.title,
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      book.author,
                                      style: TextStyle(fontSize: 14, color: Colors.grey),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    );
                  }).toList(),
                );
              },
              loading: () => Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Failed to load books: $error')),
            ),
          ),
        ],
      ),
    );
  }
}
