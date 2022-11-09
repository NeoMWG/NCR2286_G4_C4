import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Uninorte',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        brightness: Brightness.dark,
      ),
      home: const Conversor(),
    );
  }
}

class Conversor extends StatefulWidget {
  const Conversor({super.key});

  @override
  State<Conversor> createState() => _ConversorState();
}

class _ConversorState extends State<Conversor> {
  final items = const <DropdownMenuItem>[
    DropdownMenuItem(
      value: 'COP',
      child: Text('COP'),
    ),
    DropdownMenuItem(
      value: 'USD',
      child: Text('USD'),
    ),
    DropdownMenuItem(
      value: 'EUR',
      child: Text('EUR'),
    ),
  ];
  final _keyPad = <KeyPad>[
    KeyPad('1'),
    KeyPad('2'),
    KeyPad('3'),
    KeyPad('4'),
    KeyPad('5'),
    KeyPad('6'),
    KeyPad('7'),
    KeyPad('8'),
    KeyPad('9'),
    KeyPad('0'),
    KeyPad('Borrar'),
    KeyPad('Calcular'),
    // KeyPad('Reset'),
  ];
  final List<List<double>> rates = [
    [1.0, 0.00026, 0.00025],
    [3829, 1.0, .94],
    [4080, 1.07, 1.0]
  ];
  String itemOrigen = 'COP';
  String itemDestino = 'USD';
  String cantidadMoneda = '0';
  String cambioMoneda = '0';

  void calcular() {
    int indexOrigen = itemOrigen == 'COP'
        ? 0
        : itemOrigen == 'USD'
            ? 1
            : 2;
    int indexDestino = itemDestino == 'COP'
        ? 0
        : itemDestino == 'USD'
            ? 1
            : 2;
    int valueOrigen = int.parse(cantidadMoneda);
    double result = valueOrigen * rates[indexOrigen][indexDestino];
    cambioMoneda = result.toString();
    setState(() {});
  }

  void onReset() {
    cantidadMoneda = '0';
    cambioMoneda = '0';
    setState(() {});
  }

  void onPress(String value) {
    if (value == 'Reset') {
      onReset();
    } else if (value == 'Calcular') {
      calcular();
    } else if (value == 'Borrar') {
      cantidadMoneda = cantidadMoneda.substring(0, cantidadMoneda.length - 1);
      if (cantidadMoneda.isEmpty) cantidadMoneda = '0';
    } else {
      cantidadMoneda = cantidadMoneda == '0' ? value : cantidadMoneda + value;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversor de monedas'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.purple.shade500,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Encabezado
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Origen'),
                DropdownButton(
                    value: itemOrigen,
                    items: items,
                    onChanged: (value) {
                      setState(() {
                        itemOrigen = value;
                      });
                    }),
                const Text('||'),
                const Text('Destino'),
                DropdownButton(
                    value: itemDestino,
                    items: items,
                    onChanged: (value) {
                      setState(() {
                        itemDestino = value;
                      });
                    }),
              ],
            ),
            const Divider(),
            // Cantidad a cambiar
            Row(children: [
              const Text('Valor:'),
              Expanded(
                child: Text(
                  cantidadMoneda.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ]),
            // Cantidad a cambio
            Row(children: [
              const Text('Cambio:'),
              Expanded(
                child: Container(
                  color: Colors.black26,
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(left: 8),
                  child: Text(
                    cambioMoneda.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ]),
            // Teclado
            const Divider(),
            // Reset
            Container(
              margin: const EdgeInsets.all(3),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.purple,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    offset: const Offset(-1, -1),
                    blurRadius: 8,
                  ),
                  const BoxShadow(
                    color: Colors.black54,
                    offset: Offset(1, 1),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: ListTile(
                  title: const Text(
                    'Reset',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    onPress('Reset');
                  }),
            ),
            Expanded(
              flex: 1,
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: _keyPad.length,
                  padding: const EdgeInsets.all(5),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            offset: const Offset(-1, -1),
                            blurRadius: 8,
                          ),
                          const BoxShadow(
                            color: Colors.black54,
                            offset: Offset(1, 1),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: ListTile(
                          title: Text(
                            _keyPad[index].titulo,
                            style: const TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          onTap: () {
                            onPress(_keyPad[index].titulo);
                          }),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class KeyPad {
  final String titulo;
  final IconData? icon;

  KeyPad(this.titulo, {this.icon});
}
