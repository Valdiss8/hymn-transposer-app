from music21 import converter, stream

def parse_musicxml_or_mxl(file_path):
    """
    Parse a MusicXML or MXL file to extract musical notes.
    """
    try:
        score = converter.parse(file_path)
        print(f"Successfully parsed file: {file_path}")
        return score
    except Exception as e:
        raise RuntimeError(f"Error parsing MusicXML or MXL file: {e}")

def transpose_notes(score, interval):
    """
    Transpose notes in the given score by a specified interval.
    """
    try:
        transposed_score = stream.Score()
        for part in score.parts:
            transposed_part = part.transpose(interval)  # Transpose by given interval
            transposed_score.append(transposed_part)
        return transposed_score
    except Exception as e:
        raise RuntimeError(f"Error transposing notes: {e}")

def save_transposed_score_as_mxl(score, output_path):
    """
    Save the transposed score to an MXL file.
    """
    try:
        score.write('mxl', fp=output_path)
        print(f"Transposed score saved as MXL at: {output_path}")
    except Exception as e:
        raise RuntimeError(f"Error saving transposed score as MXL: {e}")

def mxl_to_xml(input_mxl, output_xml):
    """
    Convert an MXL file to a MusicXML file.
    """
    try:
        score = converter.parse(input_mxl)
        score.write('musicxml', fp=output_xml)
        print(f"Converted MXL to XML: {output_xml}")
    except Exception as e:
        raise RuntimeError(f"Error converting to XML: {e}")
