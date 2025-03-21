# Base-de-datos-Ambientsalud
Base de datos de las atenciones realizadas en la IPS Ocupacional Ambientsalud, durante un periodo de 3 meses.
Para la construcción de la base de datos se parte desde un archivo de excel de generación automática por parte del software médico usado por la IPS.
El primer paso es borrar el formato de la columna fecha_creacion que genera el software ya que este no acepta ningún tipo de modificación, ![Captura de pantalla 2025-03-20 192022](https://github.com/user-attachments/assets/678d6293-19a6-4b36-93f7-8a21947f2be9) para ello se utiliza el block de notas en el cual se pegan los datos. 
![Captura de pantalla 2025-03-20 192151](https://github.com/user-attachments/assets/14d800a1-5ad2-4ffd-a509-1d15300d027d)
Posteriormente se vuelven a llevar al archivo de excel y se le da el formato compatible con la base de datos de MySQL.
![Captura de pantalla 2025-03-20 192301](https://github.com/user-attachments/assets/4973d388-1a15-4167-9444-b9003d0669fc)
Luego se procede a cambiar el formato de la columna precio, ya que esta viene en formato moneda,
![formato moneda](https://github.com/user-attachments/assets/265291d0-8d28-4abe-a723-3596a9b54ffd)
Este formato incluye separador de miles y el simbolo de la moneda lo cuál tambien genera errores en la base de datos de MySQL, por lo tanto se debe dejar en formato número, asi workbench lo puede identificar como entero y no como texto.
![Captura de pantalla 2025-03-20 192455](https://github.com/user-attachments/assets/ad6d12de-d794-4a6a-b397-bd4ef84d257f)
Por ultimo se guarda una copia del archivo en formato csv separado por comas.
![Captura de pantalla 2025-03-20 192616](https://github.com/user-attachments/assets/25409b7f-cb15-4580-96e9-7f06ca0af480)
Y estamos listos para cargar los datos a workbench
![image](https://github.com/user-attachments/assets/577a6b4e-1758-463a-bf7b-a844a6a98df8)
Se busca el archivo
![image](https://github.com/user-attachments/assets/a6d7d325-24bd-409b-9494-5ea20cdb9ea7)
Se verifica que los datos y las columnas conincidan correctamente
![image](https://github.com/user-attachments/assets/49b2a254-8a5a-43d4-be29-faea7b41b4a3)
y se importan los datos
![image](https://github.com/user-attachments/assets/6ecc9f26-18d9-4922-b864-12ebe9da358d)
Una vez cargados los datos se ejecuta un código de creación de tablas normalizadas
![image](https://github.com/user-attachments/assets/f714cb56-0753-442f-9ef3-6115e83dfa1f)
Luego un procedimiento para migrar los datos desde la tabla original hacia las tablas normalizadas
![image](https://github.com/user-attachments/assets/369107a5-fa96-4987-bc34-f35035ba029e)
Por último un procedimiento para la cración de las relaciones entre las tablas
![image](https://github.com/user-attachments/assets/bea05e56-9f66-4f30-85b8-d71585eca067)
Generando el siguiente diagrama entidad relación
![diagrama entidad relacion](https://github.com/user-attachments/assets/38c9f2d8-4666-4fd1-ad50-8402afa6ba35)
