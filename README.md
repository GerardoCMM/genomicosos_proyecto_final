# Proyecto final del equipo Genomicosos
Se presenta en este repositorio el código utilizado para el proyecto semestral del equipo genomicosos como parte de la materia de genómica computacional. 

## Integrantes
- Aldo Daniel Licona Gómez
- Gerardo Cendejas Mendoza
- Leonardo Daniel Álvarez Lechuga
- Oscar René Garzón Castro

## Información

<p align="justify"> En el archivo <i>script.sh</i> se encuentra el código principal ejecutado para la obtención del árbol filogenético. Este código a su vez llama otros scripts como <i>get_seqs.R</i> el cual se utiliza para obtener las secuencias de genes desde el GenBank o como <i>select_model.R </i>que se utiliza para la selección del mejor modelo de sustitución de nucleótidos para la matriz de caracteres, o <i>trim_mat.py</i> que se utiliza para cortar la matriz de datos de cada gen. La información para correr mrBayes se encuentra en un bloque de mrbayes en el documento formato nexus llamado <i>matrix.nexus</i>.</p>

<p align="justify"> Para el código utilizado en los métodos de Pagel y de umbral se muestra en la carpeta <i>Comparison/</i> el documento <i>comp.R</i>, en este se encuentra el script en R para la obtención de resultados y gráficas. </p>
