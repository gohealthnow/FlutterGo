import 'package:flutter/material.dart';
import 'package:gohealth/api/models/pharmacy_model.dart';
import 'package:gohealth/api/models/product_models.dart';
import 'package:gohealth/api/repositories/pharmacy_repository.dart';
import 'package:gohealth/api/repositories/product_repository.dart';

class GeneratedReportPage extends StatefulWidget {
  GeneratedReportPage({super.key, required this.pharmacy});

  final PharmacyModels pharmacy;

  @override
  _GeneratedReportPageState createState() => _GeneratedReportPageState();
}

class _GeneratedReportPageState extends State<GeneratedReportPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatório da Farmácia'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (widget.pharmacy.image != null)
                          CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                NetworkImage(widget.pharmacy.image!),
                          ),
                        const SizedBox(width: 12),
                        Flexible(
                          child: Text(
                            widget.pharmacy.name!,
                            style: Theme.of(context).textTheme.headlineSmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Divider(),
                    const SizedBox(height: 8),
                    Text(
                      'Informações de Contato',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text('Email: ${widget.pharmacy.email}'),
                    Text('Telefone: ${widget.pharmacy.phone}'),
                    const SizedBox(height: 16),
                    Text(
                      'Endereço',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(widget.pharmacy.geolocation!.address!),
                    Text('CEP: ${widget.pharmacy.geolocation!.cep!}'),
                    if (widget.pharmacy.geolocation!.additional!.isNotEmpty)
                      Text(
                          'Complemento: ${widget.pharmacy.geolocation!.additional!}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // capturar o relatório de vendas e estoque
            (widget.pharmacy.pharmacyProducts != null &&
                    widget.pharmacy.pharmacyProducts!.length > 0)
                ? Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Relatório de Vendas',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 8),
                          FutureBuilder<List<Order>>(
                            future: PharmacyRepository()
                                .getOrdersAllByIdPharmacy(
                                    id: widget.pharmacy.id!),
                            builder:
                                (context, AsyncSnapshot<List<Order>> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }
                              final orders = snapshot.data;
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: orders!.length,
                                itemBuilder: (context, index) {
                                  final order = orders[index];
                                  return ListTile(
                                    title: Text(
                                        'Pedido: ${order.id.split('-')[0]}'),
                                    subtitle:
                                        Text('Quantidade: ${order.quantity}'),
                                    trailing: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                            'Data: ${order.createdAt.toString().split(' ')[0].split('-').reversed.join('/')}'),
                                        Text(
                                            'Hora: ${order.createdAt.toString().split(' ')[1].substring(0, 5)}'),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Relatório de Estoque',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 16),
                          FutureBuilder<List<ProductModels>>(
                            future: ProductRepository().getAll(),
                            builder: (context,
                                AsyncSnapshot<List<ProductModels>> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }
                              final products = snapshot.data;
                              final productsInStock = widget
                                  .pharmacy.pharmacyProducts!
                                  .map((e) => e.productId)
                                  .toList();
                              final productsInStockList = products!
                                  .where((element) =>
                                      productsInStock.contains(element.id))
                                  .toList();
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: productsInStockList.length,
                                itemBuilder: (context, index) {
                                  final product = productsInStockList[index];
                                  return ListTile(
                                    title: Text(product.name!),
                                    subtitle: Text(
                                        'Quantidade: ${widget.pharmacy.pharmacyProducts!.firstWhere((element) => element.productId == product.id).quantity}'),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
