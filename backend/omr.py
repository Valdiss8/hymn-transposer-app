import subprocess
import os
from pathlib import Path

# Update the path to the new Audiveris location inside the backend folder
AUDIVERIS_PATH = Path("Audiveris/bin/Audiveris.bat").resolve()

def run_audiveris(image_path, output_dir):
    """ Run Audiveris on the given image using the new local path. """
    if not AUDIVERIS_PATH.exists():
        raise FileNotFoundError(f"Audiveris not found at {AUDIVERIS_PATH}")

    output_dir = Path(output_dir).resolve()
    output_dir.mkdir(parents=True, exist_ok=True)

    command = [
        str(AUDIVERIS_PATH),
        "-batch",
        "-export",
        "-output", str(output_dir),
        image_path
    ]

    try:
        subprocess.run(command, check=True, capture_output=True, text=True)
        print(f"OMR completed. Results saved in {output_dir}")
    except subprocess.CalledProcessError as e:
        print(f"Error running Audiveris: {e}")
        raise
