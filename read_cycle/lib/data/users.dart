import 'package:read_cycle/classes/app_image.dart';
import 'package:read_cycle/classes/user.dart';
import 'package:read_cycle/data/fiction_books.dart';

User currentUser = User(
  name: '[Nome]', 
  email: '[Email]', 
  location: '[Localização]', 
  profileImage: AppImage.asset('assets/images/blank_profile.jpg'), 
  rating: '[Avaliação]', 
  favGenres: [], 
  bio: '[Biografia]', 
  books: [appFictionBooks[0], appFictionBooks[1]], 
  numTrades: 0
);

final List<User> appUsers = [
    User(
      name: 'Emma',
      email: 'emma@email.com',
      location: 'Aveiro',
      profileImage: AppImage.asset('assets/images/persona2.jpg'),
      rating: '4.5',
      favGenres: ['Ficção', 'Romance', 'Biografia'],
      bio: 'Blogger de viagens',
      books: [appFictionBooks[2]],
      numTrades: 15,
    ),
    User(
      name: 'Gonçalo Silva',
      email: 'gonca@email.com',
      location: 'Aveiro',
      profileImage: AppImage.asset('assets/images/blank_profile.jpg'),
      rating: '4.9',
      favGenres: ['Ficção', 'Thriller', 'Romance'],
      bio: 'Olá! Sou o Gonçalo! E aqui estão escritas mais um monte de palavras que não dizem nada apenas servem para ver se o botão de ver mais está ou não a funcionar, acho que já deve ser suficiente.',
      books: appFictionBooks.sublist(3),
      numTrades: 10,
    ),
];