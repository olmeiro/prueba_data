import pandas as pd

"""
    Respectivamente:
        a) Cargamos el archivo
        b) Eliminamos los registros que no son tipo D
        c) Eliminamos columnas innecesarias
        d) Guardamos el archivo depurado
"""
def ingest_data():
    data = []

    current_agent = None

    with open('OFEI1204.txt', 'r', encoding='utf-8') as file:
        for line in file:
            line = line.strip()

            if not line:
                continue

            if line.startswith("AGENTE:"):
                current_agent = line.split(":")[1].strip()
                continue

            values = line.split(',')
            file = [current_agent] + [value.strip() for value in values]
            data.append(file)

    columnsData = ['Agente', 'Planta', 'Tipo'] + [f'Hora_{i}' for i in range(1,25)]

    df = pd.DataFrame(data, columns=columnsData)

    df = df.iloc[1:]

    df = df[df['Tipo'] == 'D']
    df = df.drop('Tipo', axis=1)

    df.to_csv('OFEI1204_clean.txt', index=False, sep=";")

    print(df)

if __name__ == '__main__':
    ingest_data()