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
  Post(
    user: appUsers[0],
    book: appFictionBooks[0],
    location: 'Aveiro',
    date: xDaysAgo(7),
    images: [AppImage.asset('assets/images/placeholder.jpg'), AppImage.asset('assets/images/placeholder.jpg'), AppImage.asset('assets/images/placeholder.jpg'), AppImage.asset('assets/images/placeholder.jpg')],
    notes: '',
  ),
  Post(
    user: appUsers[2],
    book: appFictionBooks[2],
    location: 'Aveiro',
    date: DateTime.now(),
    images: [AppImage.asset('assets/images/placeholder.jpg'), AppImage.asset('assets/images/placeholder.jpg'), AppImage.asset('assets/images/placeholder.jpg')],
    notes: '',
  ),
  Post(
    user: appUsers[3],
    book: appFictionBooks[1],
    location: 'Aveiro',
    date: xDaysAgo(10),
    images: [AppImage.asset('assets/images/placeholder.jpg')],
    notes: '',
  ),
  Post(
    user: appUsers[3],
    book: appFictionBooks[3],
    location: 'Aveiro',
    date: xDaysAgo(2),
    images: [AppImage.asset('assets/images/placeholder.jpg')],
    notes: '',
  ),
  Post(
    user: appUsers[3],
    book: appFictionBooks[4],
    location: 'Aveiro',
    date: xDaysAgo(2),
    images: [AppImage.asset('assets/images/placeholder.jpg')],
    notes: '',
  ),
];



List<Post> thrillerPosts = [
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
  Post(
    user: appUsers[5], 
    book: romanceBooks[6], 
    location: 'Aveiro', 
    date: xDaysAgo(8), 
    images: [AppImage.asset('assets/images/placeholder.jpg'), AppImage.asset('assets/images/placeholder.jpg'),], 
    notes: ''
  ),
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
  Post(
    user: appUsers[4], 
    book: poetryBooks[3], 
    location: 'Aveiro', 
    date: DateTime.now(), 
    images: [AppImage.asset('assets/images/placeholder.jpg'), AppImage.asset('assets/images/placeholder.jpg'), AppImage.asset('assets/images/placeholder.jpg'),], 
    notes: ''
  ),
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


List<PostTile> fictionTiles = fictionPosts.map((post) => PostTile(post: post)).toList();
List<PostTile> thrillerTiles = thrillerPosts.map((post) => PostTile(post: post)).toList();
List<PostTile> romanceTiles = romancePosts.map((post) => PostTile(post: post)).toList();
List<PostTile> poetryTiles = poetryPosts.map((post) => PostTile(post: post)).toList();

List<Post> allPosts = [...fictionPosts, ...thrillerPosts, ...romancePosts, ...poetryPosts];
