# backend/main.py
from fastapi import FastAPI, File, UploadFile
from fastapi.middleware.cors import CORSMiddleware
import google.generativeai as genai
import PIL.Image
import fitz
import tempfile
import io
from pathlib import Path

app = FastAPI(title="Tahlil Kolay – Gemini")

# CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

genai.configure(api_key="")
model = genai.GenerativeModel("gemini-1.5-flash")

@app.post("/analyze")
async def analyze(file: UploadFile = File(...)):
    prompt = """
    Gönderilen tahlil sonucunu analiz et:
    1. Her parametrenin normal aralığını belirt.
    2. Sonucu 100 kelimeyi geçmeyecek şekilde sade Türkçe açıkla.
    3. Basit öneri ver.
    4. Sonuna ekle: "Bu analiz tıbbi tavsiye değildir, doktorunuza danışın."
    """

    # tempfile kullanarak dosya kilidini önle
    with tempfile.NamedTemporaryFile(delete=False, suffix=Path(file.filename).suffix) as tmp:
        tmp.write(await file.read())
        tmp_path = tmp.name

    try:
        mime = file.content_type
        if mime in ["image/jpeg", "image/png"]:
            image = PIL.Image.open(tmp_path)
            response = model.generate_content([prompt, image])
        elif mime == "application/pdf":
            doc = fitz.open(tmp_path)
            images = [
                PIL.Image.open(io.BytesIO(page.get_pixmap().tobytes()))
                for page in doc
            ]
            response = model.generate_content([prompt] + images)
            doc.close()
        else:
            return {"error": "Desteklenmeyen dosya tipi"}

        return {"report": response.text.strip()}
    finally:
        Path(tmp_path).unlink(missing_ok=True)