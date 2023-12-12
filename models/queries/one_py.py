def model(dbt, session):
    df = dbt.ref("dim_customer").fetchdf()

    mapping = {
        "ABC": "2",
        "DEF": "3",
        "GHI": "4",
        "JKL": "5",
        "MNO": "6",
        "PQRS": "7",
        "TUV": "8",
        "WXYZ": "9",
    }

    df["name_to_phone"] = df["last_name"].apply(lambda name: "".join(
        [v for i in name for k, v in mapping.items() if i.upper() in k]
    ))
    df["phone"] = df["phone"].str.replace('-', '')

    df = df[df['phone']==df['name_to_phone']][["phone", "last_name"]]

    return df

