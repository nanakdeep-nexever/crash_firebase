// lib/bloc/product_bloc.dart
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crash_firebase/common_code.dart';
import 'package:dio/dio.dart';

import '../MODEL/PHOTO_MODEL.dart';
import 'image_uploading_event.dart';
import 'image_uploading_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final Dio _dio = Dio();
  final String _url = 'https://fakestoreapi.com/products/';
  List<Product> _allProducts = [];
  bool _hasMore = true;
  int limit = 1;
  ProductBloc() : super(ProductInitial()) {
    on<FetchProducts>(_load);
  }

  Future<bool> _isImageValid(String url) async {
    try {
      final response = await _dio.head(url);
      return response.statusCode != 404;
    } catch (_) {
      return false;
    }
  }

  FutureOr<void> _load(FetchProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());

    try {
      final response = await _dio.get(_url);
      final List<Product> products = (response.data as List)
          .map((json) => Product.fromJson(json))
          .toList();

      final List<Product> validProducts = [];
      for (var product in products) {
        if (await _isImageValid(product.image)) {
          validProducts.add(product);
        }
      }

      emit(ProductLoaded(validProducts));
      // if (_hasMore) {
      //   final response = await _dio.get('$_url?limit=$limit');
      //   final List<Product> products = (response.data as List)
      //       .map((json) => Product.fromJson(json))
      //       .toList();
      //
      //   if (products.length < limit) {
      //     _hasMore = false;
      //   }
      //   for (var product in products) {
      //     if (await _isImageValid(product.image)) {
      //       _allProducts.add(product);
      //     }
      //   }
      //
      //   emit(ProductLoaded(_allProducts));
      //   limit++;
      // }
    } catch (e) {
      getdata.reportError(
          e.toString(), StackTrace.current, getdata.userid, getdata.deviceid);
      emit(ProductError(e.toString()));
    }
  }
}
