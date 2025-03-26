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

## Installation Instructions

### 1. Clone the repository

```bash
git clone https://github.com/YOUR_USERNAME/Hymnals_transpose.git
cd Hymnals_transpose
```

### 2. Backend Setup (Python + FastAPI)

1. Navigate to backend folder

```bash
cd backend
```

2. Create a virtual environment and activate it

```bash
python -m venv venv
venv\Scripts\activate   # For Windows
# Or
source venv/bin/activate  # For macOS/Linux
```

3. Install dependencies

```bash
pip install -r requirements.txt
```

4. Run the FastAPI server

```bash
uvicorn main:app --reload
```

By default, the backend will be available at `http://127.0.0.1:8000`

### 3. Flutter App Setup

1. Open the frontend folder in Visual Studio Code or another IDE  
2. Install Flutter dependencies

```bash
flutter pub get
```

3. Run the app

```bash
flutter run
```

Make sure you have an emulator or device connected.

## File Structure

```
Hymnals_transpose/
│
├── backend/                # FastAPI project
│   ├── static/             # Output files
│   ├── preprocess.py       # Image preprocessing
│   ├── transposition.py    # MusicXML parsing and transposition
│   ├── export_pdf.py       # PDF export with MuseScore
│   └── main.py             # FastAPI server
│
├── frontend/               # Flutter mobile application
│
├── requirements.txt        # Python dependencies
├── .gitignore              # Ignored files and folders
└── README.md               # Project overview and instructions
```

## Notes

- Ensure that Audiveris and MuseScore 4 are installed on your machine and their executables are accessible in the system PATH or correctly referenced in your code.
- The backend assumes that `.mxl` files are saved in `static/outputs/` and processed there.
- The app does not currently support handwritten notation.

## Future Improvements

- Support for handwritten scores  
- Real-time transposition preview  
- Integration with MIDI output  
- In-app editing of notes

## License

MIT License

## Author

Vadim Skrypiy – Master's Thesis, HSE University, 2025