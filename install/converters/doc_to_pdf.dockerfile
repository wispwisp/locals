FROM ubuntu:latest

RUN apt update && apt install -y unoconv

RUN useradd me
USER me
WORKDIR /home/me

# docker build -t converters/doc_to_pdf -f doc_to_pdf.dockerfile .
# docker run -it --rm --name=doc_to_pdf -v$(pwd -P):/home/me converters/doc_to_pdf
# unoconv -fpdf file.doc
