FROM python:3.9.15-slim-bullseye

WORKDIR /app

COPY . /app/

RUN pip3 install -r /app/requirements.txt

CMD ["python","./app/flashcards.py"]