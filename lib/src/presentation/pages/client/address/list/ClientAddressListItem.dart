import 'package:ecommerce_flutter/src/domain/models/Address.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/address/list/bloc/ClientAddressListBloc.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/address/list/bloc/ClientAddressListEvent.dart';
import 'package:ecommerce_flutter/src/presentation/pages/client/address/list/bloc/ClientAddressListState.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ClientAddressListItem extends StatelessWidget {
  ClientAddressListBloc? bloc;
  ClientAddressListState state; 
  Address address;
  int index;

  ClientAddressListItem(this.bloc, this.state, this.address, this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Radio(
            value: index,
            groupValue: state.radioValue,
            onChanged: (value) {
              bloc?.add(ChangeRadioValue(
                radioValue: value!,
                address: address,
                )
              );
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
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            address.neighborhood,
            style: const TextStyle(fontSize: 14),
          ),
        ),
        Divider(
          color: Colors.grey,
          height: 1,
          indent: 30,
          endIndent: 30,
        ),
      ],
    );
  }
}