// import 'package:flutter/material.dart';
// import '../models/product_model.dart';
// import '../services/api_services.dart';
// import '../widgets/image_curousel.dart';

// class ProductDetailScreen extends StatefulWidget {
//   final int productId;

//   const ProductDetailScreen({Key? key, required this.productId})
//       : super(key: key);

//   @override
//   _ProductDetailScreenState createState() => _ProductDetailScreenState();
// }

// class _ProductDetailScreenState extends State<ProductDetailScreen> {
//   late Future<Product> _product;

//   @override
//   void initState() {
//     super.initState();
//     _product = ApiService().fetchProductDetails(widget.productId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Product Details'),
//       ),
//       body: FutureBuilder<Product>(
//         future: _product,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(Icons.error_outline, size: 64, color: Colors.red),
//                   const SizedBox(height: 10),
//                   Text(
//                     'Failed to load product details.\n${snapshot.error}',
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(color: Colors.red),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () {
//                       setState(() {
//                         _product =
//                             ApiService().fetchProductDetails(widget.productId);
//                       });
//                     },
//                     child: const Text('Retry'),
//                   ),
//                 ],
//               ),
//             );
//           } else if (!snapshot.hasData) {
//             return const Center(child: Text('No product data found.'));
//           }

//           final product = snapshot.data!;
//           return SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ImageCarousel(images: product.images),
//                 const SizedBox(height: 16),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         product.title,
//                         style: const TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         '\$${product.price}',
//                         style: const TextStyle(
//                           fontSize: 20,
//                           color: Colors.green,
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       Text(
//                         product.description,
//                         style: const TextStyle(fontSize: 16),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:sliding_sheet2/sliding_sheet2.dart';
// import '../models/product_model.dart';
// import '../services/api_services.dart';
// import '../widgets/image_curousel.dart';

// class ProductDetailScreen extends StatefulWidget {
//   final int productId;

//   const ProductDetailScreen({Key? key, required this.productId})
//       : super(key: key);

//   @override
//   _ProductDetailScreenState createState() => _ProductDetailScreenState();
// }

// class _ProductDetailScreenState extends State<ProductDetailScreen> {
//   late Future<Product> _product;

//   @override
//   void initState() {
//     super.initState();
//     _product = ApiService().fetchProductDetails(widget.productId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Product Details'),
//       ),
//       body: FutureBuilder<Product>(
//         future: _product,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(Icons.error_outline, size: 64, color: Colors.red),
//                   const SizedBox(height: 10),
//                   Text(
//                     'Failed to load product details.\n${snapshot.error}',
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(color: Colors.red),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () {
//                       setState(() {
//                         _product =
//                             ApiService().fetchProductDetails(widget.productId);
//                       });
//                     },
//                     child: const Text('Retry'),
//                   ),
//                 ],
//               ),
//             );
//           } else if (!snapshot.hasData) {
//             return const Center(child: Text('No product data found.'));
//           }

//           final product = snapshot.data!;
//           return SlidingSheet(
//             elevation: 8,
//             cornerRadius: 16,
//             snapSpec: const SnapSpec(
//               // Enable snapping. This is true by default.
//               snap: true,
//               // Set custom snapping points.
//               snappings: [0.4, 0.7, 1.0],
//               // Define to what the snappings relate to. In this case,
//               // the total available space that the sheet can expand to.
//               positioning: SnapPositioning.relativeToAvailableSpace,
//             ),
//             // The body widget will be displayed under the SlidingSheet
//             // and a parallax effect can be applied to it.
//             body: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   ImageCarousel(images: product.images),
//                 ],
//               ),
//             ),
//             builder: (context, state) {
//               // This is the content of the sheet that will get
//               // scrolled, if the content is bigger than the available
//               // height of the sheet.
//               return Container(
//                 height: 500,
//                 child: Center(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           product.title,
//                           style: const TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           '\$${product.price}',
//                           style: const TextStyle(
//                             fontSize: 20,
//                             color: Colors.green,
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         Text(
//                           product.description,
//                           style: const TextStyle(fontSize: 16),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:sliding_sheet2/sliding_sheet2.dart';
import '../models/product_model.dart';
import '../services/api_services.dart';
import '../widgets/image_curousel.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;

  const ProductDetailScreen({Key? key, required this.productId})
      : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late Future<Product> _product;

  @override
  void initState() {
    super.initState();
    _product = ApiService().fetchProductDetails(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: FutureBuilder<Product>(
        future: _product,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 10),
                  Text(
                    'Failed to load product details.\n${snapshot.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _product =
                            ApiService().fetchProductDetails(widget.productId);
                      });
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No product data found.'));
          }

          final product = snapshot.data!;
          return SlidingSheet(
            elevation: 8,
            cornerRadius: 16,
            snapSpec: const SnapSpec(
              snap: true,
              snappings: [0.4, 0.7, 1.0],
              positioning: SnapPositioning.relativeToAvailableSpace,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ImageCarousel(images: product.images),
                ],
              ),
            ),
            builder: (context, state) {
              return Container(
                height: 500,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title ?? 'No Title Available',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$${product.price?.toStringAsFixed(2) ?? 'N/A'}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Rating: ${product.rating?.toString() ?? 'No Rating'} ⭐',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        product.description ?? 'No Description Available',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
