import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(const DoctorWhoApp());
}

class DoctorWhoApp extends StatelessWidget {
  const DoctorWhoApp({super.key});

  @override
  Widget build(BuildContext context) {
    const tardisBlue = Color(0xFF0D47A1);
    const bgDark = Color(0xFF020814);

    return MaterialApp(
      title: 'Doctor Who App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bgDark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: tardisBlue,
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0B1020),
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: tardisBlue,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: tardisBlue),
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

//MODELOS

class Doctor {
  final int id;
  final String name;
  final String info;
  final String imageUrl;

  Doctor({
    required this.id,
    required this.name,
    required this.info,
    required this.imageUrl,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    final img = (json['img'] ?? '').toString().trim();
    return Doctor(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: (json['name'] ?? '').toString(),
      info: (json['info'] ?? '').toString(),
      imageUrl: img,
    );
  }
}

class Villain {
  final int id;
  final String name;
  final String info;
  final String imageUrl;

  Villain({
    required this.id,
    required this.name,
    required this.info,
    required this.imageUrl,
  });

  factory Villain.fromJson(Map<String, dynamic> json) {
    final img = (json['img'] ?? '').toString().trim();
    return Villain(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: (json['name'] ?? '').toString(),
      info: (json['info'] ?? '').toString(),
      imageUrl: img,
    );
  }
}

//LENDO JSON DOS ASSETS

Future<List<Doctor>> loadDoctors() async {
  final jsonStr = await rootBundle.loadString('assets/doctors.json');
  final List<dynamic> data = jsonDecode(jsonStr);
  return data.map((e) => Doctor.fromJson(e as Map<String, dynamic>)).toList();
}

Future<List<Villain>> loadVillains() async {
  final jsonStr = await rootBundle.loadString('assets/villains.json');
  final List<dynamic> data = jsonDecode(jsonStr);
  return data.map((e) => Villain.fromJson(e as Map<String, dynamic>)).toList();
}

//TELAS

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _openDoctors(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CharactersGridPageDoctors()),
    );
  }

  void _openVillains(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CharactersGridPageVillains()),
    );
  }

  void _openCredits(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CreditsPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Who App'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // LOGO DA API EM CIMA DO TÍTULO
              SizedBox(
                height: 120,
                width: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/imagens/api_logo.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.black26,
                        child: const Center(
                          child: Icon(
                            Icons.broken_image,
                            size: 40,
                            color: Colors.white54,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Doctor Who APP',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Selecione para ver as encarnações do Doctor,\n'
                'alguns vilões clássicos ou os créditos da API.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _openDoctors(context),
                  child: const Text('Doctors'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _openVillains(context),
                  child: const Text('Vilões'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => _openCredits(context),
                  child: const Text('Créditos da API'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//CARD PADRÃO

class CharacterCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final VoidCallback onTap;

  const CharacterCard({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Card(
        color: const Color(0xFF111827),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: _CharacterImage(imageUrl: imageUrl),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//IMAGEM: PEGA DA PASTA assets/imagens/ + nome do arquivo do JSON

class _CharacterImage extends StatelessWidget {
  final String imageUrl;
  const _CharacterImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return Container(
        color: const Color(0xFF020818),
        child: const Center(
          child: Icon(Icons.person, size: 40, color: Colors.white54),
        ),
      );
    }

    final isNetwork = imageUrl.startsWith('http');

    if (isNetwork) {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: const Color(0xFF020818),
            child: const Center(
              child: Icon(Icons.person_off, size: 40, color: Colors.white54),
            ),
          );
        },
      );
    } else {
      // se vier só "doctor1.jpg", monta o caminho certo
      final path = imageUrl.startsWith('assets/')
          ? imageUrl
          : 'assets/imagens/$imageUrl';

      return Image.asset(
        path,
        fit: BoxFit.cover,
        width: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: const Color(0xFF020818),
            child: const Center(
              child: Icon(Icons.person_off, size: 40, color: Colors.white54),
            ),
          );
        },
      );
    }
  }
}

//GRID DOCTORS

class CharactersGridPageDoctors extends StatelessWidget {
  const CharactersGridPageDoctors({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctors'),
      ),
      body: FutureBuilder<List<Doctor>>(
        future: loadDoctors(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Erro ao carregar Doctors.',
                style: TextStyle(color: Colors.redAccent),
              ),
            );
          }

          final docs = snapshot.data ?? [];

          if (docs.isEmpty) {
            return const Center(
              child: Text('Nenhum Doctor encontrado.'),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final doctor = docs[index];
              return CharacterCard(
                name: doctor.name,
                imageUrl: doctor.imageUrl,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DoctorDetailPage(doctor: doctor),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

//GRID VILÕES

class CharactersGridPageVillains extends StatelessWidget {
  const CharactersGridPageVillains({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vilões'),
      ),
      body: FutureBuilder<List<Villain>>(
        future: loadVillains(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Erro ao carregar vilões.',
                style: TextStyle(color: Colors.redAccent),
              ),
            );
          }

          final vils = snapshot.data ?? [];

          if (vils.isEmpty) {
            return const Center(
              child: Text('Nenhum vilão encontrado.'),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemCount: vils.length,
            itemBuilder: (context, index) {
              final villain = vils[index];
              return CharacterCard(
                name: villain.name,
                imageUrl: villain.imageUrl,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => VillainDetailPage(villain: villain),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

//DETALHE DOCTOR

class DoctorDetailPage extends StatelessWidget {
  final Doctor doctor;

  const DoctorDetailPage({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(doctor.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: _CharacterImage(imageUrl: doctor.imageUrl),
            ),
            const SizedBox(height: 16),
            Text(
              doctor.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              doctor.info,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//DETALHE VILÃO

class VillainDetailPage extends StatelessWidget {
  final Villain villain;

  const VillainDetailPage({super.key, required this.villain});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(villain.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: _CharacterImage(imageUrl: villain.imageUrl),
            ),
            const SizedBox(height: 16),
            Text(
              villain.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              villain.info,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//CRÉDITOS

class CreditsPage extends StatelessWidget {
  const CreditsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Créditos'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              SizedBox(
                height: 120,
                width: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/imagens/api_logo.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.black26,
                        child: const Center(
                          child: Icon(
                            Icons.broken_image,
                            size: 40,
                            color: Colors.white54,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Dados lidos de arquivos JSON baseados na\n'
                'Doctor Who API de PhoenixJaymes:\n\n'
                'https://phoenixjaymes.com/lab/r-doctorwho-api/\n\n'
                'Aplicativo desenvolvido para trabalho escolar,\n'
                'mostrando uma lista de Doctors e vilões\n'
                'em uma interface simples.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
