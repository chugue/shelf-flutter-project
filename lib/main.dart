import 'package:cosmos_epub/Model/book_progress_model.dart';
import 'package:cosmos_epub/cosmos_epub.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // 환경변수 관련
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shelf/_core/constants/move.dart';
import 'package:webview_flutter/webview_flutter.dart'; // WebView 패키지 추가
import 'package:webview_flutter_android/webview_flutter_android.dart'; // Android용 WebView 패키지 추가

import 'data/store/darkmode.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://5a29f7363cce22760b0250ee9e02300e@o4507654994853888.ingest.us.sentry.io/4507655007830016';
      options.tracesSampleRate = 0.01;
      options.profilesSampleRate = 0.01;
    },
    appRunner: () => runApp(MyApp()),
  );

  WidgetsFlutterBinding.ensureInitialized();

  try {
    // .env 파일 로드
    await dotenv.load(fileName: ".env");
    print(".env 파일 로드 성공");
  } catch (e) {
    print(".env 파일 로드 실패: $e");
  }

  // WebView 플랫폼 초기화
  if (WebViewPlatform.instance == null) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      WebViewPlatform.instance = AndroidWebViewPlatform();
    }
  }

  var _initialized = await CosmosEpub.initialize();

  if (_initialized) {
    BookProgressModel bookProgress = CosmosEpub.getBookProgress('bookId');
    await CosmosEpub.setCurrentPageIndex('bookId', 1);
    await CosmosEpub.setCurrentChapterIndex('bookId', 2);
    await CosmosEpub.deleteBookProgress('bookId');
    await CosmosEpub.deleteAllBooksProgress();
  }

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);

    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: Move.startViewPage,
      routes: getRouters(),
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
