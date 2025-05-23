import 'package:read_cycle/classes/app_image.dart';
import 'package:read_cycle/classes/book.dart';

final List<Book> fictionBooks = [
    Book(
      title: 'Ficciones',
      author: 'Jorge Luis Borges',
      pages: 203,
      genres: ['Fiction', 'Fantasy'],
      coverImage: AppImage.asset('assets/books/Ficciones.jpg'),
      description:
          'The seventeen pieces in Ficciones demonstrate the whirlwind of Borges\'s...',
    ),
    Book(
      title: 'Os Jogos da Fome',
      author: 'Suzanne Collins',
      pages: 260,
      genres: ['Ficção', 'Fantasia', 'Romance'],
      coverImage: AppImage.asset('assets/books/fiction/jogos_fome.jpg'),
      description: 'Num futuro pós-apocalíptico, surge das cinzas do que foi a América do Norte, Panem, uma nova nação governada por um regime totalitário que a partir da megalópole, Capitol, governa os doze Distritos com mão de ferro. Uma anterior revolta fracassada dos Distritos contra Capitol resultou num acordo de rendição em que todos os Distritos se comprometeram a enviar anualmente dois adolescentes para participar nos Jogos de Fome - um espetáculo sangrento de combates mortais. No final, apenas um destes jovens escapará com vida… Katniss Everdeen é uma adolescente que se oferece para substituir a irmã mais nova nos Jogos, o que a obrigará a escolher entre a sobrevivência e a solidariedade.'
    ),
    Book(
      title: 'Contos Inacabados',
      author: 'J.R.R Tolkien',
      pages: 592,
      genres: ['Ficção', 'Fantasia', 'Clássico'],
      coverImage: AppImage.asset('assets/books/fiction/contos.jpg'),
      description: 'Contos Inacabados é uma coleção de narrativas que vão desde os Dias Antigos da Terra-média, através da Segunda Era e da ascensão de Sauron, até ao fim da Guerra do Anel-que relatam os acontecimentos contados em O Silmarillion e O Senhor dos Anéis. O livro inclui o relato animado de Gandalf sobre como e quando enviou os Anões para a célebre festa de Fundo-do-Saco, o aparecimento do deus do mar Ulmo diante dos olhos de Tuor na costa de Beleriand, uma descrição exata da organização militar dos cavaleiros de Rohan, e a viagem dos cavaleiros Negros durante a caça ao Anel'
    ),
    Book(
      title: 'Renegados',
      author: 'Marissa Meyer',
      pages: 584,
      genres: ['Ficção', 'Romance', 'Jovem Adulto', 'Distopia'],
      coverImage: AppImage.asset('assets/books/fiction/renegados.jpg'),
      description: 'Há mais de dez anos, os Renegados — um grupo de humanos com poderes extraordinários — emergiram das ruínas de uma sociedade destroçada e caótica e estabeleceram a paz e a ordem. Desde então, tornaram-se um símbolo de esperança e de coragem para todos... exceto para os vilões que foram derrotados.'
    ),
    Book(
      title: 'A Lâmina da Assassina',
      author: 'Sarah J. Maas',
      pages: 406,
      genres: ['Ficção', 'Romance', 'Jovem Adulto'],
      coverImage: AppImage.asset('assets/books/fiction/lamina.jpg'),
      description: 'O início da jornada da assassina… com sangue, suor e lágrimas. Celaena Sardothien é a assassina mais temida de Adarlan. Embora trabalhe para a poderosa Guilda de Assassinos e para o seu ardiloso mestre, Arobynn Hamel, Celaena não se deixa vergar e confia apenas no seu colega assassino contratado, Sam. E quando Arobynn a envia em missões que a levam de ilhas remotas a desertos hostis, Celaena dá por si a contrariar as ordens do seu mestre e a questionar a sua própria lealdade.'
    ),
    Book(
      title: 'Na rota de Vasco da Gama',
      author: 'Geronimo Stilton',
      pages: 128,
      genres: ['Fiction', 'Mystery', 'Juvenile'],
      coverImage: AppImage.asset('assets/books/fiction/geronimo.jpg'),
      description: '«Com mil mozarelas, fomos convidados para ir a Lisboa, Portugal, para uma aventura extrarrática… refazer a viagem por mar do grande Vasco da Gama! Nem imaginam! Ao que parece, o famoso navegador português é antepassado dos Stiltons! E assim começa uma aventura de perder o fôlego!» ',
    ),
    Book(
      title: 'O Hobbit', 
      author: 'J.R.R Tolkien', 
      pages: 328, 
      genres: ['Ficção', 'Clássico', 'Aventura', 'Fantasia'], 
      coverImage: AppImage.asset('assets/books/fiction/hobbit.jpg'), 
      description: 'Um clássico intemporal e um dos livros mais adorados e influentes do século xx. Esta é a história de como um Baggins viveu uma aventura e deu por si a fazer e a dizer coisas totalmente inesperadas... Bilbo Baggins goza de uma vida confortável, calma e pouco ambiciosa. Raramente viaja mais longe do que a despensa ou a adega do seu buraco de hobbit, em Fundo-do-Saco. Mas a sua tranquilidade é perturbada quando, um dia, o feiticeiro Gandalf e uma companhia de treze anões aparecem à sua porta, para o levar numa perigosa aventura. Eles têm um plano: saquear o tesouro guardado por Smaug, O Magnífico, um dragão enorme e muito perigoso…'
    ),
  ];