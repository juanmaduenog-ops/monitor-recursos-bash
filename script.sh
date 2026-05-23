#!/bin/bash

# NOMBRE DEL SCRIPT: script.sh
# CONTEXTO: Administración de Sistemas y Monitoreo de Infraestructura.
# FIN: Supervisar en tiempo real el uso de CPU, RAM y Disco, emitiendo
#      alertas visuales por colores y registrando eventos en un Log.
# CURSO: Introducción a la Computación
# AUTOR: Madueño Gil, Juan Luis
# FECHA: Mayo 2026

# CONFIGURACIÓN DE VARIABLES
UMBRAL_DISCO=80
UMBRAL_RAM=80
ARCHIVO_LOG="registro_sistema.log"

# PALETA DE COLORES ANSI
VERDE='\033[0;32m'
AMARILLO='\033[1;33m'
ROJO='\033[0;31m'
AZUL='\033[0;34m'
SIN_COLOR='\033[0m'

echo -e "${AZUL}======================================================${SIN_COLOR}"
echo -e "${AZUL}   SISTEMA AUTOMATIZADO DE MONITOREO DE SERVIDORES   ${SIN_COLOR}"
echo -e "${AZUL}======================================================${SIN_COLOR}"
echo "Fecha actual: $(date '+%Y-%m-%d %H:%M:%S')"
echo "------------------------------------------------------"

# 1. MONITOREO DEL DISCO DURO (Corrección Multiplataforma)
USO_DISCO=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')

echo -n "Uso de Disco: ${USO_DISCO}% -> "
if [ "$USO_DISCO" -ge "$UMBRAL_DISCO" ]; then
    echo -e "${ROJO}[CRÍTICO] Espacio en disco casi lleno.${SIN_COLOR}"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - [CRÍTICO] DISCO al ${USO_DISCO}%" >> "$ARCHIVO_LOG"
else
    echo -e "${VERDE}[OK] Almacenamiento estable.${SIN_COLOR}"
fi

# 2. MONITOREO DE LA MEMORIA RAM (Corrección Multiplataforma)
USO_RAM=$(free | awk '/Mem:/ {print int($3/$2 * 100)}')

echo -n "Uso de Memoria RAM: ${USO_RAM}% -> "
if [ "$USO_RAM" -ge "$UMBRAL_RAM" ]; then
    echo -e "${ROJO}[CRÍTICO] Alta demanda de memoria.${SIN_COLOR}"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - [CRÍTICO] RAM al ${USO_RAM}%" >> "$ARCHIVO_LOG"
else
    echo -e "${VERDE}[OK] Memoria estable.${SIN_COLOR}"
fi

# 3. TIEMPO DE ACTIVIDAD
TIEMPO_ACTIVO=$(uptime | awk -F, '{print $1}' | sed 's/.*up //')

echo -e "Tiempo de actividad del sistema: ${AMARILLO}${TIEMPO_ACTIVO}${SIN_COLOR}"

# 4. CONTROL DE RETROALIMENTACIÓN
echo "------------------------------------------------------"
if [ -f "$ARCHIVO_LOG" ]; then
    echo -e "${AZUL}[LOG]${SIN_COLOR} Eventos críticos registrados en: ${ARCHIVO_LOG}"
else
    echo "No se registraron alertas críticas en esta ejecución."
fi
echo -e "${AZUL}======================================================${SIN_COLOR}"