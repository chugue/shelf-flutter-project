import 'package:cosmos_epub/Model/book_progress_model.dart';
import 'package:cosmos_epub/cosmos_epub.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/_core/constants/move.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initializer and methods return a bool
  var _initialized = await CosmosEpub.initialize();

  if (_initialized) {
    // Use BookProgressModel model instance anywhere in your app to access current book progress of specific book
    BookProgressModel bookProgress = CosmosEpub.getBookProgress('bookId');
    await CosmosEpub.setCurrentPageIndex('bookId', 1);
    await CosmosEpub.setCurrentChapterIndex('bookId', 2);
    await CosmosEpub.deleteBookProgress('bookId');
    await CosmosEpub.deleteAllBooksProgress();
  }

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: Move.startViewPage,
      routes: getRouters(),
    );
  }
}
