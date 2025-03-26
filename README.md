# Hymn Transposition App

## Overview

This project is a mobile and server-based system that allows users to automatically recognize musical scores from images and transpose them to a different key. The solution is especially useful for volunteers in Protestant communities who play music but may not have professional musical training.

The system supports:

- Optical Music Recognition (OMR) using **Audiveris**
- Score transposition using **music21**
- PDF generation using **MuseScore Studio 4**
- A mobile frontend built with **Flutter**
- A backend API built with **FastAPI**

## Features

- Upload a photo or scan of a sheet music page
- Recognize musical notation from the image
- Automatically transpose all parts of the music to a desired key
- Download the result as a clean PDF or MusicXML file
- Mobile interface for fast and easy access

## Technologies Used

- 🐍 Python (FastAPI, music21, OpenCV)
- 🎼 Audiveris (OMR engine)
- 🎵 MuseScore Studio 4 (PDF rendering)
- 📱 Flutter (Frontend mobile app)
- 🖼️ OpenCV (Image preprocessing)

## Repository

🔗 GitHub: [https://github.com/Valdiss8/hymn-transposer-app](https://github.com/Valdiss8/hymn-transposer-app)

## Installation Instructions

### 1. Clone the repository

```bash
git clone https://github.com/Valdiss8/hymn-transposer-app.git
cd hymn-transposer-app
```

### 2. Backend Setup (Python + FastAPI)

1. Navigate to the backend directory (where your Python source files are located):

```bash
cd backend
```

2. Create a virtual environment and activate it:

```bash
python -m venv venv
venv\Scripts\activate   # On Windows
# or
source venv/bin/activate   # On macOS/Linux
```

3. Install the dependencies:

```bash
pip install -r requirements.txt
```

4. Run the FastAPI backend:

```bash
uvicorn main:app --reload
```

The backend server will be available at: `http://127.0.0.1:8000`

You can open Swagger UI for testing: [http://127.0.0.1:8000/docs](http://127.0.0.1:8000/docs)

### 3. Flutter App Setup

1. Open the `frontend` folder in **Visual Studio Code** or another IDE
2. Install Flutter dependencies:

```bash
flutter pub get
```

3. Run the Flutter app:

```bash
flutter run
```

Make sure you have an Android emulator or physical device connected.

## File Structure

```
hymn-transposer-app/
│
├── backend/
│   ├── __pycache__/
│   ├── static/                # Contains uploaded and output files
│   ├── venv/                  # Virtual environment (not uploaded to GitHub)
│   ├── export_pdf.py          # MuseScore PDF export
│   ├── main.py                # FastAPI application entry point
│   ├── omr.py                 # OMR integration with Audiveris
│   ├── preprocess.py          # Image preprocessing with OpenCV
│   ├── transposition.py       # Transposition logic using music21
│   └── requirements.txt       # Backend dependencies
│
├── frontend/                  # Flutter mobile app
│   ├── lib/
│   └── pubspec.yaml
│
├── .gitignore
└── README.md
```

## Notes

- Make sure `MuseScore 4` and `Audiveris` are installed on your machine.
- MuseScore and Audiveris executables should be correctly configured in the backend code.
- Input image formats: `.png`, `.jpg`, `.jpeg`
- Output formats: `.mxl`, `.pdf`
- The app currently does **not** support handwritten musical scores.

## Future Improvements

- Handwritten notation support
- In-app score editing
- MIDI export support
- Real-time transposition preview
- Docker containerization for easier deployment

## License

MIT License

---

**Author**: Vadim Skrypiy  
**Project type**: Master's Thesis  
**Institution**: National Research University Higher School of Economics  
**Program**: Master of Data Science  
**Year**: 2025