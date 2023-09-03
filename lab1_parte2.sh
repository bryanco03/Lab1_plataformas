#!/bin/bash

# Comprobar si se proporcionan dos argumentos
if [ $# -ne 2 ]; then
    echo "Error: Debes proporcionar el nombre de un nuevo usuario y el nombre del grupo."
    exit 1
fi

nuevo_usuario="$1"
nombre_grupo="$2"

# Comprobar si el usuario ya existe
if id "$nuevo_usuario" &>/dev/null; then
    echo "El usuario '$nuevo_usuario' ya existe."
else
    # Crear el usuario
    sudo useradd "$nuevo_usuario"
    echo "Usuario '$nuevo_usuario' creado."
fi

# Comprobar si el grupo ya existe
if grep -q "^$nombre_grupo:" /etc/group; then
    echo "El grupo '$nombre_grupo' ya existe."
else
    # Crear el grupo
    sudo groupadd "$nombre_grupo"
    echo "Grupo '$nombre_grupo' creado."
fi

# Agregar usuarios al grupo
sudo usermod -aG "$nombre_grupo" "$USER"
sudo usermod -aG "$nombre_grupo" "$nuevo_usuario"
echo "Usuarios agregados al grupo '$nombre_grupo'."

# Asignar permisos al script
sudo chown :"$nombre_grupo" lab1_parte1.sh
sudo chmod 751 lab1_parte1.sh
echo "Permisos asignados al script para que solo miembros del grupo puedan ejecutarlo."
