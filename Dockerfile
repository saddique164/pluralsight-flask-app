FROM python:3.9.15-slim-bullseye

WORKDIR /app

COPY ${WORKSPACE}/* /app/

RUN pip install -r /app/requirements.txt

CMD ["python","./app/flashcards.py"]