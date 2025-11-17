import 'package:flutter/material.dart';
import 'package:my_smash/widgets/app_bar.dart';
import 'package:my_smash/widgets/bottom_nav_bar.dart';

class Discussion9 extends StatefulWidget {
  @override
  _Discussion9State createState() => _Discussion9State();
}

class _Discussion9State extends State<Discussion9> {
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _newDiscussionController = TextEditingController();
  
  List<Map<String, dynamic>> discussions = [
    {
      'id': 1,
      'user': {
        'name': 'Ervalsa Dwi Nanda',
        'role': 'Clean Person',
        'avatar': 'assets/avatar1.png',
      },
      'time': '1 menit yang lalu',
      'content': 'Halo saya ingin berdiskusi mengenai hasil uang yang saya dapatkan setelah membuang sampah di smart drop box.',
      'comments': [
        {
          'user': {
            'name': 'Ahmad Usamah Ali',
            'role': 'Android Developer',
            'avatar': 'assets/avatar2.png',
          },
          'time': 'Baru saja',
          'content': 'Yang saya ketahui hasil uang dari sampah yang telah kita buang akan masuk kedalam akun dan terkumpul.',
          'likes': 0,
          'isLiked': false,
        },
        {
          'user': {
            'name': 'Ersan Karimi',
            'role': 'Android Developer',
            'avatar': 'assets/avatar3.png',
          },
          'time': '1 hari yang lalu',
          'content': 'Saya mendapatkan 100 Point yang sama dengan 10.000',
          'likes': 1,
          'isLiked': true,
        },
      ],
      'expanded': false,
    },
    {
      'id': 2,
      'user': {
        'name': 'Alexander Batubara',
        'role': 'Clean Person',
        'avatar': 'assets/avatar4.png',
      },
      'time': '5 hari yang lalu',
      'content': 'Menurut kalian, lebih baik pisahin sampah organik sama anorganik di rumah dulu atau pas di lokasi drop box',
      'comments': [
        {
          'user': {
            'name': 'Renaldi Tri Saputra',
            'role': 'Android Developer',
            'avatar': 'assets/avatar5.png',
          },
          'time': '1 hari yang lalu',
          'content': 'Saya mendapatkan 230 Point dan dapat ditukarkan dengan Tupperware',
          'likes': 1,
          'isLiked': false,
        },
      ],
      'expanded': false,
    },
  ];

