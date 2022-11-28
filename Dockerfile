FROM python:3.9.15-slim-bullseye

WORKDIR /app

COPY requirments.txt /app

RUN pip install -r /app/requirements.txt

COPY . /app/

CMD ["python","./app/flashcards.py"]