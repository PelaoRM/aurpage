import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
// Removed Google Fonts to avoid network fetch in restricted environments
import 'package:flutter/gestures.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aurora Software — Soluciones',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.slate),
        useMaterial3: true,
      ),
      scrollBehavior: AppScrollBehavior(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();

  // Keys para navegar por secciones
  final _keyInicio = GlobalKey();
  final _keyServicios = GlobalKey();
  final _keySobre = GlobalKey();
  final _keyContacto = GlobalKey();
  final _keyMedLog = GlobalKey();
  final _keyApps = GlobalKey();
  final _keyAppUsc = GlobalKey();
  final _keyAppMalvi = GlobalKey();
  final _keyAppUscl = GlobalKey();
  final _keyAppPhoto = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignment: 0,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width >= 900;
    final isVeryWide = width >= 1100;

    return Scaffold(
      drawer: isVeryWide
          ? null
          : Drawer(
              child: SafeArea(
                child: ListView(
                  children: [
                    _DrawerItem(
                      label: 'Inicio',
                      onTap: () {
                        Navigator.pop(context);
                        _scrollTo(_keyInicio);
                      },
                    ),
                    _DrawerItem(
                      label: 'Servicios',
                      onTap: () {
                        Navigator.pop(context);
                        _scrollTo(_keyServicios);
                      },
                    ),
                    _DrawerItem(
                      label: 'Sobre',
                      onTap: () {
                        Navigator.pop(context);
                        _scrollTo(_keySobre);
                      },
                    ),
                    _DrawerItem(
                      label: 'MedLog:',
                      style: const TextStyle(
                        fontFamily: 'AmericanTypewriter',
                        fontWeight: FontWeight.w600,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        _scrollTo(_keyMedLog);
                      },
                    ),
                    _DrawerItem(
                      label: 'USC y algo más',
                      onTap: () {
                        Navigator.pop(context);
                        _scrollTo(_keyAppUsc);
                      },
                    ),
                    _DrawerItem(
                      label: 'MalviFitness',
                      onTap: () {
                        Navigator.pop(context);
                        _scrollTo(_keyAppMalvi);
                      },
                    ),
                    _DrawerItem(
                      label: 'USCL Book App',
                      onTap: () {
                        Navigator.pop(context);
                        _scrollTo(_keyAppUscl);
                      },
                    ),
                    _DrawerItem(
                      label: 'PhotoCash',
                      onTap: () {
                        Navigator.pop(context);
                        _scrollTo(_keyAppPhoto);
                      },
                    ),
                    _DrawerItem(
                      label: 'Contacto',
                      onTap: () {
                        Navigator.pop(context);
                        _scrollTo(_keyContacto);
                      },
                    ),
                  ],
                ),
              ),
            ),
      appBar: AppBar(
        leadingWidth: isVeryWide ? 180 : null,
        leading: isVeryWide
            ? const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: 160,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: _Brand(),
                    ),
                  ),
                ),
              )
            : null,
        centerTitle: true,
        title: isVeryWide
            ? null
            : const FittedBox(
                fit: BoxFit.scaleDown,
                child: _Brand(),
              ),
        scrolledUnderElevation: 0,
        actions: isVeryWide
            ? [
                _NavButton(text: 'Inicio', onTap: () => _scrollTo(_keyInicio)),
                _NavButton(
                    text: 'Servicios', onTap: () => _scrollTo(_keyServicios)),
                _NavButton(text: 'Sobre', onTap: () => _scrollTo(_keySobre)),
                _NavButton(
                  text: 'MedLog:',
                  onTap: () => _scrollTo(_keyMedLog),
                  style: const TextStyle(
                    fontFamily: 'AmericanTypewriter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                _NavButton(
                  text: 'USC y algo más',
                  onTap: () => _scrollTo(_keyAppUsc),
                ),
                _NavButton(
                  text: 'MalviFitness',
                  onTap: () => _scrollTo(_keyAppMalvi),
                ),
                _NavButton(
                  text: 'USCL Book App',
                  onTap: () => _scrollTo(_keyAppUscl),
                ),
                _NavButton(
                  text: 'PhotoCash',
                  onTap: () => _scrollTo(_keyAppPhoto),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: FilledButton(
                    onPressed: () => _scrollTo(_keyContacto),
                    child: const Text('Contacto'),
                  ),
                ),
                const SizedBox(width: 8),
              ]
            : null,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const ClampingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Inicio / Hero
            _Section(
              key: _keyInicio,
              color: _heroBg(context),
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
              child: _HeroSection(onCta: () => _scrollTo(_keyContacto)),
            ),

            // Servicios
            _Section(
              key: _keyServicios,
              padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
              backgroundImage: const DecorationImage(
                image: AssetImage('assets/servicios_bg.png'),
                fit: BoxFit.cover,
              ),
              child: const _ServicesSection(),
            ),

            // Sobre
            _Section(
              key: _keySobre,
              color: Theme.of(context).colorScheme.surfaceContainer,
              padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
              child: const _AboutSection(),
            ),

            // MedLog
            _Section(
              key: _keyMedLog,
              padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
              child: const _MedLogSection(),
            ),

            _Section(
              key: _keyApps,
              padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
              color: Color.alphaBlend(
                AppColors.lavender.withOpacity(0.14),
                Theme.of(context).colorScheme.surface,
              ),
              child: _AppsShowcaseSection(
                uscKey: _keyAppUsc,
                malviKey: _keyAppMalvi,
                usclKey: _keyAppUscl,
                photoKey: _keyAppPhoto,
              ),
            ),

            // Contacto
            _Section(
              key: _keyContacto,
              color: Color.alphaBlend(
                AppColors.aqua.withOpacity(0.18),
                Theme.of(context).colorScheme.surface,
              ),
              padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
              child: const _ContactSection(),
            ),

            const _Footer(),
          ],
        ),
      ),
    );
  }

  Color _heroBg(BuildContext context) {
    // Fondo suave para toda la sección (no el rectángulo de la imagen)
    final scheme = Theme.of(context).colorScheme;
    return Color.alphaBlend(scheme.primary.withOpacity(0.06), scheme.surface);
  }
}

