import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountCard extends StatelessWidget {
  final String name;
  final double amount;

  final TextStyle textStyle = TextStyle(
    fontSize: 14.0,
    color: Colors.black,
  );

  AccountCard({
    this.name,
    this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0.0),
        border: Border.all(color: Colors.black, width: 1.0),
      ),
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
      child: Material(
        clipBehavior: Clip.antiAlias, // Add This
        child: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10, top: 10),
          child: Row(
            children: [
              Text(name,
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center),
              Spacer(),
              Text(amount.toString(),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),

            ],
          ),
        ),
      ],
    );
  }
}
