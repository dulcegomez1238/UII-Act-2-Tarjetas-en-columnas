import 'package:flutter/material.dart';

void main() {
  runApp(const MiTiendaDeFlores());
}

class MiTiendaDeFlores extends StatelessWidget {
  const MiTiendaDeFlores({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Quita la etiqueta de 'debug'
      title: 'Tienda de Flores',
      theme: ThemeData(
        // Definimos el color rosita de fondo para toda la aplicación
        scaffoldBackgroundColor: const Color(
          0xFFFFE0E9,
        ), // Un rosa pastel muy suave
        useMaterial3: true,
      ),
      home: const PantallaProductos(),
    );
  }
}

class PantallaProductos extends StatelessWidget {
  const PantallaProductos({super.key});

  @override
  Widget build(BuildContext context) {
    // Definimos los datos de ejemplo para los 4 productos
    final List<Map<String, String>> productos = [
      {
        'nombre': 'Ramo Romántico',
        'precio': '\$3,500.00',
        // Usaremos imágenes de marcador de posición de internet para este ejemplo
        'imagen':
            'https://raw.githubusercontent.com/dulcegomez1238/imagenes-jpg/refs/heads/main/imagenes.jpg/imagen4.PNG' 
          },
      {
        'nombre': 'Girasoles Alegres',
        'precio': '\$2,400.00',
        'imagen':
            'https://raw.githubusercontent.com/dulcegomez1238/imagenes-jpg/refs/heads/main/imagenes.jpg/imagen13.PNG'      
            },
      {
        'nombre': 'Tulipanes de Primavera',
        'precio': '\$4,300.00',
        'imagen':
            'https://raw.githubusercontent.com/dulcegomez1238/imagenes-jpg/refs/heads/main/imagenes.jpg/imagen10.PNG'      
            },
      {
        'nombre': 'Orquídea Elegante',
        'precio': '\$5,000.00',
        'imagen':
            'https://raw.githubusercontent.com/dulcegomez1238/imagenes-jpg/refs/heads/main/imagenes.jpg/imagen11.PNG'     
             },
    ];

    return Scaffold(
      // El fondo rosa ya está definido en el ThemeData
      body: SafeArea(
        // Evita que el contenido choque con la barra de estado
        child: Column(
          children: [
            // --- 1. Rectángulo superior (Encabezado) ---
            Container(
              width: double.infinity, // Ocupa todo el ancho disponible
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              margin: const EdgeInsets.all(
                15,
              ), // Espacio alrededor del rectángulo
              decoration: BoxDecoration(
                color: const Color(0xFFE1BEE7), // Un morado claro/lavanda
                borderRadius: BorderRadius.circular(15), // Bordes redondeados
              ),
              child: const Text(
                'Conoce nuestros Productos más Vendidos',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A148C), // Un morado oscuro para contraste
                ),
              ),
            ),

            // --- 2. Cuadrícula de 4 Productos (GridView) ---
            // Usamos Expanded para que la cuadrícula ocupe el espacio restante
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                  // 'itemCount: 4' asegura que solo muestre tus 4 productos definidos
                  itemCount: productos.length,
                  // 'gridDelegate' controla la estructura de la cuadrícula
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 columnas
                    crossAxisSpacing: 10, // Espacio horizontal entre tarjetas
                    mainAxisSpacing: 10, // Espacio vertical entre tarjetas
                    childAspectRatio:
                        0.65, // Ajusta la relación de aspecto (más alto que ancho)
                  ),
                  // 'itemBuilder' construye cada tarjeta individualmente
                  itemBuilder: (context, index) {
                    final producto = productos[index];
                    return Card(
                      elevation: 4, // Sombra suave para efecto de elevación
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // --- Imagen del producto ---
                          Expanded(
                            child: ClipRRect(
                              // Redondeamos solo las esquinas superiores de la imagen
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                              child: Image.network(
                                producto['imagen']!,
                                fit: BoxFit
                                    .cover, // La imagen cubre el espacio sin deformarse
                                // Mientras carga la imagen real, muestra un indicador
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                              ),
                            ),
                          ),

                          // --- Nombre y Precio ---
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  producto['nombre']!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 1, // Limita a una línea
                                  overflow: TextOverflow
                                      .ellipsis, // Pone "..." si es muy largo
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  producto['precio']!,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // --- Botón 'Añadir al carrito' ---
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8,
                              right: 8,
                              bottom: 8,
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                // Acción al presionar el botón
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '¡${producto['nombre']} añadido!',
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(
                                  0xFFE1BEE7,
                                ), // Fondo morado claro
                                foregroundColor: const Color(
                                  0xFF4A148C,
                                ), // Texto morado oscuro
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                              ),
                              child: const Text(
                                'Añadir carrito',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
