//import 'package:dyplom/tresc_screen/NieCategoryRepository.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'home_page.dart';
// import 'user_pages/login_page.dart';
// import 'user_pages/logout_page.dart';
// import 'user_pages/password_change_page.dart';
// import 'user_pages/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:dyplom/theme/theme.dart';
import 'package:dyplom/glowny_screen/glowny_screen.dart';
import 'package:dyplom/ranking_screen/RatingModel.dart';
import 'package:dyplom/tresc_screen/Category.dart';
// //-----Karola-------------------
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyBNd_Vx1xdImlJ1sZg6WfTDfhYqic5A990',
      authDomain: 'dyplom-986dd.firebaseapp.com',
      projectId: 'dyplom-986dd',
      storageBucket: 'dyplom-986dd.appspot.com',
      messagingSenderId: '232096191273',
      appId: '1:232096191273:web:051de7f6986206c56b5d38',
      measurementId: 'G-HE5TEZBXRF',
    ),
  );
  runApp(MyApp());
}
// //----------------------------------------
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(
//     ChangeNotifierProvider<CategoryRepository>(
//       create: (context) => CategoryRepository(),
//       child: MyApp(),
//     ),
//   );
// }


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Studenci dla studentów',
            theme: themeNotifier.currentTheme,
            //home: HomePage(),
            home: EkranGlowny(),
          );
        },
      ),
    );
  }
}

class CategoryRepository extends ChangeNotifier {
  List<Category> categories = [
    Category(CategoryType.Uczelnie, 'Uczelnie', [
      //Uniwersytety:
      'Uniwersytet Warszawski',
      'Uniwersytet w Białymstoku',
      'Uniwersytet Gdański',
      'Uniwersytet im. Adama Mickiewicza w Poznaniu',
      'Uniwersytet Jagielloński w Krakowie',
      'Uniwersytet Łódzki',
      'Uniwersytet Marii Curie-Skłodowskiej w Lublinie',
      'Uniwersytet Mikołaja Kopernika w Toruniu',
      'Uniwersytet Opolski',
      'Uniwersytet Szczeciński',
      'Uniwersytet Śląski w Katowicach',
      'Uniwersytet Rzeszowski',
      'Uniwersytet Warmińsko-Mazurski w Olsztynie',
      'Uniwersytet Wrocławski',
      'Uniwersytet Kardynała Stefana Wyszyńskiego w Warszawie',
      'Uniwersytet Zielonogórski',
      'Uniwersytet Kazimierza Wielkiego w Bydgoszczy',
      'Uniwersytet Jana Kochanowskiego w Kielcach',
      'Akademia Piotrkowska',
      'Uniwersytet Bielsko-Bialski',
      'Uniwersytet Radomski im. Kazimierza Pułaskiego',
      'Uniwersytet Kaliski im. Prezydenta Stanisława Wojciechowskiego',
//Uczelnie techniczne:
      'Zachodniopomorski Uniwersytet Technologiczny w Szczecinie',
      'Politechnika Rzeszowska im. Ignacego Łukasiewicza',
      'Politechnika Warszawska',
      'Politechnika Białostocka',
      'Politechnika Częstochowska',
      'Politechnika Gdańska',
      'Politechnika Śląska (Gliwice)',
      'Politechnika Świętokrzyska w Kielcach',
      'Politechnika Koszalińska',
      'Politechnika Krakowska im. Tadeusza Kościuszki',
      'Akademia Górniczo-Hutnicza im. Stanisława Staszica w Krakowie',
      'Politechnika Lubelska',
      'Politechnika Łódzka',
      'Politechnika Opolska',
      'Politechnika Poznańska',
      'Politechnika Wrocławska',
//Uczelnie ekonomiczne:
      'Uniwersytet Ekonomiczny w Katowicach',
      'Uniwersytet Ekonomiczny w Krakowie',
      'Uniwersytet Ekonomiczny w Poznaniu',
      'Szkoła Główna Handlowa w Warszawie',
      'Uniwersytet Ekonomiczny we Wrocławiu',
//Uczelnie pedagogiczne:
      'Akademia Pedagogiki Specjalnej im. Marii Grzegorzewskiej (Warszawa)',
      'Uniwersytet Jana Długosza w Częstochowie',
      'Uniwersytet Komisji Edukacji Narodowej w Krakowie',
      'Uniwersytet Pomorski w Słupsku',
      'Uniwersytet w Siedlcach',
//Uczelnie rolnicze/przyrodnicze:
      'Szkoła Główna Gospodarstwa Wiejskiego w Warszawie',
      'Politechnika Bydgoska im. Jana i Jędrzeja Śniadeckich',
      'Uniwersytet Rolniczy im. Hugona Kołłątaja w Krakowie',
      'Uniwersytet Przyrodniczy w Lublinie',
      'Uniwersytet Przyrodniczy w Poznaniu',
      'Uniwersytet Przyrodniczy we Wrocławiu',
//Uczelnie wychowania fizycznego:
      'Akademia Wychowania Fizycznego i Sportu im. Jędrzeja Śniadeckiego w Gdańsku',
      'Akademia Wychowania Fizycznego im. Jerzego Kukuczki w Katowicach',
      'Akademia Wychowania Fizycznego im. Bronisława Czecha w Krakowie',
      'Akademia Wychowania Fizycznego im. Eugeniusza Piaseckiego w Poznaniu',
      'Akademia Wychowania Fizycznego Józefa Piłsudskiego w Warszawie',
      'Akademia Wychowania Fizycznego im. Polskich Olimpijczyków we Wrocławiu',
//Uczelnie teologiczne:
      'Chrześcijańska Akademia Teologiczna w Warszawie'
    ], []), // Initialize an empty ratings list
    Category(CategoryType.Wydzialy, 'Wydziały', [
      'Wydział Budownictwa i Architektury',
      'Wydział Elektrotechniki i Informatyki',
      'Wydział Inżynierii Środowiska',
      'Wydział Mechaniczny',
      'Wydział Matematyki i Informatyki Technicznej',
      'Wydział Zarządzania'
    ], []),
    Category(CategoryType.Kierunki, 'Kierunki', [
      'Budownictwo',
      'Architektura',
      'Elektrotechnika',
      'Informatyka',
      'Inżynierskie zastosowania informatyki w elektrotechnice',
      'Inżynieria multimediów',
      'Inżynieria recyklingu',
      'Inżynieria odnawialnych źródeł energii',
      'Inżynieria środowiska',
      'Energetyka',
      'Mechanika i budowa maszyn',
      'Mechatronika',
      'Zarządzanie i inżynieria produkcji',
      'Transport',
      'Inżynieria biomedyczna',
      'Robotyzacja procesów wytwórczych',
      'Inżynieria pojazdów',
      'Matematyka (studia inżynierskie)',
      'Edukacja techniczno-informatyczna',
      'Inżynieria bezpieczeństwa',
      'Inżynieria i analiza danych',
      'Zarządzanie',
      'Finanse i rachunkowość',
      'Marketing i komunikacja rynkowa',
      'Inżynieria logistyki',
      'Sztuczna inteligencja w biznesie'
    ], []),
    Category(CategoryType.Przedmioty, 'Przedmioty', [
      'Wychowanie fizyczne I',
      'Wychowanie fizyczne II',
      'Język angielski I',
      'Język angielski II',
      'Język angielski - zawodowy informatyczny ',
      'Bezpieczeństwo i higiena pracy',
      'Przysposobienie biblioteczne',
      'Ochrona własności intelektualnej',
      'Podstawy ekonomii',
      'Wprowadzenie na rynek pracy i do działalności gospodarczej',
      'Podstawy fizyki',
      'Wstęp do matematyki',
      'Matematyka dyskretna',
      'Metrologia',
      'Technika mikroprocesorowa',
      'Sieci rozproszone',
      'Matematyka dla informatyków I',
      'Matematyka dla informatyków II',
      'Wprowadzenie do informatyki',
      'Programowanie strukturalne',
      'Narzędzia informatyczne',
      'Programowanie obiektowe w C++',
      'Podstawy algorytmiki',
      'Wstęp do systemów operacyjnych',
      'Podstawy sieci komputerowych',
      'Algorytmy analizy numerycznej',
      'Podstawy elektrotechniki i elektroniki',
      'Programowanie obiektowe w Java',
      'Architektura komputerów i programowanie niskopoziomowe',
      'Wprowadzenie do systemów baz danych',
      'Podstawy grafiki komputerowej',
      'Podstawy inżynierii oprogramowania',
      'Bezpieczeństwo informacji',
      'Podstawy aplikacji internetowych',
      'Podstawy techniki cyfrowej',
      'Podstawy paradygmatów programowania',
      'Systemy wbudowane',
      'Podstawy sztucznej inteligencji w języku Python',
      'Projekt zespołowy - projektowanie',
      'Projekt zespołowy - implementacja',
      'Seminarium dyplomowe',
      'Praca dyplomowa'
    ], []),
  ];