class _Brand extends StatelessWidget {
  const _Brand();

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const _AuroraGlyph(),
        const SizedBox(width: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('AURORA',
                style: TextStyle(
                  color: onSurface,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2.0,
                  fontSize: 16,
                )),
            Text('software',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1.0,
                  fontSize: 11,
                )),
          ],
        ),
      ],
    );
  }
}

class _AuroraGlyph extends StatelessWidget {
  const _AuroraGlyph();

  @override
  Widget build(BuildContext context) {
    // Cinco barras con alturas y colores pastel inspirados en la imagen
    const heights = [18.0, 26.0, 38.0, 26.0, 18.0];
    const colors = [
      AppColors.lavender,
      AppColors.aqua,
      AppColors.mint,
      AppColors.sand,
      AppColors.peach,
    ];
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(5, (i) {
          final h = heights[i];
          final c = colors[i];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Container(
              width: 8,
              height: h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [c.withOpacity(0.95), c.withOpacity(0.6)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final TextStyle? style;
  const _NavButton({required this.text, required this.onTap, this.style});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(text, style: style),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final TextStyle? style;
  const _DrawerItem({required this.label, required this.onTap, this.style});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label, style: style),
      onTap: onTap,
    );
  }
}

class _Section extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final DecorationImage? backgroundImage;

  const _Section({super.key, required this.child, this.padding = const EdgeInsets.all(24), this.color, this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    final content = Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1100),
        child: child,
      ),
    );
    final hasDecoration = backgroundImage != null || color != null;
    if (hasDecoration) {
      return Container(
        decoration: BoxDecoration(color: color, image: backgroundImage),
        padding: padding,
        child: content,
      );
    }
    return Padding(padding: padding, child: content);
  }
}

