import pandas as pd

master_data = pd.read_excel('Datos Maestros VF.xlsx', sheet_name='Master Data Oficial')

# Seleccionamos columnas
master_data_columns = master_data[['Nombre visible Agente', 'AGENTE (OFEI)', 'CENTRAL (dDEC, dSEGDES, dPRU…)', 'Tipo de central (Hidro, Termo, Filo, Menor)']]

# Registros permitidos
permitted_agents = ['EMGESA', 'EMGESA S.A.']
type_central = ['H', 'T']

# Selección de registros sobre los datos
master_data_filter = master_data_columns[(master_data_columns['AGENTE (OFEI)'].isin(permitted_agents))
& master_data_columns['Tipo de central (Hidro, Termo, Filo, Menor)'].isin(type_central)]

# Eliminar duplicados
master_data_filter = master_data_filter.drop_duplicates()

# Realizamos el merge con dDEC1204.txt de Central

data = []

with open('dDEC1204.txt', 'r') as file:
    for line in file:
        line = line.strip()

        if not line:
            continue

        values = line.split(',')
        row = [value.strip() for value in values]
        data.append(row)

# Columns names
hours = [f'Hora_{i}' for i in range(1,25)]
columns_central = ['CENTRAL (dDEC, dSEGDES, dPRU…)'] + hours

# DataFrame
dataframe_central = pd.DataFrame(data, columns=columns_central)

dataframe_central['CENTRAL (dDEC, dSEGDES, dPRU…)'] = dataframe_central['CENTRAL (dDEC, dSEGDES, dPRU…)'].str.replace('"', '')

# Columnas sumadas
dataframe_central['Total_Horas'] = dataframe_central[hours].apply(pd.to_numeric, errors='coerce').sum(axis=1)

# Unimos los datos (merge)
dataframe_merged = pd.merge(master_data_filter, dataframe_central, on='CENTRAL (dDEC, dSEGDES, dPRU…)', how='inner')

# Registros con suma horizontal > 0
dataframe_merged = dataframe_merged[dataframe_merged['Total_Horas'] > 0]

# Llevamos el resultado a un archivo CSV
dataframe_merged.to_csv('data_frame_merged.csv', index=False, sep=';')


