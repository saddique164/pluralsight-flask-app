FROM python:3.9.15-slim-bullseye

WORKDIR /app

COPY ${WORKSPACE}//requirements.txt /app

RUN pip install -r /app/requirements.txt

COPY ${WORKSPACE}/* /app/

CMD ["python","./app/flashcards.py"]