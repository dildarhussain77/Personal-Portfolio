import 'package:flutter/material.dart';
import '../models/certificate_model.dart';

List<Certificate> getCertificates() {
  return [
    Certificate(
      id: '1',
      title: 'Leadership & Generative AI',
      issuer: 'Connected Pakistan',
      issueDate: 'Dec 2025',
      // credentialId: 'FLT-2023-001',
      url: 'https://drive.google.com/file/d/1Ii-xzx3fcEsEzcrtGMdMt1Sw6ZHXX6dB/view?usp=drive_link',
      // color: const Color(0xFF02569B),
      badgePath: 'assets/images/pic3.png',
    ),
    Certificate(
      id: '2',
      title: 'Employability & Professional English',
      issuer: 'U.S. Embassy Pakistan',
      issueDate: 'Feb 2025',
      // credentialId: 'AND-2023-002',
      url: 'https://drive.google.com/file/d/12HGylkZjNKTUYdoxxV5aGI9wCYN7ET0V/view?usp=drive_link',
      // color: const Color(0xFF3DDC84),
      badgePath: 'assets/images/pic3.png',
    ),
    Certificate(
      id: '3',
      title: 'English for Career Development ',
      issuer: 'U.S. Department of State',
      issueDate: 'Dec 2022',
      // credentialId: 'FIR-2022-003',
      url: 'https://drive.google.com/file/d/10ZIXoW_orzDa5a_QbjLh4ToumzoXGUTE/view?usp=drive_link',
      // color: const Color(0xFFFFCA28),
      badgePath: 'assets/images/pic3.png',
    ),
    Certificate(
      id: '4',
      title: 'Flutter for Beginners',
      issuer: 'Great Learning Academy ',
      issueDate: 'August 2024',
      // credentialId: 'GIT-2022-004',
      url: 'https://drive.google.com/file/d/1fg2nnWyJ-Obj88MpDY4WdMQ7GYGdZpjf/view?usp=drive_link',
       // color: const Color(0xFFF1502F),
      badgePath: 'assets/images/pic3.png',
    ),
    Certificate(
      id: '5',
      title: 'Introduction to Flutter',
      issuer: 'Simplilearn',
      issueDate: 'July 2024',
      // credentialId: 'GIT-2022-004',
      url: 'https://drive.google.com/file/d/1v7eWDp-WSOp-UtvqjXpRsnE8tZGd0A9Z/view?usp=drive_link',
      // color: const Color(0xFFF1502F),
      badgePath: 'assets/images/pic3.png',
    ),
  ];
}