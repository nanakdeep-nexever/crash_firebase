import 'package:crash_firebase/common_code.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bloc/image_uploading_bloc.dart';
import 'Bloc/image_uploading_event.dart';
import 'Bloc/image_uploading_state.dart';

class ImagePage extends StatelessWidget {
  Future<void> _logEvent() async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'Image_i',
    );
    FirebaseAnalytics.instance.setCurrentScreen(
        screenName: "Image_page", screenClassOverride: 'Image_page_screen');
  }

  @override
  Widget build(BuildContext context) {
    _logEvent();
    return Scaffold(
      appBar: AppBar(title: Text('Image Loader')),
      body: BlocConsumer<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return ListTile(
                  leading: Image.network(product.image,
                      width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(product.title),
                );
              },
            );
          } else if (state is ProductError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('Press button to load image'));
        },
        listener: (BuildContext context, state) {},
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getdata.getDeviceId();
          getdata.getuserid();
          context.read<ProductBloc>().add(FetchProducts());
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
