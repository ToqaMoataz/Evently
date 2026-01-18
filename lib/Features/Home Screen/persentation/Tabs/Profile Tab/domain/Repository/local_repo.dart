import 'dart:io';

abstract class ProfileLocalRepo{
  Future<File?> pickUserImage();
}