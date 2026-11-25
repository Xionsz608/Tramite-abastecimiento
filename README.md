# Trámite Abastecimiento · Archivo Digital

Sistema de gestión documentaria y mesa de partes digital para la **Unidad de Abastecimiento** de una entidad pública. Propuesta desarrollada a partir de las prácticas preprofesionales en la Unidad de Abastecimientos de la Universidad Nacional del Altiplano (UNA-Puno).

**Demo en línea:** https://tramite-abastecimiento.vercel.app (se actualiza sola con cada cambio en `main`).

> **Estado: prototipo de prueba.** Todo funciona dentro del navegador: las cuentas, los trámites y los documentos se guardan en el propio equipo (IndexedDB). No hay servidor todavía.

## El problema

Los requerimientos de las áreas usuarias (bienes, servicios, conformidades, modificaciones presupuestales, pagos al personal, etc.) llegan en papel, con sellos y firmas físicas. Los expedientes de contratación son voluminosos (algunos superan las 500 páginas) y su seguimiento, búsqueda y archivo se hace a mano.

## Qué hace el prototipo

**Dos portales, cuatro roles**

| Rol | Qué hace |
|---|---|
| Área usuaria | Sube requerimientos de **bienes, servicios u obras**, sigue en qué paso están, recibe notificaciones, subsana observaciones y recibe documentos de la Unidad. |
| Secretaría | Verifica los requisitos, recibe con N.° de registro y eleva a Jefatura. |
| Jefatura | Revisa el requerimiento y lo **deriva a un equipo de especialistas** con un responsable principal (o lo observa). Administra usuarios. |
| Especialista | Revisa su parte, envía avances a otros especialistas, da su conformidad y registra las etapas del expediente. El responsable inicia la ejecución y concluye el trámite. |

**Flujo:** área usuaria → Secretaría (recepción) → Jefatura (revisión y derivación) → especialista (ejecución) → archivo en Carpetas.

**Seguimiento que ve el área usuaria:** En curso → Revisión de Jefatura → Derivado → En ejecución → Concluido.

**Funciones principales**

- Seguimiento por etapas con barra de avance y notificaciones al área usuaria en cada cambio (recepción, documento abierto por Secretaría o Jefatura, derivación, inicio de la ejecución, observaciones y conclusión).
- Equipo de especialistas por requerimiento. Al derivar, el sistema sugiere el equipo según el objeto, la cuantía (hasta 8 UIT o más), si es común (ficha técnica u homologación) y si está en los catálogos electrónicos de acuerdo marco. Funciones: programación y certificación, indagación de mercado, catálogos y acuerdos marco, procedimientos de selección, contrataciones hasta 8 UIT, y órdenes y ejecución contractual. Cada etapa del expediente muestra quién la tiene a cargo.
- Avances de especialista a especialista, con mensaje y adjunto (internos: el área usuaria no los ve), y conformidad de cada parte. El área usuaria solo ve cuántas partes están conformes.
- Actividad simultánea: las ventanas abiertas se actualizan solas cuando otro usuario mueve un trámite. En el prototipo funciona entre pestañas del mismo navegador; con servidor llegará a todos los equipos.
- Código de barras (Code 128) en la primera página, cargo de recepción en PDF y huella SHA-256 de cada versión del documento.
- Tres tipos de requerimiento: bienes (con EETT), servicios (con TDR) y obras (con expediente técnico).
- Lista de verificación del requerimiento según la Ley N.° 32069 (EETT/TDR/expediente técnico, finalidad pública, CMN/PMBSO, fichas, catálogos electrónicos, meta y clasificador).
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

## Base compartida para la demo (Supabase, opcional)

1. Crea un proyecto gratuito en [supabase.com](https://supabase.com).
2. En **SQL Editor**, pega y ejecuta `supabase/schema.sql`.
3. En **Settings → API**, copia la *Project URL* y la clave pública **anon**, y pégalas en `supabase-config.js`. Nunca uses la clave `service_role`.
4. Publica el cambio. Al abrir el sistema verás el aviso "Base compartida activa" y los trámites se verán en todos los equipos al instante.

Si `supabase-config.js` está vacío, el sistema funciona como antes (datos en el navegador).

## Limitaciones de esta versión

- El sistema no firma ni sella documentos: el área adjunta el documento ya firmado y sellado. Si más adelante se requiere firma digital con valor legal (Ley N.° 27269), se integraría un firmador oficial, como la plataforma **Firma Perú**.
- Sin configurar la base compartida, los datos viven solo en el navegador de cada equipo. Con Supabase activo (ver abajo) se comparten entre equipos, pero es solo para la demo: el acceso es abierto y los PDF se guardan en la base como texto, así que usa únicamente datos ficticios.
- Las marcas de tiempo usan la hora del equipo, no un sello de tiempo acreditado.

## Próximos pasos

- [ ] Servidor local o nube privada (por ejemplo, Nextcloud) con inicio de sesión por correo institucional.
- [ ] Base de datos central y almacenamiento de expedientes con OCR y compresión.
- [x] Demo con base compartida y actualización simultánea entre equipos (Supabase Realtime).
- [ ] Notificaciones por correo institucional y reglas de acceso por rol (Supabase Auth o servidor de la UNA).
- [ ] Integración opcional con Firma Perú para firmas digitales con validez legal.
- [ ] Coordinación con el área de informática de la UNA sobre la infraestructura.

## Importante

Este repositorio contiene **solo código y datos de prueba**. No subas expedientes reales, escaneos de sellos o firmas reales, ni datos personales de proveedores o trabajadores.

## Tecnologías

HTML, CSS y JavaScript en un solo archivo, sin compilación · [pdf-lib](https://pdf-lib.js.org/) · [PDF.js](https://mozilla.github.io/pdf.js/) · [Tesseract.js](https://tesseract.projectnaptha.com/) · IndexedDB.
