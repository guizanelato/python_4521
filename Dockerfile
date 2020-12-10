#1:  definição da imagem base (leve)
FROM python:3-alpine as base

#2: criar um diretório para armazenar os arquivos de dependencia
RUN mkdir /install

#3: copia do arquivos das dependencias
COPY ./requirements.txt /requirements.txt

#4: instalar as dep.
RUN pip install --prefix=/install -r /requirements.txt

#5: Segundo build
FROM base

#6: copia as dependencias para o build final
COPY --from=base /install /usr/local 

#7: Copia a aplicação para o container
COPY . /app

#8: modifica o diretório de trabalho
WORKDIR /app

#9: expõe a porta do gunicorn
EXPOSE 8000

#10: comando de execução do gunicorn

CMD ["gunicorn", "-w 4", "app:app", "-b 0.0.0.0:8000" ]


