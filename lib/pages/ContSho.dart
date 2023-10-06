import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop/pages/PayDone.dart';

class ContShop extends StatefulWidget {
  //final title, description, price;
  const ContShop({super.key,});
  //required this.title, required this.description,required this.price
  @override
  State<ContShop> createState() => _ContShopState();
}

class _ContShopState extends State<ContShop> {

  bool _city = false;
  bool _address = false;
  bool _street = false;
  bool _postal = false;

  final cityadd = TextEditingController();
  final adresadd = TextEditingController();
  final streadd = TextEditingController();
  final postadd = TextEditingController();

  Future <void> _uploadAddressInfo () async{
    if(cityadd.text.isEmpty){
      setState(() {
        _city = true;
      });
    }else if (adresadd.text.isEmpty){
      setState(() {
        _address = true;
      });
    }else if(streadd.text.isEmpty){
      setState(() {
        _street = true;
      });
    }else if(postadd.text.isEmpty){
      setState(() {
        _postal = true;
      });
    }else{
      try{
        await FirebaseFirestore.instance.collection('Address_Info').add(
            {
              'City': cityadd.text,
              'Address': adresadd.text,
              'Street Address': streadd.text,
              'Postal Code': postadd.text,
            }
        );
      }catch (e){
        print(e.toString());
      }
      Navigator.push(context, MaterialPageRoute(builder: (context) => PayDone()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          centerTitle: true,
          title: const Text('Address Info'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text('City'),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 70,
                  child: TextField(
                    controller: cityadd,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'City',
                      errorText: _city ? 'enter city' : null,
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Address'),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 70,
                  child: TextField(
                    controller: adresadd,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Address',
                      errorText: _address ? 'enter address' : null,
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Street Address'),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 70,
                  child: TextField(
                    controller: streadd,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Street Address',
                      errorText: _street ? 'enter street address' : null,
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Postal Code'),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 70,
                  child: TextField(
                    controller: postadd,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Postal Code',
                      errorText: _postal ? 'enter postal address' : null,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Container(
                  height: 60,
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 150),
                  decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                    onPressed: () {
                      _uploadAddressInfo();
                    },
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}