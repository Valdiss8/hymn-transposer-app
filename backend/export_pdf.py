import subprocess
from pathlib import Path

MUSESCORE_PATH = Path("MuseScore 4/bin/MuseScore4.exe").resolve()

def export_to_pdf(input_mxl, output_pdf):
    """
    Convert a MusicXML (.mxl) file to a PDF using MuseScore.
    """
    if not MUSESCORE_PATH.exists():
        raise FileNotFoundError(f"MuseScore not found at {MUSESCORE_PATH}")

    command = [
        str(MUSESCORE_PATH),
        str(input_mxl),  # Input MusicXML file
        "-o", str(output_pdf)  # Output PDF file
    ]

    print(f"Running MuseScore PDF export command: {' '.join(command)}")

    try:
        subprocess.run(command, check=True, capture_output=True, text=True)
        print(f"PDF saved at: {output_pdf}")
        return output_pdf
    except subprocess.CalledProcessError as e:
        print(f"Error exporting PDF with MuseScore: {e}")
        print(f"Standard Output:\n{e.stdout}")
        print(f"Standard Error:\n{e.stderr}")
        raise
