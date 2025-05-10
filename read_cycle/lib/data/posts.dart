import 'package:read_cycle/classes/app_image.dart';
import 'package:read_cycle/classes/post.dart';
import 'package:read_cycle/data/users.dart';
import 'package:read_cycle/data/fiction_books.dart';


final List<Post> appPosts = [
      Post(
        user: appUsers[0],
        book: appFictionBooks[0],
        location: 'Aveiro',
        date: DateTime.now(),
        images: [AppImage.asset('assets/images/placeholder.jpg'), AppImage.asset('assets/images/placeholder.jpg')],
        notes: '',
      ),
      Post(
        user: appUsers[1],
        book: appFictionBooks[1],
        location: 'Aveiro',
        date: DateTime.now(),
        images: [AppImage.asset('assets/images/placeholder.jpg'), AppImage.asset('assets/images/placeholder.jpg'), AppImage.asset('assets/images/placeholder.jpg')],
        notes: 'Livro em muito bom estado, praticamente novo!',
      ),
      Post(
        user: appUsers[1],
        book: appFictionBooks[2],
        location: 'Aveiro',
        date: DateTime.now(),
        images: [AppImage.asset('assets/images/placeholder.jpg')],
        notes: '',
      ),
      Post(
        user: appUsers[1],
        book: appFictionBooks[3],
        location: 'Aveiro',
        date: DateTime.now(),
        images: [AppImage.asset('assets/images/placeholder.jpg'), AppImage.asset('assets/images/placeholder.jpg')],
        notes: '',
      ),
      Post(
        user: appUsers[1],
        book: appFictionBooks[4],
        location: 'Aveiro',
        date: DateTime.now(),
        images: [AppImage.asset('assets/images/placeholder.jpg')],
        notes: '',
      ),
    ];