  void updateRating(CategoryType categoryType, String itemName, double rating) {
    final categoryIndex =
        categories.indexWhere((category) => category.type == categoryType);

    if (categoryIndex != -1) {
      final itemIndex = categories[categoryIndex].items.indexOf(itemName);

      if (itemIndex != -1) {
        categories[categoryIndex]
            .ratings
            .add(RatingModel(itemName, rating, 0.0));
      }
    }
  }

  void removeCategory(CategoryType categoryType) {
    categories.removeWhere((category) => category.type == categoryType);
  }

  void removeItem(CategoryType categoryType, String itemName) {
    final categoryIndex =
        categories.indexWhere((category) => category.type == categoryType);

    if (categoryIndex != -1) {
      categories[categoryIndex].items.remove(itemName);
    }
  }

  void addNewCategory(
      CategoryType categoryType, String categoryName, List<String> items) {
    final newCategory = Category(categoryType, categoryName, items, []);
    categories.add(newCategory);
  }
}

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Studenci dla studentów"),
//       ),
//     );
//   }

//   void _showLoginDialog(BuildContext context) {
//     TextEditingController emailController = TextEditingController();
//     TextEditingController passwordController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: emailController,
//                 decoration: InputDecoration(labelText: 'Email'),
//               ),
//               TextField(
//                 controller: passwordController,
//                 decoration: InputDecoration(labelText: 'Hasło'),
//                 obscureText: true,
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
