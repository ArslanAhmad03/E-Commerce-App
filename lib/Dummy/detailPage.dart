import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageDetailPage extends StatefulWidget {
  final product;
  const ImageDetailPage({super.key,required this.product});

  @override
  State<ImageDetailPage> createState() => _ImageDetailPageState();
}

class _ImageDetailPageState extends State<ImageDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
            title: Text('Detail Page')),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 3,
              ),
              Container(
                height: 140,
                width: double.infinity,
                child: CarouselSlider(
                  items: [
                    Image.asset('assets/sliderImages/sale.jpg'),
                    Image.asset('assets/sliderImages/shoe.jpg'),
                  ],
                  options: CarouselOptions(
                    viewportFraction: 0.9,
                    autoPlay: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                  ),
                ),
              ),
              Row(
                children: [
                  const Padding(padding: EdgeInsets.only(left: 10)),
                  Text(
                   ' widget.product[]', ////product name
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
    );
  }
}