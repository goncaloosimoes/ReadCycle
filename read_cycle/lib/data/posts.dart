import 'package:read_cycle/classes/app_image.dart';
import 'package:read_cycle/classes/post.dart';
import 'package:read_cycle/data/poetry_books.dart';
import 'package:read_cycle/data/romance_books.dart';
import 'package:read_cycle/data/thriller_books.dart';
import 'package:read_cycle/data/users.dart';
import 'package:read_cycle/data/fiction_books.dart';
import 'package:read_cycle/data/time.dart';
import 'package:read_cycle/components/post_tile.dart';


List<Post> fictionPosts = [

  // O Hobbit
  // Pedro
  Post(
    user: appUsers[8],
    book: fictionBooks[6],
    location: 'Aveiro',
    date: DateTime.now(),
    images: [AppImage.asset('assets/images/placeholder.jpg')],
    notes: '',
  ),
  Post(
    user: appUsers[0],
    book: fictionBooks[6],
    location: 'Aveiro',
    date: xDaysAgo(2),
    images: [AppImage.asset('assets/images/placeholder.jpg')],
    notes: '',
  ),
  // Galileu
  Post(
    user: appUsers[9],
    book: fictionBooks[6],
    location: 'Aveiro',
    date: xDaysAgo(3),
    images: [AppImage.asset('assets/images/placeholder.jpg')],
    notes: '',
  ),
  // Maria
  Post(
    user: appUsers[7],
    book: fictionBooks[6],
    location: 'Aveiro',
    date: xDaysAgo(6),
    images: [AppImage.asset('assets/images/placeholder.jpg'), AppImage.asset('assets/images/placeholder.jpg')],
    notes: '',
  ),
  
  // CurrentUser
  Post(
    user: currentUser,
    book: fictionBooks[0],
    location: 'Aveiro',
    date: xDaysAgo(4),
    images: [AppImage.asset('assets/images/placeholder.jpg'), AppImage.asset('assets/images/placeholder.jpg'), AppImage.asset('assets/images/placeholder.jpg')],
    notes: '',
  ),
  Post(
    user: currentUser,
    book: fictionBooks[1],
    location: 'Aveiro',
    date: xDaysAgo(2),
    images: [AppImage.asset('assets/images/placeholder.jpg'), AppImage.asset('assets/images/placeholder.jpg'), AppImage.asset('assets/images/placeholder.jpg')],
    notes: '',
  ),

  // Emma
  Post(
    user: appUsers[0],
    book: fictionBooks[2],
    location: 'Aveiro',
    date: DateTime.now(),
    images: [AppImage.asset('assets/images/placeholder.jpg'), AppImage.asset('assets/images/placeholder.jpg'), AppImage.asset('assets/images/placeholder.jpg')],
    notes: '',
  ),

  // António Santos
  Post(
    user: appUsers[2],
    book: fictionBooks[2],
    location: 'Aveiro',
    date: DateTime.now(),
    images: [AppImage.asset('assets/images/placeholder.jpg'), AppImage.asset('assets/images/placeholder.jpg'), AppImage.asset('assets/images/placeholder.jpg')],
    notes: '',
  ),
  
  // Gonçalo Simões
  Post(
    user: appUsers[3],
    book: fictionBooks[1],
    location: 'Aveiro',
    date: xDaysAgo(10),
    images: [AppImage.asset('assets/images/placeholder.jpg')],
    notes: '',
  ),
  Post(
    user: appUsers[3],
    book: fictionBooks[3],
    location: 'Aveiro',
    date: xDaysAgo(2),
    images: [AppImage.asset('assets/images/placeholder.jpg')],
    notes: '',
  ),
  Post(
    user: appUsers[3],
    book: fictionBooks[4],
    location: 'Aveiro',
    date: xDaysAgo(2),
    images: [AppImage.asset('assets/images/placeholder.jpg')],
    notes: '',
  ),
];



