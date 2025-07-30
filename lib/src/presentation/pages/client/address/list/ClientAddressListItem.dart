import 'package:ecommerce_flutter/src/domain/models/Address.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/address/list/bloc/ClientAddressListBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/address/list/bloc/ClientAddressListEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/address/list/bloc/ClientAddressListState.dart';
import 'package:flutter/material.dart';

class ClientAddressListItem extends StatelessWidget {
  final ClientAddressListBloc? bloc;
  final ClientAddressListState state; 
  final Address address;
  final int index;

  ClientAddressListItem(this.bloc, this.state, this.address, this.index);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 600;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isSmall ? 0 : 40, vertical: isSmall ? 0 : 10),
      child: Card(
        elevation: isSmall ? 0 : 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(isSmall ? 0 : 16)),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: isSmall ? 16 : 32, vertical: isSmall ? 0 : 12),
          leading: Radio(
            value: index,
            groupValue: state.radioValue,
            onChanged: (value) {
              bloc?.add(ChangeRadioValue(
                radioValue: value!,
                address: address,
              ));
            },
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () {
              bloc?.add(DeleteAddress(id: address.id!));
            },
          ),
          title: Text(
            address.address,
            style: TextStyle(
              fontSize: isSmall ? 16 : 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                address.neighborhood,
                style: TextStyle(fontSize: isSmall ? 14 : 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}