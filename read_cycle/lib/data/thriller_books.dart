import 'package:read_cycle/classes/app_image.dart';
import 'package:read_cycle/classes/book.dart';

final List<Book> thrillerBooks = [
  Book(
    title: 'A criada', 
    author: 'Freida McFadden', 
    pages: 336, 
    genres: ['Thriller', 'Mystery', 'Fiction', 'Suspense'],
    coverImage: AppImage.asset('assets/books/thriller/acriada.jpg'),
    description: '«Bem-vinda à família», diz Nina Winchester enquanto me cumprimenta com a sua mão elegante e bem cuidada. Sorrio educadamente e olho para o longo corredor de mármore. Este emprego caiu-me do céu. Talvez seja a minha última oportunidade para mudar de vida. E o melhor de tudo é que aqui ninguém sabe nada acerca do meu passado. Posso esconder-me e fingir ser aquilo que eu quiser. Infelizmente, não tardo a descobrir que os segredos dos Winchester são muito mais perigosos do que os meus…'
  ),
];
