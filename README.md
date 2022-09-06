# The-MovieDB-App


La presente APP tiene como propósito demostrar mis conocimientos en el desarrollo iOS.
El patron de arquitectura seleccionado para el desarrollo de la aplicación fue MVVM, sin embargo es importante recalcar que se aplico también el uso de Delegados y Singleton con la intención de que el código se lo mas limpio para su fácil entendimiento y mantenimiento. 

Estructura u orden de Archivos :
📁App: Contiene todo el código de la app
	📁Mock: Aqui estan alojados todos los mocks utilizados para testing de los servicios
	📁Moduls: Modulos de la app, aqui se alojan por capetas separadas el código de cada modulo o sección
	📁Share: En esta carpeta se encuentra localizado todo archivo cuya funcionalidad es mostrar algún contenido o información al usuario y puede ser aplicado en varias secciones
	📁Utils: Aqui se aloja todo aquello que puede ser utilizado en todos o casi todos los modelos.
	

Ciclo de Vida de la app:

* Log In Y sign Up

![Simulator Screen Recording - iPhone 11 Pro Max - 2022-08-19 at 07 38 49](https://user-images.githubusercontent.com/81894293/185625887-24393908-d49c-4c2d-a8f1-6cdb752c2349.gif)



* Home

![Simulator Screen Recording - iPhone 11 Pro Max - 2022-08-19 at 09 18 30](https://user-images.githubusercontent.com/81894293/185627270-7abbb70a-ce23-4467-a47f-0f3912ad0dce.gif)


* Profile

![Simulator Screen Recording - iPhone 11 Pro Max - 2022-08-19 at 09 20 08](https://user-images.githubusercontent.com/81894293/185627618-63ad2f23-db49-4796-8757-7b9b6cb20f6b.gif)



Bugs, errores o cosas que no tuve tiempo de resolver :

1. Debido al tiempo de entrega (3 dias) no resolví el problema que esta presente cuándo se inicia la app sin conexión  a internet el home muestra las celdas vacías. Cuando en realidad debería mostrar un modal con la opción de recargar.
2. Usar una mejor metodo para las navegaciones.
3. Crear mejores validaciones para el log in y signUp 
4. Aplicar testing a todos lo modelos de la app

Nota: Quisiera saber sus opiniones sobre mi codigo, el siguiente link me pueden mandar sus comentarios: https://www.linkedin.com/in/adriancys-jesus-villegas-toro-283641160/

esta un user creado con los siguientes datos:
User adriancysvillegast@gmail.com
Hola2896

sin embargo puede crearse una cuenta usted mismo.

Proceso de descarga del proyecto:

1) descargar del proyecto

a)

![Screenshot 2022-08-30 at 3 04 05 PM](https://user-images.githubusercontent.com/81894293/187521608-e6de0e2a-da39-4dee-849a-c0ddc4ee2044.png)

b) clonar proyecto

![Screenshot 2022-08-30 at 3 07 03 PM](https://user-images.githubusercontent.com/81894293/187522050-e12e9916-158f-4d59-ba9c-26f8e9d954e6.png)

c) pegar link y guardar donde prefieras

![Screenshot 2022-08-30 at 3 08 38 PM](https://user-images.githubusercontent.com/81894293/187522748-91265dd0-e232-4f9e-83e3-9c734d08f4de.png)

2) descargar Pods

a)

![Screenshot 2022-08-30 at 3 11 59 PM](https://user-images.githubusercontent.com/81894293/187523597-e73001e3-f7a6-4918-b1db-143e937f2dab.png)

b) Escribir el comando de la imagen para descargar los pods -> pod install

![Screenshot 2022-08-30 at 3 14 01 PM](https://user-images.githubusercontent.com/81894293/187523786-3ceed6fa-bac3-47fc-ac99-d220de143796.png)

c) al descargarse todos los pods abrir el archivo .xcworkspace
![The Movie DB App](https://user-images.githubusercontent.com/81894293/187523930-988bef2d-0992-43a9-a22e-75ef754f8178.png)

d) Fin Ya puedes usar el proyecto.

Nota: Debes tener instalado cocoapods en tu mac para poder hacer usos de los pods, la instrucciones de instalacion de cocoapods la encuentras en su pagina oficial.

