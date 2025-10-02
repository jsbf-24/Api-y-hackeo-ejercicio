Guía de Ejecución y Pruebas - API de Seguridad

COMO EJECUTAR LA API
Instalación de Dependencias
Primero, es necesario instalar las librerías usando pip. Se NECESITA FastAPI, Uvicorn, SQLModel y Requests.

EJECUTAR EL SERVIDOR
Abrir el archivo main.py y ejecutar el servidor con Uvicorn. El parámetro --reload permite que el servidor se reinicie automáticamente cuando detecte cambios en el código.

ACCESO A LA API
Una vez ejecutado, la API estará disponible en localhost puerto 8000. al agregar "/docs" se abre una pestaña interactiva para probar el API

EJEMPLOS SENCILLOS
CREAR USUARIOS DE PRUEBA
Es posible crear usuarios mediante solicitudes POST al endpoint /users. Envía un objeto JSON con id, username, password, email y si esta activo o no. La API verifica que el nombre de usuario sea único antes de registrar al usuario.

PROBAR AUTENTICACIÓN
El endpoint /login permite verificar credenciales. SE DEBE PROPORCIONAR  username y password para recibir una respuesta de éxito o error.

OPERACIONES CRUD COMPLETAS
Se pueden listar todos los usuarios con GET /users, obtener un usuario específico por ID, actualizar información con PUT , pero no se puede actualizar la contraseña excepto la contraseña(para eso solo es necesario usar un bloque if extra en el update), y eliminar usuarios con DELETE.

PRUEBAS DE SEGURIDAD
El script de ataque demuestra vulnerabilidades como la exposición de contraseñas en texto plano. Este se conecta a la API para extraer y mostrar todas las credenciales almacenadas.

PRUEBAS
*PRUEBA 1
Al ingresar un usuario unico el codigo determina y representa rapidamente las credenciales del API a pesar de editar los
datos con el endpoint update al correr nuevamente el script se revelan los datos. La contraseña sin embargo debe ser de 3 digitos, si se ingresa una contraseña con más/menos caracteres el programa no la encuentra.


*PRUEBA 2
Al ingresar multiples usuarios hay un problema ya que el codigo apunta a un usuario especifico. Por lo tanto la información de los otros usuarios no sera expuesta.

La API está diseñada para demostrar vulnerabilidades comunes en sistemas de autenticación, haciendo evidente la importancia de prácticas como verificación de dos pasos aparte de las contraseñas y la implementación de controles de acceso adecuados para evitar este tipo de vulnerabilidades en la seguridad de sistemas futuros.











jsbf-24
