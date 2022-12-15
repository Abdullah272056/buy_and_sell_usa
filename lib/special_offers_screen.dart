import 'package:flutter/material.dart';
import 'package:fnf_buy/special_offer_widget.dart';


class SpecialOfferScreen extends StatefulWidget {
  const SpecialOfferScreen({super.key});

  @override
  State<SpecialOfferScreen> createState() => _SpecialOfferScreenState();

  static String route() => '/special_offers';
}

class _SpecialOfferScreenState extends State<SpecialOfferScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemBuilder: (context, index) {

          return Container(
            height: 181,
            decoration: const BoxDecoration(
              color: Color(0xFFE7E7E7),
              borderRadius: BorderRadius.all(Radius.circular(32)),
            ),
            child: SpecialOfferWidget(),
          );
        },
        itemCount:3,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 24);
        },
      ),
    );
  }
}
