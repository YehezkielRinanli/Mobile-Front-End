
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class ProfileHeader extends StatefulWidget {
  final VoidCallback onSettingsTap;

  const ProfileHeader({
    super.key,
    required this.onSettingsTap,
  });

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  String? selectedImage;

  final List<String> availableImages = [
    'assets/images/proflecwe.png',
    'assets/images/proflecwo.png',
  ];

  bool get isDark =>
      Theme.of(context).brightness == Brightness.dark;

  Color get primaryColor => isDark
      ? const Color(0xFFA8C9A5)
      : AppColors.primaryGreen;

  Color get headingColor => isDark
      ? const Color(0xFFF1EFE9)
      : AppColors.darkGreen;

  Color get secondaryTextColor => isDark
      ? const Color(0xFFBEC8BE)
      : Colors.grey.shade700;

  Color get cardColor =>
      isDark ? Theme.of(context).cardColor : AppColors.card;

  Color get avatarBackgroundColor => isDark
      ? const Color(0xFF29382F)
      : AppColors.lightGreen;

  void showImageOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (sheetContext) {
        final sheetIsDark =
            Theme.of(sheetContext).brightness == Brightness.dark;

        final sheetPrimaryColor = sheetIsDark
            ? const Color(0xFFA8C9A5)
            : AppColors.primaryGreen;

        final sheetHeadingColor = sheetIsDark
            ? const Color(0xFFF1EFE9)
            : AppColors.darkGreen;

        final sheetAvatarColor = sheetIsDark
            ? const Color(0xFF29382F)
            : AppColors.lightGreen;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: sheetIsDark
                        ? Colors.grey.shade600
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 20),

                Text(
                  'Pilih Foto Profil',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: sheetHeadingColor,
                  ),
                ),

                const SizedBox(height: 20),

                Wrap(
                  spacing: 20,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: availableImages.map((imagePath) {
                    final isSelected = selectedImage == imagePath;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedImage = imagePath;
                        });

                        Navigator.pop(sheetContext);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? sheetPrimaryColor
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 36,
                              backgroundColor: sheetAvatarColor,
                              backgroundImage: AssetImage(imagePath),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            isSelected ? 'Dipilih' : 'Pilih',
                            style: TextStyle(
                              fontSize: 12,
                              color: sheetPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 16),

                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedImage = null;
                    });

                    Navigator.pop(sheetContext);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: sheetPrimaryColor,
                  ),
                  child: const Text('Gunakan Foto Default'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: showImageOptions,
          child: Stack(
            children: [
              CircleAvatar(
                radius: 36,
                backgroundColor: avatarBackgroundColor,
                backgroundImage: selectedImage != null
                    ? AssetImage(selectedImage!)
                    : null,
                child: selectedImage == null
                    ? Icon(
                        Icons.person,
                        size: 40,
                        color: primaryColor,
                      )
                    : null,
              ),

              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: cardColor,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    size: 14,
                    color: isDark
                        ? AppColors.darkGreen
                        : Colors.white,
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
                'Choi Soobin',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: headingColor,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                'soobinny@gmail.com',
                style: TextStyle(
                  fontSize: 13,
                  color: secondaryTextColor,
                ),
              ),

              const SizedBox(height: 8),

              GestureDetector(
                onTap: showImageOptions,
                child: Text(
                  'Ubah Foto Profil',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),

        IconButton(
          onPressed: widget.onSettingsTap,
          icon: Icon(
            Icons.settings_outlined,
            color: primaryColor,
          ),
          tooltip: 'Pengaturan',
        ),
      ],
    );
  }
}
