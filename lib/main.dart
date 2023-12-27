import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '183213 - Лабораториска вежба 2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('183213 - Лабораториска вежба 2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: Clothes.clothes.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    // Кога ќе се кликне на една од елементите каде било прикажи го тој елемент на екран со помош на Display
                    onTap: ()=>{
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Display(
                          cloth: Clothes.clothes[index],
                        ),
                      ),
                      )
                    },
                    // Прикажи ја сликата на екран
                    leading: Image.network(
                      Clothes.clothes[index].image,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    // Прикажи го името и цената
                    title: Text(Clothes.clothes[index].name),
                    subtitle: Text('Цена: \ ${Clothes.clothes[index].price} ден'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            // Оди во Edit и стави го во Navigator за даможе да се клике назат
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                // Исто така испрати ги податоците за cloth кој ќе се едитира и индексот
                                builder: (context) => Edit(
                                  cloth: Clothes.clothes[index],
                                  index: index,
                                ),
                              ),
                            );
                          },
                        ),
                        // Избриши го елементот од низата и испринтај кој индекс бил!
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            Clothes.clothes.remove(Clothes.clothes[index]);
                            debugPrint('\n\n  Успешно е отстранет елементот со индекс : $index \n\n');
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // Копче за додавање на нов елемент (облека)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Add(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

// Widget за Додавање на нов елемент
class Add extends StatelessWidget {

  // Со помош на контролерите ние ги земаме податоците од формите
  final TextEditingController nameController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // во Title нека стои Create
      appBar: AppBar(
        title: Text('Create'),
      ),
      body: Center(
        child: Column(
          children: [
            // Форма за името
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                    labelText: 'Name',
                ),
              ),
            ),
            // форма за слика
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: imageController,
                decoration: const InputDecoration(
                    labelText: 'Image',
                ),
              ),
            ),
            // форма за цена
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'Price'
                ),
              ),
            ),
            // форма за опис
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                    labelText: 'Description',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextButton(
                // Кога ќе кликнеме на копчето Create
                onPressed: () {
                  // Провери дали сите полиња се потоплнети, доколку се направи нов обејкт и додади го во лисатата
                  if (nameController.text.isNotEmpty && imageController.text.isNotEmpty && priceController.text.isNotEmpty && descriptionController.text.isNotEmpty ){
                    int newPrice = int.tryParse(priceController.text) ?? 0;

                    Cloth cloth = Cloth(
                        name: nameController.text,
                        image: imageController.text,
                        price: newPrice,
                        description: descriptionController.text
                    );
                    Clothes.clothes.add(cloth);
                    debugPrint('Успешно е додадена: \n\n $cloth \n\n');

                  }
                },
                child: const Text(
                  'Create',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Edit, буквално е исто како Add, затоа нема да го опишувам.
class Edit extends StatelessWidget {
  final Cloth cloth;
  final int index;

  // Кога се праќаат информациите се праќат и cloth и индекс, во спротивно нема да се прикаже Edit widget.
  Edit({Key? key, required this.cloth, required this.index}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cloth.name),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: cloth.name
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: imageController,
                decoration: InputDecoration(
                    labelText: 'Image',
                    hintText: cloth.image
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Price',
                    hintText: '${cloth.price} ден'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: cloth.description
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),

              child: TextButton(
                onPressed: () {
                  debugPrint('\n\n Смени ги податоците за: $index \n\n');
                  // Текст
                  if (nameController.text != cloth.name && nameController.text.isNotEmpty){
                    Clothes.clothes[index].name = nameController.text;
                  }
                  // Слика
                  if (imageController.text != cloth.image && imageController.text.isNotEmpty){
                    Clothes.clothes[index].image = imageController.text;
                  }
                  // Цена
                  if (priceController.text.isNotEmpty) {
                    int newPrice = int.tryParse(priceController.text) ?? 0;
                    if (newPrice != cloth.price) {
                      Clothes.clothes[index].price = newPrice;
                    }
                  }

                  if (descriptionController.text != cloth.description && descriptionController.text.isNotEmpty){
                    Clothes.clothes[index].description = descriptionController.text;
                  }

                },
                child: const Text(
                  'EDIT',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget Dispaly, ја прикажува сликата на екран и информациите за тој елемент.
class Display extends StatelessWidget {
  final Cloth cloth;

  const Display({Key? key, required this.cloth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cloth.name),
      ),
      body: Center(
        child: Column(
          children: [
            // Прикажи ја сликата со 500 висина и дебелина
            Image.network(cloth.image, height: 550, width: 500),
            Text(
              cloth.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
            Text(
              '${cloth.price} ден\n',
              style: const TextStyle(
                  fontSize: 18,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
              cloth.description,
              style: const TextStyle(
                  fontSize: 15,
                ),
            ),
            ),
          ],
        ),
      ),


    );
  }
}

// Во Cloth ги чуваме податоците за секој елемент на облеката, имаме име, цена, слика и опис.
class Cloth {
  String image;
  int price;
  String name;
  String description;

  Cloth({
    required this.image,
    required this.price,
    required this.name,
    required this.description,
  });
}

// Тука ги чуваме податоците за облеката.
class Clothes{
  static List<Cloth> clothes = [
    Cloth(
        image: 'https://static.zara.net/photos///2023/I/0/2/p/5320/321/505/2/w/563/5320321505_6_1_1.jpg?ts=1693902519549',
        price: 3990,
        name: 'OVERSIZED TECHNICAL TRENCH COAT',
        description: 'Oversize trench coat made of a lightweight technical fabric with ripstop texture, resistant to tearing. Lapel collar and long sleeves with adjustable cuffs'
    ),
    Cloth(
        image: 'https://static.zara.net/photos///2023/I/0/2/p/1437/401/737/2/w/563/1437401737_6_1_1.jpg?ts=1695295557590',
        price: 3290,
        name: 'RUBBERISED PARKA WITH HOOD',
        description: 'Parka made of rubberised finish fabric. High neck with an adjustable hood. Long sleeves with elasticated cuffs. Welt pockets at the hip and an inside pocket. Zip-up front hidden by a snap-button placket.'
    ),
    Cloth(
        image: 'https://static.zara.net/photos///2023/I/0/2/p/2878/310/251/2/w/563/2878310251_6_1_1.jpg?ts=1701248271751',
        price: 3290,
        name: 'CONTRAST FAUX SHEARLING JACKET',
        description: 'Jacket with a high collar and long sleeves. Contrast patch pockets with zip fastening on the chest. Elasticated trims. Zip-up front.'
    ),
    Cloth(
        image: 'https://static.zara.net/photos///2023/I/0/2/p/8281/335/401/2/w/563/8281335401_6_1_1.jpg?ts=1694703475919',
        price: 4990,
        name: 'RUBBERISED PARKA WITH HOOD',
        description: 'Long parka made of fabric with a rubberised finish. Long sleeves and hood. Hip welt pockets. Back vent at the centre of the hem. Button-up front.'
    ),
    Cloth(
        image: 'https://static.zara.net/photos///2023/I/0/2/p/8062/320/251/2/w/563/8062320251_6_1_1.jpg?ts=1696415126662',
        price: 1990,
        name: 'STRAIGHT FIT JEANS',
        description: 'Straight fit jeans with five pockets. Faded effect. Front button fastening.'
    )];
}