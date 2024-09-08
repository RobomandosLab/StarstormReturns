## Mando is a CLI tool for automating tedious tasks of the mod making process
import typer

app = typer.Typer()

@app.command()
def build(output_dir: str):
    pass

@app.command()
def lint():
    pass

@app.command()
def add_tokens(language: str, category: str, name: str):
    pass

if __name__ == "__main__":
    app()