class _HeroSection extends StatelessWidget {
  final VoidCallback onCta;
  const _HeroSection({required this.onCta});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 900;
    final scheme = Theme.of(context).colorScheme;
    if (isWide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'software minimalista que impulsa tu actividad',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        height: 1.1,
                      ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Aurora Software: desarrollo web y móvil con IA, Flutter y Dart. Rápido, moderno y escalable.',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    FilledButton.icon(
                      onPressed: onCta,
                      icon: const Icon(Icons.mail_outline_rounded),
                      label: const Text('Hablemos'),
                    ),
                    OutlinedButton.icon(
                      onPressed: onCta,
                      icon: const Icon(Icons.description_outlined),
                      label: const Text('Solicitar propuesta'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            flex: 4,
            child: _CardSurface(
              bgColor: const Color(0x6637474F),
              child: Container(
                height: 320,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/herobackgroun.png'),
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                    opacity: 0.9,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'software minimalista que impulsa tu actividad',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  height: 1.1,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'Aurora Software: desarrollo web y móvil con IA, Flutter y Dart. Rápido, moderno y escalable.',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              FilledButton.icon(
                onPressed: onCta,
                icon: const Icon(Icons.mail_outline_rounded),
                label: const Text('Hablemos'),
              ),
              OutlinedButton.icon(
                onPressed: onCta,
                icon: const Icon(Icons.description_outlined),
                label: const Text('Solicitar propuesta'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _CardSurface(
            bgColor: const Color(0x6637474F),
            child: Container(
              height: 220,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/herobackgroun.png'),
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                  opacity: 0.9,
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
}

class _ServicesSection extends StatelessWidget {
  const _ServicesSection();

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 900;
    final cards = <Widget>[
      const _ServiceCard(
        icon: Icons.web_rounded,
        title: 'Sitios y Web Apps',
        desc: 'Landing pages, paneles administrativos y apps progresivas (PWA).',
        transparent: true,
      ),
      const _ServiceCard(
        icon: Icons.phone_android_rounded,
        title: 'Apps móviles',
        desc: 'Publicación en iOS y Android con una base de código.',
        transparent: true,
      ),
      const _ServiceCard(
        icon: Icons.integration_instructions_rounded,
        title: 'Integraciones',
        desc: 'APIs, autenticación, pagos y automatizaciones a medida.',
        transparent: true,
      ),
    ];

    final Widget cardsLayout;
    if (isWide) {
      cardsLayout = GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
        children: cards,
      );
    } else {
      cardsLayout = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < cards.length; i++) ...[
            cards[i],
            if (i != cards.length - 1) const SizedBox(height: 16),
          ],
        ],
      );
    }

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Servicios',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800, color: Colors.white),
        ),
        const SizedBox(height: 16),
        Text(
          'Soluciones completas para tu producto digital.',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white70),
        ),
        const SizedBox(height: 24),
        cardsLayout,
      ],
    );
    return content;
  }
}

