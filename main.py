from fastapi import FastAPI

app = FastAPI()


@app.get("/")
async def root():
    # update
    return {"message": "Hello World"}
