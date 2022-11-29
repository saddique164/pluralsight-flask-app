WORKDIR /app

ENV FLASK_APP=/app/flashcards.py

ENV FLASK_RUN_HOST=0.0.0.0

COPY requirements.txt /app

RUN pip3 install -r /app/requirements.txt

COPY . /app/

EXPOSE 5000

CMD ["flask","run"]
