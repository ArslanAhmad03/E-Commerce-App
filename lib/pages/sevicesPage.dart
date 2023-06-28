import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class sevicesPage extends StatelessWidget {
  const sevicesPage({super.key});

  static const TextStyle _textStyle =
      TextStyle(color: Colors.black, fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: const Text('Our Services'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: const Icon(Icons.security_outlined),
              title: const Text('e-commerce'),
              subtitle:
                  const Text('we provide professinal e-commerce services'),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward),
                splashRadius: 15,
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 220),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all()),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Profile',
                            style: _textStyle,
                          ),
                          const Text(
                            'we provide professional e-commerce services',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Material(
                            child: Column(
                              children: [
                                const Row(
                                  children: [
                                    Text('Name : ',
                                        style: TextStyle(
                                          fontSize: 15,
                                        )),
                                    SizedBox(
                                      height: 30,
                                      width: 200,
                                      child: TextField(
                                        decoration:
                                            InputDecoration(labelText: 'name'),
                                        style: TextStyle(),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                const Row(
                                  children: [
                                    Text('Email : ',
                                        style: TextStyle(
                                          fontSize: 15,
                                        )),
                                    SizedBox(
                                      height: 30,
                                      width: 200,
                                      child: TextField(
                                        decoration: InputDecoration(
                                            labelText: 'abc@gmail.com'),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 100),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('OK')),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            height: 60,
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: const Icon(Icons.list_alt_outlined),
              title: const Text('List'),
              subtitle: const Text('documents'),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward),
                splashRadius: 15,
              ),
              onTap: () {
                showAnimatedDialog(
                    context: context,
                    barrierDismissible: true,
                    animationType: DialogTransitionType.slideFromLeft,
                    curve: Curves.fastOutSlowIn,
                    duration: const Duration(milliseconds: 100),
                    builder: (BuildContext context) {
                      return ClassicGeneralDialogWidget(
                        titleText: 'List',
                        contentText: 'describe',
                        onPositiveClick: () {
                          Navigator.of(context).pop();
                        },
                        onNegativeClick: () {
                          Navigator.of(context).pop();
                        },
                      );
                    });
              },
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            height: 60,
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Interior Design'),
              subtitle: const Text('transform a design'),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward),
                splashRadius: 15,
              ),
              onTap: () {
                showAnimatedDialog(
                    context: context,
                    barrierDismissible: true,
                    animationType: DialogTransitionType.slideFromLeft,
                    curve: Curves.fastOutSlowIn,
                    duration: const Duration(milliseconds: 100),
                    builder: (BuildContext context) {
                      return ClassicGeneralDialogWidget(
                        titleText: 'Interior Design',
                        contentText: 'describe',
                        onPositiveClick: () {
                          Navigator.of(context).pop();
                        },
                        onNegativeClick: () {
                          Navigator.of(context).pop();
                        },
                      );
                    });
              },
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            height: 60,
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: const Icon(Icons.trending_up_outlined),
              title: const Text('Budget Calculator'),
              subtitle:
                  const Text('Calculate and manage your budget effectively'),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const BudCal()));
              },
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            height: 60,
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: const Icon(Icons.architecture),
              title: const Text('Architecture'),
              subtitle: const Text('Experince innovative design solution'),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward),
              ),
              onTap: () {
                showAnimatedDialog(
                    context: context,
                    barrierDismissible: true,
                    animationType: DialogTransitionType.slideFromLeft,
                    curve: Curves.fastOutSlowIn,
                    duration: const Duration(milliseconds: 100),
                    builder: (BuildContext context) {
                      return ClassicGeneralDialogWidget(
                        titleText: 'Architecture',
                        contentText: 'describe',
                        onPositiveClick: () {
                          Navigator.of(context).pop();
                        },
                        onNegativeClick: () {
                          Navigator.of(context).pop();
                        },
                      );
                    });
              },
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            height: 60,
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: const Icon(Icons.verified),
              title: const Text('Varification'),
              subtitle: const Text('Varify your documents and records'),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward),
              ),
              onTap: () {
                showAnimatedDialog(
                    context: context,
                    barrierDismissible: true,
                    animationType: DialogTransitionType.slideFromLeft,
                    curve: Curves.fastOutSlowIn,
                    duration: const Duration(milliseconds: 100),
                    builder: (BuildContext context) {
                      return ClassicGeneralDialogWidget(
                        titleText: 'Varification',
                        contentText: 'describe',
                        onPositiveClick: () {
                          Navigator.of(context).pop();
                        },
                        onNegativeClick: () {
                          Navigator.of(context).pop();
                        },
                      );
                    });
              },
            ),
          ),
        ],
      ),
      //bottomNavigationBar: cartbottom(),
    );
  }
}

class BudCal extends StatefulWidget {
  const BudCal({super.key});

  @override
  State<BudCal> createState() => _BudCalState();
}

class _BudCalState extends State<BudCal> {
  final TextEditingController _1controller = TextEditingController();
  final TextEditingController _2controller = TextEditingController();
  final TextEditingController _3controller = TextEditingController();
  final TextEditingController _4controller = TextEditingController();
  String _result = "0.0";
  final _formKey = GlobalKey<FormState>();
  int value = 0;
  void clearText() {
    _1controller.clear();
    _2controller.clear();
    _3controller.clear();
    _4controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formKey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Budget Calculator'),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: TextFormField(
                controller: _1controller,
                decoration: InputDecoration(
                    hintText: 'Products',
                    suffixIcon: IconButton(
                      onPressed: _1controller.clear,
                      icon: const Icon(
                        Icons.close,
                        size: 20,
                      ),
                      splashRadius: 20,
                    )),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: TextFormField(
                controller: _2controller,
                decoration: InputDecoration(
                    hintText: 'Utilities',
                    suffixIcon: IconButton(
                      onPressed: _2controller.clear,
                      icon: const Icon(
                        Icons.close,
                        size: 20,
                      ),
                      splashRadius: 20,
                    )),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: TextFormField(
                controller: _3controller,
                decoration: InputDecoration(
                    hintText: 'Other Expenses',
                    suffixIcon: IconButton(
                      onPressed: _3controller.clear,
                      icon: const Icon(
                        Icons.close,
                        size: 20,
                      ),
                      splashRadius: 20,
                    )),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: TextFormField(
                controller: _4controller,
                decoration: InputDecoration(
                    hintText: 'Service Charges',
                    suffixIcon: IconButton(
                      onPressed: _4controller.clear,
                      icon: const Icon(
                        Icons.close,
                        size: 20,
                      ),
                      splashRadius: 20,
                    )),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    clearText();
                  });
                },
                child: const Text('all clear')),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 40,
              width: 325,
              child: ElevatedButton(
                onPressed: () {
                  setState(
                    () {
                      double sum = double.parse(_1controller.text) +
                          double.parse(_2controller.text) +
                          double.parse(_3controller.text) +
                          double.parse(_4controller.text);

                      _result = sum.toString();
                    },
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      margin: const EdgeInsets.only(
                          left: 120, right: 120, bottom: 50),
                      content: const Text(
                        'process done',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor: Colors.grey.shade100,
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(milliseconds: 300),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  elevation: 4,
                ),
                child: const Text('Calculate Budget'),
              ),
            ),
            const Divider(
              height: 60,
              indent: 20,
              endIndent: 20,
              color: Colors.purple,
            ),
            SizedBox(
              height: 100,
              width: 325,
              child: Card(
                elevation: 3,
                shadowColor: Colors.purple,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Your's total is RS: $_result"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
