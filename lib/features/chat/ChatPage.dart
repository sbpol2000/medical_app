import 'package:flutter/material.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  final _searchCtrl = TextEditingController();
  final List<ChatItem> _allChats = [
    ChatItem(
      id: '1',
      name: 'Dra. Ana Pérez',
      lastMessage: 'Perfecto, nos vemos el lunes.',
      time: DateTime.now().subtract(const Duration(minutes: 4)),
      unread: 2,
    ),
    ChatItem(
      id: '2',
      name: 'Recepción Clínica',
      lastMessage: 'Su cita fue confirmada ',
      time: DateTime.now().subtract(const Duration(hours: 3)),
      unread: 0,
    ),
    ChatItem(
      id: '3',
      name: 'Farmacia',
      lastMessage: 'Su medicamento esta listo para ser recogido.',
      time: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
      unread: 1,
    ),
  ];

  String _query = '';

  List<ChatItem> get _filtered => _allChats
      .where((c) => c.name.toLowerCase().contains(_query.toLowerCase()))
      .toList();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final isToday =
        time.year == now.year && time.month == now.month && time.day == now.day;
    if (isToday) {
      final hh = time.hour.toString().padLeft(2, '0');
      final mm = time.minute.toString().padLeft(2, '0');
      return '$hh:$mm';
    }
    // Muestra día/mes (simple)
    return '${time.day}/${time.month}';
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Regresar',
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        title: const Text('Mensajes', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(0, 122, 255, 100), // Colo ,
      ),

      body: SafeArea(
        child: Column(
          children: [
            // Buscador
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: TextField(
                controller: _searchCtrl,
                textInputAction: TextInputAction.search,
                onChanged: (v) => setState(() => _query = v),
                decoration: InputDecoration(
                  hintText: 'Buscar chats...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 14,
                  ),
                ),
              ),
            ),

            // Lista de conversaciones
            Expanded(
              child: ListView.separated(
                itemCount: _filtered.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final chat = _filtered[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    leading: CircleAvatar(
                      radius: 24,
                      child: Text(
                        chat.initials,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(
                      chat.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      chat.lastMessage,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _formatTime(chat.time),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        if (chat.unread > 0) ...[
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(
                                0,
                                122,
                                255,
                                100,
                              ), // Color azul,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              '${chat.unread}',
                              style: TextStyle(
                                color: scheme.onPrimary,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ChatThreadPage(chatId: chat.id, title: chat.name),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Nuevo chat',
        onPressed: () {
          // acción para crear nuevo chat
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Acción: nuevo chat')));
        },
        shape: const CircleBorder(), // asegura forma circular del FAB
        clipBehavior: Clip.antiAlias,
        child: Image.asset('assets/plusicon.jpg'),
      ),
    );
  }
}

class ChatItem {
  final String id;
  final String name;
  final String lastMessage;
  final DateTime time;
  final int unread;

  ChatItem({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unread,
  });

  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first.characters.first.toUpperCase();
    return (parts.first.characters.first + parts.last.characters.first)
        .toUpperCase();
  }
}

/// ====== PANTALLA: HILO DE MENSAJES ======
class ChatThreadPage extends StatefulWidget {
  const ChatThreadPage({super.key, required this.chatId, required this.title});

  final String chatId;
  final String title;

  @override
  State<ChatThreadPage> createState() => _ChatThreadPageState();
}

class _ChatThreadPageState extends State<ChatThreadPage> {
  final _msgCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();

  final List<Message> _messages = [
    Message(
      text: '¡Hola! ¿Cómo va todo?',
      isMe: false,
      time: DateTime.now().subtract(const Duration(minutes: 10)),
    ),
    Message(
      text: 'Hola doctora, todo bien, gracias.',
      isMe: true,
      time: DateTime.now().subtract(const Duration(minutes: 9)),
    ),
    Message(
      text: '¿Confirmamos la cita del lunes a las 9:00 am?',
      isMe: false,
      time: DateTime.now().subtract(const Duration(minutes: 7)),
    ),
    Message(
      text: 'Sí, perfecto para mí 👍',
      isMe: true,
      time: DateTime.now().subtract(const Duration(minutes: 6)),
    ),
  ];

  @override
  void dispose() {
    _msgCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _send() {
    final text = _msgCtrl.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(Message(text: text, isMe: true, time: DateTime.now()));
      _msgCtrl.clear();
    });

    // Scroll al final
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent + 80,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
        foregroundColor: Colors.white,
        backgroundColor: Color.fromRGBO(0, 122, 255, 100),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Lista de mensajes
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final m = _messages[index];
                  return Align(
                    alignment: m.isMe
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 280),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          //schema color
                          color: m.isMe
                              ? scheme.primary
                              : scheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(16),
                            topRight: const Radius.circular(16),
                            bottomLeft: Radius.circular(
                              m.isMe ? 16 : 4,
                            ), // ligera “cola”
                            bottomRight: Radius.circular(
                              m.isMe ? 4 : 16,
                            ), // ligera “cola”
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: m.isMe
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Text(
                              m.text,
                              style: TextStyle(
                                //schema color
                                color: m.isMe
                                    ? scheme.onPrimary
                                    : scheme.onSurface,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _fmtTime(m.time),
                              style: TextStyle(
                                fontSize: 11,
                                //schema color
                                color: m.isMe
                                    ? scheme.onPrimary.withValues(alpha: 0.8)
                                    : scheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Caja de entrada de mensaje
            _InputBar(controller: _msgCtrl, onSend: _send),
          ],
        ),
      ),
    );
  }

  String _fmtTime(DateTime time) {
    final hh = time.hour.toString().padLeft(2, '0');
    final mm = time.minute.toString().padLeft(2, '0');
    return '$hh:$mm';
  }
}

class Message {
  final String text;
  final bool isMe;
  final DateTime time;

  Message({required this.text, required this.isMe, required this.time});
}

/// Barra de entrada con TextField + botón enviar, respetando el teclado y SafeArea.
class _InputBar extends StatelessWidget {
  const _InputBar({required this.controller, required this.onSend});

  final TextEditingController controller;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                minLines: 1,
                maxLines: 5,
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(
                  hintText: 'Escribe un mensaje',
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                onSubmitted: (_) => onSend(),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              height: 44,
              width: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(0, 122, 255, 100),
                  padding: EdgeInsets.zero,
                  shape: const CircleBorder(),
                ),
                onPressed: onSend,
                child: const Icon(Icons.send, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
