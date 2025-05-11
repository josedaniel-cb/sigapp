# 🌿 Sostenibilidad de SIGApp en iOS

SIGApp es un proyecto libre y abierto, desarrollado con el deseo de ofrecer herramientas útiles sin depender de publicidad ni vender datos personales. Sin embargo, publicar en iOS requiere una cuenta anual de Apple Developer, cuyo costo es de aproximadamente **USD 99 al año** (~S/370).

## 🧭 Modelo de apoyo propuesto

Para sostener esta presencia en la App Store, se ha implementado en la versión iOS de SIGApp un sistema opcional de contribución anual de **S/4.99 (menos de USD 1.50)**.

### ¿Qué incluye este aporte?

- Acceso completo a la app en iOS.
- Apoyo directo al mantenimiento del proyecto.
- Transparencia sobre el destino del ingreso: cubrir exclusivamente el costo de publicación en iOS.

### ¿Cómo se comunica esto al usuario?

- Durante el onboarding, se informa con claridad que la app puede usarse sin costo durante un período de prueba.
- Al finalizar la prueba, se presenta una interfaz amigable donde se invita al usuario a apoyar el proyecto.
- Se evita el uso de ventanas intrusivas o lenguaje engañoso.
- Se incluye un mensaje explicativo en la interfaz con una barra de progreso colectiva:  
  _"Meta anual: cubrir S/370 de Apple. Recolectado: S/XXX por N usuarios."_

### ¿Por qué no simplemente mantener todo gratis?

Nos parece más honesto ofrecer un modelo basado en la confianza y el gesto voluntario de quien encuentra valor en la app. La sostenibilidad no debe ir en contra de los principios del software libre, sino apoyarse en su comunidad.

## ✨ Enfoque UX/UI para la contribución opcional en iOS

El objetivo de esta experiencia es permitir que el usuario explore la aplicación en iOS con total libertad durante un período inicial, y luego se le invite, de forma clara y no invasiva, a contribuir con un pequeño monto que permita cubrir los costos de publicación en la App Store.

Este enfoque busca transparencia, respeto por el tiempo del usuario, y una interfaz cuidada, sin generar presión ni falsas urgencias.

---

### 🌿 Etapa 1: Onboarding + Prueba gratuita

Durante el proceso de bienvenida (pantallas 3 o 4), se presenta un mensaje breve y directo:

> “SIGApp en iOS se sostiene gracias a aportes voluntarios.  
> Puedes probarla ahora y decidir luego si deseas apoyar.”

#### Interfaz sugerida:

- **Botón principal**: `Probar ahora` → inicia una prueba gratuita (7 a 14 días).
- **Botón informativo**: `¿Por qué pedimos esto?` → abre un cuadro explicativo con los motivos y transparencia del modelo.
- **Colores**: blancos, grises claros, verdes suaves o azules apagados. Se evita el uso de rojo o tonos que sugieran urgencia o advertencia.
- **Elementos visuales opcionales**: animaciones suaves o ilustraciones relacionadas con naturaleza o código (e.g., una hoja cayendo, líneas de terminal flotando).

---

### 🌊 Etapa 2: Durante la prueba

Se muestra un pequeño banner (superior o inferior), semi-transparente, con información sobre los días restantes.

> “Te quedan 10 días de exploración gratuita. Gracias por estar aquí.”

- Este banner desaparece automáticamente tras unos segundos y reaparece solo cuando el usuario accede a secciones clave.
- **Tipografía recomendada**: sans-serif de peso ligero o serif moderno, entre 14 y 16px.

---

### 🔒 Etapa 3: Fin de prueba — Invitación a contribuir

Una vez finalizado el período gratuito:

- Se muestra una pantalla con la aplicación desenfocada (blur) al fondo, visible pero inactiva.
- El texto central explica el motivo de la pausa:

> “Este proyecto se sostiene gracias a aportes voluntarios.  
> Con S/4.99 al año, ayudas a mantener SIGApp disponible en iOS.”

#### Interacción:

- **Botón principal**: `Apoyar y continuar` → color cálido (ámbar o dorado suave).
- **Botón secundario**: `Recordármelo luego` → color neutro, bajo contraste.
- Se incluye una nota al pie:
  > “Tu aporte cubre exclusivamente el costo de publicación en la App Store.”

---

### 🎭 Principios de experiencia

- El término “Suscripción” se usa únicamente en los detalles legales requeridos por Apple.
- Se prioriza la comunicación empática, sin lenguaje coercitivo.
- No se utilizan alertas del sistema ni popups intrusivos.
- Todo está implementado mediante interfaces propias, coherentes con el estilo visual de la app.

---

### 🎨 Elementos opcionales de refuerzo

Puede incluirse una sección visible dentro de la app con una barra de progreso colectiva:

> “🌱 Este proyecto crece gracias a ti.”

> “Meta anual: cubrir S/370 de Apple.  
> Recolectado: S/123.40 por 34 personas.”

Esta barra no es obligatoria, pero puede reforzar la transparencia del modelo y fomentar la participación.

## 🧷 Nota final

El código es y seguirá siendo abierto.  
Este mecanismo de contribución no impide la compilación ni el uso de SIGApp en Android, ni en plataformas no oficiales. Es simplemente una forma ética de sostener su presencia en un entorno cerrado como iOS.

Gracias por leer y, si lo deseas, por sumarte como cómplice en esta pequeña resistencia.

— SIGApp Team
