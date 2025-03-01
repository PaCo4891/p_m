# Instalar y cargar los paquetes necesarios
install.packages("dplyr")
install.packages("lubridate")
install.packages("writexl")
install.packages("openxlsx")
install.packages("readxl", dependencies = TRUE)
library(dplyr)
library(lubridate)
library(openxlsx)
library(writexl)
library(readxl)



data <- read_excel("eje.xlsx") 

# Crear una columna para el trimestre basado en Per.Presup
data <- data %>%
  mutate(Trimestre = case_when(
    Per.Presup %in% c("01-ENE", "02-FEB", "03-MAR") ~ "Q1",
    Per.Presup %in% c("04-ABR", "05-MAY", "06-JUN") ~ "Q2",
    Per.Presup %in% c("07-JUL", "08-AGO", "09-SEP") ~ "Q3",
    Per.Presup %in% c("10-OCT", "11-NOV", "12-DIC") ~ "Q4"
  ))

# Agrupar por Posición Presupuestaria y Trimestre, y calcular la suma de Modificado
resultado <- data %>%
  group_by(`Posición presupuestaria`, Trimestre) %>%
  summarise(Suma_Modificado = sum(Modificado, na.rm = TRUE)) %>%
  ungroup()

# Agrupar por Posición Presupuestaria, Centro Gestor y Trimestre, y calcular la suma de Modificado
resultado <- data %>%
  group_by(`Posición presupuestaria`, `Centro gestor`, Trimestre) %>%
  summarise(Suma_Modificado = sum(Modificado, na.rm = TRUE)) %>%
  ungroup()

# Guardar el resultado en un archivo Excel
write_xlsx(resultado, "C:/Users/HP/Documents/resultado_trimestral.xlsx")













