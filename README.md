# Trámite Abastecimiento · Archivo Digital

Sistema de gestión documentaria y mesa de partes digital para la **Unidad de Abastecimiento** de una entidad pública. Propuesta desarrollada a partir de las prácticas preprofesionales en la Unidad de Abastecimientos de la Universidad Nacional del Altiplano (UNA-Puno).

> **Estado: prototipo de prueba.** Todo funciona dentro del navegador: las cuentas, los trámites y los documentos se guardan en el propio equipo (IndexedDB). No hay servidor todavía.

## El problema

Los requerimientos de las áreas usuarias (bienes, servicios, conformidades, modificaciones presupuestales, pagos al personal, etc.) llegan en papel, con sellos y firmas físicas. Los expedientes de contratación son voluminosos (algunos superan las 500 páginas) y su seguimiento, búsqueda y archivo se hace a mano.

## Qué hace el prototipo

**Dos portales, cuatro roles**

| Rol | Qué hace |
|---|---|
| Área usuaria | Envía requerimientos con su firma y sello, sigue en qué paso están, subsana observaciones y recibe documentos de la Unidad. |
| Secretaría | Verifica los requisitos, recibe con sello de recepción y N.° de registro, eleva a Jefatura y deriva lo aprobado. |
| Jefatura | Revisa, sella, firma, asigna al responsable de ejecución y administra usuarios. |
| Especialista | Ejecuta el requerimiento, registra las etapas del expediente de contratación y lo marca como atendido. |

**Flujo:** área usuaria → Secretaría (recepción) → Jefatura (revisión) → derivación → especialista (ejecución) → archivo en Carpetas.

**Funciones principales**

- Firma y sellos gráficos sobre el PDF: firma dibujada o escaneada, sello de área, post-firma, sello de recepción, sello de revisión, V°B° y proveídos. Se colocan arrastrando sobre la página (PDF.js + pdf-lib).
- Código de barras (Code 128) en la primera página, cargo de recepción en PDF y huella SHA-256 de cada versión del documento.
- Lista de verificación del requerimiento según la Ley N.° 32069 (EETT/TDR, finalidad pública, CMN/PMBSO, fichas, catálogos electrónicos, meta y clasificador).
- Semáforo de plazos en días hábiles (con feriados nacionales) y control del plazo de pago tras la conformidad (art. 67.3).
- Expediente de contratación por etapas: mercado, cuantía, estrategia, certificación, selección, orden y pago.
- Emisión de oficios, memorandos e informes con numeración correlativa, despacho a las áreas y acuse de lectura.
- Reportes: inventario de expedientes anteriores (préstamos y transferencias al Archivo Central), contratos hasta 8 UIT para prevenir el fraccionamiento, órdenes OC/OS en el formato de carga masiva del SEACE e importación de sus reportes.
- Exportación a Excel (.xlsx) sin librerías externas.
- Digitalización con cámara o archivos, compresión en escala de grises y OCR en español (Tesseract.js).
- Registro de auditoría y aviso de privacidad (Ley N.° 29733).

## Cómo probarlo

1. Abre `index.html` en un navegador actualizado (Chrome, Edge o Firefox). Necesita internet la primera vez para cargar las librerías de PDF y OCR.
2. En la portada, elige un portal y toca una de las **cuentas de prueba** para completar los datos. Contraseña inicial: `demo2026`.
3. Para usar la cámara del navegador, la página debe abrirse por HTTPS o como `localhost`.

Todos los nombres, correos y documentos de las cuentas de prueba son ficticios.

## Limitaciones de esta versión

- **La firma y los sellos son imágenes, no firma digital.** No tienen el valor legal de la firma digital de la Ley N.° 27269. La versión final debe integrarse con un firmador oficial, como la plataforma **Firma Perú**.
- Los datos viven solo en el navegador de cada equipo: no se comparten entre usuarios ni hay respaldo.
- Las marcas de tiempo usan la hora del equipo, no un sello de tiempo acreditado.

## Próximos pasos

- [ ] Servidor local o nube privada (por ejemplo, Nextcloud) con inicio de sesión por correo institucional.
- [ ] Base de datos central y almacenamiento de expedientes con OCR y compresión.
- [ ] Integración con Firma Perú para firmas digitales con validez legal.
- [ ] Coordinación con el área de informática de la UNA sobre la infraestructura.

## Importante

Este repositorio contiene **solo código y datos de prueba**. No subas expedientes reales, escaneos de sellos o firmas reales, ni datos personales de proveedores o trabajadores.

## Tecnologías

HTML, CSS y JavaScript en un solo archivo, sin compilación · [pdf-lib](https://pdf-lib.js.org/) · [PDF.js](https://mozilla.github.io/pdf.js/) · [Tesseract.js](https://tesseract.projectnaptha.com/) · IndexedDB.
