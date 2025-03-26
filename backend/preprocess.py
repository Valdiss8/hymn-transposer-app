import cv2

def preprocess_image(image_path, output_path):
    """
    Preprocess the image for better recognition.
    """
    img = cv2.imread(image_path, cv2.IMREAD_GRAYSCALE)
    if img is None:
        raise FileNotFoundError(f"Image not found: {image_path}")

    _, thresh = cv2.threshold(img, 128, 255, cv2.THRESH_BINARY)
    cv2.imwrite(output_path, thresh)
    return output_path
