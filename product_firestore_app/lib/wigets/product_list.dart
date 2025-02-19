import 'package:flutter/material.dart';
import 'package:product_firestore_app/service/database.dart';
import 'package:product_firestore_app/wigets/product_item.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {

    Database db = Database.myInstance;
    var myStream = db.getAllProductStream();    
    
    
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: StreamBuilder(
        stream: myStream, 
        builder: (context, snapshot){
          if(snapshot.data!.isEmpty){
            return const Center(child: Text('No Product Data '),);
          }else if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index){
                return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  if(direction == DismissDirection.endToStart){
                    db.deleteProduct(product: snapshot.data![index]);
                  }
                },
                direction: DismissDirection.endToStart,
                background:  Container(color: Colors.red,alignment: Alignment.centerRight,
                padding:  const EdgeInsets.only(right: 20),
                child: const Icon(Icons.delete,color: Colors.white,),
                ),
                child: ProductItem(product: snapshot.data![index],)
              );
            });
          }
          return const Center(child:  CircularProgressIndicator(),);
        }),
      
    );
  }
}