from duckdb import DuckDBPyConnection

from dbt.adapters.duckdb.plugins import BasePlugin


def name_to_number(name: str) -> str:
    """Convert the name to a phone number based on the letters on a phone keypad."""
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
    return "".join([v for i in name for k, v in mapping.items() if i.upper() in k])


class Plugin(BasePlugin):
    def configure_connection(self, conn: DuckDBPyConnection):
        conn.create_function("name_to_number", name_to_number)
