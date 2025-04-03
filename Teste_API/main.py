from fastapi import FastAPI, HTTPException, Depends
from pydantic import BaseModel
from database import database
from controller import router
import uvicorn

app = FastAPI()

app.include_router(router)

if __name__ == '__main__':
    uvicorn.run(app, host='localhost', port=8080, reload=True)