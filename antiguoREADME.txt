# Tarea 2 TDI - Financiera Huanca (Spring MVC)

Aplicación web desarrollada bajo el patrón de arquitectura Modelo-Vista-Controlador (MVC) utilizando Spring Framework. El sistema permite registrar datos personales y simular los detalles de un crédito financiero, guardando la información en una base de datos MySQL y devolviendo una vista de resumen.

## Equipo de Desarrollo
* Hernández Torres Marco Antonio
* Morales Silva Libni Jael

## Tecnologías y Requisitos Previos
Para compilar y ejecutar este proyecto, es necesario contar con el siguiente entorno:
* **Java Development Kit (JDK):** Versión 17
* **Servidor de Aplicaciones:** Apache Tomcat 9.0.x
* **Base de Datos:** MySQL Server 8.0+
* **Framework:** Spring Web MVC 5.3.31
* **Librerías Adicionales:** JSTL 3.0.2, MySQL Connector/J 8.x o superior

## Configuración de la Base de Datos
1. Abre MySQL Workbench (o tu cliente de preferencia) y ejecuta el siguiente script para preparar las tablas:

```sql
CREATE DATABASE IF NOT EXISTS test;
USE test;

DROP TABLE IF EXISTS Datos_Personales;
CREATE TABLE Datos_Personales (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    documento VARCHAR(20) NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS Datos_Credito;
CREATE TABLE Datos_Credito (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
    periodo INT NOT NULL,
    moneda VARCHAR(10) NOT NULL,
    monto DECIMAL(12,2) NOT NULL,
    cuota DECIMAL(12,2) NOT NULL,
    tea DECIMAL(5,2) NOT NULL,
    vencimiento DATE NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

Verifica las credenciales de conexión. Si el servidor MySQL evaluador utiliza una contraseña distinta, dirígete al archivo src/java/controladores/CreditoController.java y actualiza la constante DB_PASSWORD.

Despliegue y Ejecución en NetBeans
Clona este repositorio o extrae el archivo ZIP en tu espacio de trabajo.

Abre el proyecto en Apache NetBeans.

Confirma que el proyecto esté utilizando JDK 17 (Properties > Libraries > Java Platform y Properties > Sources > Source/Binary Format).

Asegúrate de que el archivo mysql-connector-j-XX.X.X.jar se encuentre dentro de la carpeta física web/WEB-INF/lib.

Haz clic en el botón Clean and Build para compilar las fuentes y aplicar el filtro UTF-8 de web.xml.

Haz clic en Run para desplegar en Tomcat.

En el navegador de tu preferencia, accede a la ruta del formulario:
http://localhost:8080/Tarea2_SpringMVC/inicio

Estructura Principal
CreditoController.java: Controlador de Spring que intercepta las peticiones, gestiona la conexión JDBC a MySQL con carga explícita del driver y envía los atributos al modelo.

formulario.jsp: Interfaz gráfica de la Financiera Huanca (HTML/CSS/JS puro) que captura y valida los datos.

resumen.jsp: Vista de éxito que renderiza los valores inyectados por el controlador.

dispatcher-servlet.xml: Configuración del escaneo de componentes y ViewResolver.

web.xml: Configuración del DispatcherServlet y filtro de codificación para evitar caracteres corruptos.