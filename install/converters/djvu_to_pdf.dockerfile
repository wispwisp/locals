FROM ubuntu:latest

RUN apt update && apt install -y djvulibre-bin

RUN useradd me
USER me
WORKDIR /home/me

# docker build -t converters/djvu_to_pdf -f djvu_to_pdf.dockerfile .
# docker run -it --rm --name=djvu_to_pdf -v$(pwd -P):/home/me converters/djvu_to_pdf
# ddjvu -format=pdf name.{djvu,pdf}
