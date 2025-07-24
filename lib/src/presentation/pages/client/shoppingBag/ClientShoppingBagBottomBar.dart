import 'package:ecommerce_flutter/src/presentation/pages/client/shoppingBag/Bloc/ClientShoppingBagState.dart';
import 'package:ecommerce_flutter/src/presentation/widgets/DefaultButton.dart';
import 'package:flutter/material.dart';

class ClientShoppingBagBottomBar extends StatelessWidget {
  ClientShoppingBagState state;
  ClientShoppingBagBottomBar(this.state);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Container(
      height: screenHeight * 0.12,
      color: Colors.grey[300],
      child: Column(
        children: [
          Container(
            width: double.infinity, 
            height: 1,
            color: Colors.grey[400],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.015,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Total: \$${state.total.toString()}', 
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.4,
                    height: screenHeight * 0.055,
                    child: DefaultButton(
                      text: 'Confirmar orden', 
                      onPressed: (){
                        Navigator.pushNamed(context, 'client/address/list');
                      }
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}