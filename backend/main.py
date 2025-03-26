from fastapi import FastAPI, File, UploadFile, Form, Response
from pathlib import Path
import shutil
from preprocess import preprocess_image
from omr import run_audiveris
from transposition import parse_musicxml_or_mxl, transpose_notes, save_transposed_score_as_mxl, mxl_to_xml
from export_pdf import export_to_pdf
from fastapi.staticfiles import StaticFiles

app = FastAPI()

UPLOAD_DIR = Path("static/uploads")
OUTPUT_DIR = Path("static/outputs")
UPLOAD_DIR.mkdir(parents=True, exist_ok=True)
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
app.mount("/static", StaticFiles(directory="static"), name="static")

@app.post("/upload/")
async def upload_file(file: UploadFile = File(...), transpose_interval: int = Form(0)):
    """Handles file upload, runs OMR, transposes the score, and exports PDF."""
    try:
        # Save the uploaded image
        file_path = UPLOAD_DIR / file.filename
        with open(file_path, "wb") as buffer:
            shutil.copyfileobj(file.file, buffer)

        # Preprocess image
        preprocessed_image_path = OUTPUT_DIR / f"preprocessed_{file.filename}"
        preprocess_image(str(file_path), str(preprocessed_image_path))

        # Run Audiveris OMR
        run_audiveris(str(preprocessed_image_path), str(OUTPUT_DIR))

        # Find the generated .mxl file
        mxl_path = next(OUTPUT_DIR.glob("*.mxl"), None)
        if not mxl_path:
            return {"error": "No .mxl file generated"}

        # Transpose using music21
        transposed_mxl = OUTPUT_DIR / f"transposed_{mxl_path.name}"
        score = parse_musicxml_or_mxl(str(mxl_path))
        transposed_score = transpose_notes(score, transpose_interval)
        save_transposed_score_as_mxl(transposed_score, str(transposed_mxl))

        # Convert transposed score to PDF using MuseScore
        transposed_pdf = OUTPUT_DIR / f"transposed_{mxl_path.stem}.pdf"
        export_to_pdf(str(transposed_mxl), str(transposed_pdf))

        return {
            "message": "Transposition complete",
            "transposed_mxl": str(transposed_mxl),
            "transposed_pdf": str(transposed_pdf)
        }

    except Exception as e:
        return {"error": str(e)}

@app.get("/download/{filename}")
async def download_file(filename: str):
    """Download the transposed PDF file."""
    file_path = OUTPUT_DIR / filename
    if not file_path.exists():
        return {"error": "File not found"}

    return Response(content=file_path.read_bytes(), media_type="application/pdf",
                    headers={"Content-Disposition": f"attachment; filename={filename}"})

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="127.0.0.1", port=8000, reload=True)
