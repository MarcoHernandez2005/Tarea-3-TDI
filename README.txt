# Tarea 3: Sistema Web Financiero con Spring MVC y MySQL — Financiera Huanca

**Asignatura:** Tecnologías para Desarrollos en Internet  
**Semestre:** 2027-1  
**Integrantes:**
* Marco Antonio Hernández Torres
* Libni Jael Morales Silva  

---

## Descripción del Proyecto

Esta aplicación web es una extensión de la **Tarea 2** para la gestión de solicitudes de crédito y registro de pagos de tarjetas de crédito del sistema **Financiera Huanca**.

El sistema integra el patrón **MVC (Modelo-Vista-Controlador)** mediante **Spring Framework**, conectándose a una base de datos relacional **MySQL** para la consulta y actualización dinámica de información financiera en tiempo real.

---

## Características Principales

1. **Formulario Dinámico con Pestañas:**
   * **Datos Personales:** Captura fecha, nombre completo y documento de identidad.
   * **Datos del Crédito:** Selección de moneda (Soles / Dólares), monto, plazo en meses, cuota mensual, TEA % y fecha de vencimiento.
   * Validación en cliente (JavaScript) para asegurar consistencia en fechas.

2. **Tabla Interactiva de Gastos y Pagos:**
   * Carga dinámica de movimientos desde la tabla `Gastos_Tarjeta` en MySQL.
   * Columnas no editables (*Fecha, Mes, Tarjeta, Transacción, Gastos*) para consulta.
   * **Columna de Pagos Editable:** Permite al usuario capturar o modificar montos mediante un *wrapper list binding* en Spring MVC (`GastoWrapper`).

3. **Persistencia en MySQL:**
   * Inserción automática de los datos del cliente y la solicitud de crédito (`Datos_Personales` y `Datos_Credito`).
   * Actualización (`UPDATE`) de los montos de pago registrados en la tabla de tarjetas.

4. **Vista de Resumen:**
   * Renderizado final en `resumen.jsp` confirmando la transacción, mostrando el desglose del crédito y desplegando la lista de pagos efectuados.

---

## Tecnologías Utilizadas

* **Lenguaje:** Java 17+ / JDK
* **Framework:** Spring MVC 5.3.31
* **Servidor Web / Container:** Apache Tomcat 9.0.121 (`javax.servlet`)
* **Librería de Etiquetas:** JSTL 1.2
* **Base de Datos:** MySQL Server 8.0+ / MySQL Workbench
* **Vistas:** JSP (JavaServer Pages), JSTL, Spring Form Tags, HTML5, CSS3, JavaScript
* **Entorno de Desarrollo:** Apache NetBeans IDE

---

## Estructura de la Base de Datos (MySQL)

Para la ejecución del proyecto se requiere crear el esquema `test` y las tablas correspondientes con el siguiente script:

```sql
USE test;

-- Tabla de gastos de tarjeta
DROP TABLE IF EXISTS Gastos_Tarjeta;
CREATE TABLE Gastos_Tarjeta (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fecha VARCHAR(15) NOT NULL,
    mes VARCHAR(15) NOT NULL,
    tarjeta VARCHAR(30) NOT NULL,
    transaccion VARCHAR(100) NOT NULL,
    gasto DECIMAL(12,2) DEFAULT NULL,
    pago DECIMAL(12,2) DEFAULT NULL
);

-- Inserción de datos iniciales
INSERT INTO Gastos_Tarjeta (fecha, mes, tarjeta, transaccion, gasto, pago) VALUES
('1/1/2021', 'enero', 'VISA', 'Peluquería', 1000.00, NULL),
('2/1/2021', 'enero', 'VISA', 'TV plasma (1 de 6)', 2500.00, NULL),
('3/1/2021', 'enero', 'MASTERCARD', 'Vajilla Kit', 2500.00, NULL),
('4/1/2021', 'enero', 'MASTERCARD', 'YouTube Premium', 170.00, NULL),
('5/1/2021', 'enero', 'VISA', 'Pasaje Londres', 25000.00, NULL),
('6/1/2021', 'enero', 'MASTERCARD', 'Pago Mastercard', NULL, 2670.00),
('7/2/2021', 'febrero', 'VISA', 'Teatro', 150.00, NULL),
('8/2/2021', 'febrero', 'VISA', 'Pago VISA', NULL, 150.00),
('9/2/2021', 'febrero', 'MASTERCARD', 'Cine', 23.00, NULL),
('10/2/2021', 'febrero', 'MASTERCARD', 'Libros x 5', 1400.00, NULL);

-- Tabla para almacenar datos personales del cliente
CREATE TABLE IF NOT EXISTS Datos_Personales (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    documento VARCHAR(20) NOT NULL
);

-- Tabla para almacenar el registro de solicitudes de crédito
CREATE TABLE IF NOT EXISTS Datos_Credito (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fecha VARCHAR(15) NOT NULL,
    periodo INT NOT NULL,
    moneda VARCHAR(20) NOT NULL,
    monto DECIMAL(12,2) NOT NULL,
    cuota DECIMAL(12,2) NOT NULL,
    tea DECIMAL(5,2) NOT NULL,
    vencimiento VARCHAR(15) NOT NULL
);

Estructura del Proyecto
Tarea-2-TDI-Financiera-Huanca/
├── src/
│   └── java/
│       ├── controladores/
│       │   └── CreditoController.java    # Controlador principal de Spring MVC
│       └── modelos/
│           ├── Gasto.java                # Modelo para la entidad Gasto/Tarjeta
│           └── GastoWrapper.java         # Wrapper para vinculación de colecciones en formulario
├── web/
│   ├── META-INF/
│   │   └── context.xml
│   └── WEB-INF/
│       ├── applicationContext.xml        # Configuración raíz de Spring
│       ├── dispatcher-servlet.xml        # Configuración de Servlets y ViewResolver
│       ├── web.xml                       # Despliegue de la aplicación web
│       ├── lib/                          # Driver MySQL y librerías Spring / JSTL 1.2
│       └── jsp/
│           ├── formulario.jsp            # Vista del formulario y tabla interactiva
│           ├── index.jsp                 # Vista de bienvenida
│           └── resumen.jsp               # Vista con el resumen de la transacción
├── build.xml                             # Script de construcción Ant
└── README.md                             # Documentación del repositorio

Instrucciones de Configuración y Ejecución
Base de Datos:

Asegúrate de tener MySQL Server en ejecución local (localhost:3306).

Ejecuta el script SQL en el esquema test.

Apertura del Proyecto:

Abre Apache NetBeans IDE.

Ve a File -> Open Project... y selecciona la carpeta del proyecto.

Configuración de Servidor:

Asegúrate de asociar el proyecto a Apache Tomcat 9.0.x.

Compilación y Ejecución:

Haz clic derecho sobre el proyecto y selecciona Clean and Build.

Presiona Run (F6).

La aplicación estará disponible en la ruta principal:http://localhost:8080/Tarea2_SpringMVC/inicio

