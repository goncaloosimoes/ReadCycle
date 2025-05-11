import 'package:flutter/material.dart';
import 'package:read_cycle/data/users.dart';

class WishList extends StatelessWidget {
  WishList({super.key, required this.afterSave, this.bookName = ''});

  // Função para executar depois de carregar no salvar (usar para setState, evita que seja preciso usar StatefulWidget)
  final void Function() afterSave;
  final String bookName;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.text = bookName;
    return AlertDialog(
      title: const Text("Adicionar à lista de desejos"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Nome"),
          TextField(
            controller: _controller,
            // TODO: maybe mudar estilo
          ),
          Text(
            "Receberá uma notificação se este livro for disponibilizado por alguém perto de si.",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
            ),
        ],
      ),
      actions: [
        ElevatedButton(
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
            currentUser.wishlist.add(_controller.text);
            afterSave();
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}