class _ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;
  final bool transparent;
  const _ServiceCard({required this.icon, required this.title, required this.desc, this.transparent = false});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final Color titleColor = transparent ? Colors.white : scheme.onSurface;
    final Color descColor = transparent ? Colors.white70 : scheme.onSurfaceVariant;
    final Color iconColor = transparent ? Colors.white : AppColors.aqua;
    return _CardSurface(
      bgColor: transparent ? Colors.transparent : null,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 40, color: iconColor),
            const SizedBox(height: 12),
            Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: titleColor)),
            const SizedBox(height: 8),
            Text(desc, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: descColor)),
          ],
        ),
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  const _AboutSection();

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 900;
    final scheme = Theme.of(context).colorScheme;
    if (isWide) {
      return Row(
        children: [
          const Expanded(
            flex: 4,
            child: _AboutText(),
          ),
          const SizedBox(width: 24),
          Expanded(
            flex: 5,
            child: _CardSurface(
              bgColor: AppColors.aqua.withOpacity(0.18),
              child: SizedBox(
                height: 220,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Center(
                    child: Wrap(
                      spacing: 24,
                      runSpacing: 24,
                      alignment: WrapAlignment.center,
                      children: [
                        SvgPicture.asset('assets/logos/android.svg', height: 48),
                        SvgPicture.asset('assets/logos/apple.svg', height: 48),
                        SvgPicture.asset('assets/logos/appstore.svg', height: 48),
                        SvgPicture.asset('assets/logos/firefox.svg', height: 48),
                        SvgPicture.asset('assets/logos/flutter.svg', height: 48),
                        SvgPicture.asset('assets/logos/github.svg', height: 48),
                        SvgPicture.asset('assets/logos/githubcopilot.svg', height: 48),
                        SvgPicture.asset('assets/logos/googlechrome.svg', height: 48),
                        SvgPicture.asset('assets/logos/googlecloud.svg', height: 48),
                        SvgPicture.asset('assets/logos/googlegemini.svg', height: 48),
                        SvgPicture.asset('assets/logos/googleplay.svg', height: 48),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/logos/openai.svg', height: 48),
                            const SizedBox(width: 24),
                            const Text(
                              'MedLog:',
                              style: TextStyle(
                                fontFamily: 'AmericanTypewriter',
                                fontSize: 32,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _AboutText(),
          const SizedBox(height: 24),
          _CardSurface(
            bgColor: AppColors.aqua.withOpacity(0.18),
            child: SizedBox(
              height: 220,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Center(
                  child: Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    alignment: WrapAlignment.center,
                    children: [
                      SvgPicture.asset('assets/logos/android.svg', height: 40),
                      SvgPicture.asset('assets/logos/apple.svg', height: 40),
                      SvgPicture.asset('assets/logos/appstore.svg', height: 40),
                      SvgPicture.asset('assets/logos/firefox.svg', height: 40),
                      SvgPicture.asset('assets/logos/flutter.svg', height: 40),
                      SvgPicture.asset('assets/logos/github.svg', height: 40),
                      SvgPicture.asset('assets/logos/githubcopilot.svg', height: 40),
                      SvgPicture.asset('assets/logos/googlechrome.svg', height: 40),
                      SvgPicture.asset('assets/logos/googlecloud.svg', height: 40),
                      SvgPicture.asset('assets/logos/googlegemini.svg', height: 40),
                      SvgPicture.asset('assets/logos/googleplay.svg', height: 40),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/logos/openai.svg', height: 40),
                          const SizedBox(width: 8),
                          const Text(
                            'MedLog:',
                            style: TextStyle(
                              fontFamily: 'AmericanTypewriter',
                              fontSize: 28,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
}

class _AboutText extends StatelessWidget {
  const _AboutText();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Sobre nosotros', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 16),
        Text(
          'Creamos productos digitales utilizando IA, Flutter y las tecnologías más modernas para construir apps compiladas nativamente para móvil, web y escritorio desde una sola base de código.',
          style: textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        Text(
          'Nuestra misión es ayudar a las empresas a transformar sus ideas en soluciones digitales efectivas y de alto rendimiento.',
          style: textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const [
            Chip(avatar: Icon(Icons.shield_outlined), label: Text('Seguridad y mantenimiento')),
            Chip(avatar: Icon(Icons.bolt_rounded), label: Text('Tiempos de carga <100ms')),
            Chip(avatar: Icon(Icons.devices_rounded), label: Text('Web, móvil y escritorio')),
            Chip(avatar: Icon(Icons.tune_rounded), label: Text('Hecho a la medida')),
          ],
        )
      ],
    );
  }
}

class _ContactSection extends StatefulWidget {
  const _ContactSection();

  @override
  State<_ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<_ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _msgCtrl = TextEditingController();
  bool _isSending = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _msgCtrl.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() => _isSending = true);

    // IMPORTANTE: Reemplaza esta URL con la URL de tu endpoint de Formspree o similar.
    final url = Uri.parse('https://formspree.io/f/mkgqedvn');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': _nameCtrl.text,
          'email': _emailCtrl.text,
          'message': _msgCtrl.text,
        }),
      );

      if (response.statusCode == 200) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Gracias, te contactaremos pronto.')),
          );
        }
        _nameCtrl.clear();
        _emailCtrl.clear();
        _msgCtrl.clear();
      } else {
        // Imprime los detalles de la respuesta para depuración
        debugPrint('Fallo al enviar el mensaje. Código de estado: ${response.statusCode}');
        debugPrint('Cuerpo de la respuesta: ${response.body}');
        throw Exception('Error al enviar el mensaje.');
      }
    } catch (e) {
      // Imprime el error en la consola de depuración
      debugPrint('Error al enviar el mensaje: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text('Error: No se pudo enviar el mensaje. Intenta de nuevo.')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSending = false);
      }
    }
  }

  Future<void> _launchUri(Uri uri) async {
    try {
      final ok = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
        webOnlyWindowName: '_blank',
      );
      if (!ok && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo abrir el enlace')),
        );
      }
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo abrir el enlace')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 900;

    // Reusable cards to avoid duplicating both layouts
    final formCard = _CardSurface(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Ingresa tu nombre' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Ingresa tu email';
                  final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+').hasMatch(v.trim());
                  return ok ? null : 'Email inválido';
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _msgCtrl,
                minLines: 4,
                maxLines: 6,
                decoration: const InputDecoration(labelText: 'Mensaje'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Escribe un mensaje' : null,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  FilledButton.icon(
                    onPressed: _isSending ? null : _sendMessage,
                    icon: _isSending
                        ? const SizedBox.square(
                            dimension: 18,
                            child: CircularProgressIndicator(strokeWidth: 2))
                        : const Icon(Icons.send_rounded),
                    label: Text(_isSending ? 'Enviando...' : 'Enviar mensaje'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    final infoCard = _CardSurface(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ContactInfoItem(
              icon: Icons.email_outlined,
              color: Colors.amber,
              text: 'friquel@aurisoftware.com',
              onTap: () => _launchUri(Uri.parse('mailto:friquel@aurisoftware.com')),
            ),
            _ContactInfoItem(
              icon: Icons.chat_bubble_outline_rounded,
              color: Colors.green,
              text: 'WhatsApp: +56 9 8294 6019',
              onTap: () => _launchUri(Uri.parse('https://wa.me/56982946019?text=Hola%20Aurora%20Software%21')),
            ),
            _ContactInfoItem(
              icon: Icons.location_on_outlined,
              color: Colors.red,
              text: 'Providencia, Santiago, Chile',
              onTap: () => _launchUri(Uri.parse('https://www.google.com/maps/search/?api=1&query=Providencia%2C%20Santiago%2C%20Chile')),
            ),
            const _ContactInfoItem(
              icon: Icons.public_rounded,
              color: Colors.blue,
              text: 'Contacto remoto / LATAM',
            ),
          ],
        ),
      ),
    );

    // Title + responsive layout
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Contacto', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 16),
        Text('Cuéntanos sobre tu proyecto y te contactamos a la brevedad.',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
        const SizedBox(height: 24),
        if (isWide)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 5, child: formCard),
              const SizedBox(width: 24),
              Expanded(flex: 4, child: infoCard),
            ],
          )
        else
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              formCard,
              const SizedBox(height: 24),
              infoCard,
            ],
          ),
      ],
    );
  }
}

