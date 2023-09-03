#!/bin/bash

read -p "Ingrese el nombre del archivo: " archivo

# Verificar si se proporciona un archivo como argumento
#if [ $# -eq 0 ]; then
 #   echo "Error: Debes proporcionar un archivo como argumento."
  #  exit 1
#fi

#archivo="$1"

# Verificar si el archivo existe
if [ ! -e "$archivo" ]; then
    echo "Error: El archivo '$archivo' no existe."
    exit 1
fi

# Obtener permisos del archivo
permisos=$(stat -c "%A" "$archivo")

# Definir la función get_permissions_verbose
get_permissions_verbose() {
    local permisos="$1"
    usuario_permisos="${permisos:1:3}"
    grupo_permisos="${permisos:4:3}"
    otros_permisos="${permisos:7:3}"

    echo "Los permisos de $archivo son: "

    echo "Permisos del usuario:"

    for ((i = 0; i < 3; i++)); do
        perm="${usuario_permisos:$i:1}"
        if [ "$perm" = "r" ]; then
            echo " - Lectura"
        elif [ "$perm" = "w" ]; then
            echo " - Escritura"
        elif [ "$perm" = "x" ]; then
            echo " - Ejecución"
        else
            echo " - "
        fi
    done

    echo "Permisos del grupo:"

    for ((i = 0; i < 3; i++)); do
        perm="${grupo_permisos:$i:1}"
        if [ "$perm" = "r" ]; then
            echo " - Lectura"
        elif [ "$perm" = "w" ]; then
            echo " - Escritura"
        elif [ "$perm" = "x" ]; then
            echo " - Ejecución"
        else
            echo " - "
        fi
    done

    echo "Permisos de otros usuarios:"

    for ((i = 0; i < 3; i++)); do
        perm="${otros_permisos:$i:1}"
        if [ "$perm" = "r" ]; then
            echo " - Lectura"
        elif [ "$perm" = "w" ]; then
            echo " - Escritura"
        elif [ "$perm" = "x" ]; then
            echo " - Ejecución"
        else
            echo " - "
        fi
    done
}

# Llamar a la función con los permisos obtenidos
get_permissions_verbose "$permisos"
