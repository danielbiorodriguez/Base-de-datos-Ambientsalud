# 📌 Base de Datos - Ambientsalud

Este repositorio contiene la base de datos de las atenciones realizadas en la IPS Ocupacional Ambientsalud durante un periodo de 3 meses.

## 📄 Descripción

La base de datos se construye a partir de un archivo de Excel generado automáticamente por el software médico de la IPS. A continuación, se detallan los pasos seguidos para limpiar y transformar los datos antes de importarlos a MySQL.

---

## 🔹 Preparación de los Datos

### 1️⃣ Eliminación del formato en la columna `fecha_creacion`

El software genera la columna `fecha_creacion` con un formato que impide modificaciones. Para corregirlo:
- Copia y pega los datos en un archivo de texto plano (Bloc de Notas).
- Luego, vuelve a pegar los datos en Excel.

📷 _Ejemplo:_  
![Captura de pantalla](https://github.com/user-attachments/assets/678d6293-19a6-4b36-93f7-8a21947f2be9)

### 2️⃣ Ajuste del formato de la columna `precio`

La columna `precio` viene en formato moneda, lo cual genera errores en MySQL debido a los separadores de miles y el símbolo de moneda. Para corregirlo:
- Convierte la columna a formato número para que MySQL la identifique correctamente como `INT` o `DECIMAL`.

📷 _Ejemplo:_  
![Formato moneda](https://github.com/user-attachments/assets/265291d0-8d28-4abe-a723-3596a9b54ffd)

### 3️⃣ Exportación del archivo en formato CSV

Una vez corregidos los formatos, se debe exportar el archivo en formato `.csv` separado por comas.

📷 _Ejemplo:_  
![Captura de pantalla](https://github.com/user-attachments/assets/25409b7f-cb15-4580-96e9-7f06ca0af480)

---

## 🔹 Carga de Datos en MySQL Workbench

1. Se abre MySQL Workbench y se selecciona la opción para importar un archivo CSV.
2. Se busca el archivo exportado.

📷 _Ejemplo:_  
![Carga de datos](https://github.com/user-attachments/assets/577a6b4e-1758-463a-bf7b-a844a6a98df8)

3. Se verifican los datos y columnas antes de la importación.

📷 _Ejemplo:_  
![Verificación](https://github.com/user-attachments/assets/49b2a254-8a5a-43d4-be29-faea7b41b4a3)

4. Se procede con la importación.

📷 _Ejemplo:_  
![Importación](https://github.com/user-attachments/assets/6ecc9f26-18d9-4922-b864-12ebe9da358d)

---

## 🔹 Creación de Tablas Normalizadas

Una vez importados los datos, se ejecuta un código SQL para la creación de tablas normalizadas.

📷 _Ejemplo:_  
![Creación de tablas](https://github.com/user-attachments/assets/f714cb56-0753-442f-9ef3-6115e83dfa1f)

Luego, se migra la información de la tabla original a las nuevas tablas normalizadas.

📷 _Ejemplo:_  
![Migración de datos](https://github.com/user-attachments/assets/369107a5-fa96-4987-bc34-f35035ba029e)

Finalmente, se crean las relaciones entre las tablas mediante procedimientos SQL específicos.

📷 _Ejemplo:_  
![Creación de relaciones](https://github.com/user-attachments/assets/bea05e56-9f66-4f30-85b8-d71585eca067)

---

## 🔹 Diagrama Entidad-Relación (ERD)

Al finalizar la normalización y la creación de relaciones, se genera el siguiente diagrama entidad-relación:

📷 _Ejemplo:_  
![Diagrama ERD](https://github.com/user-attachments/assets/38c9f2d8-4666-4fd1-ad50-8402afa6ba35)

---

## 🛠 Tecnologías Utilizadas

- **📊 MySQL Workbench** - Para la gestión de la base de datos.
- **📑 Excel** - Para la limpieza y transformación de los datos.
- **📝 Bloc de Notas** - Para eliminar formatos no deseados.

## 📌 Contacto
Si tienes dudas o sugerencias, no dudes en abrir un issue o hacer un pull request.

---

Los datos sensibles fueron modificados para proteger la identidad de los pacientes.
