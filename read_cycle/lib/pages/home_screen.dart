import 'package:flutter/material.dart';
import 'package:read_cycle/classes/book.dart';
import 'package:read_cycle/classes/post.dart';
import 'package:read_cycle/classes/user.dart';
import 'package:read_cycle/components/books_tile.dart';
import 'package:read_cycle/components/post_tile.dart';
import 'package:read_cycle/pages/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _MainState();
}

class _MainState extends State<HomeScreen> {
  bool searchBarVisible = false;

  void toggleSearchBarVisibility() {
    searchBarVisible = !searchBarVisible;
    if (searchBarVisible) {
      print("show!");
    }
  }

  final List<User> users = [
    User(
      name: 'Emma',
      email: 'emma@email.com',
      profileImagePath: 'assets/images/persona2.jpg',
      rating: '4.5',
    ),
    User(
      name: 'Gonçalo Silva',
      email: 'gonca@email.com',
      profileImagePath: '',
      rating: '4.9'
    ),
  ];

  final List<Book> books = [
    Book(
      title: 'Ficciones',
      author: 'Jorge Luis Borges',
      pages: 203,
      genres: ['Fiction', 'Fantasy'],
      coverImagePath: 'assets/books/Ficciones.jpg',
      description:
          'The seventeen pieces in Ficciones demonstrate the whirlwind of Borges\'s...',
    ),
    Book(
      title: 'Os Jogos da Fome',
      author: 'Suzanne Collins',
      pages: 260,
      genres: ['Ficção', 'Fantasia', 'Romance'],
      coverImagePath: 'assets/books/fiction/jogos_fome.jpg',
      description: 'Num futuro pós-apocalíptico, surge das cinzas do que foi a América do Norte, Panem, uma nova nação governada por um regime totalitário que a partir da megalópole, Capitol, governa os doze Distritos com mão de ferro. Uma anterior revolta fracassada dos Distritos contra Capitol resultou num acordo de rendição em que todos os Distritos se comprometeram a enviar anualmente dois adolescentes para participar nos Jogos de Fome - um espetáculo sangrento de combates mortais. No final, apenas um destes jovens escapará com vida… Katniss Everdeen é uma adolescente que se oferece para substituir a irmã mais nova nos Jogos, o que a obrigará a escolher entre a sobrevivência e a solidariedade.'
    ),
    Book(
      title: 'Contos Inacabados',
      author: 'J.R.R Tolkien',
      pages: 592,
      genres: ['Ficção', 'Fantasia', 'Clássico'],
      coverImagePath: 'assets/books/fiction/contos.jpg',
      description: 'Contos Inacabados é uma coleção de narrativas que vão desde os Dias Antigos da Terra-média, através da Segunda Era e da ascensão de Sauron, até ao fim da Guerra do Anel-que relatam os acontecimentos contados em O Silmarillion e O Senhor dos Anéis. O livro inclui o relato animado de Gandalf sobre como e quando enviou os Anões para a célebre festa de Fundo-do-Saco, o aparecimento do deus do mar Ulmo diante dos olhos de Tuor na costa de Beleriand, uma descrição exata da organização militar dos cavaleiros de Rohan, e a viagem dos cavaleiros Negros durante a caça ao Anel'
    ),
    Book(
      title: 'Renegados',
      author: 'Marissa Meyer',
      pages: 584,
      genres: ['Ficção', 'Romance', 'Jovem Adulto', 'Distopia'],
      coverImagePath: 'assets/books/fiction/renegados.jpg',
      description: 'Há mais de dez anos, os Renegados — um grupo de humanos com poderes extraordinários — emergiram das ruínas de uma sociedade destroçada e caótica e estabeleceram a paz e a ordem. Desde então, tornaram-se um símbolo de esperança e de coragem para todos... exceto para os vilões que foram derrotados.'
    ),
    Book(
      title: 'A Lâmina da Assassina',
      author: 'Sarah J. Maas',
      pages: 406,
      genres: ['Ficção', 'Romance', 'Jovem Adulto'],
      coverImagePath: 'assets/books/fiction/lamina.jpg',
      description: 'O início da jornada da assassina… com sangue, suor e lágrimas. Celaena Sardothien é a assassina mais temida de Adarlan. Embora trabalhe para a poderosa Guilda de Assassinos e para o seu ardiloso mestre, Arobynn Hamel, Celaena não se deixa vergar e confia apenas no seu colega assassino contratado, Sam. E quando Arobynn a envia em missões que a levam de ilhas remotas a desertos hostis, Celaena dá por si a contrariar as ordens do seu mestre e a questionar a sua própria lealdade.'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final List<Post> posts = [
      Post(
        user: users[0],
        book: books[0],
        location: 'Aveiro',
        date: DateTime.now(),
        imagePaths: [],
      ),
      Post(
        user: users[0],
        book: books[0],
        location: 'Aveiro',
        date: DateTime.now(),
        imagePaths: [],
      ),
      Post(
        user: users[0],
        book: books[0],
        location: 'Aveiro',
        date: DateTime.now(),
        imagePaths: [],
      ),
      Post(
        user: users[1],
        book: books[1],
        location: 'Aveiro',
        date: DateTime.now(),
        imagePaths: [],
      ),
      Post(
        user: users[1],
        book: books[2],
        location: 'Aveiro',
        date: DateTime.now(),
        imagePaths: [],
      ),
      Post(
        user: users[1],
        book: books[3],
        location: 'Aveiro',
        date: DateTime.now(),
        imagePaths: [],
      ),
      Post(
        user: users[1],
        book: books[4],
        location: 'Aveiro',
        date: DateTime.now(),
        imagePaths: [],
      ),
    ];

    final List<PostTile> postTiles = [
      PostTile(post: posts[0]),
      PostTile(post: posts[1]),
      PostTile(post: posts[2]),
      PostTile(post: posts[3]),
      PostTile(post: posts[4]),
      PostTile(post: posts[5]),
      PostTile(post: posts[6]),
    ];
    

    final List<BooksTile> bookTiles = [
      BooksTile(title: 'Sugestões', postTiles: postTiles),
      BooksTile(title: 'Ficção', postTiles: postTiles.sublist(3)),
      BooksTile(title: 'Biografias', postTiles: postTiles),
      BooksTile(title: 'Comédia', postTiles: postTiles),
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          elevation: 0,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'ReadCycle',
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                  Visibility(
                    visible: searchBarVisible,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Color.fromARGB(255, 0, 255, 255),
                        hintText: 'Enter a search term',
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: toggleSearchBarVisibility,
                        icon: const Icon(Icons.search),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfileScreen(),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 28,
                            backgroundImage: AssetImage(
                              'assets/images/persona2.jpg',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: bookTiles.length,
        itemBuilder: (context, index) => bookTiles[index],
      ),
    );
  }
}