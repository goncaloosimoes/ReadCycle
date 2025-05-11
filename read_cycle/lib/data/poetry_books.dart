import 'package:read_cycle/classes/app_image.dart';
import 'package:read_cycle/classes/book.dart';

final List<Book> poetryBooks = [
  Book(
    title: 'Livro do Desassossego', 
    author: 'Fernando Pessoa, Bernardo Soares (Heterónimo)', 
    pages: 461, 
    genres: ['Poesia', 'Ficção', 'Filosofia'], 
    coverImage: AppImage.asset('assets/books/poetry/desassossego.jpg'), 
    description: 'Publicado pela primeira vez em 1982, quase meio século após a morte de Fernando Pessoa, o "Livro do Desassossego" é uma obra-prima pouco convencional, resistente às habituais classificações literárias. A palavra desassossego refere-se à angústia existencial do narrador, sim, mas também à sua recusa em ficar quieto, parado. Sem sair de Lisboa, este viaja constantemente na sua maneira de ver, sentir e dizer. Ler este livro, repleto de emoção e observações penetrantes, é uma experiência estranhamente libertadora.'
  ),
  Book(
    title: 'O Livro de Cesário Verde e Outros Poemas', 
    author: 'Cesário Verde', 
    pages: 168, 
    genres: ['Poesia', 'Literatura Portuguesa'], 
    coverImage: AppImage.asset('assets/books/poetry/cesario.jpg'), 
    description: 'É de 1887 a publicação de um dos mais belos e importantes livros de poesia em língua portuguesa. No ano anterior, 1886, morria, aos 31 anos, o seu autor, vítima de tuberculose e da maior incompreensão e desdém dos seus pares. Cesário Verde, o homem que viu poesia na sujidade das ruas, no corpo doente da engomadeira, na azáfama dos trabalhadores, revolucionou o cânone e impôs uma nova forma de olhar o real, de o descrever e sentir. Entre a cidade e o campo, o caos e a liberdade, o idílio e a realidade, emerge em Cesário uma nova sensibilidade, transgressora, que privilegia os sentidos e as impressões do quotidiano em detrimento de um sentimentalismo exacerbado que sentia já distante, imposição de uma consciência social preconizadora de um final de século turbulento.'
  ),
  Book(
    title: 'Mensagem', 
    author: 'Fernando Pessoa', 
    pages: 120, 
    genres: ['Poesia', 'Clássico', 'Literatura Portuguesa'], 
    coverImage: AppImage.asset('assets/books/poetry/mensagem.jpg'), 
    description: 'Mensagem é o único livro de poemas de Fernando Pessoa publicado em português durante a sua vida. É também "realmente um só poema", como escreveu, dada a unidade perfeita conseguida pelo seu canto das grandezas passadas da nação - que se reflectem no futuro, potenciadas pelo Quinto Império.'
  ),
  Book(
    title: 'Vim Sem Tempo', 
    author: 'Poeta da Cidade', 
    pages: 120, 
    genres: ['Poesia'], 
    coverImage: AppImage.asset('assets/books/poetry/tempo.jpg'), 
    description: 'O tempo, implacável e constante, define a perceção do mundo, revelando tanto a beleza quanto a dor da existência. É a consciência da finitude que impulsiona cada ação. É no tempo que se ancoram as maiores virtudes do Homem; é no tempo que reside a Justiça, é no tempo que experimenta a Ciência; é ele , o tempo, que tece a condição humana. Nós vamos, ele fica, ele continua. Neste ansiado livro, Pedro Freitas, o Poeta da Cidade, chegou sem tempo a perder, como todos nós. Aprendamos a saborear o que temos... antes que seja tarde demais.'
  ),
];