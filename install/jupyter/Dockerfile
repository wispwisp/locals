FROM python:3.6.3-jessie

# pandoc, texlive-xetex, nbconvert - save to pdf
# https://nbconvert.readthedocs.io/en/latest/install.html#installing-tex.
RUN apt update && apt install -y pandoc texlive-xetex

# talib
# https://github.com/mrjbq7/ta-lib
RUN wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz && \
    tar xf ta-lib-0.4.0-src.tar.gz && \
    cd ta-lib && ./configure --prefix=/usr && make && make install && \
    cd .. && rm -rf ta-lib && rm ta-lib-0.4.0-src.tar.gz

RUN pip install --upgrade pip
RUN pip install jupyter numpy scipy pandas matplotlib seaborn sklearn \
    statsmodels imbalanced-learn xgboost py-postgresql psycopg2 \
    tensorflow keras nbconvert

# after installation pf numpy
RUN pip install TA-Lib

# RUN pip install jupyterthemes
# RUN pip install --upgrade jupyterthemes
# RUN jt -t onedork -fs 95 -altp -tfs 11 -nfs 115 -cellw 88% -T

RUN useradd -ms /bin/bash jupyter
USER jupyter

WORKDIR /home/jupyter

CMD ["jupyter", "notebook", "--config=/home/jupyter/from_host/jupyter_notebook_config.py"]

