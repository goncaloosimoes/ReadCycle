import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:read_cycle/bar_stuff.dart';
import 'package:read_cycle/classes/app_image.dart';
import 'package:read_cycle/classes/book.dart';
import 'package:read_cycle/classes/post.dart';
import 'package:read_cycle/data/posts.dart';
import 'package:read_cycle/data/users.dart';
import 'package:read_cycle/components/step_indicator.dart';
import 'package:read_cycle/classes/isbn_input_formatter.dart';
import 'package:read_cycle/main.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  String selectedOption = 'manual';
  int _currentScreen = 0;
  bool _isbnConfirmationScreen = false;
  bool isLoading = false;

  // Controladores para os campos de texto
  final TextEditingController _isbnController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _pagesController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  // Detalhes do livro específico para o ISBN 978-0345-371-485
  final Map<String, String> _perryMasonBook = {
    'title': 'Perry Mason - The Case of the Demure Defendant',
    'author': 'Erle Stanley Gardner',
    'description':
        'Janice Wainwright, uma jovem reservada, é acusada de matar seu chefe. Apesar das evidências contra ela, Perry Mason acredita em sua inocência. Investigando a fundo, ele descobre segredos perigosos e inimigos ocultos. No tribunal, cada movimento é decisivo para virar o jogo. Mason precisa provar a verdade antes que Janice seja condenada injustamente.',
    'pages': '276',
    'genre': 'Mistério, Thriller',
    'isbn': '9780345371485',
  };

  // Obter o primeiro url que funcione de uma lista (usar para obter a melhor imagem de cover da API)
  Future<String> _findWorkingCover(List<String> coverUrls) async {
    for (String url in coverUrls) {
      final response = await http.head(Uri.parse(url));
      if (response.statusCode == 200) {
        return url;
      }
    }
    return "";
  }

  void goToNextScreen() async {
    FocusScope.of(context).unfocus();

    bool hasInternet = false;

    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasInternet = true;
      }
    } on SocketException catch (_) {
      hasInternet = false;
    }

    late final http.Response response;
    late final http.Response responseWorks;
    if (!_isbnConfirmationScreen && _currentScreen == 1) {
      if (!hasInternet) {
        if (mounted) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Sem internet!"),
                content: Text("Não há conexão à internet!"),
                actions: [
                  ElevatedButton(
                    child: const Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
        return;
      }
      setState(() {
        isLoading = true;
      });
      final String isbn = _isbnController.text.replaceAll(
        RegExp(r'[- ]*'),
        '',
      ); // Sem os traços/espaços
      response = await http.get(
        Uri.parse(
          'https://openlibrary.org/api/books?bibkeys=ISBN:$isbn&format=json&jscmd=data',
        ),
      );

      // Colocar a imagem de cover (não pode ser no setState porque não dá para fazer await lá)
      if (response.statusCode == 200 &&
          response.body != '{}' &&
          jsonDecode(response.body) != null) {
        final Map<String, dynamic> jsonResponse =
            (jsonDecode(response.body) as Map<String, dynamic>)["ISBN:$isbn"];

        // Obter resposta da book edition API
        var responseEdition = await http.get(
          Uri.parse('https://openlibrary.org${jsonResponse["key"]}.json'),
        );

        if (responseEdition.statusCode == 200 &&
            responseEdition.body != '{}' &&
            jsonDecode(responseEdition.body) != null) {
          final Map<String, dynamic> jsonResponseEdition =
              (jsonDecode(responseEdition.body) as Map<String, dynamic>);

          // Obter resposta da works API
          responseWorks = await http.get(
            Uri.parse(
              'https://openlibrary.org${jsonResponseEdition["works"][0]["key"]}.json',
            ),
          );
        }

        List<String> urlList =
            jsonResponse["cover"].values
                .toList(growable: false)
                .reversed
                .toList(growable: false)
                .cast<String>();

        if (_selectedImages.isEmpty) {
          _selectedImages.add(AppImage.url(await _findWorkingCover(urlList)));
        } else {
          _selectedImages[0] = AppImage.url(await _findWorkingCover(urlList));
        }
      }

      setState(() {
        isLoading = false;
      });
    }

    setState(() {
      if (_isbnConfirmationScreen) {
        _isbnConfirmationScreen = false;
        _currentScreen = 3; // Vai para localização após confirmar ISBN
      } else if (_currentScreen == 0) {
        if (selectedOption == 'isbn') {
          _currentScreen = 1; // Vai para inserção de ISBN
        } else {
          _currentScreen = 2; // Vai para inserção manual
        }
      } else if (_currentScreen == 1) {
        // Colocaar dados nos campos
        if (response.statusCode == 200 &&
            response.body != '{}' &&
            jsonDecode(response.body) != null) {
          final String isbn = _isbnController.text.replaceAll(
            RegExp(r'[- ]*'),
            '',
          ); // Sem os traços/espaços
          // Obter dados
          final Map<String, dynamic> jsonResponse =
              (jsonDecode(response.body) as Map<String, dynamic>)["ISBN:$isbn"];

          _titleController.text = jsonResponse["title"];
          _authorController.text =
              jsonResponse['authors'][0]['name']; // Usar este como primeiro autor

          if (responseWorks.statusCode == 200 &&
              responseWorks.body != '{}' &&
              jsonDecode(responseWorks.body) != null) {
            final Map<String, dynamic> jsonResponseWorks =
                (jsonDecode(responseWorks.body) as Map<String, dynamic>);

            // Se tem descrição, colocar
            if (jsonResponseWorks["description"] != null) {
              if (jsonResponseWorks["description"] is Map) {
                // Descrição é um mapa
                _descriptionController.text =
                    jsonResponseWorks["description"]["value"];
              } else {
                // Descrição é só uma string
                _descriptionController.text = jsonResponseWorks["description"];
              }
            } else {
              _descriptionController.text = '';
            }
          }

          // Se tem nº de páginas, colocar
          if (jsonResponse["number_of_pages"] != null) {
            _pagesController.text =
                (jsonResponse["number_of_pages"] as int).toString();
          } else if (jsonResponse["title"] ==
              "The Case of the Demure Defendant") {
            _pagesController.text = '276';
          }

          // Se tem subjects/géneros, colocar o mais curto (provavelmente o que melhor descreve)
          if (jsonResponse["subjects"] != null) {
            List<dynamic> subjects = jsonResponse["subjects"] as List<dynamic>;
            String smallestSubject = subjects[0]["name"];
            for (Map subject in subjects) {
              if (smallestSubject.split(' ').length >
                  subject["name"].split(' ').length) {
                smallestSubject = subject["name"];
              }
            }
            _genreController.text = smallestSubject;
          } else {
            _genreController.text = '';
          }

          _currentScreen =
              2; // Vai para inserção manual se ISBN não for reconhecido
        } else {
          _currentScreen =
              2; // Vai para inserção manual se ISBN não for reconhecido
        }

        // usar 00 para ser mais rapido testar
        //if (_isbnController.text == '978 0345 371 485' || _isbnController.text == '00') {
        //  _titleController.text = _perryMasonBook['title']!;
        //  _authorController.text = _perryMasonBook['author']!;
        //  _descriptionController.text = _perryMasonBook['description']!;
        //  _pagesController.text = _perryMasonBook['pages']!;
        //  _genreController.text = _perryMasonBook['genre']!;
        //  _isbnConfirmationScreen = true;
        //} else {
        //  _currentScreen =
        //      2; // Vai para inserção manual se ISBN não for reconhecido
        //}
      } else if (_currentScreen == 2) {
        _currentScreen = 3; // Vai para localização
      } else if (_currentScreen == 3) {
        _currentScreen = 4; // Vai para fotos
      } else if (_currentScreen == 4) {
        _currentScreen = 5; // Vai para tela de confirmação final
      } else if (_currentScreen == 5) {
        // Postar livro e voltar para a tela inicial
        Book bookToAdd = Book(
          title: _titleController.text,
          author: _authorController.text,
          pages: int.parse(_pagesController.text),
          genres: [_genreController.text],
          coverImage:
              (_selectedImages.isNotEmpty)
                  ? _selectedImages[0]
                  : AppImage.asset("assets/images/placeholder.jpg"),
          description: _descriptionController.text,
        );

        allPosts.add(
          Post(
            user: currentUser,
            book: bookToAdd,
            location: _locationController.text,
            date: DateTime.now(),
            images: [for (AppImage image in _selectedImages) image],
            notes: _notesController.text,
          ),
        );
        currentUser.books.add(bookToAdd);

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.of(context).pop();

              selectedIdx = 0;
              mainScreenKey.currentState?.update();
            });

            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Livro postado com sucesso!',
                      style: TextStyle(fontSize: 18),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            );
          },
        );

        // Volta para a tela inicial após o dialog
        setState(() {
          _currentScreen = 0;
        });

        // Limpar campos
        _isbnController.clear();
        _titleController.clear();
        _authorController.clear();
        _descriptionController.clear();
        _pagesController.clear();
        _genreController.clear();
        _locationController.clear();
        _notesController.clear();
        _selectedImages.clear();
        _currentScreen = 0;
      }
    });
  }

  void goBack() {
    FocusScope.of(context).unfocus();

    setState(() {
      if (_isbnConfirmationScreen) {
        _isbnConfirmationScreen = false;
        _currentScreen = 1; // Volta para a tela de inserção de ISBN
      } else if (_currentScreen == 4) {
        _currentScreen = 3; // De fotos volta para localização
      } else if (_currentScreen == 3) {
        _currentScreen = 2; // De localização volta para detalhes
      } else if (_currentScreen == 2) {
        if (selectedOption == 'isbn') {
          _currentScreen = 1; // De detalhes volta para ISBN
        } else {
          _currentScreen = 0; // De detalhes volta para método de seleção
        }
      } else if (_currentScreen == 1) {
        _currentScreen = 0; // De ISBN volta para método de seleção
      } else if (_currentScreen == 5) {
        _currentScreen = 4; // Da tela de confirmação final volta para as fotos
      }
    });
  }

  Widget _buildStyledButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 130,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text, style: const TextStyle(fontSize: 20)),
      ),
    );
  }

  void editIsbnData() {
    setState(() {
      _isbnConfirmationScreen = false;
      _currentScreen = 2;
    });
  }

  Widget _buildNavigationButtons() {
    if (_currentScreen == 0) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 130, height: 50),
            _buildStyledButton(text: 'Seguinte', onPressed: goToNextScreen),
          ],
        ),
      );
    }

    String leftButtonText = _isbnConfirmationScreen ? 'Editar' : 'Anterior';
    String rightButtonText;

    if (_isbnConfirmationScreen) {
      rightButtonText = 'Confirmar';
    } else if (_currentScreen == 5) {
      rightButtonText = 'Publicar';
    } else {
      rightButtonText = 'Seguinte';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStyledButton(
            text: leftButtonText,
            onPressed: _isbnConfirmationScreen ? editIsbnData : goBack,
          ),
          _buildStyledButton(text: rightButtonText, onPressed: goToNextScreen),
        ],
      ),
    );
  }

  Widget _buildMethodSelectionScreen() {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Selecione o método de\npostagem',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          RadioListTile<String>(
            title: const Text('Inserir dados manualmente'),
            value: 'manual',
            groupValue: selectedOption,
            onChanged: (String? value) {
              setState(() {
                selectedOption = value!;
              });
            },
          ),
          RadioListTile<String>(
            title: const Text('Inserir ISBN'),
            value: 'isbn',
            groupValue: selectedOption,
            onChanged: (String? value) {
              setState(() {
                selectedOption = value!;
              });
            },
          ),
          const Spacer(),
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildIsbnScreen() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: StepIndicator(
            currentPage: _getStepIndex(),
            totalPages: _getTotalSteps(),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Insira o ISBN',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _isbnController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'XXX-XXXX-XXX-XXX',
                    hintStyle: TextStyle(
                      color: Colors.grey
                    )
                  ),
                  inputFormatters: [IsbnInputFormatter()],
                ),
                const SizedBox(height: 20),
                const Text(
                  'O ISBN é um número único que identifica cada livro publicado. '
                  'Geralmente pode encontrá-lo na contracapa ou nas primeiras páginas.',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const Spacer(),
                _buildNavigationButtons(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIsbnConfirmationScreen() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: StepIndicator(
            currentPage: _getStepIndex(),
            totalPages: _getTotalSteps(),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Confirme os detalhes do livro',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // Card com os detalhes do livro
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _perryMasonBook['title']!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Autor
                        Row(
                          children: [
                            const Text(
                              'Autor: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(_perryMasonBook['author']!),
                          ],
                        ),
                        const SizedBox(height: 5),

                        // Número de páginas
                        Row(
                          children: [
                            const Text(
                              'Páginas: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(_perryMasonBook['pages']!),
                          ],
                        ),
                        const SizedBox(height: 5),

                        // Gênero
                        Row(
                          children: [
                            const Text(
                              'Género(s): ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(_perryMasonBook['genre']!),
                          ],
                        ),
                        const SizedBox(height: 5),

                        // ISBN
                        Row(
                          children: [
                            const Text(
                              'ISBN: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(_perryMasonBook['isbn']!),
                          ],
                        ),
                        const SizedBox(height: 15),

                        // Descrição
                        const Text(
                          'Descrição:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(_perryMasonBook['description']!),
                      ],
                    ),
                  ),
                ),

                const Spacer(),
                const Text(
                  'Confirme se as informações do livro estão corretas.',
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                _buildNavigationButtons(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationNotesScreen() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  StepIndicator(
                    currentPage: _getStepIndex(),
                    totalPages: _getTotalSteps(),
                  ),

                  const Text(
                    'Localização',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // Mapa
                  SizedBox(
                    height: 420,
                    child: FlutterLocationPicker(
                      searchBarHintText: "Pesquisar local",
                      showSelectLocationButton: false,
                      showZoomController: false,

                      // coordenadas iniciais no deti :)
                      initPosition: LatLong(
                        40.63330334401945,
                        -8.659509397102308,
                      ),
                      initZoom: 11,
                      minZoomLevel: 5,
                      maxZoomLevel: 16,
                      trackMyPosition: false,
                      onChanged: (pickedData) {
                        print(
                          'Localização selecionada: ${pickedData.latLong.latitude}, ${pickedData.latLong.longitude}',
                        );

                        setState(() {
                          _locationController.text = pickedData.address;
                          // Continua preenchendo o _locationController se precisar enviar depois
                        });
                      },
                      onPicked: (pickedData) {
                        print(
                          'Localização selecionada: ${pickedData.latLong.latitude}, ${pickedData.latLong.longitude}',
                        );

                        setState(() {
                          _locationController.text = pickedData.address;
                          // Continua preenchendo o _locationController se precisar enviar depois
                        });
                      },
                    ),
                  ),
                  // const Text(
                  //   'Notas adicionais (opcional)',
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // TextField(
                  //   controller: _notesController,
                  //   maxLines: 3,
                  //   decoration: const InputDecoration(
                  //     border: OutlineInputBorder(),
                  //     hintText:
                  //         'Ex: Estado do livro, condições de troca...',
                  //     hintStyle: TextStyle(color: Colors.grey),
                  //   ),
                  // ),
                  //const Spacer(),
                  const SizedBox(height: 30),
                  _buildNavigationButtons(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  final List<AppImage> _selectedImages = [];

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        if (_selectedImages.length < 6) {
          // limite 6 imagens
          _selectedImages.add(AppImage.file(File(image.path)));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Máximo de 6 imagens permitidas.')),
          );
        }
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  Widget _buildPhotosScreen() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: StepIndicator(
            currentPage: _getStepIndex(),
            totalPages: _getTotalSteps(),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Adicione fotos do livro',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: GridView.builder(
                    itemCount: 6, // Sempre mostra 6 slots
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                    itemBuilder: (context, index) {
                      // Se temos uma imagem para este índice, mostra-a
                      if (index < _selectedImages.length) {
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image(
                                image: _selectedImages[index].build(),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              child: GestureDetector(
                                onTap: () => _removeImage(index),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      // Caso contrário, mostra uma caixa vazia (placeholder)
                      else {
                        return GestureDetector(
                          onTap: () {
                            if (_selectedImages.length < 6) {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return SafeArea(
                                    child: Wrap(
                                      children: [
                                        ListTile(
                                          leading: const Icon(
                                            Icons.photo_library,
                                          ),
                                          title: const Text('Galeria'),
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            _pickImage(ImageSource.gallery);
                                          },
                                        ),
                                        ListTile(
                                          leading: const Icon(Icons.camera_alt),
                                          title: const Text('Câmera'),
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            _pickImage(ImageSource.camera);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Máximo de 6 imagens permitidas.',
                                  ),
                                ),
                              );
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey[400]!),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo,
                                  size: 32,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Foto ${index + 1}",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                const Text(
                  'Notas adicionais (opcional)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: _notesController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Ex: Estado do livro, condições de troca...',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 16),
                _buildNavigationButtons(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFinalConfirmationScreen() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: StepIndicator(
            currentPage: _getStepIndex(),
            totalPages: _getTotalSteps(),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Confirmar publicação',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  // Detalhes do livro
                  _buildSectionTitle('Detalhes do livro'),
                  _buildInfoCard(
                    children: [
                      _buildInfoItem('Título', _titleController.text),
                      _buildInfoItem('Autor', _authorController.text),
                      _buildInfoItem('Páginas', _pagesController.text),
                      _buildInfoItem('Género', _genreController.text),
                      if (_isbnController.text.isNotEmpty)
                        _buildInfoItem('ISBN', _isbnController.text),
                      const SizedBox(height: 10),
                      const Text(
                        'Descrição:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(_descriptionController.text),
                    ],
                  ),

                  // Localização
                  _buildSectionTitle('Localização de troca'),
                  _buildInfoCard(
                    children: [
                      Text(
                        _locationController.text.isEmpty
                            ? 'Localização não especificada'
                            : _locationController.text,
                      ),
                    ],
                  ),

                  if (_notesController.text.isNotEmpty) ...[
                    _buildSectionTitle('Notas adicionais'),
                    _buildInfoCard(children: [Text(_notesController.text)]),
                  ],

                  // Imagens
                  _buildSectionTitle(
                    'Fotografias (${_selectedImages.length}/6)',
                  ),
                  SizedBox(
                    height: 120,
                    child:
                        _selectedImages.isEmpty
                            ? const Center(
                              child: Text('Nenhuma fotografia adicionada'),
                            )
                            : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _selectedImages.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image(
                                      image: _selectedImages[index].build(),
                                      width: 100,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                  ),

                  const SizedBox(height: 30),
                  // Aviso
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.amber),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.amber),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Ao publicar, o seu livro ficará visível para outros utilizadores que poderão entrar em contacto para troca.',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  _buildNavigationButtons(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInfoCard({required List<Widget> children}) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  // Método para construir a tela de detalhes do livro
  Widget _buildBookDetailsScreen() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  StepIndicator(
                    currentPage: _getStepIndex(),
                    totalPages: _getTotalSteps(),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Título do livro',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Digite o título do livro',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Autor',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _authorController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Digite o nome do autor',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Páginas',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextField(
                              controller: _pagesController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Número',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Gênero',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextField(
                              controller: _genreController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Ex: Romance',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Descrição',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _descriptionController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Uma pequena descrição da história do livro',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildNavigationButtons(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  int _getTotalSteps() {
    if (selectedOption == 'isbn') {
      return 5;
    }
    return 4;
  }

  int _getStepIndex() {
    if (_isbnConfirmationScreen) {
      return 1;
    }
    if (selectedOption == 'isbn') {
      return _currentScreen - 1;
    }
    return _currentScreen == 0 ? 0 : _currentScreen - 2;
  }

  @override
  Widget build(BuildContext context) {
    // Determinar título da AppBar com base na tela atual
    String appBarTitle = 'Postar livro';
    if (_currentScreen == 1) {
      appBarTitle = 'Inserir ISBN';
    } else if (_isbnConfirmationScreen) {
      appBarTitle = 'Detalhes encontrados';
    } else if (_currentScreen == 2) {
      appBarTitle = 'Detalhes do livro';
    } else if (_currentScreen == 3) {
      appBarTitle = 'Localização';
    } else if (_currentScreen == 4) {
      appBarTitle = 'Fotografias';
    } else if (_currentScreen == 5) {
      appBarTitle = 'Confirmação';
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(appBarTitle),
        // Removida a seta de voltar da AppBar
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          _currentScreen == 0
              ? _buildMethodSelectionScreen()
              : _isbnConfirmationScreen
              ? _buildIsbnConfirmationScreen()
              : _currentScreen == 1
              ? _buildIsbnScreen()
              : _currentScreen == 2
              ? _buildBookDetailsScreen()
              : _currentScreen == 3
              ? _buildLocationNotesScreen()
              : _currentScreen == 4
              ? _buildPhotosScreen()
              : _buildFinalConfirmationScreen(),

          if (isLoading)
            Positioned.fill(
              child: Container(
                alignment: Alignment.center,
                color: Colors.black26, // Dark overlay
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "A procurar informações sobre o livro...",
                        style: TextStyle(fontSize: 12, color: Colors.grey[200]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Limpar os controladores quando o widget for descartado
    _isbnController.dispose();
    _titleController.dispose();
    _authorController.dispose();
    _descriptionController.dispose();
    _pagesController.dispose();
    _genreController.dispose();
    super.dispose();
  }
}
