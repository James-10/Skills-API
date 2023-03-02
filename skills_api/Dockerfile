FROM python:3.9

WORKDIR /skills_api

COPY Pipfile Pipfile.lock /skills_api/

RUN pip install pipenv

RUN pipenv install --system --deploy

COPY . /skills_api/

ENV PYTHONUNBUFFERED=1
ENV DJANGO_ENVIRONMENT=development

EXPOSE 8080

CMD ["python3", "manage.py", "runserver", "8080"]