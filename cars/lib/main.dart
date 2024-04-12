import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cars/carmodel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share/share.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Momin's Cars",
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double imageWidthPercentage = 1;

   return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20.0),
              const Text(
                "Momin's Cars",
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontStyle: FontStyle.italic, // Set to FontStyle.italic for italic style
                 fontFamily: 'Sans-serif', // Replace 'YourFontFamily' with the desired font family
                ),
              ),
              const Text(
                'Selling Cars on the low!',
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                   fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 20.0),
               GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity! > 0) {
                    // Swiped from left to right
                    _showSwipeAlert(context, 'S');
                  } else if (details.primaryVelocity! < 0) {
                    // Swiped from right to left
                    _showSwipeAlert(context, 'Swiped Left');
                  }
                },
                
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0.0),
                child: Image.asset(
                  'assets/car1.jpg',
                  width: screenWidth * imageWidthPercentage,
                  fit: BoxFit.cover,
                ),
              ),
               ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth * 0.4,
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black, // White border at the bottom
                                width: 2.0,
                              ),
                            ),
                          ),
                    child: const Text(
                      'SALES',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center, // Center-align the text
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.4,
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black, // White border at the bottom
                                width: 2.0,
                              ),
                            ),
                          ),
                    child: const Text(
                      'SERVICE',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center, // Center-align the text
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    
    
    
     bottomNavigationBar: Container(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0), // Add top and bottom margins
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 0, 0, 0), 
        // Dark grey background for the row
        boxShadow: [
            BoxShadow(
              color: Colors.white,
              blurRadius: 0.0, // Adjust the blur radius as needed
              spreadRadius: 0.7, // Adjust the spread radius as needed
              offset: Offset(0, -2), // Offset for shadow, negative y to place it at the top
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
           ElevatedButton(
              onPressed: () {
                // Handle contact button tap
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 38, 38, 38), // White text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                   // Rounded corners
                ),
              ),
              
              child: const Text('Home'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle Cars button tap
               Navigator.push(
  context,
  PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const CarsPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      var offsetAnimation = animation.drive(tween);

      return SlideTransition(position: offsetAnimation, child: child);
    },
),

                  );

              },
              
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 38, 38, 38),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              child: const Text('Cars'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CameraScreen()),
                  );
                // Handle contact button tap
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 38, 38, 38),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              child: const Text('Contact'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle admin button tap
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 38, 38, 38),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              child: const Text('Admin'),
              
            ),
          ],
        ),
      ),
    );
  }
   void _showSwipeAlert(BuildContext context, String alertText) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(alertText),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

}

// **********************  The second page 
class CarsPage extends StatefulWidget {
  const CarsPage({super.key});

  @override

  // ignore: library_private_types_in_public_api
  _CarsPageState createState() => _CarsPageState();
}

class _CarsPageState extends State<CarsPage> {
  List<Car> cars = [];
  
  

  @override
  void initState() {
    super.initState();
    loadCars();
  }

Future<void> loadCars() async {
  try {
    final String data = await rootBundle.loadString('assets/cars.json');
    final List<dynamic> jsonList = json.decode(data);
    final List<Car> loadedCars = jsonList.map((json) => Car.fromJson(json)).toList();

    setState(() {
      cars = loadedCars;
    });
  } catch (error) {
    // Handle errors, e.g., show an error message or fallback to default data
  }
}

// ignore: unused_element
void _shareCarData(Car car) {
    Share.share(
      'Check out this car:\n\n'
      'Brand: ${car.brand}\n'
      'Model: ${car.model}\n'
      'Price: €${car.price}\n'
      'Mileage: ${car.milage} miles\n'
      'Description: ${car.description}\n',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liams Cars Stock'),
        backgroundColor: const Color.fromARGB(255, 96, 94, 94),
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];
          return Dismissible(
            key: UniqueKey(),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            onDismissed: (direction) {
              // Handle dismiss (e.g., remove item from list)
              setState(() {
                cars.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Car dismissed')),
              );
            },
            secondaryBackground: Container(
              color: Colors.green,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20),
              child: const Icon(
                Icons.share,
                color: Colors.white,
              ),
            ),
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.endToStart) {
                // Show confirmation dialog for deletion
                return await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Delete Confirmation'),
                      content: const Text('Are you sure you want to delete this car?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('Delete'),
                        ),
                      ],
                    );
                  },
                );
              } else if (direction == DismissDirection.startToEnd) {
                // Share car data
                _shareCarData(car);
                return false; // Prevent dismiss after sharing
              }
              return false;
            },
            child: Card(
              elevation: 5,
              margin: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    'assets/${car.image}',
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(
                        '${car.brand} ${car.model}',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Price: €${car.price}'),
                          Text('Mileage: ${car.milage} miles'),
                          Text(
                            'Description: ${car.description}',
                            textAlign: TextAlign.justify,
                          ),
                                                    const Text(
                            'Swipe Right To Share Or Left To Delete',
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(height: 8),
         ElevatedButton(
                          onPressed: () async {
                            await addToFavorites(car);
                          },
                            child: const Text('Add to Favorites'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
 Future<void> addToFavorites(Car car) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteCarIds = prefs.getStringList('favoriteCars') ?? [];
    if (!favoriteCarIds.contains(car.id)) {
      favoriteCarIds.add(car.id);
      await prefs.setStringList('favoriteCars', favoriteCarIds);
    }
  }
}
class CameraScreen extends StatelessWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _initializeControllerFuture;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Page'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var _controller;
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),

      body: Center(
        child: Text(
          'Camera Page',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            
          ),
        ),
      ),
    );
  }
}