class _CardSurface extends StatelessWidget {
  final Widget child;
  final Color? bgColor;
  const _CardSurface({required this.child, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      color: bgColor ?? Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: child,
    );
  }
}

// _LogoSpacer removed; logos in "Sobre nosotros" restored to original Wrap layout

class _ContactTextItem extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  const _ContactTextItem({required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    final child = Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(text),
    );

    if (onTap == null) return child;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: child,
    );
  }
}

class _ContactInfoItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;
  final Color? color;
  const _ContactInfoItem({required this.icon, required this.text, this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    final row = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 36,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Icon(icon, size: 28, color: color),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(text)),
      ],
    );

    if (onTap == null) return Padding(padding: const EdgeInsets.symmetric(vertical: 6), child: row);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: row,
      ),
    );
  }
}

// Removed WhatsApp icon usage in contact section to keep text-only lines

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    final year = DateTime.now().year;
    final scheme = Theme.of(context).colorScheme;
    return Container(
      color: scheme.surfaceContainer,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final copyright = Text(
                '© $year Aurora Software — Todos los derechos reservados',
                textAlign: constraints.maxWidth < 600 ? TextAlign.center : TextAlign.right,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: scheme.onSurfaceVariant),
              );

              if (constraints.maxWidth < 600) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const _Brand(),
                    const SizedBox(height: 16),
                    copyright,
                  ],
                );
              }

              return Row(
                children: [
                  const _Brand(),
                  const Spacer(),
                  Flexible(child: copyright),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

// Paleta Aurora inspirada en la imagen de referencia
class AppColors {
  static const lavender = Color(0xFFDAD8FF); // lila suave
  static const aqua = Color(0xFFBFEAF6); // celeste
  static const mint = Color(0xFFAEE6D2); // menta
  static const sand = Color(0xFFF6E6A8); // arena/amarillo pálido
  static const peach = Color(0xFFF8C7B5); // durazno
  static const slate = Color(0xFF607D8B); // gris azuloso (Blue Grey 500)
}

// Habilita scroll con mouse, trackpad y táctil en web/desktop
class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => const {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.stylus,
        PointerDeviceKind.unknown,
      };
}

class MedLogPage extends StatelessWidget {
  const MedLogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Uri webUrl = Uri.parse('https://medlogapp.com');
    final Uri androidUrl = Uri.parse('https://play.google.com/store/apps/details?id=com.example.medlog'); // TODO
    final Uri iosUrl = Uri.parse('https://apps.apple.com/app/id0000000000'); // TODO

    Future<void> open(Uri uri) async {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
        webOnlyWindowName: '_blank',
      );
    }

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 160,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Tooltip(
            message: 'Volver al inicio',
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                borderRadius: BorderRadius.circular(8),
                child: const FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: _Brand(),
                ),
              ),
            ),
          ),
        ),
        title: null,
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Center(
              child: Text(
                'MedLog:',
                style: TextStyle(
                  fontFamily: 'AmericanTypewriter',
                  fontWeight: FontWeight.w600,
                  fontSize:
                      (Theme.of(context).textTheme.titleLarge?.fontSize ?? 20) * 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background image spanning the whole page
          Positioned.fill(
            child: Image.asset(
              'assets/medlog/d9fd5bcb-32a2-4407-87c7-cac3757da365.png',
              fit: BoxFit.cover,
              alignment: Alignment.center,
              errorBuilder: (context, error, stack) => Container(
                color: Colors.black12,
                alignment: Alignment.center,
                child: Text(
                  'No se pudo cargar la imagen de fondo',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.black54),
                ),
              ),
            ),
          ),
          // Content overlay (shifted upward to match sky area)
          Align(
            alignment: const Alignment(0, -0.5),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  Text(
                    'MedLog',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontFamily: 'AmericanTypewriter',
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'MedLog es una aplicación para registrar pacientes y procedimientos médicos, '
                    'entregar feedback a alumnos de medicina (pregrado y postgrado), y para organizarse '
                    'creando comunidad clínica y académica.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () => open(webUrl),
                    icon: const Icon(Icons.open_in_new_rounded),
                    label: const Text('Abrir aplicación'),
                  ),
                  const SizedBox(height: 24),
                  Text('Disponible en:', style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 44,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      children: [
                        InkWell(
                          onTap: () => open(webUrl),
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: SvgPicture.asset('assets/logos/googlechrome.svg', height: 32),
                          ),
                        ),
                        const SizedBox(width: 20),
                        InkWell(
                          onTap: () => open(androidUrl),
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: SvgPicture.asset('assets/logos/android.svg', height: 32),
                          ),
                        ),
                        const SizedBox(width: 20),
                        InkWell(
                          onTap: () => open(iosUrl),
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: SvgPicture.asset('assets/logos/apple.svg', height: 32),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 16,
                        runSpacing: 12,
                        children: [
                          _StoreBadge(
                            asset: 'assets/logos/googleplay.svg',
                            onTap: () => open(androidUrl),
                            height: 44,
                          ),
                          _StoreBadge(
                            asset: 'assets/logos/appstore.svg',
                            onTap: () => open(iosUrl),
                            height: 44,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StoreBadge extends StatelessWidget {
  final String asset;
  final VoidCallback onTap;
  final double height;
  const _StoreBadge({required this.asset, required this.onTap, this.height = 44});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SvgPicture.asset(asset, height: height),
        ),
      ),
    );
  }
}

class _AppsShowcaseSection extends StatelessWidget {
  final GlobalKey uscKey;
  final GlobalKey malviKey;
  final GlobalKey usclKey;
  final GlobalKey photoKey;

  const _AppsShowcaseSection({
    required this.uscKey,
    required this.malviKey,
    required this.usclKey,
    required this.photoKey,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final features = [
      _AppFeatureData(
        title: 'USC y algo más',
        description: 'Aplicación para los amantes del ultrasonido clínico.',
        highlights: const [
          'Aprendizaje guiado por expertos.',
          'Repositorio de material original.',
          'Feedback directo de urgenciólogos especialistas en USC.',
          'Y mucho más para seguir creciendo en comunidad.',
        ],
        icon: Icons.monitor_heart_rounded,
        accentColor: AppColors.aqua,
        assetImage: 'assets/USC.png',
        sectionKey: uscKey,
      ),
      _AppFeatureData(
        title: 'MalviFitness',
        description:
            '¿Quieres estar en forma pero no sabes cómo empezar o tienes una vida ajetreada? Creamos un plan fitness hecho a tu medida, con material exclusivo y rutinas pensadas para ti.',
        highlights: const [
          'Consejería personalizada de deporte y estilo de vida.',
          'Rutinas y contenido exclusivos para cada objetivo.',
          'Consultas con personal trainers, nutriólogos, kinesiólogos y médicos.',
        ],
        icon: Icons.fitness_center_rounded,
        accentColor: AppColors.peach,
        assetImage: 'assets/malvi.png',
        textBackgroundColor: AppColors.peach.withOpacity(0.55),
        sectionKey: malviKey,
      ),
      _AppFeatureData(
        title: 'USCL Book App',
        description:
            'Libro de ultrasonido clínico convertido en experiencia interactiva con imágenes, videos y rutas guiadas. Pensado para reforzar lo básico y dominar escenarios avanzados directamente desde tu dispositivo, con nuevas cápsulas clínicas y retos semanales que mantienen el aprendizaje activo.',
        highlights: const [
          'Posibilidad de recibir feedback on spot por expertos en ultrasonido clínico para ajustar cada sesión.',
          'Ecocardiografía básica y avanzada explicada paso a paso con ejemplos visuales.',
          'Protocolos de ultrasonido en PCR (USC en paro cardiorrespiratorio) para decisiones inmediatas.',
          'Cobertura de procedimientos guiados por USC con listas de verificación listas para usar.',
          'Módulos dedicados a USC pulmonar para reconocer patrones respiratorios críticos.',
          'Algoritmos prácticos para evaluar al paciente en shock utilizando ultrasonido en el punto de atención.',
          'Galerías multimedia con casos clínicos comentados, imágenes clave, clips de práctica y quizzes rápidos.',
          'Secciones comparativas para correlacionar hallazgos entre pacientes y patologías frecuentes.',
        ],
        icon: Icons.menu_book_rounded,
        accentColor: AppColors.lavender,
        assetImage: 'assets/book.png',
        imageAlignment: const Alignment(0, 0.6),
        textBackgroundColor: Color(0xFFDAD8FF),
        sectionKey: usclKey,
      ),
      _AppFeatureData(
        title: 'PhotoCash',
        description:
            'App para quienes aman la fotografía: camina por la ciudad, captura momentos georreferenciados y descubre lo que otros ven en el mismo lugar.',
        highlights: const [
          'Explora fotografías de la comunidad en cada punto del mapa.',
          'Comparte tus capturas y crea nuevas historias en cada recorrido.',
          'Juega a atrapar fotos sin necesidad de ser profesional. ¡PhotoCash them all!',
        ],
        icon: Icons.camera_alt_rounded,
        accentColor: AppColors.sand,
        assetImage: 'assets/photocash.png',
        sectionKey: photoKey,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Más soluciones digitales',
          style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 16),
        Text(
          'Proyectos creados junto a especialistas para llevar nuevas experiencias a cada disciplina.',
          style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
        ),
        const SizedBox(height: 40),
        for (var i = 0; i < features.length; i++) ...[
          _AppFeatureBlock(
            data: features[i],
            mediaOnLeft: i.isEven,
            sectionKey: features[i].sectionKey,
          ),
          if (i != features.length - 1) const SizedBox(height: 48),
        ],
      ],
    );
  }
}

class _AppFeatureData {
  final String title;
  final String description;
  final List<String> highlights;
  final IconData icon;
  final Color accentColor;
  final String? assetImage;
  final Color? textBackgroundColor;
  final AlignmentGeometry? imageAlignment;
  final Key? sectionKey;

  const _AppFeatureData({
    required this.title,
    required this.description,
    required this.highlights,
    required this.icon,
    required this.accentColor,
    this.assetImage,
    this.textBackgroundColor,
    this.imageAlignment,
    this.sectionKey,
  });
}

class _AppFeatureBlock extends StatelessWidget {
  final _AppFeatureData data;
  final bool mediaOnLeft;
  final Key? sectionKey;

  const _AppFeatureBlock({required this.data, required this.mediaOnLeft, this.sectionKey});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 900;

    Widget content;
    if (isWide) {
      final media = _FeatureMedia(data: data, expandVertically: true);
      final description = _FeatureDescription(data: data);

      content = IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (mediaOnLeft)
              Expanded(
                flex: 3,
                child: media,
              ),
            if (mediaOnLeft) const SizedBox(width: 36),
            Expanded(
              flex: 4,
              child: description,
            ),
            if (!mediaOnLeft) const SizedBox(width: 36),
            if (!mediaOnLeft)
              Expanded(
                flex: 3,
                child: media,
              ),
          ],
        ),
      );
    } else {
      final media = _FeatureMedia(data: data, expandVertically: false);
      final description = _FeatureDescription(data: data);

      content = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (mediaOnLeft) media else description,
          const SizedBox(height: 24),
          if (mediaOnLeft) description else media,
        ],
      );
    }

    return KeyedSubtree(
      key: sectionKey,
      child: content,
    );
  }
}

