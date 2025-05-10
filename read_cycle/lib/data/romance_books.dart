import 'package:read_cycle/classes/app_image.dart';
import 'package:read_cycle/classes/book.dart';

final List<Book> romanceBooks = [
  Book(
    title: 'Isto Começa Aqui', 
    author: 'Colleen Hoover', 
    pages: 320, 
    genres: ['Ficção', 'Romance', 'Contemporâneo'], 
    coverImage: AppImage.asset('assets/books/romance/aqui.jpg'), 
    description: 'Depois do seu reencontro inesperado, Lily e Atlas não conseguem parar de pensar um no outro nem em tudo aquilo por que passaram. Mas uma nova aproximação entre eles poderá não ser tão simples como parece. Lily tem de pensar no bem-estar da filha e na reação de Ryle a uma eventual relação com Atlas. Atlas também está ciente das dificuldades. Sabe que Ryle não irá aceitar facilmente a sua presença na vida da ex-mulher e da filha e não tem dúvidas de que os problemas de comportamento dele não terminaram com o fim do casamento.'
  ),
  Book(
    title: 'Isto Acaba Aqui', 
    author: 'Colleen Hoover', 
    pages: 336, 
    genres: ['Romance', 'Ficção', 'Contemporâneo'], 
    coverImage: AppImage.asset('assets/books/romance/acaba.jpg'), 
    description: 'O que te resta quando o homem dos teus sonhos te magoa? Lily tem 25 anos. Acaba de se mudar para Boston, pronta para começar uma nova vida e encontrar finalmente a felicidade. No terraço de um edifício, onde se refugia para pensar, conhece o homem dos seus sonhos: Ryle. Um neurocirurgião. Bonito. Inteligente. Perfeito. Todas as peças começam a encaixar-se.'
  ),
  Book(
    title: 'Memorial do Convento', 
    author: 'José Saramago', 
    pages: 376, 
    genres: ['Ficção', 'Clássico', 'Literatura Portuguesa'], 
    coverImage: AppImage.asset('assets/book/romance/convento.jpg'), 
    description: 'Era uma vez um rei que fez promessa de levantar convento em Mafra. Era uma vez a gente que construiu esse convento. Era uma vez um soldado maneta e uma mulher que tinha poderes. Era uma vez um padre que queria voar e morreu doido.'
  ),
  Book(
    title: 'A Biblioteca da Meia-Noite', 
    author: 'Matt Haig', 
    pages: 335, 
    genres: ['Ficção', 'Romance', 'Fantasia'], 
    coverImage: AppImage.asset('assets/books/romance/biblioteca.jpg'), 
    description: 'No limiar entre a vida e a morte, depois de uma vida cheia de desgostos e carregada de remorsos, Nora Seed dá por si numa biblioteca onde o relógio marca sempre a meia-noite e as estantes estão repletas de livros que se estendem até perder de vista. Cada um desses livros oferece-lhe a hipótese de experimentar uma outra vida, de fazer novas escolhas, de corrigir erros, de perceber o que teria acontecido se tivesse escolhido um caminho diferente. As possibilidades são infinitas e vários horizontes se abrem à sua frente.'
  ),
];

