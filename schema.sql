-- Schéma de la base "suivi boursier" (PostgreSQL)
-- Les prix sont ajustés des dividendes et des splits (yfinance, auto_adjust=True).

CREATE TABLE IF NOT EXISTS instrument (
    ticker            TEXT PRIMARY KEY,
    nom               TEXT NOT NULL,
    type              TEXT NOT NULL CHECK (type IN ('action', 'indice')),
    devise            TEXT NOT NULL,
    bourse            TEXT,
    fuseau_horaire    TEXT,
    secteur           TEXT,
    industrie         TEXT,
    site              TEXT,
    adresse           TEXT,
    indice_reference  TEXT REFERENCES instrument(ticker)
);

CREATE TABLE IF NOT EXISTS cotation (
    ticker  TEXT NOT NULL REFERENCES instrument(ticker),
    date    DATE NOT NULL,
    open    DOUBLE PRECISION NOT NULL,
    high    DOUBLE PRECISION NOT NULL,
    low     DOUBLE PRECISION NOT NULL,
    close   DOUBLE PRECISION NOT NULL,
    volume  BIGINT NOT NULL,
    PRIMARY KEY (ticker, date)
);