  // ✅ Add new discussion
  void _addNewDiscussion() {
    if (_newDiscussionController.text.trim().isEmpty) return;

    setState(() {
      final newId = discussions.length + 1;
      discussions.insert(0, {
        'id': newId,
        'user': {
          'name': 'You',
          'role': 'User',
          'avatar': 'assets/you_avatar.png',
        },
        'time': 'Baru saja',
        'content': _newDiscussionController.text.trim(),
        'comments': [],
        'expanded': false,
      });
      _newDiscussionController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Diskusi berhasil ditambahkan!')),
    );
  }

  // ✅ Show add discussion dialog
  void _showAddDiscussionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Buat Diskusi Baru'),
        content: TextField(
          controller: _newDiscussionController,
          maxLines: 4,
          decoration: const InputDecoration(
            hintText: 'Apa yang ingin kamu diskusikan?',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _newDiscussionController.clear();
            },
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _addNewDiscussion();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF216BC2),
              foregroundColor: Colors.white,
            ),
            child: const Text('Posting'),
          ),
        ],
      ),
    );
  }

  // ✅ Add comment
  void _addComment(int discussionId) {
    if (_commentController.text.isEmpty) return;

    setState(() {
      final discussion = discussions.firstWhere((d) => d['id'] == discussionId);
      discussion['comments'].add({
        'user': {
          'name': 'You',
          'role': 'User',
          'avatar': 'assets/you_avatar.png',
        },
        'time': 'Baru saja',
        'content': _commentController.text,
        'likes': 0,
        'isLiked': false,
      });
      _commentController.clear();
    });
  }

  // ✅ Toggle discussion expand/collapse
  void _toggleDiscussion(int discussionId) {
    setState(() {
      final discussion = discussions.firstWhere((d) => d['id'] == discussionId);
      discussion['expanded'] = !discussion['expanded'];
    });
  }

  // ✅ Toggle like comment (like/unlike)
  void _likeComment(int discussionId, int commentIndex) {
    setState(() {
      final discussion = discussions.firstWhere((d) => d['id'] == discussionId);
      final comment = discussion['comments'][commentIndex];
      
      final currentlyLiked = comment['isLiked'] ?? false;
      
      if (currentlyLiked) {
        comment['likes'] = (comment['likes'] ?? 0) - 1;
        comment['isLiked'] = false;
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('💔 Like dihapus'),
            duration: Duration(milliseconds: 1000),
          ),
        );
      } else {
        comment['likes'] = (comment['likes'] ?? 0) + 1;
        comment['isLiked'] = true;
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('❤️ Komentar disukai!'),
            duration: Duration(milliseconds: 1000),
          ),
        );
      }
      
      if (comment['likes'] < 0) {
        comment['likes'] = 0;
      }
    });
  }

  // ✅ Handle comment actions (edit/delete)
  void _handleCommentAction(String action, int discussionId, int commentIndex, Map<String, dynamic> comment) {
    switch (action) {
      case 'edit':
        _editComment(discussionId, commentIndex, comment);
        break;
      case 'delete':
        _showDeleteCommentDialog(discussionId, commentIndex);
        break;
    }
  }

  // ✅ Edit comment inline
  void _editComment(int discussionId, int commentIndex, Map<String, dynamic> comment) {
    setState(() {
      final discussion = discussions.firstWhere((d) => d['id'] == discussionId);
      discussion['comments'][commentIndex]['isEditing'] = true;
      discussion['comments'][commentIndex]['editingText'] = comment['content'];
    });
  }

  // ✅ Save edited comment
  void _saveEditedComment(int discussionId, int commentIndex, String newContent) {
    if (newContent.trim().isEmpty) return;
    
    setState(() {
      final discussion = discussions.firstWhere((d) => d['id'] == discussionId);
      discussion['comments'][commentIndex]['content'] = newContent.trim();
      discussion['comments'][commentIndex]['isEditing'] = false;
      discussion['comments'][commentIndex]['time'] = 'Diedit · Baru saja';
      discussion['comments'][commentIndex].remove('editingText');
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Komentar berhasil diupdate')),
    );
  }

  // ✅ Cancel editing
  void _cancelEditComment(int discussionId, int commentIndex) {
    setState(() {
      final discussion = discussions.firstWhere((d) => d['id'] == discussionId);
      discussion['comments'][commentIndex]['isEditing'] = false;
      discussion['comments'][commentIndex].remove('editingText');
    });
  }

  // ✅ Show delete confirmation dialog
  void _showDeleteCommentDialog(int discussionId, int commentIndex) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Komentar'),
        content: const Text('Yakin ingin menghapus komentar ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteComment(discussionId, commentIndex);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  // ✅ Delete comment
  void _deleteComment(int discussionId, int commentIndex) {
    setState(() {
      final discussion = discussions.firstWhere((d) => d['id'] == discussionId);
      discussion['comments'].removeAt(commentIndex);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Komentar berhasil dihapus')),
    );
  }

  // ✅ Reply to comment
  void _replyToComment(int discussionId, String replyToUser) {
    _commentController.text = '@$replyToUser ';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Membalas $replyToUser')),
    );
  }

  // ✅ Safe Avatar Widget
  Widget _buildAvatar(String name, double radius, {String? avatarPath}) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: const Color(0xFF216BC2),
      child: Text(
        name.isNotEmpty ? name[0].toUpperCase() : 'U',
        style: TextStyle(
          color: Colors.white,
          fontSize: radius * 0.6,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                children: [
                  // Forum Title
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8EFFF),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      'Forum Diskusi',
                      style: TextStyle(
                        color: const Color(0xFF00A478),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Add Discussion Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _showAddDiscussionDialog,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF216BC2),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: const Icon(Icons.add),
                      label: const Text(
                        'Buat Diskusi Baru',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Discussions List
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: discussions.length,
                    itemBuilder: (context, index) {
                      final discussion = discussions[index];
                      return _buildDiscussionCard(discussion);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 2),
    );
  }

  Widget _buildDiscussionCard(Map<String, dynamic> discussion) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: const Color(0xFFBCBCBC), width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info Row
            Row(
              children: [
                _buildAvatar(discussion['user']['name'], 22),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        discussion['user']['name'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        discussion['time'],
                        style: const TextStyle(
                          color: Color(0xFF7A757D),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Discussion Content
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFC6F7FD),
                borderRadius: BorderRadius.circular(10),
              ),
              width: double.infinity,
              child: Text(
                discussion['content'],
                style: const TextStyle(
                  color: Color(0xFF7A757D),
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Comments Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => _toggleDiscussion(discussion['id']),
                  child: Text(
                    '${discussion['comments'].length} Komentar',
                    style: const TextStyle(
                      color: Color(0xFF216BC2),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    discussion['expanded'] ? Icons.expand_less : Icons.expand_more,
                    color: const Color(0xFF216BC2),
                  ),
                  onPressed: () => _toggleDiscussion(discussion['id']),
                ),
              ],
            ),
            
            // Expanded Comments
            if (discussion['expanded']) ...[
              Column(
                children: [
                  // Comment Input Row
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        _buildAvatar('You', 18),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _commentController,
                            decoration: InputDecoration(
                              hintText: 'Tambahkan komentar...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: const Color(0xFFB5B5B5)),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.send, color: const Color(0xFF216BC2)),
                          onPressed: () => _addComment(discussion['id']),
                        ),
                      ],
                    ),
                  ),
                  
                  // Comments List
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: discussion['comments'].length,
                    itemBuilder: (context, commentIndex) {
                      final comment = discussion['comments'][commentIndex];
                      return _buildCommentCard(comment, discussion['id'], commentIndex);
                    },
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCommentCard(Map<String, dynamic> comment, int discussionId, int commentIndex) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: const Color(0xFF7F7F7F), width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ FIXED: Commenter Info Row - Edit/Delete menu ONLY for own comments
            Row(
              children: [
                _buildAvatar(comment['user']['name'], 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment['user']['name'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              comment['user']['role'],
                              style: const TextStyle(
                                color: Color(0xFF7A757D),
                                fontSize: 11,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Container(
                            height: 10,
                            width: 1,
                            color: const Color(0xFF7A757D),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            comment['time'],
                            style: const TextStyle(
                              color: Color(0xFF7A757D),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // ✅ ONLY Edit/Delete Menu for Own Comments
                if (comment['user']['name'] == 'You' || comment['user']['name'] == 'Ahmad Usamah Ali') ...[
                  PopupMenuButton<String>(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.more_vert, size: 16, color: Colors.grey[600]),
                    onSelected: (value) => _handleCommentAction(value, discussionId, commentIndex, comment),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.edit, size: 16),
                            SizedBox(width: 8),
                            Text('Edit Komentar'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.delete, size: 16, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Hapus', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
            const SizedBox(height: 8),
            
            // Comment Content (bisa edit inline)
            _buildCommentContent(comment, discussionId, commentIndex),
            
            const SizedBox(height: 8),
            
            // ✅ FIXED: Comment Actions - Like button ALWAYS visible for ALL comments
            Row(
              children: [
                // Reply Button - untuk semua komentar
                TextButton.icon(
                  onPressed: () => _replyToComment(discussionId, comment['user']['name']),
                  icon: Icon(Icons.reply, size: 16, color: const Color(0xFF34364A)),
                  label: Text(
                    'Balas',
                    style: TextStyle(color: const Color(0xFF34364A)),
                  ),
                ),
                const SizedBox(width: 20),
                
                // ✅ FIXED: Like Button - SELALU ADA untuk SEMUA komentar
                InkWell(
                  onTap: () => _likeComment(discussionId, commentIndex),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          transitionBuilder: (child, animation) {
                            return ScaleTransition(scale: animation, child: child);
                          },
                          child: Icon(
                            comment['isLiked'] == true 
                                ? Icons.favorite 
                                : Icons.favorite_border,
                            key: ValueKey(comment['isLiked']),
                            size: 16,
                            color: comment['isLiked'] == true 
                                ? Colors.red 
                                : const Color(0xFF34364A),
                          ),
                        ),
                        const SizedBox(width: 4),
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          style: TextStyle(
                            color: comment['isLiked'] == true 
                                ? Colors.red 
                                : const Color(0xFF34364A),
                            fontWeight: comment['isLiked'] == true 
                                ? FontWeight.w600 
                                : FontWeight.normal,
                          ),
                          child: Text('${comment['likes']}'),
                        ),
                        const SizedBox(width: 4),
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          style: TextStyle(
                            color: comment['isLiked'] == true 
                                ? Colors.red 
                                : const Color(0xFF34364A),
                          ),
                          child: const Text('Likes'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Build comment content (editable or text)
  Widget _buildCommentContent(Map<String, dynamic> comment, int discussionId, int commentIndex) {
    final bool isEditing = comment['isEditing'] ?? false;
    
    if (isEditing) {
      // Editing mode
      final TextEditingController editController = TextEditingController(
        text: comment['editingText'] ?? comment['content']
      );
      
      return Column(
        children: [
          TextField(
            controller: editController,
            maxLines: null,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: const Color(0xFF216BC2)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: const Color(0xFF216BC2), width: 2),
              ),
              hintText: 'Edit komentar...',
              contentPadding: const EdgeInsets.all(12),
            ),
            onChanged: (value) {
              setState(() {
                comment['editingText'] = value;
              });
            },
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => _cancelEditComment(discussionId, commentIndex),
                child: const Text('Batal'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => _saveEditedComment(discussionId, commentIndex, editController.text),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF216BC2),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Simpan'),
              ),
            ],
          ),
        ],
      );
    } else {
      // Display mode
      return Text(
        comment['content'],
        style: const TextStyle(
          color: Color(0xFF7A757D),
          fontSize: 14,
        ),
      );
    }
  }
}
