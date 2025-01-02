// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:task_1/provider/product_provider.dart';

// import 'screens/product_list_screen.dart';

// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => ProductProvider(),
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: ProductListScreen(),
//       ),
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_1/provider/product_provider.dart';

import 'screens/product_list_screen.dart';
import 'screens/product_detail_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ProductProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        theme: ThemeData(useMaterial3: true),
        routes: {
          '/': (context) => ProductListScreen(),
          '/details': (context) => ProductDetailScreen(
                productId: ModalRoute.of(context)!.settings.arguments as int,
              ),
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(title: const Text('404')),
              body: const Center(child: Text('Page Not Found')),
            ),
          );
        },
      ),
    ),
  );
}
