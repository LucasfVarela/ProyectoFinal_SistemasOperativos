#!/bin/bash

# Función para mostrar el menú
mostrar_menu() {
    echo "Selecciona una opción:"
    echo "1. Abrir el editor de texto (nano)"
    echo "2. Modificar texto (nano)"
    echo "3. Eliminar un archivo"
    echo "4. Mostrar el contenido de un directorio"
    echo "5. Buscar un archivo por nombre"
    echo "6. Mostrar el espacio libre en disco"
    echo "7. Mostrar la información de la red"
    echo "8. Monitorear procesos activos"
    echo "9. Crear un nuevo usuario"
    echo "10. Buscar texto dentro de un archivo"
    echo "11. Realizar un respaldo de un directorio"
    echo "12. Cambiar permisos de un archivo o directorio"
    echo "13. Verificar puertos abiertos"
    echo "14. Mostrar uso de memoria RAM"
    echo "15. Copiar un archivo o directorio"
    echo "16. Salir"
}


abrir_editor() {
    echo "Abriendo el editor de texto (nano)..."
    nano
}

modificar_archivo_texto() {
    read -p "Ingresa la ruta del archivo a modificar: " archivo_modificar
    if [ -f "$archivo_modificar" ]; then
        echo "Abriendo $archivo_modificar con nano..."
        nano "$archivo_modificar"
    else
        echo "El archivo no existe."
    fi
}

eliminar_archivo() {
    read -p "Ingresa la ruta del archivo a eliminar: " ruta_archivo
    if [ -f "$ruta_archivo" ]; then
        rm "$ruta_archivo"
        echo "Archivo eliminado exitosamente."
    else
        echo "El archivo no existe."
    fi
}


mostrar_directorio() {
    read -p "Ingresa la ruta del directorio: " ruta_directorio
    if [ -d "$ruta_directorio" ]; then
        echo "Contenido del directorio:"
        ls -l "$ruta_directorio"
    else
        echo "El directorio no existe."
    fi
}


buscar_archivo() {
    read -p "Ingresa el nombre del archivo a buscar: " nombre_archivo
    echo "Buscando archivos..."
    find / -name "$nombre_archivo" 2>/dev/null
}


mostrar_espacio_disco() {
    echo "Espacio libre en disco:"
    df -h
}


mostrar_info_red() {
    echo "Información de red:"
    ip a
}


monitorear_procesos() {
    echo "Procesos activos (10 más recientes):"
    ps aux --sort=-%cpu | head -n 10
}


crear_usuario() {
    read -p "Ingresa el nombre del nuevo usuario: " nuevo_usuario
    sudo useradd -m "$nuevo_usuario" && echo "Usuario $nuevo_usuario creado exitosamente." || echo "Error al crear el usuario."
}


buscar_texto_archivo() {
    read -p "Ingresa el texto a buscar: " texto
    read -p "Ingresa el archivo donde buscar: " archivo
    if [ -f "$archivo" ]; then
        echo "Resultados de la búsqueda:"
        grep "$texto" "$archivo"
    else
        echo "El archivo no existe."
    fi
}


respaldar_directorio() {
    read -p "Ingresa el directorio a respaldar: " dir_respaldo
    read -p "Ingresa el nombre del archivo de respaldo (sin extensión): " archivo_respaldo
    if [ -d "$dir_respaldo" ]; then
        tar -czvf "${archivo_respaldo}.tar.gz" "$dir_respaldo"
        echo "Respaldo realizado exitosamente en ${archivo_respaldo}.tar.gz"
    else
        echo "El directorio no existe."
    fi
}


cambiar_permisos() {
    read -p "Ingresa la ruta del archivo o directorio para cambiar permisos: " ruta_permiso
    read -p "Ingresa los permisos (ejemplo: 755): " permisos
    chmod "$permisos" "$ruta_permiso" && echo "Permisos cambiados exitosamente." || echo "Error al cambiar permisos."
}

# Función para verificar puertos abiertos
verificar_puertos_abiertos() {
    echo "Puertos abiertos en el sistema:"
    sudo netstat -tuln
}


mostrar_uso_memoria() {
    echo "Uso de memoria RAM:"
    free -h
}


copiar_archivo_directorio() {
    read -p "Ingresa la ruta del archivo o directorio a copiar: " fuente
    read -p "Ingresa la ruta de destino: " destino
    if [ -e "$fuente" ]; then
        cp -r "$fuente" "$destino" && echo "Copiado exitosamente." || echo "Error al copiar."
    else
        echo "El archivo o directorio de origen no existe."
    fi
}

# Bucle principal del menú
while true; do
    mostrar_menu
    read -p "Ingresa tu opción: " opcion

    case $opcion in
        1) abrir_editor ;;
		2) modificar_archivo_texto ;;
        3) eliminar_archivo ;;
        4) mostrar_directorio ;;
        5) buscar_archivo ;;
        6) mostrar_espacio_disco ;;
        7) mostrar_info_red ;;
        8) monitorear_procesos ;;
        9) crear_usuario ;;
        10) buscar_texto_archivo ;;
        11) respaldar_directorio ;;
        12) cambiar_permisos ;;
        13) verificar_puertos_abiertos ;;
        14) mostrar_uso_memoria ;;
        15) copiar_archivo_directorio ;;
        16)
            echo "Saliendo..."
            break
            ;;
        *)
            echo "Opción no válida. Intenta de nuevo."
            ;;
    esac
done