class _FeatureMedia extends StatelessWidget {
  final _AppFeatureData data;
  final bool expandVertically;

  const _FeatureMedia({required this.data, required this.expandVertically});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(24);

    Widget mediaContent;
    if (data.assetImage != null) {
      mediaContent = Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            data.assetImage!,
            fit: BoxFit.cover,
            alignment: data.imageAlignment ?? Alignment.center,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.35),
                  Colors.black.withOpacity(0.1),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
        ],
      );
    } else {
      mediaContent = Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              data.accentColor.withOpacity(0.9),
              data.accentColor.withOpacity(0.45),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Icon(
            data.icon,
            size: 96,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      );
    }

    if (expandVertically) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: mediaContent,
      );
    }

    return ClipRRect(
      borderRadius: borderRadius,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: mediaContent,
      ),
    );
  }
}

class _FeatureDescription extends StatelessWidget {
  final _AppFeatureData data;

  const _FeatureDescription({required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final background = data.textBackgroundColor ??
        Color.alphaBlend(data.accentColor.withOpacity(0.18), theme.colorScheme.surface);

    return _CardSurface(
      bgColor: background,
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(data.icon, size: 36, color: data.accentColor),
            const SizedBox(height: 12),
            Text(
              data.title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontFamily: 'AmericanTypewriter',
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              data.description,
              style: theme.textTheme.bodyMedium,
            ),
            if (data.highlights.isNotEmpty) ...[
              const SizedBox(height: 16),
              for (final item in data.highlights) _BulletText(text: item, color: data.accentColor),
            ],
          ],
        ),
      ),
    );
  }
}

