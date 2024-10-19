# Usar una imagen base de JDK para ejecutar la aplicación
FROM eclipse-temurin:17-jdk-alpine

# Establecer el directorio de trabajo en /home
WORKDIR /home

# Borrar el contenido previo del directorio /home (opcional)
RUN rm -rf /home/*$

# Copiar el JAR generado en el contenedor
COPY holamundo.jar /home/holamundo.jar

# Exponer el puerto en el que se ejecutará la aplicación
EXPOSE 8082

# Comando para ejecutar la aplicación
ENTRYPOINT ["java", "-jar", "/home/holamundo.jar", "--spring.profiles.active=prod"]