List<Post> thrillerPosts = [
  // Gonçalo Silva
  Post(
    user: appUsers[1], 
    book: thrillerBooks[0], 
    location: 'Aveiro', 
    date: xDaysAgo(4), 
    images: [AppImage.asset('assets/images/placeholder.jpg'), AppImage.asset('assets/images/placeholder.jpg')], 
    notes: ''
  ),
  Post(
    user: appUsers[1], 
    book: thrillerBooks[4], 
    location: 'Aveiro', 
    date: xDaysAgo(6), 
    images: [AppImage.asset('assets/images/placeholder.jpg')], 
    notes: ''
  ),

  // António Santos
  Post(
    user: appUsers[2], 
    book: thrillerBooks[1], 
    location: 'Aveiro', 
    date: xDaysAgo(2), 
    images: [AppImage.asset('assets/images/placeholder.jpg'), AppImage.asset('assets/images/placeholder.jpg')], 
    notes: ''
  ),
  Post(
    user: appUsers[2], 
    book: thrillerBooks[2], 
    location: 'Aveiro', 
    date: DateTime.now(), 
    images: [AppImage.asset('assets/images/placeholder.jpg')], 
    notes: ''
  ),

  // Thriller
  Post(
    user: appUsers[6], 
    book: thrillerBooks[3], 
    location: 'Aveiro', 
    date: xDaysAgo(1), 
    images: [AppImage.asset('assets/images/placeholder.jpg'), AppImage.asset('assets/images/placeholder.jpg'),], 
    notes: 'Livro muito bom, está em bom estado!'
  ),
  Post(
    user: appUsers[6], 
    book: thrillerBooks[5], 
    location: 'Aveiro', 
    date: DateTime.now(), 
    images: [AppImage.asset('assets/images/placeholder.jpg'), AppImage.asset('assets/images/placeholder.jpg'),], 
    notes: ''
  ),
  Post(
    user: appUsers[6], 
    book: thrillerBooks[6], 
    location: 'Aveiro', 
    date: xDaysAgo(4), 
    images: [AppImage.asset('assets/images/placeholder.jpg')], 
    notes: ''
  ),  
];

List<Post> romancePosts = [
  // Gonçalo Silva
  Post(
    user: appUsers[1], 
    book: romanceBooks[0], 
    location: 'Aveiro', 
    date: DateTime.now(), 
    images: [AppImage.asset('assets/images/placeholder.jpg'), AppImage.asset('assets/images/placeholder.jpg'),], 
    notes: ''
  ),
  Post(
    user: appUsers[1], 
    book: romanceBooks[1], 
    location: 'Aveiro', 
    date: xDaysAgo(3), 
    images: [AppImage.asset('assets/images/placeholder.jpg'),], 
    notes: ''
  ),

  // Joana
  Post(
    user: appUsers[4], 
    book: romanceBooks[2], 
    location: 'Aveiro', 
    date: xDaysAgo(5), 
    images: [AppImage.asset('assets/images/placeholder.jpg'), AppImage.asset('assets/images/placeholder.jpg'), AppImage.asset('assets/images/placeholder.jpg'),], 
    notes: ''
  ),
  Post(
    user: appUsers[4], 
    book: romanceBooks[3], 
    location: 'Aveiro', 
    date: xDaysAgo(3), 
    images: [AppImage.asset('assets/images/placeholder.jpg'),], 
    notes: ''
  ),
  Post(
    user: appUsers[4], 
    book: romanceBooks[4], 
    location: 'Aveiro', 
    date: xDaysAgo(2), 
    images: [AppImage.asset('assets/images/placeholder.jpg'), AppImage.asset('assets/images/placeholder.jpg'),], 
    notes: ''
  ),

  // Manuel
  Post(
    user: appUsers[5], 
    book: romanceBooks[6], 
    location: 'Aveiro', 
    date: xDaysAgo(8), 
    images: [AppImage.asset('assets/images/placeholder.jpg'), AppImage.asset('assets/images/placeholder.jpg'),], 
    notes: ''
  ),

  // Ana
  Post(
    user: appUsers[6], 
    book: romanceBooks[5], 
    location: 'Aveiro', 
    date: DateTime.now(), 
    images: [AppImage.asset('assets/images/placeholder.jpg'),], 
    notes: ''
  ),
];


List<Post> poetryPosts = [
  // Joana
  Post(
    user: appUsers[4], 
    book: poetryBooks[3], 
    location: 'Aveiro', 
    date: DateTime.now(), 
    images: [AppImage.asset('assets/images/placeholder.jpg'), AppImage.asset('assets/images/placeholder.jpg'), AppImage.asset('assets/images/placeholder.jpg'),], 
    notes: ''
  ),

  // Manuel
  Post(
    user: appUsers[5], 
    book: poetryBooks[0], 
    location: 'Aveiro', 
    date: xDaysAgo(1), 
    images: [AppImage.asset('assets/images/placeholder.jpg'),], 
    notes: ''
  ),
  Post(
    user: appUsers[5], 
    book: poetryBooks[1], 
    location: 'Aveiro', 
    date: xDaysAgo(2), 
    images: [], 
    notes: ''
  ),
  Post(
    user: appUsers[5], 
    book: poetryBooks[2], 
    location: 'Aveiro', 
    date: xDaysAgo(4), 
    images: [AppImage.asset('assets/images/placeholder.jpg'),], 
    notes: ''
  ),
];


List<PostTile> fictionTiles = fictionPosts.map((post) => PostTile(post: post)).toList().sublist(2);
List<PostTile> thrillerTiles = thrillerPosts.map((post) => PostTile(post: post)).toList();
List<PostTile> romanceTiles = romancePosts.map((post) => PostTile(post: post)).toList();
List<PostTile> poetryTiles = poetryPosts.map((post) => PostTile(post: post)).toList();

List<Post> allPosts = [...fictionPosts, ...thrillerPosts, ...romancePosts, ...poetryPosts];
