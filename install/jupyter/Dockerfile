FROM ubuntu:latest

RUN apt update && apt install -y python3 python3-pip wget

# talib
# https://github.com/mrjbq7/ta-lib
RUN wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz && \
    tar xf ta-lib-0.4.0-src.tar.gz && \
    cd ta-lib && ./configure --prefix=/usr && make && make install && \
    cd .. && rm -rf ta-lib && rm ta-lib-0.4.0-src.tar.gz

RUN python3 -m pip install --upgrade pip && pip3 install \
    pandas psycopg2-binary sklearn jupyter numpy scipy matplotlib seaborn \
    statsmodels imbalanced-learn xgboost tensorflow keras pykalman

# after installation pf numpy
RUN pip3 install TA-Lib

RUN useradd -ms /bin/bash jupyter
USER jupyter

WORKDIR /home/jupyter

CMD ["jupyter", "notebook", "--config=/home/jupyter/from_host/jupyter_notebook_config.py"]

