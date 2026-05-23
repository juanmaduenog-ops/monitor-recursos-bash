# Automated Server Health Monitor

## Contexto del Proyecto
En la ingeniería de infraestructura y sistemas, la **homeostasis y supervisión** de los servidores son fundamentales para garantizar la continuidad del negocio. Este script en Bash actúa como un sistema de control de lazo abierto que recolecta métricas clave del hardware del sistema operativo, procesa las variables y determina si el sistema se encuentra en un estado óptimo o crítico.

## Características Técnicas
* **Parseo de Métricas:** Filtrado preciso de flujos de texto mediante comandos `awk`, `grep` y `sed`.
* **Modularidad Dinámica:** Centralización de variables globales (umbrales de alerta) al inicio del script para facilitar el mantenimiento.
* **Gestor de Alertas:** Clasificación visual de criticidad utilizando secuencias de escape de colores ANSI.
* **Sistema de Loggin:** Redirección de flujos de error hacia un archivo histórico estático (`registro_sistema.log`).

## Instrucciones de Ejecución
Para clonar y desplegar este monitor localmente, ejecute en su terminal Linux:

```bash
git clone https://github.com/juanmaduenog-ops/monitor-recursos-bash.git

cd monitor-recursos-bash

chmod +x script.sh

./script.sh