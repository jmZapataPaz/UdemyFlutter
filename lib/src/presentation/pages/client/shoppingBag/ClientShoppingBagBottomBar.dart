import 'package:ecommerce_flutter/src/presentation/pages/client/shoppingBag/Bloc/ClientShoppingBagState.dart';
import 'package:ecommerce_flutter/src/presentation/widgets/DefaultButton.dart';
import 'package:flutter/material.dart';

class ClientShoppingBagBottomBar extends StatelessWidget {
  ClientShoppingBagState state;
  ClientShoppingBagBottomBar(this.state);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.10,
      color: Colors.grey[300],
      child: Column(
        children: [
          Divider(color: Colors.grey[400], height: 0,),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Total: \$${state.total.toStringAsFixed(2)}', 
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                
                child: DefaultButton(
                  text: 'Confirmar orden', 
                  onPressed: (){}
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}