class _BulletText extends StatelessWidget {
  final String text;
  final Color color;

  const _BulletText({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class _MedLogSection extends StatelessWidget {
  const _MedLogSection();

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 900;
    if (isWide) {
      return Row(
        children: [
          Expanded(
            flex: 4,
            child: _CardSurface(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset(
                  'assets/medlog/medlog.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stack) => Center(
                    child: Text(
                      'No se encontró assets/medlog/medlog.png',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.mint.withOpacity(0.25),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MedLog',
                    style: const TextStyle(
                      fontFamily: 'AmericanTypewriter',
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'App medica que soluciona la docencia clinica precencial, feedback, calificacion, registro, comunidad. Todo en un lugar.',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const MedLogPage()),
                    ),
                    icon: const Icon(Icons.open_in_new_rounded),
                    label: const Text(
                      'MedLog:',
                      style: TextStyle(
                        fontFamily: 'AmericanTypewriter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          _CardSurface(
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                'assets/medlog/medlog.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stack) => Center(
                  child: Text(
                    'No se encontró assets/medlog/medlog.png',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: AppColors.mint.withOpacity(0.25),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'MedLog',
                  style: TextStyle(
                    fontFamily: 'AmericanTypewriter',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'App medica que soluciona la docencia clinica precencial, feedback, calificacion, registro, comunidad. Todo en un lugar.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const MedLogPage()),
                  ),
                  icon: const Icon(Icons.open_in_new_rounded),
                  label: const Text(
                    'MedLog:',
                    style: TextStyle(
                      fontFamily: 'AmericanTypewriter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }
}
