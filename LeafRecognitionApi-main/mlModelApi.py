from fastapi import FastAPI, File, UploadFile
from fastapi.middleware.cors import CORSMiddleware
import uvicorn
import numpy as np
from io import BytesIO
from PIL import Image
import tensorflow as tf

app = FastAPI()

# cors
origins = [
    # "http://localhost:5173",
    # "http://localhost:3000",
    "http://localhost:40076",
    
]


app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

MODEL = tf.keras.models.load_model("./1")

CLASS_NAMES = ["Tomato_Bacterial_spot", "Tomato__Tomato_mosaic_virus" , "Tomato_healthy"]


# GET REQ
# ==================================
@app.get("/")
async def welcome():
    return "Welcome to the Leaf Recognition API"

@app.get("/testGet")
async def ping():
    return "hello"



# POST REQ
# ==================================

@app.post("/testPost")
async def ping():
    return "hellow"

# Call prediction model endpoint
def read_file_as_image(data) -> np.ndarray:
    image = np.array(Image.open(BytesIO(data)))
    return image

@app.post("/predict")
async def predict(
    file: UploadFile = File(...)
):
    image = read_file_as_image(await file.read())
    img_batch = np.expand_dims(image, 0)
    
    predictions = MODEL.predict(img_batch)

    predicted_class = CLASS_NAMES[np.argmax(predictions[0])]
    confidence = np.max(predictions[0])
    return {
        'class': predicted_class,
        'confidence': float(confidence)
    }

if __name__ == "__main__":
    uvicorn.run(app, host='localhost', port=8000)