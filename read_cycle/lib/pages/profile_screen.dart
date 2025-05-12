import 'package:flutter/material.dart';
import 'package:read_cycle/components/wishlist.dart';
import 'package:read_cycle/data/users.dart';
import 'package:read_cycle/components/book_tile.dart';
import 'package:read_cycle/data/book_genres.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  bool isExpandedBio = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Perfil'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    radius: 48,
                    backgroundImage: currentUser.profileImage.build(),
                  ),
                ),
                const SizedBox(width: 15,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            currentUser.name,
                            style: const TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  TextEditingController nameController = TextEditingController(text: currentUser.name);
                                  TextEditingController emailController = TextEditingController(text: currentUser.email);
                                  return AlertDialog(
                                    title: const Text('Editar Perfil'),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                currentUser.profileImage.asset = 'assets/images/blank_profile.jpg';
                                              });
                                            },
                                            child: CircleAvatar(
                                              radius: 40,
                                              backgroundImage: currentUser.profileImage.build(),
                                            ),
                                          ),
                                          const SizedBox(height: 15,),
                                          TextField(
                                            controller: nameController,
                                            decoration: const InputDecoration(labelText: 'Nome'),
                                          ),
                                          SizedBox(height: 10,),
                                          TextField(
                                            controller: emailController,
                                            decoration: const InputDecoration(labelText: 'Email'),
                                          )
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        child: const Text('Cancelar'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: WidgetStateProperty.all(Colors.green.shade200)
                                        ),
                                        child: const Text('Guardar'),
                                        onPressed: () {
                                          setState(() {
                                            currentUser.name = nameController.text;
                                            currentUser.email = emailController.text;
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                }
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 8,),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                  )
                                ),
                              ),
                              child: Icon(Icons.edit)
                            ),
                          ),
                        ],
                      ),
                      Text(
                        currentUser.email,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            currentUser.rating,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 20
                            ),
                          ),
                          const Icon(
                            Icons.star,
                              color: Colors.amber,
                              size: 25,
                          )
                        ],
                      ),
                      Text( // não implementado
                        '10 criticas',
                        style: const TextStyle(
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                const Text(
                  'Biografia',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        TextEditingController biographyController = TextEditingController(text: currentUser.bio);
                        return AlertDialog(
                          title: const Text('Editar Biografia'),
                          content: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 15,),
                                TextField(
                                  controller: biographyController,
                                  decoration: const InputDecoration(labelText: 'Biografia'),
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              child: const Text('Cancelar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(Colors.green.shade200)
                              ),
                              child: const Text('Guardar'),
                              onPressed: () {
                                setState(() {
                                  currentUser.bio = biographyController.text;
                                });
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      }
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 8,),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 2,
                        )
                      ),
                    ),
                    child: Icon(Icons.edit, size: 17,)
                  ),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 10,),
            LayoutBuilder(
              builder: (context, constraints) {
                final maxLines = isExpandedBio ? null : 4;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentUser.bio,
                      style: const TextStyle(fontSize: 14),
                      maxLines: maxLines,
                      overflow: isExpandedBio ? TextOverflow.visible : TextOverflow.ellipsis,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isExpandedBio = !isExpandedBio;
                        });
                      },
                      child: Text(
                        isExpandedBio ? 'Ver menos' : 'Ver mais',
                        style: TextStyle(
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                      size: 25,
                    ),
                    Text(
                      currentUser.location,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            TextEditingController locationController = TextEditingController(text: currentUser.location);
                            return AlertDialog(
                              title: const Text('Editar Localização'),
                              content: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(height: 15,),
                                    TextField(
                                      controller: locationController,
                                      decoration: const InputDecoration(labelText: 'Localização'),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('Cancelar'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(Colors.green.shade200)
                                  ),
                                  child: const Text('Guardar'),
                                  onPressed: () {
                                    setState(() {
                                      currentUser.location = locationController.text;
                                    });
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          }
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 8,),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 2,
                            )
                          ),
                        ),
                        child: Icon(Icons.edit, size: 17,)
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    // <a href="https://www.flaticon.com/free-icons/transaction" title="transaction icons">Transaction icons created by feen - Flaticon</a>
                    Image.asset(
                      'assets/images/transaction.png',
                      width: 25,
                      height: 25,
                    ),
                    SizedBox(width: 5,),
                    Text(
                      '${currentUser.numTrades} trocas',
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20,),
            Row(
              children: [
                const Text(
                  'Géneros Preferidos',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    List<String> selectedGenres = List.from(currentUser.favGenres);

                    showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setStateDialog) {
                            return AlertDialog(
                              title: const Text('Selecionar Géneros Preferidos'),
                              content: SizedBox(
                                width: double.maxFinite,
                                child: ListView.builder(
                                  itemCount: bookGenres.length,
                                  itemBuilder: (context, index) {
                                    String genre = bookGenres[index];
                                    return CheckboxListTile(
                                      title: Text(genre),
                                      value: selectedGenres.contains(genre),
                                      onChanged: (bool? value) {
                                        setStateDialog(() {
                                          if (value == true) {
                                            selectedGenres.add(genre);
                                          } else {
                                            selectedGenres.remove(genre);
                                          }
                                        });
                                      },
                                    );
                                  },
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancelar'),
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(Colors.green.shade200),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      currentUser.favGenres = List.from(selectedGenres);
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Guardar'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 8,),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 2,
                        )
                      ),
                    ),
                    child: Icon(Icons.edit, size: 17,)
                  ),
                ),
              ],
            ),
            const Divider(),
            Container( // generos do livro
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: currentUser.favGenres.map((genre) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      genre,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20,),
            Row(
              children: [
                const Text(
                  'Lista de Desejos',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => WishList(
                        afterSave: () {
                          setState(() {});
                        },
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 8,),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 2,
                        )
                      ),
                    ),
                    child: Icon(Icons.edit, size: 17,)
                  ),
                )
              ],
            ),
            const Divider(),
            Container( // lista de desejos
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: currentUser.wishlist.map((bookName) {
                  return Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          bookName,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              currentUser.wishlist.removeWhere((text) => bookName == text);
                            });
                          },
                          child: const Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.redAccent
                          )
                        )
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
            const Divider(),
            const SizedBox(height: 20,),
            const Text(
              'Livros',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            const Divider(),
            SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: currentUser.books.length,
              itemBuilder: (context, index) => BookTile(book: currentUser.books[index], user: currentUser,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}