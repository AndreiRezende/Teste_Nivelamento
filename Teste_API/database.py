from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()
URL_DATABASE = 'postgresql://postgres:2547@localhost:5432/IntuitiveCare'
engine = create_engine(URL_DATABASE)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

def database():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()