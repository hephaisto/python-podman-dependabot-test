from importlib.metadata import distributions

from nicegui import app, ui

@ui.page("/")
def main_page():
    with ui.grid(columns="auto auto"):
        for dist in distributions():
            ui.label(dist.metadata["Name"])
            ui.label(dist.version)

def main():
    ui.run(title="dependency test", reload=False)

def startup_actions():
    ui.timer(10.0, lambda: save(data_store))
    ui.timer(24*3600.0, auto_clean_action)

if __name__ == '__main__':
    main()

