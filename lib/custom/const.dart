import 'package:flutter/material.dart';

class Item {
  String percent;
  Image image;
  String title;
  String description;
  String price;

  Item({
    required this.percent,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
  });
}

List<Item> itemList = [
  Item(
      percent: '35%',
      image: Image.asset('assets/S0.png'),
      title: 'Sandal',
      description: 'Heeled Shoes Comfortable For Women and Girl',
      price: '100'),
  Item(
      percent: '20%',
      image: Image.asset('assets/S1.png'),
      title: 'Watch',
      description: 'New Fashion Sports Leather Strap Wristwatches',
      price: '1500'),
  Item(
      percent: '30%',
      image: Image.asset('assets/S2.png'),
      title: 'Laptop Bag',
      description: 'Laptop Sleeve Business Briefcase Compatible With Laptop',
      price: '200'),
  Item(
      percent: '30%',
      image: Image.asset('assets/S3.png'),
      title: 'Travel Bag',
      description: 'Leather Travelling Bag Travel Bag Luggage bag',
      price: 'RS: 2000'),
  Item(
      percent: '15%',
      image: Image.asset('assets/S4.png'),
      title: 'HandBag',
      description: 'new stylish handbag new design handbag girls',
      price: 'RS: 1800'),
  Item(
      percent: '10%',
      image: Image.asset('assets/S5.png'),
      title: 'High Heel',
      description: 'Leather Travelling Bag Travel Bag Luggage bag',
      price: 'RS: 4000'),
  Item(
    percent: '40%',
    image: Image.asset('assets/S6.png'),
    title: 'Watch',
    description: 'New Fashion Sports Leather Strap Wristwatches',
    price: 'RS: 1000',
  ),
  Item(
    percent: '20%',
    image: Image.asset(
      'assets/S7.jpg',
    ),
    title: 'girl dress',
    description: 'New Fashion ',
    price: 'RS: 3000',
  ),
  Item(
    percent: '25%',
    image: Image.asset(
      'assets/S8.jpeg',
    ),
    title: 'girl dress',
    description: 'New Fashion ',
    price: 'RS: 4000',
  ),
  // Add more items as needed
];
