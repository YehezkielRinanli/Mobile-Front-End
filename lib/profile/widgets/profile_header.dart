import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import 'profile_colors.dart';

// StatefulWidget dipakai karena panel pilihan foto harus bisa
// dibuka dan ditutup.
class ProfileHeader extends StatefulWidget {
  final VoidCallback onProfileTap;
  final VoidCallback onSettingsTap;

  const ProfileHeader({
    super.key,
    required this.onProfileTap,
    required this.onSettingsTap,
  });

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
    bool _showPicker = false;
  
  final List<String> availableImages = [
    'assets/images/proflecwe.png',
    'assets/images/proflecwo.png',
  ];

    void _togglePicker() => setState(() => _showPicker = !_showPicker);

  void _selectImage(String? path) {
    setState(() {
      ProfileData.avatar = path;
      _showPicker = false;
    });
  }
  
  // [M06] GridView.builder: pilihan foto dibuat dari list.
  Widget _buildPicker(PColors c) {
    final columns = availableImages.length > 4 ? 4 : availableImages.length;

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          Divider(color: c.border),
          const SizedBox(height: 8),
          Text(
            'Pilih Foto Profil',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: c.heading,
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 130.0 * columns),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: availableImages.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  mainAxisExtent: 112,
                ),
                itemBuilder: (context, index) {
                  final imagePath = availableImages[index];
                  final isSelected = ProfileData.avatar == imagePath;

                  // ===== M09 (User Interaction) - MULAI =====
                  return GestureDetector(
                    onTap: () => _selectImage(imagePath),
                    // ===== M09 - SELESAI =====
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? c.primary
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 36,
                            backgroundColor: c.soft,
                            backgroundImage: AssetImage(imagePath),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          isSelected ? 'Dipilih' : 'Pilih',
                          style: TextStyle(fontSize: 12, color: c.primary),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          // ===== M09 (User Interaction) - MULAI =====
          GestureDetector(
            onTap: () => _selectImage(null),
            // ===== M09 - SELESAI =====
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'Gunakan Foto Default',
                style: TextStyle(
                  color: c.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = PColors.of(context);

    // [M07] MediaQuery: avatar dikecilkan pada layar sangat sempit.
    final screenWidth = MediaQuery.sizeOf(context).width;
    final avatarRadius = screenWidth < 360 ? 30.0 : 36.0;
    final profile = ProfileData.profile;
    final selectedImage = ProfileData.avatar;

    final linkStyle = TextStyle(
      color: c.primary,
      fontWeight: FontWeight.w600,
      fontSize: 12,
    );

    // [M06] Row + Stack (kamera di atas avatar) + Expanded (teks).
    return Column(
      children: [
        Row(
          children: [
            // ===== M09 (User Interaction) - MULAI =====
            GestureDetector(
              onTap: _togglePicker,
              // ===== M09 - SELESAI =====
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: avatarRadius,
                    backgroundColor: c.soft,
                    backgroundImage: selectedImage != null
                        ? AssetImage(selectedImage)
                        : null,
                    child: selectedImage == null
                        ? Icon(Icons.person, size: 40, color: c.primary)
                        : null,
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: c.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: c.card, width: 2),
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        size: 14,
                        color: c.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile.username,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: c.heading,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    profile.email,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13, color: c.secondary),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 14,
                    runSpacing: 4,
                    children: [
                      // ===== M09 (User Interaction) - MULAI =====
                      GestureDetector(
                        onTap: _togglePicker,
                        // ===== M09 - SELESAI =====
                        child: Text('Ubah Foto Profil', style: linkStyle),
                      ),
                      // ===== M09 (Navigation) - MULAI =====
                      GestureDetector(
                        onTap: widget.onProfileTap,
                        // ===== M09 - SELESAI =====
                        child: Text('Lihat Profil', style: linkStyle),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // ===== M09 (Navigation) - MULAI =====
            GestureDetector(
              onTap: widget.onSettingsTap,
              // ===== M09 - SELESAI =====
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Icon(Icons.settings_outlined, color: c.primary),
              ),
            ),
          ],
        ),
        if (_showPicker) _buildPicker(c),
      ],
    );
  }
}
