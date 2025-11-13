import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/app_colors.dart';
import '../../core/localization/app_localizations.dart';
import 'models/catch_post.dart';

class NewCatchScreen extends StatefulWidget {
  const NewCatchScreen({super.key, required this.anglerName});

  final String anglerName;

  @override
  State<NewCatchScreen> createState() => _NewCatchScreenState();
}

class _NewCatchScreenState extends State<NewCatchScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  final TextEditingController _speciesController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  XFile? _imageFile;
  String? _imageError;
  bool _isSaving = false;

  @override
  void dispose() {
    _speciesController.dispose();
    _weightController.dispose();
    _lengthController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final l10n = AppLocalizations.of(context);
    try {
      final picked = await _picker.pickImage(
        source: source,
        maxWidth: 1800,
        imageQuality: 85,
      );
      if (picked != null) {
        setState(() {
          _imageFile = picked;
          _imageError = null;
        });
      }
    } catch (_) {
      setState(() {
        _imageError = l10n.t('addCatch.validation.image');
      });
    }
  }

  Future<void> _showImageSourceSheet(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_camera_outlined, color: AppColors.accent),
                  title: Text(l10n.t('addCatch.takePhoto')),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImage(context, ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library_outlined, color: AppColors.accent),
                  title: Text(l10n.t('addCatch.pickGallery')),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImage(context, ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _submit(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    if (_imageFile == null) {
      setState(() {
        _imageError = l10n.t('addCatch.validation.image');
      });
      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final species = _speciesController.text.trim();
    final location = _locationController.text.trim();
    final description = _descriptionController.text.trim();

    final weightText = _weightController.text.trim().replaceAll(',', '.');
    final lengthText = _lengthController.text.trim().replaceAll(',', '.');

    final weight = weightText.isEmpty ? null : double.tryParse(weightText);
    final length = lengthText.isEmpty ? null : double.tryParse(lengthText);

    final friendlyName = widget.anglerName.isEmpty
        ? l10n.t('home.feed.defaultName')
        : widget.anglerName;

    final newCatch = CatchPost(
      id: 'catch-${DateTime.now().microsecondsSinceEpoch}',
      anglerName: friendlyName,
      location: location,
      avatarInitials: _initialsFromName(friendlyName),
      avatarColor: AppColors.accent,
      catchTitle: species.isEmpty ? l10n.t('addCatch.speciesLabel') : species,
      catchDescription: description,
      imagePath: _imageFile!.path,
      caughtAt: DateTime.now(),
      reactions: {},
      tags: [species, location].where((element) => element.isNotEmpty).toList(),
      species: species,
      weightKg: weight,
      lengthCm: length,
      isAssetImage: false,
    );

    if (!mounted) return;
    Navigator.of(context).pop(newCatch);
  }

  String _initialsFromName(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return 'FF';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts[0].substring(0, 1) + parts[1].substring(0, 1)).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.t('addCatch.title')),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              GestureDetector(
                onTap: () => _showImageSourceSheet(context),
                child: Container(
                  height: 220,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceAlt,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.overlay),
                  ),
                  child: _imageFile == null
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.add_a_photo_outlined, size: 36, color: AppColors.accent),
                              const SizedBox(height: 12),
                              Text(
                                l10n.t('addCatch.chooseImage'),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.file(
                            File(_imageFile!.path),
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                ),
              ),
              if (_imageError != null) ...[
                const SizedBox(height: 8),
                Text(
                  _imageError!,
                  style: const TextStyle(color: Colors.redAccent),
                ),
              ],
              const SizedBox(height: 24),
              TextFormField(
                controller: _speciesController,
                decoration: InputDecoration(labelText: l10n.t('addCatch.speciesLabel')),
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return l10n.t('addCatch.validation.species');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _weightController,
                      decoration: InputDecoration(labelText: l10n.t('addCatch.weightLabel')),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _lengthController,
                      decoration: InputDecoration(labelText: l10n.t('addCatch.lengthLabel')),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: l10n.t('addCatch.locationLabel')),
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return l10n.t('addCatch.validation.location');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: l10n.t('addCatch.descriptionLabel')),
                minLines: 2,
                maxLines: 4,
              ),
              const SizedBox(height: 32),
              FilledButton(
                onPressed: _isSaving ? null : () => _submit(context),
                child: _isSaving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(l10n.t('addCatch.submit')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
