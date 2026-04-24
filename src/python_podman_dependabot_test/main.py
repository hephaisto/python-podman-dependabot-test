import argparse
from importlib.metadata import distributions

from nicegui import app, ui

@ui.page("/")
def main_page():
    with ui.grid(columns="auto auto"):
        for dist in distributions():
            ui.label(dist.metadata["Name"])
            ui.label(dist.version)

def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("hostname", type=str, help="Hostname, IP, 0.0.0.0 or [::]")
    parser.add_argument("--port", type=int, default=8080, help="Port to listen at")
    return parser.parse_args()


def main():
    args = parse_args()
    ui.run(title="dependency test", reload=False, host=args.hostname, port=args.port)

def startup_actions():
    ui.timer(10.0, lambda: save(data_store))
    ui.timer(24*3600.0, auto_clean_action)

if __name__ == '__main__':
    main()

